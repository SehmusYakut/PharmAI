import 'package:flutter/material.dart';
import 'package:pharmai/domain/entities/icd10_code.dart';

/// Expandable result card for a single ICD-10 code.
///
/// Collapsed row: coloured code badge  +  Turkish description (highlighted)
///                +  chapter-range chip.
///
/// Expanded panel: English description, chapter hierarchy, block hierarchy,
///                 and a selectable WHO URL when present.
class Icd10ResultCard extends StatelessWidget {
  const Icd10ResultCard({
    super.key,
    required this.code,
    required this.highlight,
  });

  final Icd10Code code;

  /// Current search query – matching substring is bolded in the primary colour.
  final String highlight;

  @override
  Widget build(BuildContext context) {
    final badgeColor = _chapterColor(code.code);
    final text = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
        side: BorderSide(color: colors.outlineVariant.withValues(alpha: 0.5)),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          backgroundColor: colors.surfaceContainerLowest.withValues(
            alpha: 0.92,
          ),
          collapsedBackgroundColor: colors.surfaceContainerLowest.withValues(
            alpha: 0.92,
          ),
          tilePadding: const EdgeInsets.fromLTRB(18, 14, 18, 12),
          childrenPadding: const EdgeInsets.fromLTRB(18, 0, 18, 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          collapsedShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          iconColor: colors.primary,
          collapsedIconColor: colors.outline,
          leading: _CodeBadge(codeStr: code.code, color: badgeColor),
          title: _HighlightText(
            text: code.descriptionTr,
            highlight: highlight,
            style: text.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
              height: 1.35,
            ),
            highlightStyle: text.bodyLarge?.copyWith(
              fontWeight: FontWeight.w600,
              color: colors.primary,
            ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _ChapterChip(label: code.chapterCode, color: badgeColor),
              ],
            ),
          ),
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: colors.surfaceContainerHighest.withValues(alpha: 0.34),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _InfoRow(
                    icon: Icons.language_rounded,
                    label: 'EN',
                    child: _HighlightText(
                      text: code.descriptionEn,
                      highlight: highlight,
                      style: text.bodyMedium?.copyWith(
                        color: colors.onSurfaceVariant,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  _InfoRow(
                    icon: Icons.folder_open_rounded,
                    label: 'Bölüm',
                    child: Text(
                      '${code.chapter} (${code.chapterCode})',
                      style: text.bodySmall,
                    ),
                  ),
                  if (code.blockDescription != null) ...[
                    const SizedBox(height: 8),
                    _InfoRow(
                      icon: Icons.subdirectory_arrow_right_rounded,
                      label: 'Alt Grup',
                      child: Text(
                        code.blockCode != null
                            ? '${code.blockDescription} (${code.blockCode})'
                            : code.blockDescription!,
                        style: text.bodySmall,
                      ),
                    ),
                  ],
                  if (code.url != null) ...[
                    const SizedBox(height: 8),
                    _InfoRow(
                      icon: Icons.link_rounded,
                      label: 'WHO',
                      child: SelectableText(
                        code.url!,
                        style: text.bodySmall?.copyWith(color: colors.primary),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Chapter colour lookup ──────────────────────────────────────────────────
  // Matches the palette in icd10_code_tile.dart for visual consistency.

  static Color _chapterColor(String code) {
    if (code.isEmpty) return Colors.grey;
    return switch (code[0].toUpperCase()) {
      'A' || 'B' => const Color(0xFFE57373),
      'C' || 'D' => const Color(0xFFBA68C8),
      'E' => const Color(0xFFFFB74D),
      'F' => const Color(0xFF7986CB),
      'G' => const Color(0xFF4DB6AC),
      'H' => const Color(0xFF4DD0E1),
      'I' => const Color(0xFFEF5350),
      'J' => const Color(0xFF64B5F6),
      'K' => const Color(0xFFFFD54F),
      'L' => const Color(0xFFF48FB1),
      'M' => const Color(0xFFA1887F),
      'N' => const Color(0xFF4FC3F7),
      'O' => const Color(0xFFF06292),
      'P' => const Color(0xFFAED581),
      'Q' => const Color(0xFF9575CD),
      'R' => const Color(0xFF90A4AE),
      'S' || 'T' => const Color(0xFFFF8A65),
      'Z' => const Color(0xFF81C784),
      _ => const Color(0xFFB0BEC5),
    };
  }
}

// ── Private sub-widgets ────────────────────────────────────────────────────────

class _CodeBadge extends StatelessWidget {
  const _CodeBadge({required this.codeStr, required this.color});
  final String codeStr;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minWidth: 64),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withValues(alpha: 0.6)),
      ),
      child: Text(
        codeStr,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: color.withValues(alpha: 0.9),
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

class _ChapterChip extends StatelessWidget {
  const _ChapterChip({required this.label, required this.color});
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w600,
            color: color.withValues(alpha: 0.85),
          ),
        ),
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w700,
            color: color.withValues(alpha: 0.9),
          ),
        ),
      ),
    );
  }
}

/// One labelled detail row inside the expanded panel.
class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.icon,
    required this.label,
    required this.child,
  });
  final IconData icon;
  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: colors.primary.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 16, color: colors.primary),
        ),
        const SizedBox(width: 10),
        SizedBox(
          width: 56,
          child: Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Text(
              label,
              style: Theme.of(
                context,
              ).textTheme.labelSmall?.copyWith(color: colors.outline),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(child: child),
      ],
    );
  }
}

/// Renders [text] with the first occurrence of [highlight] bolded in
/// [highlightStyle].  Falls back to a plain [Text] when there is no match.
class _HighlightText extends StatelessWidget {
  const _HighlightText({
    required this.text,
    required this.highlight,
    this.style,
    this.highlightStyle,
  });

  final String text;
  final String highlight;
  final TextStyle? style;
  final TextStyle? highlightStyle;

  @override
  Widget build(BuildContext context) {
    if (highlight.isEmpty) {
      return Text(
        text,
        style: style,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      );
    }
    final lower = text.toLowerCase();
    final q = highlight.toLowerCase();
    final idx = lower.indexOf(q);
    if (idx == -1) {
      return Text(
        text,
        style: style,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      );
    }
    final end = idx + q.length;
    final effective =
        highlightStyle ??
        (style ?? const TextStyle()).copyWith(fontWeight: FontWeight.w600);
    return RichText(
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        style: style ?? DefaultTextStyle.of(context).style,
        children: [
          if (idx > 0) TextSpan(text: text.substring(0, idx)),
          TextSpan(text: text.substring(idx, end), style: effective),
          if (end < text.length) TextSpan(text: text.substring(end)),
        ],
      ),
    );
  }
}
