import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:pharmai/core/auth/auth_state_notifier.dart';
import 'package:pharmai/data/datasources/local/local_database_service.dart';
import 'package:pharmai/data/repositories/auth_repository_impl.dart';
import 'package:pharmai/data/repositories/icd10_repository_impl.dart';
import 'package:pharmai/data/repositories/profile_repository_impl.dart';
import 'package:pharmai/domain/repositories/auth_repository.dart';
import 'package:pharmai/domain/repositories/icd10_repository.dart';
import 'package:pharmai/domain/repositories/profile_repository.dart';
import 'package:pharmai/domain/usecases/get_or_create_profile.dart';
import 'package:pharmai/domain/usecases/search_icd10.dart';
import 'package:pharmai/domain/usecases/sign_in_with_google.dart';
import 'package:pharmai/domain/usecases/sign_out.dart';
import 'package:pharmai/domain/usecases/update_profile.dart';
import 'package:pharmai/presentation/bloc/auth/auth_bloc.dart';
import 'package:pharmai/presentation/bloc/calculator/calculator_cubit.dart';
import 'package:pharmai/presentation/bloc/icd10_search/icd10_search_cubit.dart';
import 'package:pharmai/presentation/bloc/locale/locale_cubit.dart';
import 'package:pharmai/presentation/bloc/theme/theme_cubit.dart';

final GetIt sl = GetIt.instance;

Future<void> initDependencies() async {
  // ── Core ──────────────────────────────────────────────────────────────────
  sl.registerLazySingleton<AuthStateNotifier>(() => AuthStateNotifier());

  // ── Infrastructure ────────────────────────────────────────────────────────
  sl.registerLazySingleton<LocalDatabaseService>(() => LocalDatabaseService());
  sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);

  // ── Repositories ──────────────────────────────────────────────────────────
  sl.registerLazySingleton<Icd10Repository>(
      () => Icd10RepositoryImpl(sl()));
  sl.registerLazySingleton<ProfileRepository>(
      () => ProfileRepositoryImpl(sl()));
  sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(sl(), sl()));

  // ── Use-cases ─────────────────────────────────────────────────────────────
  sl.registerLazySingleton(() => SearchIcd10(sl()));
  sl.registerLazySingleton(() => SignInWithGoogle(sl()));
  sl.registerLazySingleton(() => SignOut(sl()));
  sl.registerLazySingleton(() => GetOrCreateProfile(sl()));
  sl.registerLazySingleton(() => UpdateProfile(sl()));

  // ── BLoCs / Cubits ────────────────────────────────────────────────────────
  sl.registerFactory(() => Icd10SearchCubit(sl()));
  sl.registerFactory(() => CalculatorCubit());
  sl.registerLazySingleton(() => ThemeCubit(sl()));
  sl.registerLazySingleton(() => LocaleCubit(sl()));
  sl.registerLazySingleton(
    () => AuthBloc(
      authRepo: sl(),
      profileRepo: sl(),
      signInWithGoogle: sl(),
      signOut: sl(),
      authNotifier: sl(),
    ),
  );
}
