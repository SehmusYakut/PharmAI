import 'package:flutter/material.dart';
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

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header ─────────────────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        drug.productName,
                        style: text.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (drug.activeIngredient.isNotEmpty) ...[
                        const SizedBox(height: 2),
                        Text(
                          drug.activeIngredient,
                          style: text.bodySmall?.copyWith(
                            color: colors.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                if (drug.atcCode.isNotEmpty)
                  _Chip(label: drug.atcCode, color: colors.secondaryContainer),
              ],
            ),
          ),

          // ── Barcode ────────────────────────────────────────────────────────
          if (drug.barcode.isNotEmpty)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 6, 16, 0),
              child: Row(
                children: [
                  Icon(Icons.qr_code_2_rounded, size: 14, color: colors.outline),
                  const SizedBox(width: 4),
                  Text(
                    drug.barcode,
                    style: text.labelSmall?.copyWith(color: colors.outline),
                  ),
                ],
              ),
            ),

          const SizedBox(height: 10),

          // ── Category breadcrumb ────────────────────────────────────────────
          _CategoryPath(drug: drug),

          // ── Description (expandable) ───────────────────────────────────────
          if (_blocks.isNotEmpty) ...[
            const Divider(height: 1),
            InkWell(
              onTap: () => setState(() => _expanded = !_expanded),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'İlaç Bilgisi',
                        style: text.labelMedium?.copyWith(
                          color: colors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Icon(
                      _expanded
                          ? Icons.expand_less_rounded
                          : Icons.expand_more_rounded,
                      color: colors.primary,
                      size: 20,
                    ),
                  ],
                ),
              ),
            ),
            if (_expanded)
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: _DescriptionBody(blocks: _blocks),
              ),
          ],

          const SizedBox(height: 4),
        ],
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
                      '• ',
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
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
      child: Wrap(
        spacing: 4,
        runSpacing: 4,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          for (int i = 0; i < categories.length; i++) ...[
            if (i > 0)
              Icon(Icons.chevron_right_rounded, size: 14, color: colors.outline),
            _Chip(
              label: categories[i],
              color: i == 0
                  ? colors.primaryContainer
                  : colors.surfaceContainerHighest,
              textColor:
                  i == 0 ? colors.onPrimaryContainer : colors.outline,
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
        borderRadius: BorderRadius.circular(6),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
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
