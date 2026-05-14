import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pharmai/core/l10n/app_localizations.dart';

/// Reusable scaffold for one calculator section.
///
/// Renders a header (icon + [title] + [citation]), the [body] input area,
/// a "Hesapla" action button, and a [result] slot driven by a BlocBuilder
/// in the parent widget.
class CalculatorFormCard extends StatelessWidget {
  const CalculatorFormCard({
    super.key,
    required this.icon,
    required this.title,
    required this.citation,
    this.formula,
    this.reference,
    required this.body,
    required this.onCalculate,
    required this.result,
  });

  final IconData icon;
  final String title;

  /// Literature reference shown as a muted subtitle below the title.
  final String citation;

  /// Concise equation shown in the info sheet.
  final String? formula;

  /// Medical guideline/literature reference shown in the info sheet.
  final String? reference;

  /// Input fields area — Row/Column of [CalculatorInputField] widgets.
  final Widget body;

  final VoidCallback onCalculate;

  /// BlocBuilder-produced result card, or [SizedBox.shrink] when empty.
  final Widget result;

  bool get _hasEvidenceInfo =>
      formula != null &&
      formula!.trim().isNotEmpty &&
      reference != null &&
      reference!.trim().isNotEmpty;

  void _showEvidenceSheet(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colors = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 44,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: colors.outlineVariant,
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                ),
                Text(
                  l10n.calcInfoTitle,
                  style: text.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  '${l10n.calcFormulaLabel}: ${formula!}',
                  style: text.bodyMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  '${l10n.calcReferenceLabel}: ${reference!}',
                  style: text.bodyMedium?.copyWith(
                    color: colors.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Header ──────────────────────────────────────────────────────
            Row(
              children: [
                Icon(icon, color: colors.primary, size: 22),
                const SizedBox(width: 8),
                Expanded(child: Text(title, style: text.titleMedium)),
                if (_hasEvidenceInfo)
                  IconButton(
                    tooltip: AppLocalizations.of(context).calcInfoTooltip,
                    icon: const Icon(Icons.info_outline, size: 20),
                    onPressed: () => _showEvidenceSheet(context),
                  ),
              ],
            ),
            const SizedBox(height: 2),
            Text(
              citation,
              style: text.labelSmall?.copyWith(color: colors.outline),
            ),
            const Divider(height: 24),
            // ── Input fields ─────────────────────────────────────────────────
            body,
            const SizedBox(height: 14),
            // ── Calculate button ─────────────────────────────────────────────
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: onCalculate,
                icon: const Icon(Icons.calculate_outlined, size: 18),
                label: Text(AppLocalizations.of(context).calcCalculate),
              ),
            ),
            // ── Result / error slot ──────────────────────────────────────────
            result,
          ],
        ),
      ),
    );
  }
}

/// Numeric [TextField] pre-configured for clinical parameter entry.
///
/// [decimal] controls whether a decimal separator is permitted
/// (e.g. true for weight/creatinine, false for integer age).
class CalculatorInputField extends StatelessWidget {
  const CalculatorInputField({
    super.key,
    required this.controller,
    required this.label,
    required this.unit,
    this.decimal = false,
    this.onSubmit,
  });

  final TextEditingController controller;
  final String label;
  final String unit;
  final bool decimal;

  /// Optional: pressing the keyboard action button fires this callback.
  final VoidCallback? onSubmit;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        suffixText: unit,
        border: const OutlineInputBorder(),
        isDense: true,
      ),
      keyboardType: decimal
          ? const TextInputType.numberWithOptions(decimal: true)
          : TextInputType.number,
      inputFormatters: [
        if (decimal)
          FilteringTextInputFormatter.allow(RegExp(r'[\d.,]'))
        else
          FilteringTextInputFormatter.digitsOnly,
      ],
      onSubmitted: onSubmit != null ? (_) => onSubmit!() : null,
    );
  }
}

/// Inline validation / engine error displayed below the calculate button.
class CalculatorErrorText extends StatelessWidget {
  const CalculatorErrorText(this.message, {super.key});
  final String message;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.error;
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.error_outline, size: 16, color: color),
          const SizedBox(width: 6),
          Expanded(
            child: Text(message, style: TextStyle(color: color)),
          ),
        ],
      ),
    );
  }
}
