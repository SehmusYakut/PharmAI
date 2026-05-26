import 'package:flutter/material.dart';
import 'package:pharmai/core/l10n/app_localizations.dart';
import 'package:pharmai/core/utils/calculator_models.dart';

// ── BMI ────────────────────────────────────────────────────────────────────────

/// Colour-coded result panel for a [BmiResult].
///
/// Shows the numeric VKİ value, the WHO classification label, and the
/// BMI range that defines that category.
class BmiResultCard extends StatelessWidget {
  const BmiResultCard({super.key, required this.result});
  final BmiResult result;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final color = _categoryColor(result.category);
    final text = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: color.withValues(alpha: 0.4)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              // ── Numeric value ──────────────────────────────────────────────
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.calcBmiAbbrev,
                    style: text.labelSmall?.copyWith(color: color),
                  ),
                  Text(
                    '${result.bmi}',
                    style: text.displaySmall?.copyWith(
                      color: color,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    l10n.calcBmiUnit,
                    style: text.labelSmall?.copyWith(color: color),
                  ),
                ],
              ),
              const SizedBox(width: 20),
              // ── Classification ─────────────────────────────────────────────
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _Chip(
                      label: _categoryLabel(l10n, result.category),
                      color: color,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      _categoryRange(l10n, result.category),
                      style: text.bodySmall?.copyWith(
                        color: color.withValues(alpha: 0.8),
                      ),
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

  static Color _categoryColor(BmiCategory cat) => switch (cat) {
    BmiCategory.severelyUnderweight => Colors.indigo,
    BmiCategory.underweight => Colors.blue,
    BmiCategory.normalWeight => Colors.green,
    BmiCategory.overweight => Colors.orange,
    BmiCategory.obeseClassI => Colors.deepOrange,
    BmiCategory.obeseClassII => Colors.red,
    BmiCategory.obeseClassIII => Colors.red.shade900,
  };

  static String _categoryLabel(AppLocalizations l10n, BmiCategory cat) =>
      switch (cat) {
        BmiCategory.severelyUnderweight => l10n.calcBmiCatSeverelyUnderweight,
        BmiCategory.underweight => l10n.calcBmiCatUnderweight,
        BmiCategory.normalWeight => l10n.calcBmiCatNormal,
        BmiCategory.overweight => l10n.calcBmiCatOverweight,
        BmiCategory.obeseClassI => l10n.calcBmiCatObeseClassI,
        BmiCategory.obeseClassII => l10n.calcBmiCatObeseClassII,
        BmiCategory.obeseClassIII => l10n.calcBmiCatObeseClassIII,
      };

  static String _categoryRange(AppLocalizations l10n, BmiCategory cat) =>
      switch (cat) {
        BmiCategory.severelyUnderweight => l10n.calcBmiRangeSeverelyUnderweight,
        BmiCategory.underweight => l10n.calcBmiRangeUnderweight,
        BmiCategory.normalWeight => l10n.calcBmiRangeNormal,
        BmiCategory.overweight => l10n.calcBmiRangeOverweight,
        BmiCategory.obeseClassI => l10n.calcBmiRangeObeseClassI,
        BmiCategory.obeseClassII => l10n.calcBmiRangeObeseClassII,
        BmiCategory.obeseClassIII => l10n.calcBmiRangeObeseClassIII,
      };
}

// ── GFR ────────────────────────────────────────────────────────────────────────

/// Colour-coded result panel for a [GfrResult].
///
/// Displays the KDIGO 2022 CKD stage badge, its verbal description, and side-
/// by-side panels for CKD-EPI 2021 and Cockcroft-Gault with usage notes.
class GfrResultCard extends StatelessWidget {
  const GfrResultCard({super.key, required this.result});
  final GfrResult result;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final color = _stageColor(result.ckdStage);
    final text = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: color.withValues(alpha: 0.4)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── CKD stage row ────────────────────────────────────────────
              Row(
                children: [
                  _StageBadge(
                    label: _stageLabel(l10n, result.ckdStage),
                    color: color,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      _stageDescription(l10n, result.ckdStage),
                      style: text.bodySmall?.copyWith(color: color),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              // ── Equation results side-by-side ────────────────────────────
              IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: _EquationResult(
                        label: l10n.calcGfrCkdEpiLabel,
                        note: l10n.calcGfrCkdEpiNote,
                        value: '${result.ckdEpi2021}',
                        unit: l10n.calcGfrCkdEpiUnit,
                      ),
                    ),
                    VerticalDivider(
                      width: 24,
                      color: color.withValues(alpha: 0.25),
                    ),
                    Expanded(
                      child: _EquationResult(
                        label: l10n.calcGfrCockcroftLabel,
                        note: l10n.calcGfrCockcroftNote,
                        value: '${result.cockcroftGault}',
                        unit: l10n.calcGfrCockcroftUnit,
                      ),
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

  static Color _stageColor(CkdStage s) => switch (s) {
    CkdStage.g1 => Colors.green,
    CkdStage.g2 => Colors.lightGreen.shade700,
    CkdStage.g3a => Colors.amber.shade800,
    CkdStage.g3b => Colors.orange,
    CkdStage.g4 => Colors.deepOrange,
    CkdStage.g5 => Colors.red,
  };

  static String _stageLabel(AppLocalizations l10n, CkdStage s) => switch (s) {
    CkdStage.g1 => l10n.calcGfrStageG1,
    CkdStage.g2 => l10n.calcGfrStageG2,
    CkdStage.g3a => l10n.calcGfrStageG3a,
    CkdStage.g3b => l10n.calcGfrStageG3b,
    CkdStage.g4 => l10n.calcGfrStageG4,
    CkdStage.g5 => l10n.calcGfrStageG5,
  };

  static String _stageDescription(AppLocalizations l10n, CkdStage s) =>
      switch (s) {
        CkdStage.g1 => l10n.calcGfrStageDescG1,
        CkdStage.g2 => l10n.calcGfrStageDescG2,
        CkdStage.g3a => l10n.calcGfrStageDescG3a,
        CkdStage.g3b => l10n.calcGfrStageDescG3b,
        CkdStage.g4 => l10n.calcGfrStageDescG4,
        CkdStage.g5 => l10n.calcGfrStageDescG5,
      };
}

// ── Pediatric Estimated Weight ───────────────────────────────────────────────

class PediatricWeightResultCard extends StatelessWidget {
  const PediatricWeightResultCard({super.key, required this.result});
  final PediatricWeightResult result;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final text = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: colors.primary.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: colors.primary.withValues(alpha: 0.4)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              Icon(Icons.monitor_weight, color: colors.primary),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(l10n.calcEstimatedWeight, style: text.labelMedium),
                    Text(
                      '${result.weightKg.toStringAsFixed(1)} ${l10n.calcKgUnit}',
                      style: text.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
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

// ── IV Drip Rate ─────────────────────────────────────────────────────────────

class IvDripRateResultCard extends StatelessWidget {
  const IvDripRateResultCard({super.key, required this.result});
  final IvDripRateResult result;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final text = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: colors.tertiary.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: colors.tertiary.withValues(alpha: 0.4)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              Icon(Icons.water_drop, color: colors.tertiary),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(l10n.calcDropsPerMinute, style: text.labelMedium),
                    Text(
                      '${result.dropsPerMinute} ${l10n.calcDropsPerMinuteUnit}',
                      style: text.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
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

// ── Shared private widgets ─────────────────────────────────────────────────────

class _Chip extends StatelessWidget {
  const _Chip({required this.label, required this.color});
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}

class _StageBadge extends StatelessWidget {
  const _StageBadge({required this.label, required this.color});
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 15,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }
}

class _EquationResult extends StatelessWidget {
  const _EquationResult({
    required this.label,
    required this.note,
    required this.value,
    required this.unit,
  });
  final String label;
  final String note;
  final String value;
  final String unit;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final outline = Theme.of(context).colorScheme.outline;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: text.labelMedium?.copyWith(fontWeight: FontWeight.w600),
        ),
        Text(note, style: text.labelSmall?.copyWith(color: outline)),
        const SizedBox(height: 4),
        Text(
          value,
          style: text.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        Text(unit, style: text.labelSmall?.copyWith(color: outline)),
      ],
    );
  }
}
