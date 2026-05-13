import 'package:fpdart/fpdart.dart';
import 'package:pharmai/core/error/failures.dart';
import 'package:pharmai/data/datasources/local/local_database_service.dart';
import 'package:pharmai/domain/entities/drug.dart';
import 'package:pharmai/domain/repositories/drug_repository.dart';

class DrugRepositoryImpl implements DrugRepository {
  const DrugRepositoryImpl(this._db);

  final LocalDatabaseService _db;

  @override
  Future<Either<Failure, List<Drug>>> search(String query) async {
    if (query.trim().isEmpty) return right(const []);
    try {
      final models = await _db.searchDrugs(query);
      return right(models.map((m) => m.toDomain()).toList());
    } catch (_) {
      return left(const CacheFailure('Drug search failed.'));
    }
  }

  @override
  Future<Either<Failure, int>> count() async {
    try {
      return right(await _db.countDrugs());
    } catch (_) {
      return left(const CacheFailure('Drug count failed.'));
    }
  }
}
