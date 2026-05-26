part of 'chat_bloc.dart';

enum ChatErrorKey { localSaveFailed, upgradeFailed, renameFailed }

abstract class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object?> get props => [];
}

class ChatInitial extends ChatState {
  const ChatInitial();
}

class ChatLoading extends ChatState {
  const ChatLoading();
}

class ChatSessionsLoaded extends ChatState {
  const ChatSessionsLoaded({required this.sessions, this.openSessionId});

  final List<ChatSession> sessions;
  final int? openSessionId;

  @override
  List<Object?> get props => [sessions, openSessionId];
}

class ChatRoomState extends ChatState {
  const ChatRoomState({
    required this.sessions,
    required this.session,
    required this.messages,
    required this.isSending,
    this.errorMessage,
    this.errorKey,
  });

  final List<ChatSession> sessions;
  final ChatSession session;
  final List<ChatMessage> messages;
  final bool isSending;
  final String? errorMessage;
  final ChatErrorKey? errorKey;

  ChatRoomState copyWith({
    List<ChatSession>? sessions,
    ChatSession? session,
    List<ChatMessage>? messages,
    bool? isSending,
    String? errorMessage,
    ChatErrorKey? errorKey,
  }) => ChatRoomState(
    sessions: sessions ?? this.sessions,
    session: session ?? this.session,
    messages: messages ?? this.messages,
    isSending: isSending ?? this.isSending,
    errorMessage: errorMessage,
    errorKey: errorKey,
  );

  @override
  List<Object?> get props => [
    sessions,
    session,
    messages,
    isSending,
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
    required this.queryCount,
    required this.limit,
  });

  final int queryCount;
  final int limit;

  @override
  List<Object?> get props => [
    sessions,
    session,
    messages,
    isSending,
    queryCount,
    limit,
  ];
}
