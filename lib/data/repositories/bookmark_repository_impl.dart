import 'package:fpdart/fpdart.dart';
import 'package:isar/isar.dart';
import 'package:pharmai/core/error/failures.dart';
import 'package:pharmai/data/datasources/local/local_database_service.dart';
import 'package:pharmai/data/models/bookmark_model.dart';
import 'package:pharmai/domain/entities/bookmark.dart';
import 'package:pharmai/domain/repositories/bookmark_repository.dart';

class BookmarkRepositoryImpl implements BookmarkRepository {
  BookmarkRepositoryImpl(this._db);

  final LocalDatabaseService _db;

  @override
  Future<Either<Failure, bool>> toggleBookmark({
    required Bookmark bookmark,
  }) async {
    try {
      final isar = await _db.db;
      final existing = await isar.bookmarkModels
          .filter()
          .firebaseUidEqualTo(bookmark.userId)
          .and()
          .categoryEqualTo(bookmark.itemType.name)
          .and()
          .codeEqualTo(bookmark.itemId)
          .findFirst();

      if (existing != null) {
        await isar.writeTxn(() => isar.bookmarkModels.delete(existing.id));
        return const Right(false);
      }
      final model = BookmarkModel.fromDomain(bookmark);
      await isar.writeTxn(() => isar.bookmarkModels.put(model));
      return const Right(true);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> isBookmarked({
    required String userId,
    required BookmarkItemType itemType,
    required String itemId,
  }) async {
    try {
      final isar = await _db.db;
      final existing = await isar.bookmarkModels
          .filter()
          .firebaseUidEqualTo(userId)
          .and()
          .categoryEqualTo(itemType.name)
          .and()
          .codeEqualTo(itemId)
          .findFirst();
      return Right(existing != null);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Bookmark>>> fetchBookmarksByType({
    required String userId,
    required BookmarkItemType itemType,
  }) async {
    try {
      final isar = await _db.db;
      final models = await isar.bookmarkModels
          .filter()
          .firebaseUidEqualTo(userId)
          .and()
          .categoryEqualTo(itemType.name)
          .sortBySavedAtDesc()
          .findAll();
      return Right(models.map((m) => m.toDomain()).toList());
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Bookmark>>> fetchAllBookmarks(String userId) async {
    try {
      final isar = await _db.db;
      final models = await isar.bookmarkModels
          .filter()
          .firebaseUidEqualTo(userId)
          .sortBySavedAtDesc()
          .findAll();
      return Right(models.map((m) => m.toDomain()).toList());
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }
}
