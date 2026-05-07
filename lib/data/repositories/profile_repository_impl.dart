import 'package:fpdart/fpdart.dart';
import 'package:isar/isar.dart';
import 'package:pharmai/core/error/failures.dart';
import 'package:pharmai/data/datasources/local/local_database_service.dart';
import 'package:pharmai/data/models/bookmark_model.dart';
import 'package:pharmai/data/models/local_profile_model.dart';
import 'package:pharmai/domain/entities/bookmark.dart';
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
  Future<Either<Failure, Unit>> updateProfile(UserProfile profile) async {
    try {
      final isar = await _db.db;
      final existing = await isar.localProfileModels
          .where()
          .firebaseUidEqualTo(profile.firebaseUid)
          .findFirst();
      if (existing == null) {
        return const Left(NotFoundFailure('Profile not found'));
      }
      existing
        ..customName = profile.customName
        ..photoUrl = profile.photoUrl
        ..languageCode = profile.languageCode
        ..isDarkMode = profile.isDarkMode;
      await isar.writeTxn(() => isar.localProfileModels.put(existing));
      return const Right(unit);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Bookmark>>> getBookmarks(String uid) async {
    try {
      final isar = await _db.db;
      final models = await isar.bookmarkModels
          .filter()
          .firebaseUidEqualTo(uid)
          .findAll();
      return Right(models.map((m) => m.toDomain()).toList());
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> addBookmark(
      String uid, Bookmark bookmark) async {
    try {
      final isar = await _db.db;
      final model = BookmarkModel.fromDomain(uid, bookmark);
      await isar.writeTxn(() => isar.bookmarkModels.put(model));
      return const Right(unit);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> removeBookmark(
      String uid, String code) async {
    try {
      final isar = await _db.db;
      final existing = await isar.bookmarkModels
          .filter()
          .firebaseUidEqualTo(uid)
          .and()
          .codeEqualTo(code)
          .findFirst();
      if (existing != null) {
        await isar.writeTxn(() => isar.bookmarkModels.delete(existing.id));
      }
      return const Right(unit);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }
}
