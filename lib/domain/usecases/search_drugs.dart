import 'package:fpdart/fpdart.dart';
import 'package:pharmai/core/error/failures.dart';
import 'package:pharmai/domain/entities/drug.dart';
import 'package:pharmai/domain/repositories/drug_repository.dart';

class SearchDrugs {
  const SearchDrugs(this._repository);

  final DrugRepository _repository;

  Future<Either<Failure, List<Drug>>> call(String query) =>
      _repository.search(query);
}
