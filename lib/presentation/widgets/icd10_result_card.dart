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
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      clipBehavior: Clip.antiAlias,
      child: Theme(
        // Suppress the default ExpansionTile top/bottom dividers.
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          childrenPadding: EdgeInsets.zero,
          // ── Collapsed row ──────────────────────────────────────────────────
          leading: _CodeBadge(codeStr: code.code, color: badgeColor),
          title: _HighlightText(
            text: code.descriptionTr,
            highlight: highlight,
            style: text.bodyLarge,
            highlightStyle: text.bodyLarge?.copyWith(
              fontWeight: FontWeight.w600,
              color: colors.primary,
            ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 3),
            child: _ChapterChip(label: code.chapterCode, color: badgeColor),
          ),
          // ── Expanded panel ─────────────────────────────────────────────────
          children: [
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // English description
                  _InfoRow(
                    icon: Icons.language,
                    label: 'EN',
                    child: _HighlightText(
                      text: code.descriptionEn,
                      highlight: highlight,
                      style: text.bodyMedium
                          ?.copyWith(color: colors.onSurfaceVariant),
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Full chapter
                  _InfoRow(
                    icon: Icons.folder_outlined,
                    label: 'Bölüm',
                    child: Text(
                      '${code.chapter} (${code.chapterCode})',
                      style: text.bodySmall,
                    ),
                  ),
                  // Block / domain (optional)
                  if (code.blockDescription != null) ...[
                    const SizedBox(height: 8),
                    _InfoRow(
                      icon: Icons.subdirectory_arrow_right,
                      label: 'Alt Grup',
                      child: Text(
                        code.blockCode != null
                            ? '${code.blockDescription} (${code.blockCode})'
                            : code.blockDescription!,
                        style: text.bodySmall,
                      ),
                    ),
                  ],
                  // Active status
                  const SizedBox(height: 8),
                  _InfoRow(
                    icon: Icons.check_circle_outline,
                    label: 'Durum',
                    child: Text(
                      code.isActive ? 'Aktif' : 'Pasif',
                      style: text.bodySmall?.copyWith(
                        color: code.isActive
                            ? Colors.green.shade700
                            : colors.error,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  // WHO URL (selectable so users can long-press to copy)
                  if (code.url != null) ...[
                    const SizedBox(height: 8),
                    _InfoRow(
                      icon: Icons.link,
                      label: 'WHO',
                      child: SelectableText(
                        code.url!,
                        style: text.bodySmall
                            ?.copyWith(color: colors.primary),
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
      constraints: const BoxConstraints(minWidth: 58),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(6),
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
        color: color.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
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
        Icon(icon, size: 15, color: colors.outline),
        const SizedBox(width: 6),
        SizedBox(
          width: 56,
          child: Text(
            label,
            style: Theme.of(context)
                .textTheme
                .labelSmall
                ?.copyWith(color: colors.outline),
          ),
        ),
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
      return Text(text, style: style, maxLines: 2,
          overflow: TextOverflow.ellipsis);
    }
    final lower = text.toLowerCase();
    final q = highlight.toLowerCase();
    final idx = lower.indexOf(q);
    if (idx == -1) {
      return Text(text, style: style, maxLines: 2,
          overflow: TextOverflow.ellipsis);
    }
    final end = idx + q.length;
    final effective = highlightStyle ??
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
