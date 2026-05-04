import 'package:fpdart/fpdart.dart';
import 'package:pharmai/core/error/failures.dart';
import 'package:pharmai/domain/entities/icd10_code.dart';
import 'package:pharmai/domain/repositories/icd10_repository.dart';

/// Routes a free-text query to the most appropriate search strategy and
/// delegates to [Icd10Repository].
///
/// ICD-10 code detection:
///   A code always starts with an ASCII letter immediately followed by a
///   digit (e.g. "E11", "J00", "A09.0").  Any other input is treated as a
///   description search (e.g. "diabetes", "pneumoni").
///
/// The [offset] parameter enables cursor-based pagination: pass the total
/// number of results already held by the caller to fetch the next page.
class SearchIcd10 {
  const SearchIcd10(this._repository);

  final Icd10Repository _repository;

  static final _codePattern = RegExp(r'^[A-Za-z]\d', caseSensitive: false);

  Future<Either<Failure, List<Icd10Code>>> call(
    String query, {
    int offset = 0,
  }) {
    final trimmed = query.trim();
    if (_codePattern.hasMatch(trimmed)) {
      return _repository.searchByCode(trimmed, offset: offset);
    }
    return _repository.searchByDescription(trimmed, offset: offset);
  }
}
