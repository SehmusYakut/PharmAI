import 'package:equatable/equatable.dart';
import 'package:pharmai/domain/entities/icd10_code.dart';

/// Sealed hierarchy so every BlocBuilder switch is exhaustive at compile-time.
sealed class Icd10SearchState extends Equatable {
  const Icd10SearchState();
}

/// Nothing typed yet – show hint UI.
final class Icd10SearchInitial extends Icd10SearchState {
  const Icd10SearchInitial();
  @override
  List<Object?> get props => [];
}

/// Query debounce in progress – show shimmer/spinner.
final class Icd10SearchLoading extends Icd10SearchState {
  const Icd10SearchLoading({required this.query});
  final String query;
  @override
  List<Object?> get props => [query];
}

/// Results available.  [isLoadingMore] is true while the next page is fetching
/// (the existing [results] list is kept visible, a bottom spinner is added).
final class Icd10SearchLoaded extends Icd10SearchState {
  const Icd10SearchLoaded({
    required this.query,
    required this.results,
    required this.canLoadMore,
    this.isLoadingMore = false,
  });

  final String query;
  final List<Icd10Code> results;

  /// True when the last page returned exactly [AppConstants.maxSearchResults]
  /// items, meaning more results likely exist.
  final bool canLoadMore;

  /// True while an additional page is being fetched without replacing [results].
  final bool isLoadingMore;

  /// [query] is intentionally absent from [copyWith]: once a results state
  /// is created the search query is frozen — starting a new query replaces
  /// the entire state rather than mutating an existing one.
  Icd10SearchLoaded copyWith({
    List<Icd10Code>? results,
    bool? canLoadMore,
    bool? isLoadingMore,
  }) =>
      Icd10SearchLoaded(
        query: query,
        results: results ?? this.results,
        canLoadMore: canLoadMore ?? this.canLoadMore,
        isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      );

  @override
  List<Object?> get props => [query, results, canLoadMore, isLoadingMore];
}

/// Query returned zero results.
final class Icd10SearchEmpty extends Icd10SearchState {
  const Icd10SearchEmpty({required this.query});
  final String query;
  @override
  List<Object?> get props => [query];
}

/// A [Failure] was returned from the repository.
final class Icd10SearchError extends Icd10SearchState {
  const Icd10SearchError({required this.query, required this.message});
  final String query;
  final String message;
  @override
  List<Object?> get props => [query, message];
}
