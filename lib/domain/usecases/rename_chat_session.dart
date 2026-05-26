import 'package:fpdart/fpdart.dart';
import 'package:pharmai/core/error/failures.dart';
import 'package:pharmai/domain/repositories/chat_repository.dart';

class RenameChatSession {
  const RenameChatSession(this._repository);

  final ChatRepository _repository;

  Future<Either<Failure, Unit>> call({
    required int sessionId,
    required String newTitle,
  }) => _repository.renameSession(sessionId, newTitle);
}
