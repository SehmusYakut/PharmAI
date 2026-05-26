import 'package:fpdart/fpdart.dart';
import 'package:pharmai/core/error/failures.dart';
import 'package:pharmai/domain/entities/chat_usage.dart';
import 'package:pharmai/domain/repositories/chat_repository.dart';

class GetChatUsage {
  const GetChatUsage(this._repository);

  final ChatRepository _repository;

  Future<Either<Failure, ChatUsage>> call(String userId) =>
      _repository.getUsage(userId);
}
