import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmai/domain/entities/bookmark.dart';
import 'package:pharmai/domain/usecases/fetch_bookmarks_by_type.dart';
import 'package:pharmai/domain/usecases/is_bookmarked.dart';
import 'package:pharmai/domain/usecases/toggle_bookmark.dart';

part 'bookmark_event.dart';
part 'bookmark_state.dart';

class BookmarkBloc extends Bloc<BookmarkEvent, BookmarkState> {
  BookmarkBloc({
    required FetchBookmarksByType fetchBookmarksByType,
    required IsBookmarked isBookmarked,
    required ToggleBookmark toggleBookmark,
  }) : _fetchBookmarksByType = fetchBookmarksByType,
       _isBookmarked = isBookmarked,
       _toggleBookmark = toggleBookmark,
       super(const BookmarkState()) {
    on<BookmarkStatusRequested>(_onStatusRequested);
    on<BookmarkToggleRequested>(_onToggleRequested);
    on<BookmarkFetchByTypeRequested>(_onFetchByTypeRequested);
    on<BookmarkRemoveRequested>(_onRemoveRequested);
  }

  final FetchBookmarksByType _fetchBookmarksByType;
  final IsBookmarked _isBookmarked;
  final ToggleBookmark _toggleBookmark;

  static String _key(BookmarkItemType type, String itemId) =>
      '${type.name}:$itemId';

  Future<void> _onStatusRequested(
    BookmarkStatusRequested event,
    Emitter<BookmarkState> emit,
  ) async {
    final current = state;
    final key = _key(event.itemType, event.itemId);
    if (current.statusByKey.containsKey(key)) return;

    final result = await _isBookmarked(
      userId: event.userId,
      itemType: event.itemType,
      itemId: event.itemId,
    );

    result.fold(
      (_) => emit(current),
      (value) => emit(
        current.copyWith(statusByKey: {...current.statusByKey, key: value}),
      ),
    );
  }

  Future<void> _onToggleRequested(
    BookmarkToggleRequested event,
    Emitter<BookmarkState> emit,
  ) async {
    final current = state;
    final key = _key(event.bookmark.itemType, event.bookmark.itemId);

    final result = await _toggleBookmark(bookmark: event.bookmark);
    result.fold(
      (failure) => emit(current.copyWith(errorMessage: failure.message)),
      (isNowSaved) {
        final nextStatus = {...current.statusByKey, key: isNowSaved};
        final updatedState = _updateLists(current, event.bookmark, isNowSaved);
        emit(
          updatedState.copyWith(statusByKey: nextStatus, errorMessage: null),
        );
      },
    );
  }

  Future<void> _onFetchByTypeRequested(
    BookmarkFetchByTypeRequested event,
    Emitter<BookmarkState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final result = await _fetchBookmarksByType(
      userId: event.userId,
      itemType: event.itemType,
    );

    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, errorMessage: failure.message)),
      (bookmarks) {
        final updated = event.itemType == BookmarkItemType.drug
            ? state.copyWith(
                isLoading: false,
                drugBookmarks: bookmarks,
                errorMessage: null,
              )
            : state.copyWith(
                isLoading: false,
                icd10Bookmarks: bookmarks,
                errorMessage: null,
              );
        emit(updated);
      },
    );
  }

  Future<void> _onRemoveRequested(
    BookmarkRemoveRequested event,
    Emitter<BookmarkState> emit,
  ) async {
    final current = state;
    final key = _key(event.itemType, event.itemId);

    final check = await _isBookmarked(
      userId: event.userId,
      itemType: event.itemType,
      itemId: event.itemId,
    );
    final isSaved = check.getOrElse((_) => false);
    if (!isSaved) return;

    final placeholder = Bookmark(
      id: 0,
      userId: event.userId,
      itemType: event.itemType,
      itemId: event.itemId,
      title: '',
      subtitle: '',
      savedAt: DateTime.now(),
    );

    final result = await _toggleBookmark(bookmark: placeholder);
    result.fold(
      (failure) => emit(current.copyWith(errorMessage: failure.message)),
      (_) {
        final nextStatus = {...current.statusByKey, key: false};
        final updated = _removeFromLists(current, event.itemType, event.itemId);
        emit(updated.copyWith(statusByKey: nextStatus, errorMessage: null));
      },
    );
  }

  BookmarkState _updateLists(
    BookmarkState current,
    Bookmark bookmark,
    bool isNowSaved,
  ) {
    if (bookmark.itemType == BookmarkItemType.drug) {
      final list = [...current.drugBookmarks];
      if (isNowSaved) {
        list.insert(0, bookmark);
      } else {
        list.removeWhere((b) => b.itemId == bookmark.itemId);
      }
      return current.copyWith(drugBookmarks: list);
    }

    final list = [...current.icd10Bookmarks];
    if (isNowSaved) {
      list.insert(0, bookmark);
    } else {
      list.removeWhere((b) => b.itemId == bookmark.itemId);
    }
    return current.copyWith(icd10Bookmarks: list);
  }

  BookmarkState _removeFromLists(
    BookmarkState current,
    BookmarkItemType type,
    String itemId,
  ) {
    if (type == BookmarkItemType.drug) {
      final list = [...current.drugBookmarks]
        ..removeWhere((b) => b.itemId == itemId);
      return current.copyWith(drugBookmarks: list);
    }
    final list = [...current.icd10Bookmarks]
      ..removeWhere((b) => b.itemId == itemId);
    return current.copyWith(icd10Bookmarks: list);
  }
}
