import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pharmai/core/constants/app_constants.dart';
import 'package:pharmai/injection_container.dart';
import 'package:pharmai/presentation/bloc/icd10_search/icd10_search_cubit.dart';
import 'package:pharmai/presentation/pages/home_page.dart';
import 'package:pharmai/presentation/pages/icd10_search_page.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: AppConstants.routeHome,
  debugLogDiagnostics: false,
  routes: [
    GoRoute(
      path: AppConstants.routeHome,
      name: 'home',
      builder: (context, _) => const HomePage(),
    ),
    GoRoute(
      path: AppConstants.routeIcd10Search,
      name: 'icd10Search',
      // BlocProvider scoped to this route: a fresh cubit is created on push
      // and automatically closed when the route is popped.
      builder: (context, _) => BlocProvider(
        create: (_) => sl<Icd10SearchCubit>(),
        child: const Icd10SearchPage(),
      ),
    ),
    // Future routes:
    // GoRoute(path: AppConstants.routeDrugInfo, ...),
    // GoRoute(path: AppConstants.routeCalculators, ...),
  ],
  errorBuilder: (_, state) => Scaffold(
    body: Center(child: Text('Route not found: ${state.uri}')),
  ),
);
