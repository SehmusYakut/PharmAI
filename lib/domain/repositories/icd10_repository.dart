import 'package:fpdart/fpdart.dart';
import 'package:pharmai/core/error/failures.dart';
import 'package:pharmai/domain/entities/icd10_code.dart';

/// Contract for ICD-10 data access.
///
/// All methods return [Either]:
///   Left  → a typed [Failure] (never throws)
///   Right → the successful result
///
/// Implementations live exclusively in data/.  The domain layer never imports
/// Isar, path_provider, or any I/O package.
abstract class Icd10Repository {
  /// Returns codes whose [Icd10Code.code] starts with [prefix] (case-
  /// insensitive).  E.g. "e11" matches "E11", "E11.0", "E11.9", etc.
  /// [offset] enables cursor-based pagination (pass total results already held).
  Future<Either<Failure, List<Icd10Code>>> searchByCode(
    String prefix, {
    int offset = 0,
  });

  /// Full-text word search across [Icd10Code.descriptionTr] and
  /// [Icd10Code.descriptionEn].  Results are ordered by relevance (code ASC).
  /// [offset] enables cursor-based pagination.
  Future<Either<Failure, List<Icd10Code>>> searchByDescription(
    String query, {
    int offset = 0,
  });

  /// Exact-match lookup.  Returns [Right(null)] when not found (not a failure).
  Future<Either<Failure, Icd10Code?>> findByExactCode(String code);

  /// Bulk-inserts or updates [codes].  Used during first-launch seed import.
  Future<Either<Failure, int>> putAll(List<Icd10Code> codes);

  /// Total number of ICD-10 entries in the local store.
  Future<Either<Failure, int>> count();

  /// Wipes all ICD-10 data – called from KVKK data-erasure flow.
  Future<Either<Failure, void>> clearAll();
}
