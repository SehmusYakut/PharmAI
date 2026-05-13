import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmai/core/constants/app_constants.dart';
import 'package:pharmai/domain/usecases/search_drugs.dart';
import 'package:pharmai/presentation/bloc/drug_search/drug_search_event.dart';
import 'package:pharmai/presentation/bloc/drug_search/drug_search_state.dart';

class DrugSearchBloc extends Bloc<DrugSearchEvent, DrugSearchState> {
  DrugSearchBloc(this._searchDrugs) : super(const DrugSearchInitial()) {
    on<DrugSearchQueryChanged>(_onQueryChanged);
    on<DrugSearchCleared>(_onCleared);
    on<DrugSearchFetchRequested>(_onFetch);
  }

  final SearchDrugs _searchDrugs;
  Timer? _debounce;

  void _onQueryChanged(
    DrugSearchQueryChanged event,
    Emitter<DrugSearchState> emit,
  ) {
    _debounce?.cancel();
    final query = event.query.trim();
    if (query.length < AppConstants.minSearchLength) {
      emit(const DrugSearchInitial());
      return;
    }
    emit(DrugSearchLoading(query: query));
    _debounce = Timer(
      const Duration(milliseconds: AppConstants.icd10SearchDebounceMs),
      () => add(DrugSearchFetchRequested(query)),
    );
  }

  void _onCleared(DrugSearchCleared event, Emitter<DrugSearchState> emit) {
    _debounce?.cancel();
    emit(const DrugSearchInitial());
  }

  Future<void> _onFetch(
    DrugSearchFetchRequested event,
    Emitter<DrugSearchState> emit,
  ) async {
    final result = await _searchDrugs(event.query);
    result.fold(
      (failure) =>
          emit(DrugSearchError(query: event.query, message: failure.message)),
      (drugs) => drugs.isEmpty
          ? emit(DrugSearchEmpty(query: event.query))
          : emit(DrugSearchLoaded(query: event.query, results: drugs)),
    );
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }
}
