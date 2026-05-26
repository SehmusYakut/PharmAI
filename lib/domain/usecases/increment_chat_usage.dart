import 'package:fpdart/fpdart.dart';
import 'package:pharmai/core/error/failures.dart';
import 'package:pharmai/domain/repositories/chat_repository.dart';

class IncrementChatUsage {
  const IncrementChatUsage(this._repository);

  final ChatRepository _repository;

  Future<Either<Failure, Unit>> call(String userId) =>
      _repository.incrementUsage(userId);
}
