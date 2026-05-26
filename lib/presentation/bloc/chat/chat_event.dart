part of 'chat_bloc.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object?> get props => [];
}

class FetchSessions extends ChatEvent {
  const FetchSessions({required this.userId, this.activeSessionId});

  final String userId;
  final int? activeSessionId;

  @override
  List<Object?> get props => [userId, activeSessionId];
}

class StartNewChat extends ChatEvent {
  const StartNewChat({required this.userId});

  final String userId;

  @override
  List<Object?> get props => [userId];
}

class RenameSession extends ChatEvent {
  const RenameSession({required this.sessionId, required this.newTitle});

  final int sessionId;
  final String newTitle;

  @override
  List<Object?> get props => [sessionId, newTitle];
}

class SendMessage extends ChatEvent {
  const SendMessage({required this.userId, required this.text});

  final String userId;
  final String text;

  @override
  List<Object?> get props => [userId, text];
}

class UpgradeToPremium extends ChatEvent {
  const UpgradeToPremium({required this.userId});

  final String userId;

  @override
  List<Object?> get props => [userId];
}
