import 'package:fpdart/fpdart.dart';
import 'package:pharmai/core/error/failures.dart';
import 'package:pharmai/domain/entities/bookmark.dart';
import 'package:pharmai/domain/repositories/bookmark_repository.dart';

class IsBookmarked {
  const IsBookmarked(this._repository);

  final BookmarkRepository _repository;

  Future<Either<Failure, bool>> call({
    required String userId,
    required BookmarkItemType itemType,
    required String itemId,
  }) => _repository.isBookmarked(
    userId: userId,
    itemType: itemType,
    itemId: itemId,
  );
}
