import 'package:fpdart/fpdart.dart';
import 'package:isar/isar.dart';
import 'package:pharmai/core/error/failures.dart';
import 'package:pharmai/data/datasources/local/local_database_service.dart';
import 'package:pharmai/data/models/bookmark_model.dart';
import 'package:pharmai/data/models/chat_message_model.dart';
import 'package:pharmai/data/models/chat_session_model.dart';
import 'package:pharmai/data/models/chat_usage_model.dart';
import 'package:pharmai/data/models/local_profile_model.dart';
import 'package:pharmai/domain/entities/user_profile.dart';
import 'package:pharmai/domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  ProfileRepositoryImpl(this._db);
  final LocalDatabaseService _db;

  @override
  Future<Either<Failure, UserProfile>> getOrCreate({
    required String uid,
    required String email,
    String? displayName,
    String? photoUrl,
  }) async {
    try {
      final isar = await _db.db;
      var model = await isar.localProfileModels
          .where()
          .firebaseUidEqualTo(uid)
          .findFirst();
      if (model == null) {
        model = LocalProfileModel()
          ..firebaseUid = uid
          ..email = email
          ..customName = displayName
          ..photoUrl = photoUrl;
        await isar.writeTxn(() => isar.localProfileModels.put(model!));
      }
      return Right(model.toDomain());
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserProfile?>> getProfile(String uid) async {
    try {
      final isar = await _db.db;
      final model = await isar.localProfileModels
          .where()
          .firebaseUidEqualTo(uid)
          .findFirst();
      return Right(model?.toDomain());
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateProfile(UserProfile updatedProfile) async {
    try {
      final isar = await _db.db;
      final existing = await isar.localProfileModels
          .where()
          .firebaseUidEqualTo(updatedProfile.firebaseUid)
          .findFirst();

      if (existing == null) {
        return const Left(NotFoundFailure('Profile not found'));
      }

      final updated = LocalProfileModel()
        ..id = existing.id
        ..firebaseUid = updatedProfile.firebaseUid
        ..email = updatedProfile.email
        ..customName = updatedProfile.customName
        ..photoUrl = updatedProfile.photoUrl
        ..languageCode = updatedProfile.languageCode
        ..themeMode = updatedProfile.themeMode;

      await isar.writeTxn(() => isar.localProfileModels.put(updated));
      return const Right(unit);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteProfile(String uid) async {
    try {
      final isar = await _db.db;
      await isar.writeTxn(() async {
        // 1. Delete bookmarks
        final bookmarks = await isar.bookmarkModels
            .filter()
            .firebaseUidEqualTo(uid)
            .findAll();
        for (final b in bookmarks) {
          await isar.bookmarkModels.delete(b.id);
        }

        // 2. Delete chat messages and sessions
        final sessions = await isar.chatSessionModels
            .filter()
            .firebaseUidEqualTo(uid)
            .findAll();
        for (final session in sessions) {
          final messages = await isar.chatMessageModels
              .filter()
              .sessionIdEqualTo(session.id)
              .findAll();
          for (final message in messages) {
            await isar.chatMessageModels.delete(message.id);
          }
          await isar.chatSessionModels.delete(session.id);
        }

        // 3. Delete chat usage
        final usage = await isar.chatUsageModels
            .filter()
            .firebaseUidEqualTo(uid)
            .findFirst();
        if (usage != null) {
          await isar.chatUsageModels.delete(usage.id);
        }

        // 4. Delete local profile itself
        final profile = await isar.localProfileModels
            .filter()
            .firebaseUidEqualTo(uid)
            .findFirst();
        if (profile != null) {
          await isar.localProfileModels.delete(profile.id);
        }
      });
      return const Right(unit);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }
}
