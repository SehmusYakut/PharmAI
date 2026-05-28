import 'package:fpdart/fpdart.dart';
import 'package:pharmai/core/error/failures.dart';
import 'package:pharmai/domain/entities/chat_message.dart';
import 'package:pharmai/domain/repositories/chat_repository.dart';

class SendChatMessage {
  const SendChatMessage(this._repository);

  final ChatRepository _repository;

  Stream<Either<Failure, String>> call({
    required List<ChatMessage> history,
    required String message,
    required String localeCode,
  }) => _repository.streamReply(
    history: history,
    message: message,
    localeCode: localeCode,
  );
}
