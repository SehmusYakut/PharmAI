import 'package:equatable/equatable.dart';

enum ChatRole { user, model }

class ChatMessage extends Equatable {
  const ChatMessage({
    required this.id,
    required this.sessionId,
    required this.role,
    required this.content,
    required this.timestamp,
  });

  final int id;
  final int sessionId;
  final ChatRole role;
  final String content;
  final DateTime timestamp;

  bool get isUser => role == ChatRole.user;
  String get text => content;

  @override
  List<Object> get props => [id, sessionId, role, content, timestamp];
}
