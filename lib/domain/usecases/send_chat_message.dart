import 'package:fpdart/fpdart.dart';
import 'package:pharmai/core/error/failures.dart';
import 'package:pharmai/domain/entities/chat_message.dart';
import 'package:pharmai/domain/repositories/chat_repository.dart';

class SendChatMessage {
  const SendChatMessage(this._repository);

  final ChatRepository _repository;

  Future<Either<Failure, String>> call({
    required List<ChatMessage> history,
    required String message,
  }) =>
      _repository.generateReply(history: history, message: message);
}
