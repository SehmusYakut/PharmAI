import 'package:flutter/material.dart';
import 'package:pharmai/core/l10n/app_localizations.dart';
import 'package:pharmai/core/utils/drug_text_formatter.dart';
import 'package:pharmai/domain/entities/drug.dart';

/// Expandable card showing full drug details.
///
/// Layout:
///   Header  — bold productName + ATC chip
///   Barcode — icon + barcode number
///   Path    — breadcrumb Category 1 › 2 › 3 › 4 › 5
///   Details — expandable rich-text description
class DrugDetailCard extends StatefulWidget {
  const DrugDetailCard({super.key, required this.drug});
  final Drug drug;

  @override
  State<DrugDetailCard> createState() => _DrugDetailCardState();
}

class _DrugDetailCardState extends State<DrugDetailCard> {
  bool _expanded = false;

  /// Parsed once when the card is first created; never recomputed on rebuild.
  late final List<DrugTextBlock> _blocks;

  @override
  void initState() {
    super.initState();
    _blocks = DrugTextFormatter.parse(widget.drug.description);
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    final drug = widget.drug;
    final l10n = AppLocalizations.of(context);
    final detailsLabel = l10n.drugDetailsLabel;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 240),
      curve: Curves.easeOutCubic,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: colors.surfaceContainerLowest.withValues(alpha: 0.95),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: _expanded
              ? colors.primary.withValues(alpha: 0.26)
              : colors.outlineVariant.withValues(alpha: 0.55),
        ),
        boxShadow: [
          BoxShadow(
            color: colors.primary.withValues(alpha: _expanded ? 0.12 : 0.06),
            blurRadius: _expanded ? 24 : 18,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(24),
          onTap: _blocks.isEmpty
              ? null
              : () => setState(() => _expanded = !_expanded),
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 46,
                      height: 46,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [
                            colors.primary.withValues(alpha: 0.95),
                            colors.tertiary.withValues(alpha: 0.92),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: const Icon(
                        Icons.medication_rounded,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            drug.productName,
                            style: text.titleLarge?.copyWith(
                              fontWeight: FontWeight.w800,
                              letterSpacing: -0.2,
                            ),
                          ),
                          if (drug.activeIngredient.isNotEmpty) ...[
                            const SizedBox(height: 4),
                            Text(
                              drug.activeIngredient,
                              style: text.bodyMedium?.copyWith(
                                color: colors.onSurfaceVariant,
                                height: 1.45,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    if (drug.atcCode.isNotEmpty)
                      _Chip(
                        label: drug.atcCode,
                        color: colors.secondaryContainer,
                        textColor: colors.onSecondaryContainer,
                      ),
                  ],
                ),

                if (drug.barcode.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Container(
                        width: 28,
                        height: 28,
                        decoration: BoxDecoration(
                          color: colors.primary.withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.qr_code_2_rounded,
                          size: 16,
                          color: colors.primary,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        drug.barcode,
                        style: text.labelMedium?.copyWith(
                          color: colors.onSurfaceVariant,
                          letterSpacing: 0.2,
                        ),
                      ),
                    ],
                  ),
                ],

                const SizedBox(height: 12),

                _CategoryPath(drug: drug),

                if (_blocks.isNotEmpty) ...[
                  const SizedBox(height: 14),
                  const Divider(height: 1),
                  InkWell(
                    onTap: () => setState(() => _expanded = !_expanded),
                    borderRadius: BorderRadius.circular(18),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              detailsLabel,
                              style: text.labelLarge?.copyWith(
                                color: colors.primary,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                          AnimatedRotation(
                            turns: _expanded ? 0.5 : 0.0,
                            duration: const Duration(milliseconds: 220),
                            curve: Curves.easeOutCubic,
                            child: Icon(
                              Icons.expand_more_rounded,
                              color: colors.primary,
                              size: 22,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  AnimatedCrossFade(
                    firstChild: const SizedBox.shrink(),
                    secondChild: Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: _DescriptionBody(blocks: _blocks),
                    ),
                    crossFadeState: _expanded
                        ? CrossFadeState.showSecond
                        : CrossFadeState.showFirst,
                    duration: const Duration(milliseconds: 220),
                    sizeCurve: Curves.easeOutCubic,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ── Rich description renderer ──────────────────────────────────────────────────

class _DescriptionBody extends StatelessWidget {
  const _DescriptionBody({required this.blocks});
  final List<DrugTextBlock> blocks;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;

    final l10n = AppLocalizations.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final block in blocks)
          switch (block) {
            DrugHeadingBlock(:final blockText) => Padding(
              padding: const EdgeInsets.only(top: 14, bottom: 3),
              child: Text(
                blockText,
                style: text.bodySmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colors.onSurface,
                  height: 1.5,
                ),
              ),
            ),
            DrugSubheadingBlock(:final blockText) => Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 2),
              child: Text(
                blockText,
                style: text.labelSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: colors.primary,
                  letterSpacing: 0.2,
                  height: 1.5,
                ),
              ),
            ),
            DrugBulletBlock(:final blockText) => Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.drugBullet,
                    style: text.bodySmall?.copyWith(
                      color: colors.primary,
                      height: 1.5,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      blockText,
                      style: text.bodySmall?.copyWith(
                        color: colors.onSurfaceVariant,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            DrugBodyBlock(:final blockText) => Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                blockText,
                style: text.bodySmall?.copyWith(
                  color: colors.onSurfaceVariant,
                  height: 1.5,
                ),
              ),
            ),
          },
      ],
    );
  }
}

// ── Category breadcrumb ────────────────────────────────────────────────────────

class _CategoryPath extends StatelessWidget {
  const _CategoryPath({required this.drug});
  final Drug drug;

  @override
  Widget build(BuildContext context) {
    final categories = [
      drug.category1,
      drug.category2,
      drug.category3,
      drug.category4,
      drug.category5,
    ].map((c) => c.trim()).where((c) => c.isNotEmpty).toList();

    if (categories.isEmpty) return const SizedBox.shrink();

    final colors = Theme.of(context).colorScheme;

    return Padding(
      padding: EdgeInsets.zero,
      child: Wrap(
        spacing: 6,
        runSpacing: 6,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          for (int i = 0; i < categories.length; i++) ...[
            if (i > 0)
              Icon(
                Icons.chevron_right_rounded,
                size: 14,
                color: colors.outline,
              ),
            _Chip(
              label: categories[i],
              color: i == 0
                  ? colors.primaryContainer
                  : colors.surfaceContainerHighest,
              textColor: i == 0 ? colors.onPrimaryContainer : colors.outline,
            ),
          ],
        ],
      ),
    );
  }
}

// ── Small label chip ───────────────────────────────────────────────────────────

class _Chip extends StatelessWidget {
  const _Chip({required this.label, required this.color, this.textColor});
  final String label;
  final Color color;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    final fg = textColor ?? Theme.of(context).colorScheme.onSecondaryContainer;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: Text(
          label,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: fg,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

// Convenience extension so switch expressions can destructure the sealed class.
extension on DrugTextBlock {
  String get blockText => text;
}
