import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pharmai/core/constants/app_constants.dart';
import 'package:pharmai/core/l10n/app_localizations.dart';

class CalculatorsPage extends StatelessWidget {
  const CalculatorsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.calcTitle), centerTitle: false),
      body: GridView.count(
        padding: const EdgeInsets.all(16),
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 1.05,
        children: [
          _DashboardCard(
            title: l10n.calcBmiTitle,
            icon: Icons.monitor_weight_outlined,
            onTap: () => context.push(AppConstants.routeCalcBmi),
          ),
          _DashboardCard(
            title: l10n.calcGfrTitle,
            icon: Icons.water_drop_outlined,
            onTap: () => context.push(AppConstants.routeCalcGfr),
          ),
          _DashboardCard(
            title: l10n.calcPediatricWeightTitle,
            icon: Icons.child_care_outlined,
            onTap: () => context.push(AppConstants.routeCalcPediatric),
          ),
          _DashboardCard(
            title: l10n.calcIvDripRateTitle,
            icon: Icons.water_drop_outlined,
            onTap: () => context.push(AppConstants.routeCalcIvRate),
          ),
        ],
      ),
    );
  }
}

class _DashboardCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const _DashboardCard({
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;

    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(color: colors.outlineVariant),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: colors.primary.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: colors.primary, size: 28),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                textAlign: TextAlign.center,
                style: text.titleSmall?.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 6),
              Icon(
                Icons.arrow_forward_rounded,
                size: 18,
                color: colors.onSurfaceVariant,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
