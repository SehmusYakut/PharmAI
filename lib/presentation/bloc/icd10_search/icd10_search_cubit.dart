import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmai/core/constants/app_constants.dart';
import 'package:pharmai/domain/entities/icd10_code.dart';
import 'package:pharmai/domain/usecases/search_icd10.dart';

import 'icd10_search_state.dart';

/// Manages ICD-10 search lifecycle:
///   • Debounces keystrokes (300 ms) before hitting the database.
///   • Routes to the correct Isar query strategy via [SearchIcd10].
///   • Re-ranks results client-side for fuzzy relevance ordering.
///   • Supports cursor-based pagination via [loadMore].
class Icd10SearchCubit extends Cubit<Icd10SearchState> {
  Icd10SearchCubit(this._searchIcd10) : super(const Icd10SearchInitial());

  final SearchIcd10 _searchIcd10;

  Timer? _debounce;
  String _lastQuery = '';
  int _nextOffset = 0;

  // ── Public API ──────────────────────────────────────────────────────────────

  /// Called on every keystroke from the search field.
  /// Resets pagination, debounces 300 ms, then fires [_fetch].
  void onQueryChanged(String raw) {
    _debounce?.cancel();
    final query = raw.trim();

    if (query.isEmpty) {
      _reset();
      emit(const Icd10SearchInitial());
      return;
    }

    emit(Icd10SearchLoading(query: query));
    _debounce = Timer(
      const Duration(milliseconds: AppConstants.icd10SearchDebounceMs),
      () => _fetch(query, offset: 0),
    );
  }

  /// Appends the next page of results when the user scrolls to the bottom.
  /// No-op if already loading, nothing more to load, or state is not [Icd10SearchLoaded].
  Future<void> loadMore() async {
    final s = state;
    if (s is! Icd10SearchLoaded || !s.canLoadMore || s.isLoadingMore) return;
    emit(s.copyWith(isLoadingMore: true));
    await _fetch(_lastQuery, offset: _nextOffset, append: true);
  }

  /// Clears the search and returns to the initial hint state.
  void clear() {
    _debounce?.cancel();
    _reset();
    emit(const Icd10SearchInitial());
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }

  // ── Internals ───────────────────────────────────────────────────────────────

  void _reset() {
    _lastQuery = '';
    _nextOffset = 0;
  }

  Future<void> _fetch(
    String query, {
    required int offset,
    bool append = false,
  }) async {
    _lastQuery = query;

    final result = await _searchIcd10(query, offset: offset);

    result.fold(
      (failure) =>
          emit(Icd10SearchError(query: query, message: failure.message)),
      (fresh) {
        // Fresh page: rank by relevance (only for page 0 – appended pages keep
        // server order since the user has already seen ranked items above).
        final page = append ? fresh : _rank(fresh, query);

        if (!append && page.isEmpty) {
          emit(Icd10SearchEmpty(query: query));
          return;
        }

        final previous = append && state is Icd10SearchLoaded
            ? (state as Icd10SearchLoaded).results
            : <Icd10Code>[];

        _nextOffset = offset + fresh.length;

        emit(
          Icd10SearchLoaded(
            query: query,
            results: [...previous, ...page],
            // More results exist when the server returned a full page.
            canLoadMore: fresh.length == AppConstants.maxSearchResults,
            isLoadingMore: false,
          ),
        );
      },
    );
  }

  /// Client-side relevance ranking.
  ///
  /// Scores are assigned in descending priority so that exact code matches
  /// bubble to the top, followed by prefix matches, then substring matches.
  /// This gives "fuzzy" ordering on top of Isar's fast containment filter.
  List<Icd10Code> _rank(List<Icd10Code> codes, String query) {
    final q = query.toLowerCase();

    int score(Icd10Code c) {
      final code = c.code.toLowerCase();
      final tr = c.descriptionTr.toLowerCase();
      final en = c.descriptionEn.toLowerCase();

      if (code == q) return 100;
      if (code.startsWith(q)) return 90;
      if (tr.startsWith(q)) return 80;
      if (en.startsWith(q)) return 70;
      if (tr.split(' ').any((w) => w.startsWith(q))) return 65;
      if (en.split(' ').any((w) => w.startsWith(q))) return 60;
      if (tr.contains(q)) return 50;
      if (en.contains(q)) return 40;
      return 0;
    }

    return [...codes]..sort((a, b) => score(b).compareTo(score(a)));
  }
}
