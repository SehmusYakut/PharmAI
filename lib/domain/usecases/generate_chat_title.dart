import 'package:fpdart/fpdart.dart';
import 'package:pharmai/core/error/failures.dart';
import 'package:pharmai/domain/repositories/chat_repository.dart';

class GenerateChatTitle {
  const GenerateChatTitle(this._repository);

  final ChatRepository _repository;

  Future<Either<Failure, String>> call(String prompt) =>
      _repository.generateSessionTitle(prompt);
}
