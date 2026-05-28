part of 'bookmark_bloc.dart';

abstract class BookmarkEvent extends Equatable {
  const BookmarkEvent();

  @override
  List<Object?> get props => [];
}

class BookmarkStatusRequested extends BookmarkEvent {
  const BookmarkStatusRequested({
    required this.userId,
    required this.itemType,
    required this.itemId,
  });

  final String userId;
  final BookmarkItemType itemType;
  final String itemId;

  @override
  List<Object?> get props => [userId, itemType, itemId];
}

class BookmarkToggleRequested extends BookmarkEvent {
  const BookmarkToggleRequested({required this.bookmark});

  final Bookmark bookmark;

  @override
  List<Object?> get props => [bookmark];
}

class BookmarkFetchByTypeRequested extends BookmarkEvent {
  const BookmarkFetchByTypeRequested({
    required this.userId,
    required this.itemType,
  });

  final String userId;
  final BookmarkItemType itemType;

  @override
  List<Object?> get props => [userId, itemType];
}

class BookmarkRemoveRequested extends BookmarkEvent {
  const BookmarkRemoveRequested({
    required this.userId,
    required this.itemType,
    required this.itemId,
  });

  final String userId;
  final BookmarkItemType itemType;
  final String itemId;

  @override
  List<Object?> get props => [userId, itemType, itemId];
}
