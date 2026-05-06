import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pharmai/core/utils/calculator_models.dart';
import 'package:pharmai/presentation/bloc/calculator/calculator_cubit.dart';
import 'package:pharmai/presentation/bloc/calculator/calculator_state.dart';

class CalculatorsPage extends StatelessWidget {
  const CalculatorsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Klinik Hesaplayıcılar'),
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/'),
        ),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            _BmiCard(),
            SizedBox(height: 16),
            _GfrCard(),
            SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

// ── BMI Calculator ─────────────────────────────────────────────────────────────

class _BmiCard extends StatefulWidget {
  const _BmiCard();

  @override
  State<_BmiCard> createState() => _BmiCardState();
}

class _BmiCardState extends State<_BmiCard> {
  final _weightCtrl = TextEditingController();
  final _heightCtrl = TextEditingController();

  @override
  void dispose() {
    _weightCtrl.dispose();
    _heightCtrl.dispose();
    super.dispose();
  }

  void _calculate() {
    final weight = double.tryParse(_weightCtrl.text.replaceAll(',', '.'));
    final height = double.tryParse(_heightCtrl.text.replaceAll(',', '.'));
    if (weight == null || height == null) return;
    context.read<CalculatorCubit>().calculateBmi(
          weightKg: weight,
          heightCm: height,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.monitor_weight_outlined),
                const SizedBox(width: 8),
                Text(
                  'Vücut Kitle İndeksi',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              'WHO TRS 854 (1995)',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.outline,
                  ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _weightCtrl,
                    decoration: const InputDecoration(
                      labelText: 'Ağırlık',
                      suffixText: 'kg',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[\d.,]')),
                    ],
                    onSubmitted: (_) => _calculate(),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: _heightCtrl,
                    decoration: const InputDecoration(
                      labelText: 'Boy',
                      suffixText: 'cm',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[\d.,]')),
                    ],
                    onSubmitted: (_) => _calculate(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: _calculate,
                child: const Text('Hesapla'),
              ),
            ),
            BlocBuilder<CalculatorCubit, CalculatorState>(
              buildWhen: (p, c) =>
                  p.bmiResult != c.bmiResult || p.bmiError != c.bmiError,
              builder: (context, state) {
                if (state.bmiError != null) {
                  return _ErrorText(state.bmiError!);
                }
                if (state.bmiResult == null) return const SizedBox.shrink();
                return _BmiResultTile(result: state.bmiResult!);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _BmiResultTile extends StatelessWidget {
  const _BmiResultTile({required this.result});
  final BmiResult result;

  @override
  Widget build(BuildContext context) {
    final color = _color(result.category);
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: color.withValues(alpha: 0.35)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('VKİ', style: Theme.of(context).textTheme.labelSmall),
                  Text(
                    '${result.bmi}',
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium
                        ?.copyWith(color: color, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'kg/m²',
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall
                        ?.copyWith(color: color),
                  ),
                ],
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Text(
                  _label(result.category),
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(color: color),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _color(BmiCategory cat) => switch (cat) {
        BmiCategory.severelyUnderweight => Colors.indigo,
        BmiCategory.underweight => Colors.blue,
        BmiCategory.normalWeight => Colors.green,
        BmiCategory.overweight => Colors.orange,
        BmiCategory.obeseClassI => Colors.deepOrange,
        BmiCategory.obeseClassII => Colors.red,
        BmiCategory.obeseClassIII => Colors.red.shade900,
      };

  String _label(BmiCategory cat) => switch (cat) {
        BmiCategory.severelyUnderweight => 'Ciddi Düşük Ağırlık',
        BmiCategory.underweight => 'Düşük Ağırlık',
        BmiCategory.normalWeight => 'Normal Ağırlık',
        BmiCategory.overweight => 'Fazla Kilolu',
        BmiCategory.obeseClassI => 'Obezite – Sınıf I',
        BmiCategory.obeseClassII => 'Obezite – Sınıf II',
        BmiCategory.obeseClassIII => 'Obezite – Sınıf III',
      };
}

// ── GFR Calculator ─────────────────────────────────────────────────────────────

class _GfrCard extends StatefulWidget {
  const _GfrCard();

  @override
  State<_GfrCard> createState() => _GfrCardState();
}

class _GfrCardState extends State<_GfrCard> {
  final _scrCtrl = TextEditingController();
  final _ageCtrl = TextEditingController();
  final _weightCtrl = TextEditingController();
  BiologicalSex _sex = BiologicalSex.male;

  @override
  void dispose() {
    _scrCtrl.dispose();
    _ageCtrl.dispose();
    _weightCtrl.dispose();
    super.dispose();
  }

  void _calculate() {
    final scr = double.tryParse(_scrCtrl.text.replaceAll(',', '.'));
    final age = int.tryParse(_ageCtrl.text);
    final weight = double.tryParse(_weightCtrl.text.replaceAll(',', '.'));
    if (scr == null || age == null || weight == null) return;
    context.read<CalculatorCubit>().calculateGfr(
          serumCreatinineMgDl: scr,
          ageYears: age,
          sex: _sex,
          weightKg: weight,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.water_drop_outlined),
                const SizedBox(width: 8),
                Text(
                  'Glomerüler Filtrasyon Hızı',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              'CKD-EPI 2021 · Cockcroft-Gault · KDIGO 2022',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.outline,
                  ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _scrCtrl,
                    decoration: const InputDecoration(
                      labelText: 'Serum Kreatinin',
                      suffixText: 'mg/dL',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[\d.,]')),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: _ageCtrl,
                    decoration: const InputDecoration(
                      labelText: 'Yaş',
                      suffixText: 'yıl',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _weightCtrl,
                    decoration: const InputDecoration(
                      labelText: 'Ağırlık',
                      suffixText: 'kg',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[\d.,]')),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: SegmentedButton<BiologicalSex>(
                    segments: const [
                      ButtonSegment(
                        value: BiologicalSex.male,
                        label: Text('Erkek'),
                        icon: Icon(Icons.male),
                      ),
                      ButtonSegment(
                        value: BiologicalSex.female,
                        label: Text('Kadın'),
                        icon: Icon(Icons.female),
                      ),
                    ],
                    selected: {_sex},
                    onSelectionChanged: (s) => setState(() => _sex = s.first),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: _calculate,
                child: const Text('Hesapla'),
              ),
            ),
            BlocBuilder<CalculatorCubit, CalculatorState>(
              buildWhen: (p, c) =>
                  p.gfrResult != c.gfrResult || p.gfrError != c.gfrError,
              builder: (context, state) {
                if (state.gfrError != null) {
                  return _ErrorText(state.gfrError!);
                }
                if (state.gfrResult == null) return const SizedBox.shrink();
                return _GfrResultTile(result: state.gfrResult!);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _GfrResultTile extends StatelessWidget {
  const _GfrResultTile({required this.result});
  final GfrResult result;

  @override
  Widget build(BuildContext context) {
    final color = _stageColor(result.ckdStage);
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: color.withValues(alpha: 0.35)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      child: Text(
                        _stageLabel(result.ckdStage),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      _stageDescription(result.ckdStage),
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: color),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _MetricTile(
                      label: 'CKD-EPI 2021',
                      value: '${result.ckdEpi2021}',
                      unit: 'mL/min/1.73m²',
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _MetricTile(
                      label: 'Cockcroft-Gault',
                      value: '${result.cockcroftGault}',
                      unit: 'mL/min',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _stageColor(CkdStage s) => switch (s) {
        CkdStage.g1 => Colors.green,
        CkdStage.g2 => Colors.lightGreen.shade700,
        CkdStage.g3a => Colors.amber.shade800,
        CkdStage.g3b => Colors.orange,
        CkdStage.g4 => Colors.deepOrange,
        CkdStage.g5 => Colors.red,
      };

  String _stageLabel(CkdStage s) => switch (s) {
        CkdStage.g1 => 'G1',
        CkdStage.g2 => 'G2',
        CkdStage.g3a => 'G3a',
        CkdStage.g3b => 'G3b',
        CkdStage.g4 => 'G4',
        CkdStage.g5 => 'G5',
      };

  String _stageDescription(CkdStage s) => switch (s) {
        CkdStage.g1 => 'Normal veya yüksek (≥90)',
        CkdStage.g2 => 'Hafif azalmış (60–89)',
        CkdStage.g3a => 'Hafif–orta azalmış (45–59)',
        CkdStage.g3b => 'Orta–ciddi azalmış (30–44)',
        CkdStage.g4 => 'Ciddi azalmış (15–29)',
        CkdStage.g5 => 'Böbrek yetmezliği (<15)',
      };
}

class _MetricTile extends StatelessWidget {
  const _MetricTile({
    required this.label,
    required this.value,
    required this.unit,
  });

  final String label;
  final String value;
  final String unit;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.labelSmall),
        Text(
          value,
          style: Theme.of(context)
              .textTheme
              .headlineSmall
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        Text(unit, style: Theme.of(context).textTheme.labelSmall),
      ],
    );
  }
}

// ── Shared ──────────────────────────────────────────────────────────────────────

class _ErrorText extends StatelessWidget {
  const _ErrorText(this.message);
  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Text(
        message,
        style: TextStyle(color: Theme.of(context).colorScheme.error),
      ),
    );
  }
}
