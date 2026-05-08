import 'package:fpdart/fpdart.dart';
import 'package:pharmai/core/error/failures.dart';
import 'package:pharmai/domain/entities/icd10_code.dart';
import 'package:pharmai/domain/repositories/icd10_repository.dart';

/// Delegates free-text ICD-10 queries to [Icd10Repository.search], which
/// combines a fast code-startsWith pass with a broad code+description
/// contains filter in a single call.
///
/// The [offset] parameter enables cursor-based pagination: pass the total
/// number of results already held by the caller to fetch the next page.
class SearchIcd10 {
  const SearchIcd10(this._repository);

  final Icd10Repository _repository;

  Future<Either<Failure, List<Icd10Code>>> call(
    String query, {
    int offset = 0,
  }) =>
      _repository.search(query, offset: offset);
}
