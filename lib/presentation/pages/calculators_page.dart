import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pharmai/core/utils/calculator_models.dart';
import 'package:pharmai/presentation/bloc/calculator/calculator_cubit.dart';
import 'package:pharmai/presentation/bloc/calculator/calculator_state.dart';
import 'package:pharmai/presentation/widgets/calculator_form_card.dart';
import 'package:pharmai/presentation/widgets/calculator_result_card.dart';

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
            _BmiSection(),
            SizedBox(height: 16),
            _GfrSection(),
            SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

// ── BMI ────────────────────────────────────────────────────────────────────────

class _BmiSection extends StatefulWidget {
  const _BmiSection();

  @override
  State<_BmiSection> createState() => _BmiSectionState();
}

class _BmiSectionState extends State<_BmiSection> {
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
    return CalculatorFormCard(
      icon: Icons.monitor_weight_outlined,
      title: 'Vücut Kitle İndeksi (VKİ)',
      citation: 'WHO Technical Report Series 854 (1995)',
      onCalculate: _calculate,
      body: Row(
        children: [
          Expanded(
            child: CalculatorInputField(
              controller: _weightCtrl,
              label: 'Ağırlık',
              unit: 'kg',
              decimal: true,
              onSubmit: _calculate,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: CalculatorInputField(
              controller: _heightCtrl,
              label: 'Boy',
              unit: 'cm',
              decimal: true,
              onSubmit: _calculate,
            ),
          ),
        ],
      ),
      result: BlocBuilder<CalculatorCubit, CalculatorState>(
        buildWhen: (p, c) =>
            p.bmiResult != c.bmiResult || p.bmiError != c.bmiError,
        builder: (context, state) {
          if (state.bmiError != null) {
            return CalculatorErrorText(state.bmiError!);
          }
          if (state.bmiResult == null) return const SizedBox.shrink();
          return BmiResultCard(result: state.bmiResult!);
        },
      ),
    );
  }
}

// ── GFR ────────────────────────────────────────────────────────────────────────

class _GfrSection extends StatefulWidget {
  const _GfrSection();

  @override
  State<_GfrSection> createState() => _GfrSectionState();
}

class _GfrSectionState extends State<_GfrSection> {
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
    return CalculatorFormCard(
      icon: Icons.water_drop_outlined,
      title: 'Glomerüler Filtrasyon Hızı (GFH)',
      citation:
          'CKD-EPI 2021 · Inker et al., NEJM 385:1737  ·  Cockcroft-Gault, Nephron 1976  ·  KDIGO 2022',
      onCalculate: _calculate,
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: CalculatorInputField(
                  controller: _scrCtrl,
                  label: 'Serum Kreatinin',
                  unit: 'mg/dL',
                  decimal: true,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: CalculatorInputField(
                  controller: _ageCtrl,
                  label: 'Yaş',
                  unit: 'yıl',
                  decimal: false,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: CalculatorInputField(
                  controller: _weightCtrl,
                  label: 'Ağırlık',
                  unit: 'kg',
                  decimal: true,
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
                  onSelectionChanged: (s) =>
                      setState(() => _sex = s.first),
                ),
              ),
            ],
          ),
        ],
      ),
      result: BlocBuilder<CalculatorCubit, CalculatorState>(
        buildWhen: (p, c) =>
            p.gfrResult != c.gfrResult || p.gfrError != c.gfrError,
        builder: (context, state) {
          if (state.gfrError != null) {
            return CalculatorErrorText(state.gfrError!);
          }
          if (state.gfrResult == null) return const SizedBox.shrink();
          return GfrResultCard(result: state.gfrResult!);
        },
      ),
    );
  }
}
