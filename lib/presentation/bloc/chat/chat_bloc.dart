import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmai/core/constants/app_constants.dart';
import 'package:pharmai/domain/entities/chat_message.dart';
import 'package:pharmai/domain/entities/chat_session.dart';
import 'package:pharmai/domain/entities/chat_usage.dart';
import 'package:pharmai/domain/usecases/add_chat_message.dart';
import 'package:pharmai/domain/usecases/fetch_chat_messages.dart';
import 'package:pharmai/domain/usecases/fetch_chat_sessions.dart';
import 'package:pharmai/domain/usecases/generate_chat_title.dart';
import 'package:pharmai/domain/usecases/get_chat_usage.dart';
import 'package:pharmai/domain/usecases/increment_chat_usage.dart';
import 'package:pharmai/domain/usecases/rename_chat_session.dart';
import 'package:pharmai/domain/usecases/send_chat_message.dart';
import 'package:pharmai/domain/usecases/start_chat_session.dart';
import 'package:pharmai/domain/usecases/upgrade_to_premium.dart'
    as chat_usecases;

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc({
    required FetchChatSessions fetchChatSessions,
    required FetchChatMessages fetchChatMessages,
    required StartChatSession startChatSession,
    required RenameChatSession renameChatSession,
    required GenerateChatTitle generateChatTitle,
    required AddChatMessage addChatMessage,
    required SendChatMessage sendChatMessage,
    required GetChatUsage getChatUsage,
    required IncrementChatUsage incrementChatUsage,
    required chat_usecases.UpgradeToPremium upgradeToPremium,
  }) : _fetchChatSessions = fetchChatSessions,
       _fetchChatMessages = fetchChatMessages,
       _startChatSession = startChatSession,
       _renameChatSession = renameChatSession,
       _generateChatTitle = generateChatTitle,
       _addChatMessage = addChatMessage,
       _sendChatMessage = sendChatMessage,
       _getChatUsage = getChatUsage,
       _incrementChatUsage = incrementChatUsage,
       _upgradeToPremium = upgradeToPremium,
       super(const ChatInitial()) {
    on<FetchSessions>(_onFetchSessions);
    on<StartNewChat>(_onStartNewChat);
    on<RenameSession>(_onRenameSession);
    on<SendMessage>(_onSendMessage);
    on<UpgradeToPremium>(_onUpgradeToPremium);
    on<_UpdateSessionTitle>(_onUpdateSessionTitle);
  }

  final FetchChatSessions _fetchChatSessions;
  final FetchChatMessages _fetchChatMessages;
  final StartChatSession _startChatSession;
  final RenameChatSession _renameChatSession;
  final GenerateChatTitle _generateChatTitle;
  final AddChatMessage _addChatMessage;
  final SendChatMessage _sendChatMessage;
  final GetChatUsage _getChatUsage;
  final IncrementChatUsage _incrementChatUsage;
  final chat_usecases.UpgradeToPremium _upgradeToPremium;

  Future<void> _onFetchSessions(
    FetchSessions event,
    Emitter<ChatState> emit,
  ) async {
    emit(ChatLoading(sessions: state.sessions));
    final sessionsResult = await _fetchChatSessions(event.userId);
    await sessionsResult.fold((failure) async => emit(const ChatInitial()), (
      sessions,
    ) async {
      if (event.activeSessionId == null) {
        emit(ChatSessionsLoaded(sessions: sessions));
        return;
      }
      final match = sessions.firstWhere(
        (s) => s.id == event.activeSessionId,
        orElse: () => sessions.isNotEmpty
            ? sessions.first
            : ChatSession(
                id: event.activeSessionId!,
                userId: event.userId,
                title: '',
                createdAt: DateTime.now(),
              ),
      );
      final messagesResult = await _fetchChatMessages(match.id);
      messagesResult.fold(
        (_) => emit(
          ChatRoomState(
            sessions: sessions,
            session: match,
            messages: const [],
            isSending: false,
          ),
        ),
        (messages) => emit(
          ChatRoomState(
            sessions: sessions,
            session: match,
            messages: messages,
            isSending: false,
          ),
        ),
      );
    });
  }

  Future<void> _onStartNewChat(
    StartNewChat event,
    Emitter<ChatState> emit,
  ) async {
    emit(ChatLoading(sessions: state.sessions));
    final createResult = await _startChatSession(event.userId);
    await createResult.fold((_) async => emit(const ChatInitial()), (
      session,
    ) async {
      final sessionsResult = await _fetchChatSessions(event.userId);
      sessionsResult.fold(
        (_) => emit(ChatSessionsLoaded(sessions: [session])),
        (sessions) => emit(
          ChatSessionsLoaded(sessions: sessions, openSessionId: session.id),
        ),
      );
    });
  }

  Future<void> _onRenameSession(
    RenameSession event,
    Emitter<ChatState> emit,
  ) async {
    final current = state;
    if (current is! ChatRoomState) return;

    final trimmed = event.newTitle.trim();
    if (trimmed.isEmpty) return;

    final result = await _renameChatSession(
      sessionId: event.sessionId,
      newTitle: trimmed,
    );

    result.fold(
      (_) => emit(current.copyWith(errorKey: ChatErrorKey.renameFailed)),
      (_) {
        final updatedSession = current.session.copyWith(title: trimmed);
        final updatedSessions = current.sessions
            .map(
              (session) => session.id == event.sessionId
                  ? session.copyWith(title: trimmed)
                  : session,
            )
            .toList();
        emit(
          current.copyWith(
            sessions: updatedSessions,
            session: updatedSession,
            errorKey: null,
          ),
        );
      },
    );
  }

  Future<void> _onSendMessage(
    SendMessage event,
    Emitter<ChatState> emit,
  ) async {
    final trimmed = event.text.trim();
    if (trimmed.isEmpty) return;

    final current = state;
    if (current is! ChatRoomState) return;

    final usageResult = await _getChatUsage(event.userId);
    final usage = usageResult.getOrElse(
      (_) => const ChatUsage(userId: '', queryCount: 0, isPremium: false),
    );

    if (!usage.isPremium &&
        usage.queryCount >= AppConstants.chatFreeQueryLimit) {
      emit(
        PremiumLimitReachedState(
          sessions: current.sessions,
          session: current.session,
          messages: current.messages,
          isSending: false,
          queryCount: usage.queryCount,
          limit: AppConstants.chatFreeQueryLimit,
        ),
      );
      return;
    }

    final userMessage = ChatMessage(
      id: 0,
      sessionId: current.session.id,
      role: ChatRole.user,
      content: trimmed,
      timestamp: DateTime.now(),
    );

    final updatedMessages = [...current.messages, userMessage];
    final shouldGenerateTitle =
        current.session.title.trim().isEmpty && current.messages.isEmpty;
    emit(
      current.copyWith(
        messages: updatedMessages,
        isSending: true,
        isStreaming: true,
        streamingText: '',
        errorMessage: null,
        status: ChatStatus.typing,
      ),
    );

    final saveUserResult = await _addChatMessage(userMessage);
    if (saveUserResult.isLeft()) {
      emit(
        current.copyWith(
          messages: updatedMessages,
          isSending: false,
          isStreaming: false,
          streamingText: '',
          errorMessage: null,
          errorKey: ChatErrorKey.localSaveFailed,
          status: ChatStatus.failure,
        ),
      );
      return;
    }

    if (shouldGenerateTitle) {
      unawaited(_ensureSessionTitle(prompt: trimmed, current: current));
    }

    final replyStream = _sendChatMessage(
      history: current.messages,
      message: trimmed,
      localeCode: event.localeCode,
    );

    final buffer = StringBuffer();
    await for (final chunkResult in replyStream) {
      if (chunkResult.isLeft()) {
        final failure = chunkResult.getLeft().toNullable();
        emit(
          current.copyWith(
            messages: updatedMessages,
            isSending: false,
            isStreaming: false,
            streamingText: '',
            errorMessage: failure?.message,
            errorKey: null,
            status: ChatStatus.failure,
          ),
        );
        return;
      }

      final chunk = chunkResult.getOrElse((_) => '');
      if (chunk.isEmpty) continue;
      buffer.write(chunk);
      emit(
        current.copyWith(
          messages: updatedMessages,
          isSending: true,
          isStreaming: true,
          streamingText: buffer.toString(),
          errorMessage: null,
          errorKey: null,
          status: ChatStatus.typing,
        ),
      );
    }

    final reply = buffer.toString().trim();
    if (reply.isEmpty) {
      emit(
        current.copyWith(
          messages: updatedMessages,
          isSending: false,
          isStreaming: false,
          streamingText: '',
          errorMessage: 'Empty response from Gemini.',
          errorKey: null,
          status: ChatStatus.failure,
        ),
      );
      return;
    }

    final modelMessage = ChatMessage(
      id: 0,
      sessionId: current.session.id,
      role: ChatRole.model,
      content: reply,
      timestamp: DateTime.now(),
    );
    await _addChatMessage(modelMessage);
    await _incrementChatUsage(event.userId);
    emit(
      current.copyWith(
        messages: [...updatedMessages, modelMessage],
        isSending: false,
        isStreaming: false,
        streamingText: '',
        errorKey: null,
        status: ChatStatus.success,
      ),
    );
  }

  Future<void> _onUpgradeToPremium(
    UpgradeToPremium event,
    Emitter<ChatState> emit,
  ) async {
    final current = state;
    if (current is! ChatRoomState) return;
    final result = await _upgradeToPremium(event.userId);
    result.fold(
      (_) => emit(current.copyWith(errorKey: ChatErrorKey.upgradeFailed)),
      (_) => emit(current.copyWith(errorKey: null)),
    );
  }

  void _onUpdateSessionTitle(
    _UpdateSessionTitle event,
    Emitter<ChatState> emit,
  ) {
    final current = state;
    if (current is! ChatRoomState) return;
    emit(current.copyWith(session: event.session, sessions: event.sessions));
  }

  Future<void> _ensureSessionTitle({
    required String prompt,
    required ChatRoomState current,
  }) async {
    final titleResult = await _generateChatTitle(prompt);
    final title = titleResult.getOrElse((_) => '').trim();
    if (title.isEmpty) return;

    final renameResult = await _renameChatSession(
      sessionId: current.session.id,
      newTitle: title,
    );
    if (renameResult.isLeft()) return;

    final latest = state;
    if (latest is! ChatRoomState) return;
    if (latest.session.id != current.session.id) return;

    final updatedSession = latest.session.copyWith(title: title);
    final updatedSessions = latest.sessions
        .map(
          (session) => session.id == latest.session.id
              ? session.copyWith(title: title)
              : session,
        )
        .toList();

    add(_UpdateSessionTitle(session: updatedSession, sessions: updatedSessions));
  }
}
