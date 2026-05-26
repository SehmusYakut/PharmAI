import 'package:fpdart/fpdart.dart';
import 'package:pharmai/core/error/failures.dart';
import 'package:pharmai/domain/entities/chat_session.dart';
import 'package:pharmai/domain/repositories/chat_repository.dart';

class StartChatSession {
  const StartChatSession(this._repository);

  final ChatRepository _repository;

  Future<Either<Failure, ChatSession>> call(String userId) =>
      _repository.createSession(userId);
}
