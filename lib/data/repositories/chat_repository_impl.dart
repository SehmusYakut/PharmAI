import 'package:fpdart/fpdart.dart';
import 'package:isar/isar.dart';
import 'package:pharmai/core/error/failures.dart';
import 'package:pharmai/data/datasources/local/local_database_service.dart';
import 'package:pharmai/data/datasources/remote/gemini_chat_service.dart';
import 'package:pharmai/data/models/chat_message_model.dart';
import 'package:pharmai/data/models/chat_session_model.dart';
import 'package:pharmai/data/models/chat_usage_model.dart';
import 'package:pharmai/domain/entities/chat_message.dart';
import 'package:pharmai/domain/entities/chat_session.dart';
import 'package:pharmai/domain/entities/chat_usage.dart';
import 'package:pharmai/domain/repositories/chat_repository.dart';

class ChatRepositoryImpl implements ChatRepository {
  ChatRepositoryImpl(this._db, this._ai);

  final LocalDatabaseService _db;
  final GeminiChatService _ai;

  @override
  Future<Either<Failure, List<ChatSession>>> fetchSessions(
    String userId,
  ) async {
    try {
      final isar = await _db.db;
      final models = await isar.chatSessionModels
          .filter()
          .firebaseUidEqualTo(userId)
          .sortByCreatedAtDesc()
          .findAll();
      return Right(models.map((m) => m.toDomain()).toList());
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ChatSession>> createSession(String userId) async {
    try {
      final isar = await _db.db;
      final model = ChatSessionModel.fromValues(
        userId: userId,
        title: '',
        createdAt: DateTime.now(),
      );
      await isar.writeTxn(() => isar.chatSessionModels.put(model));
      return Right(model.toDomain());
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> renameSession(
    int sessionId,
    String newTitle,
  ) async {
    try {
      final isar = await _db.db;
      final model = await isar.chatSessionModels.get(sessionId);
      if (model == null) {
        return Left(CacheFailure('Session not found.'));
      }
      model.title = newTitle.trim();
      await isar.writeTxn(() => isar.chatSessionModels.put(model));
      return const Right(unit);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> generateSessionTitle(String prompt) async {
    try {
      final title = await _ai.generateTitle(prompt: prompt);
      return Right(title);
    } catch (e) {
      return Left(NetworkFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ChatMessage>>> fetchMessages(
    int sessionId,
  ) async {
    try {
      final isar = await _db.db;
      final models = await isar.chatMessageModels
          .filter()
          .sessionIdEqualTo(sessionId)
          .sortByTimestamp()
          .findAll();
      return Right(models.map((m) => m.toDomain()).toList());
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ChatMessage>> addMessage(ChatMessage message) async {
    try {
      final isar = await _db.db;
      final model = ChatMessageModel.fromDomain(message);
      await isar.writeTxn(() => isar.chatMessageModels.put(model));
      return Right(model.toDomain());
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> generateReply({
    required List<ChatMessage> history,
    required String message,
    required String localeCode,
  }) async {
    try {
      final text = await _ai.generateReply(
        history: history,
        message: message,
        localeCode: localeCode,
      );
      return Right(text);
    } catch (e) {
      return Left(NetworkFailure(e.toString()));
    }
  }

  @override
  Stream<Either<Failure, String>> streamReply({
    required List<ChatMessage> history,
    required String message,
    required String localeCode,
  }) async* {
    try {
      await for (final chunk in _ai.streamReply(
        history: history,
        message: message,
        localeCode: localeCode,
      )) {
        if (chunk.isEmpty) continue;
        yield Right(chunk);
      }
    } catch (e) {
      yield Left(NetworkFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ChatUsage>> getUsage(String userId) async {
    try {
      final isar = await _db.db;
      var usage = await isar.chatUsageModels
          .where()
          .firebaseUidEqualTo(userId)
          .findFirst();
      final isNew = usage == null;
      usage ??= ChatUsageModel.fromValues(
        userId: userId,
        queryCount: 0,
        isPremium: false,
      );
      if (isNew) {
        await isar.writeTxn(() => isar.chatUsageModels.put(usage!));
      }
      return Right(usage.toDomain());
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> incrementUsage(String userId) async {
    try {
      final isar = await _db.db;
      var usage = await isar.chatUsageModels
          .where()
          .firebaseUidEqualTo(userId)
          .findFirst();
      usage ??= ChatUsageModel.fromValues(
        userId: userId,
        queryCount: 0,
        isPremium: false,
      );
      usage.queryCount += 1;
      await isar.writeTxn(() => isar.chatUsageModels.put(usage!));
      return const Right(unit);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> setPremium(String userId, bool value) async {
    try {
      final isar = await _db.db;
      var usage = await isar.chatUsageModels
          .where()
          .firebaseUidEqualTo(userId)
          .findFirst();
      usage ??= ChatUsageModel.fromValues(
        userId: userId,
        queryCount: 0,
        isPremium: false,
      );
      usage.isPremium = value;
      await isar.writeTxn(() => isar.chatUsageModels.put(usage!));
      return const Right(unit);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }
}
