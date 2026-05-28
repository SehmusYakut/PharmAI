import 'package:fpdart/fpdart.dart';
import 'package:pharmai/core/error/failures.dart';
import 'package:pharmai/domain/entities/bookmark.dart';

abstract class BookmarkRepository {
  Future<Either<Failure, bool>> toggleBookmark({required Bookmark bookmark});
  Future<Either<Failure, bool>> isBookmarked({
    required String userId,
    required BookmarkItemType itemType,
    required String itemId,
  });
  Future<Either<Failure, List<Bookmark>>> fetchBookmarksByType({
    required String userId,
    required BookmarkItemType itemType,
  });
  Future<Either<Failure, List<Bookmark>>> fetchAllBookmarks(String userId);
}
