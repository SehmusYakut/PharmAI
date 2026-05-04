import 'package:fpdart/fpdart.dart';
import 'package:pharmai/core/error/failures.dart';
import 'package:pharmai/data/datasources/local/local_database_service.dart';
import 'package:pharmai/data/models/icd10_code_model.dart';
import 'package:pharmai/domain/entities/icd10_code.dart';
import 'package:pharmai/domain/repositories/icd10_repository.dart';

/// Concrete implementation of [Icd10Repository].
///
/// All calls are local-first (ProjectRules §7 – prefer Isar over network).
/// Every method catches exceptions at the data-layer boundary and returns
/// a typed [Failure] so callers never see raw exceptions.
class Icd10RepositoryImpl implements Icd10Repository {
  const Icd10RepositoryImpl(this._db);

  final LocalDatabaseService _db;

  @override
  Future<Either<Failure, List<Icd10Code>>> searchByCode(
    String prefix, {
    int offset = 0,
  }) async {
    if (prefix.isEmpty) return right(const []);
    try {
      final models = await _db.searchByCodePrefix(prefix, offset: offset);
      return right(models.map((m) => m.toDomain()).toList());
    } catch (_) {
      return left(const CacheFailure('ICD-10 code search failed.'));
    }
  }

  @override
  Future<Either<Failure, List<Icd10Code>>> searchByDescription(
    String query, {
    int offset = 0,
  }) async {
    if (query.trim().isEmpty) return right(const []);
    try {
      final models = await _db.searchByDescription(query, offset: offset);
      return right(models.map((m) => m.toDomain()).toList());
    } catch (_) {
      return left(const CacheFailure('ICD-10 description search failed.'));
    }
  }

  @override
  Future<Either<Failure, Icd10Code?>> findByExactCode(String code) async {
    try {
      final model = await _db.findByExactCode(code);
      return right(model?.toDomain());
    } catch (_) {
      return left(const CacheFailure('ICD-10 exact lookup failed.'));
    }
  }

  @override
  Future<Either<Failure, int>> putAll(List<Icd10Code> codes) async {
    try {
      final models = codes.map(Icd10CodeModel.fromDomain).toList();
      final count = await _db.putAllIcd10(models);
      return right(count);
    } catch (_) {
      return left(const CacheFailure('ICD-10 bulk insert failed.'));
    }
  }

  @override
  Future<Either<Failure, int>> count() async {
    try {
      return right(await _db.countIcd10());
    } catch (_) {
      return left(const CacheFailure('ICD-10 count failed.'));
    }
  }

  @override
  Future<Either<Failure, void>> clearAll() async {
    try {
      await _db.clearIcd10();
      return right(null);
    } catch (_) {
      return left(const CacheFailure('ICD-10 clear failed.'));
    }
  }
}
