import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pharmai/core/auth/auth_state_notifier.dart';
import 'package:pharmai/core/constants/app_constants.dart';
import 'package:pharmai/core/l10n/app_localizations.dart';
import 'package:pharmai/injection_container.dart';
import 'package:pharmai/presentation/bloc/calculator/calculator_cubit.dart';
import 'package:pharmai/presentation/bloc/chat/chat_bloc.dart';
import 'package:pharmai/presentation/bloc/drug_search/drug_search_bloc.dart';
import 'package:pharmai/presentation/bloc/icd10_search/icd10_search_cubit.dart';
import 'package:pharmai/presentation/pages/calculators/bmi_calculator_page.dart';
import 'package:pharmai/presentation/pages/calculators/gfr_calculator_page.dart';
import 'package:pharmai/presentation/pages/calculators/iv_drip_rate_calculator_page.dart';
import 'package:pharmai/presentation/pages/calculators/pediatric_weight_calculator_page.dart';
import 'package:pharmai/presentation/pages/calculators_page.dart';
import 'package:pharmai/presentation/pages/drug_info_page.dart';
import 'package:pharmai/presentation/pages/home_page.dart';
import 'package:pharmai/presentation/pages/icd10_search_page.dart';
import 'package:pharmai/presentation/pages/chat/chat_dashboard_page.dart';
import 'package:pharmai/presentation/pages/chat/chat_room_page.dart';
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
    if (!isAuth && loc.startsWith(AppConstants.routeChatDashboard)) {
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
      builder: (context, _) => BlocProvider(
        create: (_) => sl<DrugSearchBloc>(),
        child: const DrugInfoPage(),
      ),
    ),
    GoRoute(
      path: AppConstants.routeCalculators,
      name: 'calculators',
      builder: (context, _) => BlocProvider(
        create: (_) => sl<CalculatorCubit>(),
        child: const CalculatorsPage(),
      ),
      routes: [
        GoRoute(
          path: 'bmi',
          name: 'calcBmi',
          builder: (context, _) => BlocProvider(
            create: (_) => sl<CalculatorCubit>(),
            child: const BmiCalculatorPage(),
          ),
        ),
        GoRoute(
          path: 'gfr',
          name: 'calcGfr',
          builder: (context, _) => BlocProvider(
            create: (_) => sl<CalculatorCubit>(),
            child: const GfrCalculatorPage(),
          ),
        ),
        GoRoute(
          path: 'pediatric',
          name: 'calcPediatric',
          builder: (context, _) => BlocProvider(
            create: (_) => sl<CalculatorCubit>(),
            child: const PediatricWeightCalculatorPage(),
          ),
        ),
        GoRoute(
          path: 'iv-rate',
          name: 'calcIvRate',
          builder: (context, _) => BlocProvider(
            create: (_) => sl<CalculatorCubit>(),
            child: const IvDripRateCalculatorPage(),
          ),
        ),
      ],
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
    GoRoute(
      path: AppConstants.routeChatDashboard,
      name: 'chatDashboard',
      builder: (context, _) => BlocProvider(
        create: (_) => sl<ChatBloc>(),
        child: const ChatDashboardPage(),
      ),
      routes: [
        GoRoute(
          path: ':sessionId',
          name: 'chatRoom',
          builder: (context, state) {
            final id = int.tryParse(state.pathParameters['sessionId'] ?? '');
            if (id == null) {
              final l10n = AppLocalizations.of(context);
              return Scaffold(
                body: Center(child: Text(l10n.chatInvalidSession)),
              );
            }
            return BlocProvider(
              create: (_) => sl<ChatBloc>(),
              child: ChatRoomPage(sessionId: id),
            );
          },
        ),
      ],
    ),
  ],
  errorBuilder: (context, state) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      body: Center(child: Text(l10n.routeNotFound(state.uri.toString()))),
    );
  },
);
