import 'package:fpdart/fpdart.dart';
import 'package:pharmai/core/error/failures.dart';
import 'package:pharmai/domain/entities/chat_message.dart';
import 'package:pharmai/domain/repositories/chat_repository.dart';

class FetchChatMessages {
  const FetchChatMessages(this._repository);

  final ChatRepository _repository;

  Future<Either<Failure, List<ChatMessage>>> call(int sessionId) =>
      _repository.fetchMessages(sessionId);
}
