import 'package:isar/isar.dart';
import 'package:pharmai/domain/entities/chat_message.dart';

part 'chat_message_model.g.dart';

@collection
class ChatMessageModel {
  Id id = Isar.autoIncrement;

  @Index()
  late int sessionId;

  @Index(type: IndexType.hash)
  late String role;

  late String content;
  late DateTime timestamp;

  ChatMessage toDomain() => ChatMessage(
        id: id,
        sessionId: sessionId,
        role: _toRole(role),
        content: content,
        timestamp: timestamp,
      );

  static ChatMessageModel fromDomain(ChatMessage message) =>
      ChatMessageModel()
        ..sessionId = message.sessionId
        ..role = message.role.name
        ..content = message.content
        ..timestamp = message.timestamp;

  static ChatRole _toRole(String value) =>
      value == ChatRole.model.name ? ChatRole.model : ChatRole.user;
}
