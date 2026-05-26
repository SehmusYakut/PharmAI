import 'package:equatable/equatable.dart';

class ChatSession extends Equatable {
  const ChatSession({
    required this.id,
    required this.userId,
    required this.title,
    required this.createdAt,
  });

  final int id;
  final String userId;
  final String title;
  final DateTime createdAt;

  ChatSession copyWith({
    String? title,
  }) =>
      ChatSession(
        id: id,
        userId: userId,
        title: title ?? this.title,
        createdAt: createdAt,
      );

  @override
  List<Object> get props => [id, userId, title, createdAt];
}
