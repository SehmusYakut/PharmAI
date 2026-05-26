import 'package:fpdart/fpdart.dart';
import 'package:pharmai/core/error/failures.dart';
import 'package:pharmai/domain/entities/chat_message.dart';
import 'package:pharmai/domain/repositories/chat_repository.dart';

class AddChatMessage {
  const AddChatMessage(this._repository);

  final ChatRepository _repository;

  Future<Either<Failure, ChatMessage>> call(ChatMessage message) =>
      _repository.addMessage(message);
}
