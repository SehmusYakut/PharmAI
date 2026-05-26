import 'package:isar/isar.dart';
import 'package:pharmai/domain/entities/chat_usage.dart';

part 'chat_usage_model.g.dart';

@collection
class ChatUsageModel {
  Id id = Isar.autoIncrement;

  @Index(type: IndexType.hash, unique: true)
  late String firebaseUid;

  int queryCount = 0;
  bool isPremium = false;

  ChatUsage toDomain() => ChatUsage(
        userId: firebaseUid,
        queryCount: queryCount,
        isPremium: isPremium,
      );

  static ChatUsageModel fromValues({
    required String userId,
    required int queryCount,
    required bool isPremium,
  }) =>
      ChatUsageModel()
        ..firebaseUid = userId
        ..queryCount = queryCount
        ..isPremium = isPremium;
}
