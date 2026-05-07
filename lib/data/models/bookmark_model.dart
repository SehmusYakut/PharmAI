import 'package:isar/isar.dart';
import 'package:pharmai/domain/entities/bookmark.dart';

part 'bookmark_model.g.dart';

@collection
class BookmarkModel {
  Id id = Isar.autoIncrement;

  @Index(type: IndexType.hash)
  late String firebaseUid;

  @Index(type: IndexType.hash)
  late String code;

  late String category;
  late DateTime savedAt;

  Bookmark toDomain() => Bookmark(
        code: code,
        category: category,
        savedAt: savedAt,
      );

  static BookmarkModel fromDomain(String uid, Bookmark b) => BookmarkModel()
    ..firebaseUid = uid
    ..code = b.code
    ..category = b.category
    ..savedAt = b.savedAt;
}
