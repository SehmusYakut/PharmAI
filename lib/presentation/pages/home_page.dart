import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pharmai/core/constants/app_constants.dart';
import 'package:pharmai/core/l10n/app_localizations.dart';
import 'package:pharmai/presentation/bloc/auth/auth_bloc.dart';
import 'package:pharmai/presentation/bloc/theme/theme_cubit.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.appName),
        centerTitle: false,
        actions: [_ThemeToggleButton(), _ProfileButton()],
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          _HeroPanel(l10n: l10n),
          _SectionLabel(l10n.features),
          ..._features(l10n).map((f) => _FeatureCard(feature: f)),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  static List<_Feature> _features(AppLocalizations l10n) => [
        _Feature(
          icon: Icons.search_rounded,
          label: l10n.navIcd10,
          subtitle: l10n.icd10Subtitle,
          route: AppConstants.routeIcd10Search,
          available: true,
        ),
        _Feature(
          icon: Icons.medication_rounded,
          label: l10n.navDrugInfo,
          subtitle: l10n.drugInfoSubtitle,
          route: AppConstants.routeDrugInfo,
          available: true,
        ),
        _Feature(
          icon: Icons.calculate_rounded,
          label: l10n.navCalculators,
          subtitle: l10n.calculatorsSubtitle,
          route: AppConstants.routeCalculators,
          available: true,
        ),
      ];
}

// ── Hero panel ─────────────────────────────────────────────────────────────────

class _HeroPanel extends StatelessWidget {
  const _HeroPanel({required this.l10n});
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            colors.primaryContainer,
            colors.secondaryContainer,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.fromLTRB(24, 28, 24, 28),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.appName,
                  style: text.headlineLarge?.copyWith(
                    color: colors.onPrimaryContainer,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  l10n.appTagline,
                  style: text.bodyMedium?.copyWith(
                    color: colors.onPrimaryContainer
                        .withValues(alpha: 0.8),
                  ),
                ),
                const SizedBox(height: 14),
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: colors.onPrimaryContainer.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 4),
                    child: Text(
                      l10n.appVersion,
                      style: text.labelSmall?.copyWith(
                        color: colors.onPrimaryContainer
                            .withValues(alpha: 0.75),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Image.asset(
            'assets/images/app_logo.png',
            height: 64,
            fit: BoxFit.contain,
          ),
        ],
      ),
    );
  }
}

// ── Section label ──────────────────────────────────────────────────────────────

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
      child: Text(
        text.toUpperCase(),
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: Theme.of(context).colorScheme.outline,
              letterSpacing: 1.2,
              fontWeight: FontWeight.w600,
            ),
      ),
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
  });
  final IconData icon;
  final String label;
  final String subtitle;
  final String route;
  final bool available;
}

class _FeatureCard extends StatelessWidget {
  const _FeatureCard({required this.feature});
  final _Feature feature;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colors = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;

    // Cycle through M3 container colours for visual variety.
    final iconBg = switch (feature.icon) {
      Icons.search_rounded => colors.primaryContainer,
      Icons.medication_rounded => colors.tertiaryContainer,
      _ => colors.secondaryContainer,
    };
    final iconFg = switch (feature.icon) {
      Icons.search_rounded => colors.onPrimaryContainer,
      Icons.medication_rounded => colors.onTertiaryContainer,
      _ => colors.onSecondaryContainer,
    };

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: feature.available ? () => context.push(feature.route) : null,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // ── Icon column ──────────────────────────────────────────────
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: iconBg,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Icon(feature.icon, size: 28, color: iconFg),
                  ),
                ),
                const SizedBox(width: 16),
                // ── Text block ───────────────────────────────────────────────
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        feature.label,
                        style: text.titleMedium?.copyWith(
                          color: feature.available
                              ? null
                              : colors.onSurface.withValues(alpha: 0.45),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        feature.subtitle,
                        style: text.bodySmall?.copyWith(
                            color: colors.onSurfaceVariant),
                      ),
                      const SizedBox(height: 8),
                      _StatusBadge(
                        label: feature.available
                            ? l10n.badgeActive
                            : l10n.badgeSoon,
                        available: feature.available,
                      ),
                    ],
                  ),
                ),
                // ── Arrow ────────────────────────────────────────────────────
                if (feature.available)
                  Icon(Icons.chevron_right_rounded,
                      color: colors.onSurfaceVariant)
                else
                  const SizedBox(width: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.label, required this.available});
  final String label;
  final bool available;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final bg =
        available ? colors.primaryContainer : colors.surfaceContainerHighest;
    final fg = available ? colors.onPrimaryContainer : colors.outline;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        child: Text(
          label,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: fg,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.5,
              ),
        ),
      ),
    );
  }
}

// ── Profile button ─────────────────────────────────────────────────────────────

class _ProfileButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return BlocBuilder<AuthBloc, AuthState>(
      buildWhen: (p, c) =>
          (p is AuthAuthenticated) != (c is AuthAuthenticated),
      builder: (context, state) {
        final photoUrl = state is AuthAuthenticated
            ? state.profile.photoUrl
            : null;
        return IconButton(
          tooltip: l10n.navProfile,
          onPressed: () => context.push(AppConstants.routeProfile),
          icon: photoUrl != null
              ? CircleAvatar(
                  radius: 14,
                  backgroundImage: NetworkImage(photoUrl),
                )
              : const Icon(Icons.account_circle_outlined),
        );
      },
    );
  }
}

// ── Theme toggle ───────────────────────────────────────────────────────────────

class _ThemeToggleButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, mode) {
        final isDark = mode == ThemeMode.dark ||
            (mode == ThemeMode.system &&
                MediaQuery.platformBrightnessOf(context) == Brightness.dark);
        return IconButton(
          icon: Icon(
            isDark ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
          ),
          tooltip: isDark ? l10n.themeLightTooltip : l10n.themeDarkTooltip,
          onPressed: () => context.read<ThemeCubit>().toggle(),
        );
      },
    );
  }
}
