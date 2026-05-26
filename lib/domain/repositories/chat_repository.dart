import 'package:fpdart/fpdart.dart';
import 'package:pharmai/core/error/failures.dart';
import 'package:pharmai/domain/entities/chat_message.dart';
import 'package:pharmai/domain/entities/chat_session.dart';
import 'package:pharmai/domain/entities/chat_usage.dart';

abstract class ChatRepository {
  Future<Either<Failure, List<ChatSession>>> fetchSessions(String userId);
  Future<Either<Failure, ChatSession>> createSession(String userId);
  Future<Either<Failure, Unit>> renameSession(int sessionId, String newTitle);
  Future<Either<Failure, String>> generateSessionTitle(String prompt);
  Future<Either<Failure, List<ChatMessage>>> fetchMessages(int sessionId);
  Future<Either<Failure, ChatMessage>> addMessage(ChatMessage message);
  Future<Either<Failure, String>> generateReply({
    required List<ChatMessage> history,
    required String message,
  });
  Future<Either<Failure, ChatUsage>> getUsage(String userId);
  Future<Either<Failure, Unit>> incrementUsage(String userId);
  Future<Either<Failure, Unit>> setPremium(String userId, bool value);
}
