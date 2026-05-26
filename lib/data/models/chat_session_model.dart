import 'package:isar/isar.dart';
import 'package:pharmai/domain/entities/chat_session.dart';

part 'chat_session_model.g.dart';

@collection
class ChatSessionModel {
  Id id = Isar.autoIncrement;

  @Index(type: IndexType.hash)
  late String firebaseUid;

  late String title;
  late DateTime createdAt;

  ChatSession toDomain() => ChatSession(
    id: id,
    userId: firebaseUid,
    title: title,
    createdAt: createdAt,
  );

  static ChatSessionModel fromValues({
    required String userId,
    required String title,
    required DateTime createdAt,
  }) => ChatSessionModel()
    ..firebaseUid = userId
    ..title = title
    ..createdAt = createdAt;

  void updateTitle(String value) {
    title = value.trim();
  }
}
