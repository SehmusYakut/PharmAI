import 'package:fpdart/fpdart.dart';
import 'package:pharmai/core/error/failures.dart';
import 'package:pharmai/domain/entities/bookmark.dart';
import 'package:pharmai/domain/repositories/bookmark_repository.dart';

class FetchBookmarksByType {
  const FetchBookmarksByType(this._repository);

  final BookmarkRepository _repository;

  Future<Either<Failure, List<Bookmark>>> call({
    required String userId,
    required BookmarkItemType itemType,
  }) => _repository.fetchBookmarksByType(userId: userId, itemType: itemType);
}
