import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pharmai/core/constants/app_constants.dart';
import 'package:pharmai/core/l10n/app_localizations.dart';
import 'package:pharmai/injection_container.dart';
import 'package:pharmai/presentation/bloc/auth/auth_bloc.dart';
import 'package:pharmai/presentation/bloc/onboarding/onboarding_cubit.dart';
import 'package:pharmai/presentation/bloc/onboarding/onboarding_state.dart';
import 'package:pharmai/presentation/bloc/theme/theme_cubit.dart';
import 'package:pharmai/presentation/widgets/onboarding_tour_dialog.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();

  static List<_Feature> _features(AppLocalizations l10n) => [
    _Feature(
      icon: Icons.search_rounded,
      label: l10n.navIcd10,
      subtitle: l10n.icd10Subtitle,
      route: AppConstants.routeIcd10Search,
      available: true,
      accent: const Color(0xFF0B2D4D),
      glow: const Color(0xFF20C8D6),
    ),
    _Feature(
      icon: Icons.medication_rounded,
      label: l10n.navDrugInfo,
      subtitle: l10n.drugInfoSubtitle,
      route: AppConstants.routeDrugInfo,
      available: true,
      accent: const Color(0xFF0F766E),
      glow: const Color(0xFF14B8A6),
    ),
    _Feature(
      icon: Icons.calculate_rounded,
      label: l10n.navCalculators,
      subtitle: l10n.calculatorsSubtitle,
      route: AppConstants.routeCalculators,
      available: true,
      accent: const Color(0xFF155E75),
      glow: const Color(0xFF67E8F9),
    ),
  ];
}

class _HomePageState extends State<HomePage> {
  bool _onboardingPresented = false;

  Future<void> _maybeShowOnboarding(OnboardingState state) async {
    if (state.isLoading || !state.shouldShow || _onboardingPresented) return;

    _onboardingPresented = true;
    await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (_) => const OnboardingTourDialog(),
    );

    if (!mounted) return;
    await context.read<OnboardingCubit>().completeOnboarding();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final features = HomePage._features(l10n);

    return BlocListener<OnboardingCubit, OnboardingState>(
      listener: (_, state) => _maybeShowOnboarding(state),
      child: Scaffold(
        body: Stack(
          children: [
            const _DashboardBackdrop(),
            SafeArea(
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
                      child: _DashboardHeader(l10n: l10n),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
                      child: _SectionTitle(
                        title: l10n.features,
                        subtitle: l10n.homeFeaturesSubtitle,
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    sliver: SliverLayoutBuilder(
                      builder: (context, constraints) {
                        final crossAxisExtent = constraints.crossAxisExtent;
                        final columnCount = crossAxisExtent >= 1024
                            ? 3
                            : crossAxisExtent >= 720
                            ? 2
                            : 1;

                        if (columnCount == 1) {
                          return SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) => Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: _GlassFeatureCard(
                                  feature: features[index],
                                ),
                              ),
                              childCount: features.length,
                            ),
                          );
                        }

                        return SliverGrid(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) =>
                                _GlassFeatureCard(feature: features[index]),
                            childCount: features.length,
                          ),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: columnCount,
                                crossAxisSpacing: 16,
                                mainAxisSpacing: 16,
                                mainAxisExtent: 178,
                              ),
                        );
                      },
                    ),
                  ),
                  const SliverToBoxAdapter(child: SizedBox(height: 28)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DashboardBackdrop extends StatelessWidget {
  const _DashboardBackdrop();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            colors.background,
            colors.surfaceContainerLowest.withValues(alpha: 0.98),
            colors.surfaceContainerHighest.withValues(alpha: 0.32),
          ],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: -60,
            right: -40,
            child: _GlowOrb(
              color: colors.primary.withValues(alpha: 0.2),
              size: 180,
            ),
          ),
          Positioned(
            top: 140,
            left: -70,
            child: _GlowOrb(
              color: colors.tertiary.withValues(alpha: 0.14),
              size: 220,
            ),
          ),
          Positioned(
            bottom: -80,
            right: -20,
            child: _GlowOrb(
              color: colors.secondary.withValues(alpha: 0.12),
              size: 200,
            ),
          ),
        ],
      ),
    );
  }
}

class _GlowOrb extends StatelessWidget {
  const _GlowOrb({required this.color, required this.size});

  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [color, color.withValues(alpha: 0.0)],
          stops: const [0.0, 1.0],
        ),
      ),
    );
  }
}

class _DashboardHeader extends StatelessWidget {
  const _DashboardHeader({required this.l10n});
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: colors.primary.withValues(alpha: 0.16)),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            colors.primary.withValues(alpha: 0.96),
            colors.secondary.withValues(alpha: 0.92),
            colors.tertiary.withValues(alpha: 0.85),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: colors.primary.withValues(alpha: 0.18),
            blurRadius: 28,
            offset: const Offset(0, 16),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
          child: Stack(
            children: [
              Positioned(
                top: -24,
                right: -18,
                child: _GlowOrb(
                  color: Colors.white.withValues(alpha: 0.15),
                  size: 120,
                ),
              ),
              Positioned(
                bottom: -30,
                left: -10,
                child: _GlowOrb(
                  color: Colors.white.withValues(alpha: 0.08),
                  size: 140,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        _BrandMark(appName: l10n.appName),
                        const Spacer(),
                        _ThemeToggleButton(),
                        const SizedBox(width: 10),
                        _ProfileButton(),
                      ],
                    ),
                    const SizedBox(height: 22),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.dashboardWelcome,
                          style: text.headlineLarge?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                            letterSpacing: -0.8,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          l10n.appTagline,
                          style: text.bodyLarge?.copyWith(
                            color: Colors.white.withValues(alpha: 0.92),
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BrandMark extends StatelessWidget {
  const _BrandMark({required this.appName});

  final String appName;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;

    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(
            'assets/images/app_logo.png',
            width: 98,
            height: 98,
            fit: BoxFit.contain,
          ),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              appName,
              style: text.titleLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.4,
              ),
            ),
            Text(
              AppLocalizations.of(context).dashboardTitle,
              style: text.labelMedium?.copyWith(
                color: Colors.white.withValues(alpha: 0.82),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title.toUpperCase(),
          style: text.labelMedium?.copyWith(
            color: colors.primary,
            letterSpacing: 1.4,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          subtitle,
          style: text.bodyMedium?.copyWith(
            color: colors.onSurfaceVariant,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}

// ── Feature card ───────────────────────────────────────────────────────────────

class _Feature {
  const _Feature({
    required this.icon,
    required this.label,
    required this.subtitle,
    required this.route,
    required this.available,
    required this.accent,
    required this.glow,
  });

  final IconData icon;
  final String label;
  final String subtitle;
  final String route;
  final bool available;
  final Color accent;
  final Color glow;
}

class _GlassFeatureCard extends StatelessWidget {
  const _GlassFeatureCard({required this.feature});

  final _Feature feature;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colors = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;

    return Hero(
      tag: 'feature-${feature.route}',
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: feature.available ? () => context.push(feature.route) : null,
          borderRadius: BorderRadius.circular(28),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(28),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              curve: Curves.easeOutCubic,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    colors.surface.withValues(alpha: 0.92),
                    colors.surfaceContainerHigh.withValues(alpha: 0.86),
                  ],
                ),
                borderRadius: BorderRadius.circular(28),
                border: Border.all(color: feature.glow.withValues(alpha: 0.18)),
                boxShadow: [
                  BoxShadow(
                    color: feature.glow.withValues(alpha: 0.08),
                    blurRadius: 24,
                    offset: const Offset(0, 14),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                feature.accent,
                                feature.glow.withValues(alpha: 0.92),
                              ],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: feature.glow.withValues(alpha: 0.18),
                                blurRadius: 18,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: Icon(
                            feature.icon,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_rounded,
                          color: colors.primary.withValues(alpha: 0.7),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    Text(
                      feature.label,
                      style: text.titleLarge?.copyWith(
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.2,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      feature.subtitle,
                      style: text.bodyMedium?.copyWith(
                        color: colors.onSurfaceVariant,
                        height: 1.45,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        if (!feature.available)
                          _CardPill(
                            icon: Icons.schedule_rounded,
                            label: l10n.badgeSoon,
                            accent: colors.outline,
                          ),
                        _CardPill(
                          icon: Icons.touch_app_rounded,
                          label: l10n.cardTapToOpen,
                          accent: feature.accent,
                          textColor: Colors.cyan.shade900,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _CardPill extends StatelessWidget {
  const _CardPill({
    required this.icon,
    required this.label,
    required this.accent,
    this.textColor,
  });

  final IconData icon;
  final String label;
  final Color accent;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final effectiveTextColor = textColor ?? accent;

    return Container(
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(999),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: effectiveTextColor),
          const SizedBox(width: 6),
          Text(
            label,
            style: text.labelMedium?.copyWith(
              color: effectiveTextColor,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Profile button ─────────────────────────────────────────────────────────────

class _ProfileButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colors = Theme.of(context).colorScheme;

    return BlocBuilder<AuthBloc, AuthState>(
      buildWhen: (previous, current) =>
          (previous is AuthAuthenticated) != (current is AuthAuthenticated),
      builder: (context, state) {
        final photoUrl = state is AuthAuthenticated
            ? state.profile.photoUrl
            : null;

        return _ActionButton(
          tooltip: l10n.navProfile,
          onPressed: () => context.push(AppConstants.routeProfile),
          icon: photoUrl != null
              ? CircleAvatar(
                  radius: 13,
                  backgroundImage: NetworkImage(photoUrl),
                )
              : Icon(Icons.account_circle_outlined, color: colors.onPrimary),
        );
      },
    );
  }
}

class _ThemeToggleButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colors = Theme.of(context).colorScheme;

    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, mode) {
        final isDark =
            mode == ThemeMode.dark ||
            (mode == ThemeMode.system &&
                MediaQuery.platformBrightnessOf(context) == Brightness.dark);

        return _ActionButton(
          tooltip: isDark ? l10n.themeLightTooltip : l10n.themeDarkTooltip,
          onPressed: () => context.read<ThemeCubit>().toggle(),
          icon: Icon(
            isDark ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
            color: colors.onPrimary,
          ),
        );
      },
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.tooltip,
    required this.onPressed,
    required this.icon,
  });

  final String tooltip;
  final VoidCallback onPressed;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: Material(
        color: Colors.white.withValues(alpha: 0.14),
        shape: const CircleBorder(),
        child: InkWell(
          onTap: onPressed,
          customBorder: const CircleBorder(),
          child: Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white.withValues(alpha: 0.16)),
            ),
            child: Center(child: icon),
          ),
        ),
      ),
    );
  }
}
