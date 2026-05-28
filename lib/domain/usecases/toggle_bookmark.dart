import 'package:fpdart/fpdart.dart';
import 'package:pharmai/core/error/failures.dart';
import 'package:pharmai/domain/entities/bookmark.dart';
import 'package:pharmai/domain/repositories/bookmark_repository.dart';

class ToggleBookmark {
  const ToggleBookmark(this._repository);

  final BookmarkRepository _repository;

  Future<Either<Failure, bool>> call({required Bookmark bookmark}) =>
      _repository.toggleBookmark(bookmark: bookmark);
}
