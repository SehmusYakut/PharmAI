import 'package:get_it/get_it.dart';
import 'package:pharmai/data/datasources/local/local_database_service.dart';
import 'package:pharmai/data/repositories/icd10_repository_impl.dart';
import 'package:pharmai/domain/repositories/icd10_repository.dart';
import 'package:pharmai/domain/usecases/search_icd10.dart';
import 'package:pharmai/presentation/bloc/icd10_search/icd10_search_cubit.dart';

final GetIt sl = GetIt.instance;

/// Registers all dependencies in the correct order:
///   1. Infrastructure (database)
///   2. Repositories
///   3. Use-cases
///   4. BLoCs / Cubits
///
/// Called once from [main] before [runApp]. The database itself opens lazily
/// on first access, so this function completes in microseconds.
Future<void> initDependencies() async {
  // ── Infrastructure ────────────────────────────────────────────────────────
  sl.registerLazySingleton<LocalDatabaseService>(
    () => LocalDatabaseService(),
  );

  // ── Repositories ──────────────────────────────────────────────────────────
  sl.registerLazySingleton<Icd10Repository>(
    () => Icd10RepositoryImpl(sl()),
  );

  // ── Use-cases ─────────────────────────────────────────────────────────────
  sl.registerLazySingleton(() => SearchIcd10(sl()));

  // ── BLoCs / Cubits ────────────────────────────────────────────────────────
  // Factory: a fresh cubit is created per page instance so state doesn't leak
  // across navigation events.
  sl.registerFactory(() => Icd10SearchCubit(sl()));
}
