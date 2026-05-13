import 'package:fpdart/fpdart.dart';
import 'package:pharmai/core/error/failures.dart';
import 'package:pharmai/domain/entities/drug.dart';

abstract class DrugRepository {
  /// Full-text search across productName and activeIngredient (Turkish-aware).
  Future<Either<Failure, List<Drug>>> search(String query);

  /// Total drugs in the local store — used for idempotent seeding.
  Future<Either<Failure, int>> count();
}
