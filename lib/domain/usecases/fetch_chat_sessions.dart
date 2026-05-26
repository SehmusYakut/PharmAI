import 'package:fpdart/fpdart.dart';
import 'package:pharmai/core/error/failures.dart';
import 'package:pharmai/domain/entities/chat_session.dart';
import 'package:pharmai/domain/repositories/chat_repository.dart';

class FetchChatSessions {
  const FetchChatSessions(this._repository);

  final ChatRepository _repository;

  Future<Either<Failure, List<ChatSession>>> call(String userId) =>
      _repository.fetchSessions(userId);
}
