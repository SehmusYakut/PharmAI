import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmai/core/l10n/app_localizations.dart';
import 'package:pharmai/presentation/bloc/calculator/calculator_cubit.dart';
import 'package:pharmai/presentation/bloc/calculator/calculator_state.dart';
import 'package:pharmai/presentation/widgets/calculator_form_card.dart';
import 'package:pharmai/presentation/widgets/calculator_result_card.dart';

class BmiCalculatorPage extends StatelessWidget {
  const BmiCalculatorPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.calcBmiTitle)),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        behavior: HitTestBehavior.opaque,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: _BmiSection(l10n: l10n),
        ),
      ),
    );
  }
}

class _BmiSection extends StatefulWidget {
  const _BmiSection({required this.l10n});
  final AppLocalizations l10n;

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
    final l = widget.l10n;
    return CalculatorFormCard(
      icon: Icons.monitor_weight_outlined,
      title: l.calcBmiTitle,
      citation: 'WHO Technical Report Series 854 (1995)',
      formula: l.calcBmiFormula,
      reference: l.calcBmiReference,
      onCalculate: _calculate,
      body: Row(
        children: [
          Expanded(
            child: CalculatorInputField(
              controller: _weightCtrl,
              label: l.calcWeight,
              unit: 'kg',
              decimal: true,
              onSubmit: _calculate,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: CalculatorInputField(
              controller: _heightCtrl,
              label: l.calcHeight,
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
          if (state.bmiError != null) return CalculatorErrorText(state.bmiError!);
          if (state.bmiResult == null) return const SizedBox.shrink();
          return BmiResultCard(result: state.bmiResult!);
        },
      ),
    );
  }
}
