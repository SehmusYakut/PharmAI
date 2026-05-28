part of 'chat_bloc.dart';

enum ChatStatus { initial, loading, success, failure, typing }

enum ChatErrorKey { localSaveFailed, upgradeFailed, renameFailed }

abstract class ChatState extends Equatable {
  const ChatState({
    this.status = ChatStatus.initial,
    this.sessions = const [],
    this.messages = const [],
  });

  final ChatStatus status;
  final List<ChatSession> sessions;
  final List<ChatMessage> messages;

  @override
  List<Object?> get props => [status, sessions, messages];
}

class ChatInitial extends ChatState {
  const ChatInitial() : super();
}

class ChatLoading extends ChatState {
  const ChatLoading({super.sessions, super.messages}) : super(status: ChatStatus.loading);
}

class ChatSessionsLoaded extends ChatState {
  const ChatSessionsLoaded({required super.sessions, this.openSessionId})
      : super(status: ChatStatus.success);

  final int? openSessionId;

  @override
  List<Object?> get props => [status, sessions, messages, openSessionId];
}

class ChatRoomState extends ChatState {
  const ChatRoomState({
    required super.sessions,
    required this.session,
    required super.messages,
    required this.isSending,
    this.isStreaming = false,
    this.streamingText = '',
    this.errorMessage,
    this.errorKey,
    super.status = ChatStatus.success,
  });

  final ChatSession session;
  final bool isSending;
  final bool isStreaming;
  final String streamingText;
  final String? errorMessage;
  final ChatErrorKey? errorKey;

  ChatRoomState copyWith({
    List<ChatSession>? sessions,
    ChatSession? session,
    List<ChatMessage>? messages,
    bool? isSending,
    bool? isStreaming,
    String? streamingText,
    String? errorMessage,
    ChatErrorKey? errorKey,
    ChatStatus? status,
  }) =>
      ChatRoomState(
        sessions: sessions ?? this.sessions,
        session: session ?? this.session,
        messages: messages ?? this.messages,
        isSending: isSending ?? this.isSending,
        isStreaming: isStreaming ?? this.isStreaming,
        streamingText: streamingText ?? this.streamingText,
        errorMessage: errorMessage,
        errorKey: errorKey,
        status: status ?? this.status,
      );

  @override
  List<Object?> get props => [
        status,
        sessions,
        session,
        messages,
        isSending,
        isStreaming,
        streamingText,
        errorMessage,
        errorKey,
      ];
}

class PremiumLimitReachedState extends ChatRoomState {
  const PremiumLimitReachedState({
    required super.sessions,
    required super.session,
    required super.messages,
    required super.isSending,
    super.isStreaming = false,
    super.streamingText = '',
    required this.queryCount,
    required this.limit,
  }) : super(status: ChatStatus.success);

  final int queryCount;
  final int limit;

  @override
  List<Object?> get props => [
        status,
        sessions,
        session,
        messages,
        isSending,
        isStreaming,
        streamingText,
        queryCount,
        limit,
      ];
}
