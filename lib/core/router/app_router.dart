import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pharmai/core/auth/auth_state_notifier.dart';
import 'package:pharmai/core/constants/app_constants.dart';
import 'package:pharmai/injection_container.dart';
import 'package:pharmai/presentation/bloc/calculator/calculator_cubit.dart';
import 'package:pharmai/presentation/bloc/icd10_search/icd10_search_cubit.dart';
import 'package:pharmai/presentation/pages/calculators_page.dart';
import 'package:pharmai/presentation/pages/drug_info_page.dart';
import 'package:pharmai/presentation/pages/home_page.dart';
import 'package:pharmai/presentation/pages/icd10_search_page.dart';
import 'package:pharmai/presentation/pages/login_page.dart';
import 'package:pharmai/presentation/pages/profile_page.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: AppConstants.routeHome,
  debugLogDiagnostics: false,
  refreshListenable: sl<AuthStateNotifier>(),
  redirect: (context, state) {
    final isAuth = sl<AuthStateNotifier>().isAuthenticated;
    final loc = state.matchedLocation;
    if (!isAuth && loc == AppConstants.routeProfile) {
      return AppConstants.routeLogin;
    }
    if (isAuth && loc == AppConstants.routeLogin) {
      return AppConstants.routeHome;
    }
    return null;
  },
  routes: [
    GoRoute(
      path: AppConstants.routeHome,
      name: 'home',
      builder: (context, _) => const HomePage(),
    ),
    GoRoute(
      path: AppConstants.routeIcd10Search,
      name: 'icd10Search',
      builder: (context, _) => BlocProvider(
        create: (_) => sl<Icd10SearchCubit>(),
        child: const Icd10SearchPage(),
      ),
    ),
    GoRoute(
      path: AppConstants.routeDrugInfo,
      name: 'drugInfo',
      builder: (context, _) => const DrugInfoPage(),
    ),
    GoRoute(
      path: AppConstants.routeCalculators,
      name: 'calculators',
      builder: (context, _) => BlocProvider(
        create: (_) => sl<CalculatorCubit>(),
        child: const CalculatorsPage(),
      ),
    ),
    GoRoute(
      path: AppConstants.routeLogin,
      name: 'login',
      builder: (context, _) => const LoginPage(),
    ),
    GoRoute(
      path: AppConstants.routeProfile,
      name: 'profile',
      builder: (context, _) => const ProfilePage(),
    ),
  ],
  errorBuilder: (_, state) =>
      Scaffold(body: Center(child: Text('Route not found: ${state.uri}'))),
);
