import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pharmai/core/constants/app_constants.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('PharmAI')),
      body: GridView.count(
        padding: const EdgeInsets.all(24),
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        children: const [
          _FeatureCard(
            icon: Icons.search,
            label: 'ICD-10 Search',
            route: AppConstants.routeIcd10Search,
          ),
          _FeatureCard(
            icon: Icons.medication,
            label: 'Drug Info',
            route: AppConstants.routeDrugInfo,
          ),
          _FeatureCard(
            icon: Icons.calculate,
            label: 'Calculators',
            route: AppConstants.routeCalculators,
          ),
        ],
      ),
    );
  }
}

class _FeatureCard extends StatelessWidget {
  const _FeatureCard({
    required this.icon,
    required this.label,
    required this.route,
  });

  final IconData icon;
  final String label;
  final String route;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => context.go(route),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40),
            const SizedBox(height: 8),
            Text(label, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
