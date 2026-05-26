import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmai/core/l10n/app_localizations.dart';
import 'package:pharmai/core/utils/calculator_models.dart';
import 'package:pharmai/presentation/bloc/calculator/calculator_cubit.dart';
import 'package:pharmai/presentation/bloc/calculator/calculator_state.dart';
import 'package:pharmai/presentation/widgets/calculator_form_card.dart';
import 'package:pharmai/presentation/widgets/calculator_result_card.dart';

class IvDripRateCalculatorPage extends StatelessWidget {
  const IvDripRateCalculatorPage({super.key});

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
              l10n.calcIvDripRateTitle,
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
          child: _IvDripRateSection(l10n: l10n),
        ),
      ),
    );
  }
}

class _IvDripRateSection extends StatefulWidget {
  const _IvDripRateSection({required this.l10n});
  final AppLocalizations l10n;

  @override
  State<_IvDripRateSection> createState() => _IvDripRateSectionState();
}

class _IvDripRateSectionState extends State<_IvDripRateSection> {
  final _volumeCtrl = TextEditingController();
  final _timeCtrl = TextEditingController();
  IvTimeUnit _timeUnit = IvTimeUnit.hours;
  int _dropFactor = 20;

  @override
  void dispose() {
    _volumeCtrl.dispose();
    _timeCtrl.dispose();
    super.dispose();
  }

  void _calculate() {
    final volume = double.tryParse(_volumeCtrl.text.replaceAll(',', '.'));
    final time = int.tryParse(_timeCtrl.text);
    if (volume == null || time == null) return;

    context.read<CalculatorCubit>().calculateIvDripRate(
      volumeMl: volume,
      totalTime: time,
      timeUnit: _timeUnit,
      dropFactor: _dropFactor,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l = widget.l10n;
    return CalculatorFormCard(
      icon: Icons.water_drop_outlined,
      title: l.calcIvDripRateTitle,
      citation: l.calcIvDripRateCitation,
      formula: l.calcIvDripRateFormula,
      reference: l.calcIvDripRateReference,
      onCalculate: _calculate,
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: CalculatorInputField(
                  controller: _volumeCtrl,
                  label: l.calcVolumeMl,
                  unit: l.calcMlUnit,
                  decimal: true,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: DropdownButtonFormField<int>(
                  value: _dropFactor,
                  isExpanded: true,
                  decoration: InputDecoration(
                    labelText: l.calcDropFactor,
                    border: const OutlineInputBorder(),
                    isDense: true,
                  ),
                  items: const [10, 15, 20, 60]
                      .map(
                        (value) => DropdownMenuItem(
                          value: value,
                          child: Text(l.calcDropFactorOption(value)),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    if (value == null) return;
                    setState(() => _dropFactor = value);
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: CalculatorInputField(
                  controller: _timeCtrl,
                  label: l.calcTotalTime,
                  unit: _timeUnit == IvTimeUnit.hours
                      ? l.calcHoursShort
                      : l.calcMinutesShort,
                  decimal: false,
                  onSubmit: _calculate,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: DropdownButtonFormField<IvTimeUnit>(
                  value: _timeUnit,
                  isExpanded: true,
                  decoration: InputDecoration(
                    labelText: l.calcTimeUnit,
                    border: const OutlineInputBorder(),
                    isDense: true,
                  ),
                  items: [
                    DropdownMenuItem(
                      value: IvTimeUnit.hours,
                      child: Text(l.calcHours),
                    ),
                    DropdownMenuItem(
                      value: IvTimeUnit.minutes,
                      child: Text(l.calcMinutes),
                    ),
                  ],
                  onChanged: (value) {
                    if (value == null) return;
                    setState(() => _timeUnit = value);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
      result: BlocBuilder<CalculatorCubit, CalculatorState>(
        buildWhen: (p, c) =>
            p.ivDripRateResult != c.ivDripRateResult ||
            p.ivDripRateError != c.ivDripRateError,
        builder: (context, state) {
          if (state.ivDripRateError != null) {
            return CalculatorErrorText(state.ivDripRateError!);
          }
          if (state.ivDripRateResult == null) return const SizedBox.shrink();
          return IvDripRateResultCard(result: state.ivDripRateResult!);
        },
      ),
    );
  }
}
