import 'package:flutter/material.dart';
import 'package:pharmai/domain/entities/icd10_code.dart';

/// A single row in the ICD-10 search results list.
///
/// Performance notes:
///   • The tile itself is `const`-constructible (all fields are final).
///   • [_HighlightText] rebuilds only when [highlight] changes.
///   • Chapter badge color is computed once via a static lookup – O(1).
class Icd10CodeTile extends StatelessWidget {
  const Icd10CodeTile({
    super.key,
    required this.code,
    required this.highlight,
    this.onTap,
  });

  final Icd10Code code;

  /// The current search query – used to bold the matching substring.
  final String highlight;

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;
    final badgeColor = _chapterColor(code.code);

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Chapter badge ────────────────────────────────────────────────
            _CodeBadge(codeStr: code.code, color: badgeColor),
            const SizedBox(width: 12),

            // ── Description block ────────────────────────────────────────────
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _HighlightText(
                    text: code.descriptionTr,
                    highlight: highlight,
                    style: textTheme.bodyLarge,
                    highlightStyle: textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: colors.primary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  _HighlightText(
                    text: code.descriptionEn,
                    highlight: highlight,
                    style: textTheme.bodySmall?.copyWith(
                      color: colors.onSurfaceVariant,
                    ),
                  ),
                  if (code.blockDescription != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      code.blockDescription!,
                      style: textTheme.labelSmall?.copyWith(
                        color: colors.outline,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
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

  // ── Chapter color lookup ───────────────────────────────────────────────────
  // Colors loosely follow SNOMED/ICD chapter conventions for quick recognition.

  static Color _chapterColor(String code) {
    if (code.isEmpty) return Colors.grey;
    switch (code[0].toUpperCase()) {
      case 'A':
      case 'B':
        return const Color(0xFFE57373); // Infectious – red
      case 'C':
      case 'D':
        return const Color(0xFFBA68C8); // Neoplasms – purple
      case 'E':
        return const Color(0xFFFFB74D); // Endocrine – orange
      case 'F':
        return const Color(0xFF7986CB); // Mental – indigo
      case 'G':
        return const Color(0xFF4DB6AC); // Nervous – teal
      case 'H':
        return const Color(0xFF4DD0E1); // Eye/Ear – cyan
      case 'I':
        return const Color(0xFFEF5350); // Circulatory – deep red
      case 'J':
        return const Color(0xFF64B5F6); // Respiratory – blue
      case 'K':
        return const Color(0xFFFFD54F); // Digestive – amber
      case 'L':
        return const Color(0xFFF48FB1); // Skin – pink
      case 'M':
        return const Color(0xFFA1887F); // Musculoskeletal – brown
      case 'N':
        return const Color(0xFF4FC3F7); // Genitourinary – light blue
      case 'O':
        return const Color(0xFFF06292); // Pregnancy – deep pink
      case 'P':
        return const Color(0xFFAED581); // Perinatal – light green
      case 'Q':
        return const Color(0xFF9575CD); // Congenital – deep purple
      case 'R':
        return const Color(0xFF90A4AE); // Symptoms – blue-grey
      case 'S':
      case 'T':
        return const Color(0xFFFF8A65); // Injury – deep orange
      case 'Z':
        return const Color(0xFF81C784); // Health factors – green
      default:
        return const Color(0xFFB0BEC5); // Unknown – grey
    }
  }
}

// ── Private widgets ───────────────────────────────────────────────────────────

class _CodeBadge extends StatelessWidget {
  const _CodeBadge({required this.codeStr, required this.color});

  final String codeStr;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minWidth: 56),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
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

/// Renders [text] with the first occurrence of [highlight] shown in
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
      return Text(text, style: style, maxLines: 2, overflow: TextOverflow.ellipsis);
    }

    final lower = text.toLowerCase();
    final q = highlight.toLowerCase();
    final idx = lower.indexOf(q);

    if (idx == -1) {
      return Text(text, style: style, maxLines: 2, overflow: TextOverflow.ellipsis);
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
