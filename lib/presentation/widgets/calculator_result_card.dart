import 'package:flutter/material.dart';
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
                  Text('VKİ',
                      style:
                          text.labelSmall?.copyWith(color: color)),
                  Text(
                    '${result.bmi}',
                    style: text.displaySmall?.copyWith(
                        color: color, fontWeight: FontWeight.bold),
                  ),
                  Text('kg/m²',
                      style:
                          text.labelSmall?.copyWith(color: color)),
                ],
              ),
              const SizedBox(width: 20),
              // ── Classification ─────────────────────────────────────────────
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _Chip(
                        label: _categoryLabel(result.category),
                        color: color),
                    const SizedBox(height: 6),
                    Text(
                      _categoryRange(result.category),
                      style: text.bodySmall
                          ?.copyWith(color: color.withValues(alpha: 0.8)),
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

  static String _categoryLabel(BmiCategory cat) => switch (cat) {
        BmiCategory.severelyUnderweight => 'Ciddi Düşük Ağırlık',
        BmiCategory.underweight => 'Düşük Ağırlık',
        BmiCategory.normalWeight => 'Normal Ağırlık',
        BmiCategory.overweight => 'Fazla Kilolu',
        BmiCategory.obeseClassI => 'Obezite – Sınıf I',
        BmiCategory.obeseClassII => 'Obezite – Sınıf II',
        BmiCategory.obeseClassIII => 'Obezite – Sınıf III',
      };

  static String _categoryRange(BmiCategory cat) => switch (cat) {
        BmiCategory.severelyUnderweight => '< 16,0 kg/m²',
        BmiCategory.underweight => '16,0 – 18,4 kg/m²',
        BmiCategory.normalWeight => '18,5 – 24,9 kg/m²',
        BmiCategory.overweight => '25,0 – 29,9 kg/m²',
        BmiCategory.obeseClassI => '30,0 – 34,9 kg/m²',
        BmiCategory.obeseClassII => '35,0 – 39,9 kg/m²',
        BmiCategory.obeseClassIII => '≥ 40,0 kg/m²',
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
                      label: _stageLabel(result.ckdStage), color: color),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      _stageDescription(result.ckdStage),
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
                        label: 'CKD-EPI 2021',
                        note: 'Evreleme için tercih edilir',
                        value: '${result.ckdEpi2021}',
                        unit: 'mL/min/1.73m²',
                      ),
                    ),
                    VerticalDivider(
                      width: 24,
                      color: color.withValues(alpha: 0.25),
                    ),
                    Expanded(
                      child: _EquationResult(
                        label: 'Cockcroft-Gault',
                        note: 'İlaç dozlaması için tercih edilir',
                        value: '${result.cockcroftGault}',
                        unit: 'mL/min',
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

  static String _stageLabel(CkdStage s) => switch (s) {
        CkdStage.g1 => 'G1',
        CkdStage.g2 => 'G2',
        CkdStage.g3a => 'G3a',
        CkdStage.g3b => 'G3b',
        CkdStage.g4 => 'G4',
        CkdStage.g5 => 'G5',
      };

  static String _stageDescription(CkdStage s) => switch (s) {
        CkdStage.g1 => 'Normal veya yüksek  (≥ 90 mL/min/1.73m²)',
        CkdStage.g2 => 'Hafif azalmış  (60–89)',
        CkdStage.g3a => 'Hafif–orta azalmış  (45–59)',
        CkdStage.g3b => 'Orta–ciddi azalmış  (30–44)',
        CkdStage.g4 => 'Ciddi azalmış  (15–29)',
        CkdStage.g5 => 'Böbrek yetmezliği  (< 15)',
      };
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
        Text(label,
            style:
                text.labelMedium?.copyWith(fontWeight: FontWeight.w600)),
        Text(note,
            style: text.labelSmall?.copyWith(color: outline)),
        const SizedBox(height: 4),
        Text(value,
            style: text.headlineSmall
                ?.copyWith(fontWeight: FontWeight.bold)),
        Text(unit, style: text.labelSmall?.copyWith(color: outline)),
      ],
    );
  }
}
