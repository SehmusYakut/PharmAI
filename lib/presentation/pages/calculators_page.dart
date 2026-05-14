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
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _DashboardCard(
            title: l10n.calcBmiTitle,
            icon: Icons.monitor_weight_outlined,
            onTap: () => context.push(AppConstants.routeCalcBmi),
          ),
          const SizedBox(height: 12),
          _DashboardCard(
            title: l10n.calcGfrTitle,
            icon: Icons.water_drop_outlined,
            onTap: () => context.push(AppConstants.routeCalcGfr),
          ),
          const SizedBox(height: 12),
          _DashboardCard(
            title: l10n.calcPediatricWeightTitle,
            icon: Icons.child_care_outlined,
            onTap: () => context.push(AppConstants.routeCalcPediatric),
          ),
          const SizedBox(height: 12),
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
    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Theme.of(context).colorScheme.outlineVariant),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        leading: Icon(icon, color: Theme.of(context).colorScheme.primary, size: 28),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }
}
