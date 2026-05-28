import 'package:isar/isar.dart';
import 'package:pharmai/domain/entities/bookmark.dart';

part 'bookmark_model.g.dart';

@collection
class BookmarkModel {
  Id id = Isar.autoIncrement;

  @Index(type: IndexType.hash)
  late String firebaseUid;

  @Index(type: IndexType.hash)
  late String category;

  @Index(type: IndexType.hash)
  late String code;

  late DateTime savedAt;

  Bookmark toDomain() => Bookmark(
    id: id,
    userId: firebaseUid,
    itemType: BookmarkItemType.values.firstWhere(
      (e) => e.name == category,
      orElse: () => BookmarkItemType.icd10,
    ),
    itemId: code,
    title: code, // Fallback as title is missing in current schema
    subtitle: category, // Fallback as subtitle is missing in current schema
    savedAt: savedAt,
  );

  static BookmarkModel fromDomain(Bookmark b) => BookmarkModel()
    ..firebaseUid = b.userId
    ..category = b.itemType.name
    ..code = b.itemId
    ..savedAt = b.savedAt;
}
