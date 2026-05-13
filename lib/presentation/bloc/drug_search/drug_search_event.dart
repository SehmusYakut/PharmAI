import 'package:equatable/equatable.dart';

sealed class DrugSearchEvent extends Equatable {
  const DrugSearchEvent();
}

final class DrugSearchQueryChanged extends DrugSearchEvent {
  const DrugSearchQueryChanged(this.query);
  final String query;
  @override
  List<Object?> get props => [query];
}

final class DrugSearchCleared extends DrugSearchEvent {
  const DrugSearchCleared();
  @override
  List<Object?> get props => [];
}

/// Internal event fired by the debounce timer — not part of the public API.
final class DrugSearchFetchRequested extends DrugSearchEvent {
  const DrugSearchFetchRequested(this.query);
  final String query;
  @override
  List<Object?> get props => [query];
}
