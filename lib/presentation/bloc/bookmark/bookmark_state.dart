part of 'bookmark_bloc.dart';

class BookmarkState extends Equatable {
  const BookmarkState({
    this.statusByKey = const {},
    this.drugBookmarks = const [],
    this.icd10Bookmarks = const [],
    this.isLoading = false,
    this.errorMessage,
  });

  final Map<String, bool> statusByKey;
  final List<Bookmark> drugBookmarks;
  final List<Bookmark> icd10Bookmarks;
  final bool isLoading;
  final String? errorMessage;

  BookmarkState copyWith({
    Map<String, bool>? statusByKey,
    List<Bookmark>? drugBookmarks,
    List<Bookmark>? icd10Bookmarks,
    bool? isLoading,
    String? errorMessage,
  }) => BookmarkState(
    statusByKey: statusByKey ?? this.statusByKey,
    drugBookmarks: drugBookmarks ?? this.drugBookmarks,
    icd10Bookmarks: icd10Bookmarks ?? this.icd10Bookmarks,
    isLoading: isLoading ?? this.isLoading,
    errorMessage: errorMessage,
  );

  bool hasStatus(BookmarkItemType itemType, String itemId) =>
      statusByKey.containsKey(_key(itemType, itemId));

  bool isBookmarked(BookmarkItemType itemType, String itemId) =>
      statusByKey[_key(itemType, itemId)] ?? false;

  static String _key(BookmarkItemType itemType, String itemId) =>
      '${itemType.name}:$itemId';

  @override
  List<Object?> get props => [
    statusByKey,
    drugBookmarks,
    icd10Bookmarks,
    isLoading,
    errorMessage,
  ];
}
