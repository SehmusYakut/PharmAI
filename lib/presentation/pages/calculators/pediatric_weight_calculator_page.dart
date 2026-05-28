import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmai/core/l10n/app_localizations.dart';
import 'package:pharmai/core/utils/calculator_models.dart';
import 'package:pharmai/presentation/bloc/calculator/calculator_cubit.dart';
import 'package:pharmai/presentation/bloc/calculator/calculator_state.dart';
import 'package:pharmai/presentation/widgets/calculator_form_card.dart';
import 'package:pharmai/presentation/widgets/calculator_result_card.dart';

class PediatricWeightCalculatorPage extends StatelessWidget {
  const PediatricWeightCalculatorPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          height: 44,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              l10n.calcPediatricWeightTitle,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              softWrap: true,
              textAlign: TextAlign.start,
            ),
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        behavior: HitTestBehavior.opaque,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: _PediatricWeightSection(l10n: l10n),
        ),
      ),
    );
  }
}

class _PediatricWeightSection extends StatefulWidget {
  const _PediatricWeightSection({required this.l10n});
  final AppLocalizations l10n;

  @override
  State<_PediatricWeightSection> createState() =>
      _PediatricWeightSectionState();
}

class _PediatricWeightSectionState extends State<_PediatricWeightSection> {
  final _ageCtrl = TextEditingController();
  PediatricAgeUnit _ageUnit = PediatricAgeUnit.years;

  @override
  void dispose() {
    _ageCtrl.dispose();
    super.dispose();
  }

  void _calculate() {
    final ageValue = int.tryParse(_ageCtrl.text);
    if (ageValue == null) return;
    context.read<CalculatorCubit>().calculatePediatricEstimatedWeight(
      ageValue: ageValue,
      ageUnit: _ageUnit,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l = widget.l10n;
    return CalculatorFormCard(
      icon: Icons.child_care_outlined,
      title: l.calcPediatricWeightTitle,
      citation: l.calcPediatricWeightCitation,
      formula: l.calcPediatricWeightFormula,
      reference: l.calcPediatricWeightReference,
      onCalculate: _calculate,
      body: Row(
        children: [
          Expanded(
            child: CalculatorInputField(
              controller: _ageCtrl,
              label: l.calcAge,
              unit: _ageUnit == PediatricAgeUnit.months
                  ? l.calcMonthsShort
                  : l.calcYearsShort,
              decimal: false,
              onSubmit: _calculate,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: DropdownButtonFormField<PediatricAgeUnit>(
              initialValue: _ageUnit,
              isExpanded: true,
              decoration: InputDecoration(
                labelText: l.calcAgeUnit,
                border: const OutlineInputBorder(),
                isDense: true,
              ),
              items: [
                DropdownMenuItem(
                  value: PediatricAgeUnit.months,
                  child: Text(l.calcMonths),
                ),
                DropdownMenuItem(
                  value: PediatricAgeUnit.years,
                  child: Text(l.calcYears),
                ),
              ],
              onChanged: (val) {
                if (val == null) return;
                setState(() => _ageUnit = val);
              },
            ),
          ),
        ],
      ),
      result: BlocBuilder<CalculatorCubit, CalculatorState>(
        buildWhen: (p, c) =>
            p.pediatricWeightResult != c.pediatricWeightResult ||
            p.pediatricWeightError != c.pediatricWeightError,
        builder: (context, state) {
          if (state.pediatricWeightError != null) {
            return CalculatorErrorText(state.pediatricWeightError!);
          }
          if (state.pediatricWeightResult == null) {
            return const SizedBox.shrink();
          }
          return PediatricWeightResultCard(
            result: state.pediatricWeightResult!,
          );
        },
      ),
    );
  }
}
