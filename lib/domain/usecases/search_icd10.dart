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

  // Inserts a space at letter→digit and digit→letter boundaries so that
  // "type2" matches "Type 2", "e11" still routes to code search, etc.
  static final _letterDigit = RegExp(r'([A-Za-zÀ-ÿ])(\d)');
  static final _digitLetter = RegExp(r'(\d)([A-Za-zÀ-ÿ])');
  static final _multiSpace = RegExp(r'\s+');

  static String _normalise(String raw) => raw
      .trim()
      .replaceAll(_multiSpace, ' ')
      .replaceAllMapped(_letterDigit, (m) => '${m[1]} ${m[2]}')
      .replaceAllMapped(_digitLetter, (m) => '${m[1]} ${m[2]}');

  Future<Either<Failure, List<Icd10Code>>> call(
    String query, {
    int offset = 0,
  }) {
    final normalised = _normalise(query);
    if (_codePattern.hasMatch(normalised)) {
      return _repository.searchByCode(normalised, offset: offset);
    }
    return _repository.searchByDescription(normalised, offset: offset);
  }
}
