import 'package:equatable/equatable.dart';
import 'package:pharmai/domain/entities/drug.dart';

sealed class DrugSearchState extends Equatable {
  const DrugSearchState();
}

final class DrugSearchInitial extends DrugSearchState {
  const DrugSearchInitial();
  @override
  List<Object?> get props => [];
}

final class DrugSearchLoading extends DrugSearchState {
  const DrugSearchLoading({required this.query});
  final String query;
  @override
  List<Object?> get props => [query];
}

final class DrugSearchLoaded extends DrugSearchState {
  const DrugSearchLoaded({required this.query, required this.results});
  final String query;
  final List<Drug> results;
  @override
  List<Object?> get props => [query, results];
}

final class DrugSearchEmpty extends DrugSearchState {
  const DrugSearchEmpty({required this.query});
  final String query;
  @override
  List<Object?> get props => [query];
}

final class DrugSearchError extends DrugSearchState {
  const DrugSearchError({required this.query, required this.message});
  final String query;
  final String message;
  @override
  List<Object?> get props => [query, message];
}
