import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:pharmai/core/auth/auth_state_notifier.dart';
import 'package:pharmai/core/config/app_config.dart';
import 'package:pharmai/core/network/secure_network_client.dart';
import 'package:pharmai/core/security/security_service.dart';
import 'package:pharmai/data/datasources/local/app_preferences_local_data_source.dart';
import 'package:pharmai/data/datasources/local/local_database_service.dart';
import 'package:pharmai/data/datasources/remote/gemini_chat_service.dart';
import 'package:pharmai/data/repositories/app_preferences_repository_impl.dart';
import 'package:pharmai/data/repositories/auth_repository_impl.dart';
import 'package:pharmai/data/repositories/bookmark_repository_impl.dart';
import 'package:pharmai/data/repositories/chat_repository_impl.dart';
import 'package:pharmai/data/repositories/drug_repository_impl.dart';
import 'package:pharmai/data/repositories/icd10_repository_impl.dart';
import 'package:pharmai/data/repositories/profile_repository_impl.dart';
import 'package:pharmai/domain/repositories/app_preferences_repository.dart';
import 'package:pharmai/domain/repositories/auth_repository.dart';
import 'package:pharmai/domain/repositories/bookmark_repository.dart';
import 'package:pharmai/domain/repositories/chat_repository.dart';
import 'package:pharmai/domain/repositories/drug_repository.dart';
import 'package:pharmai/domain/repositories/icd10_repository.dart';
import 'package:pharmai/domain/repositories/profile_repository.dart';
import 'package:pharmai/domain/usecases/add_chat_message.dart';
import 'package:pharmai/domain/usecases/fetch_bookmarks_by_type.dart';
import 'package:pharmai/domain/usecases/fetch_chat_messages.dart';
import 'package:pharmai/domain/usecases/fetch_chat_sessions.dart';
import 'package:pharmai/domain/usecases/generate_chat_title.dart';
import 'package:pharmai/domain/usecases/is_bookmarked.dart';
import 'package:pharmai/domain/usecases/get_chat_usage.dart';
import 'package:pharmai/domain/usecases/increment_chat_usage.dart';
import 'package:pharmai/domain/usecases/get_or_create_profile.dart';
import 'package:pharmai/domain/usecases/rename_chat_session.dart';
import 'package:pharmai/domain/usecases/send_chat_message.dart';
import 'package:pharmai/domain/usecases/search_drugs.dart';
import 'package:pharmai/domain/usecases/search_icd10.dart';
import 'package:pharmai/domain/usecases/sign_in_with_google.dart';
import 'package:pharmai/domain/usecases/sign_in_with_apple.dart';
import 'package:pharmai/domain/usecases/sign_in_anonymously.dart';
import 'package:pharmai/domain/usecases/sign_out.dart';
import 'package:pharmai/domain/usecases/delete_account.dart';
import 'package:pharmai/domain/usecases/start_chat_session.dart';
import 'package:pharmai/domain/usecases/toggle_bookmark.dart';
import 'package:pharmai/domain/usecases/update_profile.dart';
import 'package:pharmai/domain/usecases/upgrade_to_premium.dart'
    as chat_usecases;
import 'package:pharmai/presentation/bloc/auth/auth_bloc.dart';
import 'package:pharmai/presentation/bloc/bookmark/bookmark_bloc.dart';
import 'package:pharmai/presentation/bloc/calculator/calculator_cubit.dart';
import 'package:pharmai/presentation/bloc/chat/chat_bloc.dart';
import 'package:pharmai/presentation/bloc/drug_search/drug_search_bloc.dart';
import 'package:pharmai/presentation/bloc/icd10_search/icd10_search_cubit.dart';
import 'package:pharmai/presentation/bloc/locale/locale_cubit.dart';
import 'package:pharmai/presentation/bloc/onboarding/onboarding_cubit.dart';
import 'package:pharmai/presentation/bloc/theme/theme_cubit.dart';

final GetIt sl = GetIt.instance;

Future<void> initDependencies() async {
  // ── Core ──────────────────────────────────────────────────────────────────
  sl.registerLazySingleton<AuthStateNotifier>(() => AuthStateNotifier());
  sl.registerLazySingleton<SecurityService>(() => SecurityService());
  sl.registerLazySingleton<SecureNetworkClient>(() => SecureNetworkClient());

  // ── Infrastructure ────────────────────────────────────────────────────────
  sl.registerLazySingleton<LocalDatabaseService>(
    () => LocalDatabaseService(),
  );
  sl.registerLazySingleton<AppPreferencesLocalDataSource>(
    () => AppPreferencesLocalDataSource(),
  );
  sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  sl.registerLazySingleton(
    () => GeminiChatService(apiKey: AppConfig.geminiApiKey, httpClient: sl<SecureNetworkClient>()),
  );

  // ── Repositories ──────────────────────────────────────────────────────────
  sl.registerLazySingleton<Icd10Repository>(() => Icd10RepositoryImpl(sl()));
  sl.registerLazySingleton<AppPreferencesRepository>(
    () => AppPreferencesRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<BookmarkRepository>(
    () => BookmarkRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl(), sl()),
  );
  sl.registerLazySingleton<DrugRepository>(() => DrugRepositoryImpl(sl()));
  sl.registerLazySingleton<ChatRepository>(
    () => ChatRepositoryImpl(sl(), sl(), sl()),
  );

  // ── Use-cases ─────────────────────────────────────────────────────────────
  sl.registerLazySingleton(() => SearchIcd10(sl()));
  sl.registerLazySingleton(() => SearchDrugs(sl()));
  sl.registerLazySingleton(() => SignInWithGoogle(sl()));
  sl.registerLazySingleton(() => SignInWithApple(sl()));
  sl.registerLazySingleton(() => SignInAnonymously(sl()));
  sl.registerLazySingleton(() => SignOut(sl()));
  sl.registerLazySingleton(() => DeleteAccount(sl()));
  sl.registerLazySingleton(() => GetOrCreateProfile(sl()));
  sl.registerLazySingleton(() => UpdateProfile(sl()));
  sl.registerLazySingleton(() => FetchChatSessions(sl()));
  sl.registerLazySingleton(() => FetchChatMessages(sl()));
  sl.registerLazySingleton(() => StartChatSession(sl()));
  sl.registerLazySingleton(() => RenameChatSession(sl()));
  sl.registerLazySingleton(() => GenerateChatTitle(sl()));
  sl.registerLazySingleton(() => AddChatMessage(sl()));
  sl.registerLazySingleton(() => SendChatMessage(sl()));
  sl.registerLazySingleton(() => FetchBookmarksByType(sl()));
  sl.registerLazySingleton(() => IsBookmarked(sl()));
  sl.registerLazySingleton(() => ToggleBookmark(sl()));
  sl.registerLazySingleton(() => GetChatUsage(sl()));
  sl.registerLazySingleton(() => IncrementChatUsage(sl()));
  sl.registerLazySingleton(() => chat_usecases.UpgradeToPremium(sl()));

  // ── BLoCs / Cubits ────────────────────────────────────────────────────────
  sl.registerFactory(() => Icd10SearchCubit(sl()));
  sl.registerFactory(() => DrugSearchBloc(sl()));
  sl.registerFactory(() => CalculatorCubit());
  sl.registerFactory(
    () => BookmarkBloc(
      fetchBookmarksByType: sl(),
      isBookmarked: sl(),
      toggleBookmark: sl(),
    ),
  );
  sl.registerFactory(() => OnboardingCubit(sl()));
  sl.registerLazySingleton(() => ThemeCubit(sl()));
  sl.registerLazySingleton(() => LocaleCubit(sl()));
  sl.registerFactory(
    () => ChatBloc(
      fetchChatSessions: sl(),
      fetchChatMessages: sl(),
      startChatSession: sl(),
      renameChatSession: sl(),
      generateChatTitle: sl(),
      addChatMessage: sl(),
      sendChatMessage: sl(),
      getChatUsage: sl(),
      incrementChatUsage: sl(),
      upgradeToPremium: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => AuthBloc(
      authRepo: sl(),
      profileRepo: sl(),
      signInWithGoogle: sl(),
      signInWithApple: sl(),
      signInAnonymously: sl(),
      signOut: sl(),
      deleteAccount: sl(),
      authNotifier: sl(),
    ),
  );
}
