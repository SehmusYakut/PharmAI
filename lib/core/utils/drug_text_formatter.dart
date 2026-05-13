/// Structured block types produced by [DrugTextFormatter.parse].
sealed class DrugTextBlock {
  const DrugTextBlock(this.text);
  final String text;
}

/// A numbered section heading, e.g. "1. DOLARIT nedir ve ne için kullanılır?"
final class DrugHeadingBlock extends DrugTextBlock {
  const DrugHeadingBlock(super.text);
}

/// A short all-caps or label line, e.g. "KULLANMA TALİMATI" or "Etkin madde:"
final class DrugSubheadingBlock extends DrugTextBlock {
  const DrugSubheadingBlock(super.text);
}

/// A single bullet point (leading bullet already stripped).
final class DrugBulletBlock extends DrugTextBlock {
  const DrugBulletBlock(super.text);
}

/// Plain body paragraph text.
final class DrugBodyBlock extends DrugTextBlock {
  const DrugBodyBlock(super.text);
}

/// Converts a raw PHPMyAdmin-exported drug description string into a list of
/// structured [DrugTextBlock]s ready for rich rendering.
///
/// Handles:
///   • C1 control-character bullets (U+0095) introduced by CP-1252 → UTF-8
///     double-encoding: bytes `0xC2 0x95` decode to U+0095, which is invisible.
///   • UTF-8 replacement characters (U+FFFD) used as fallback bullets.
///   • Numbered section headings running into preceding text without a newline.
///   • PHPMyAdmin page-number artefacts ("1 / 12").
///   • Excessive whitespace and blank lines.
abstract class DrugTextFormatter {
  DrugTextFormatter._();

  static List<DrugTextBlock> parse(String raw) {
    if (raw.trim().isEmpty) return const [];
    final cleaned = _clean(raw);
    return cleaned
        .split('\n')
        .map((l) => l.trim())
        .where((l) => l.isNotEmpty)
        .map(_classify)
        .toList();
  }

  // ── Cleaning pipeline ──────────────────────────────────────────────────────

  static String _clean(String raw) {
    var t = raw;

    // 1. Normalize line endings.
    t = t.replaceAll('\r\n', '\n').replaceAll('\r', '\n');

    // 2. Fix corrupted bullets.
    //    CP-1252 bullet (0x95) encoded in UTF-8 as the 2-byte sequence C2 95
    //    → decoded to the C1 control char U+0095 (invisible in text renderers).
    //    Optional U+00C2 prefix appears when double-encoding artefacts occur.
    t = t.replaceAll(RegExp(r'Â?'), '•');
    //    Also replace UTF-8 replacement chars used as fallback bullets.
    t = t.replaceAll('�', '•');

    // 3. Normalize bullets: place each bullet on its own line.
    //    Handles both inline bullets and leading-whitespace variants.
    t = t.replaceAll(RegExp(r'[ \t]*•[ \t]*'), '\n• ');

    // 4. Ensure numbered section headings start on their own line.
    //    Matches digit(s) + dot + space + letter when NOT already after \n.
    t = t.replaceAllMapped(
      RegExp(r'(?<!\n)(\d+\.)(\s)(?=[A-ZÇĞİÖŞÜa-zçğıöşü])'),
      (m) => '\n${m.group(1)}${m.group(2)}',
    );

    // 5. Ensure known CAPS headings start on their own line.
    for (final kw in _knownHeadings) {
      t = t.replaceAll(kw, '\n$kw');
    }

    // 6. Remove PHPMyAdmin page-number artefacts like "1 / 12".
    t = t.replaceAll(RegExp(r'(?<!\w)\d+\s*/\s*\d+(?!\w)'), '');

    // 7. Collapse runs of blank lines and excess horizontal whitespace.
    t = t.replaceAll(RegExp(r'[ \t]{2,}'), ' ');
    t = t.replaceAll(RegExp(r'\n{3,}'), '\n\n');

    return t.trim();
  }

  static const _knownHeadings = [
    'KULLANMA TALİMATI',
    'AĞIZDAN ALINIR',
    'ENDİKASYONLAR',
    'KONTRENDİKASYONLAR',
    'UYARILAR',
    'İNTERAKSİYONLAR',
    'GENEL BİLGİLER',
    'DOZAJ VE UYGULAMA',
    'YAN ETKİLER',
    'SAKLANMA KOŞULLARI',
  ];

  // ── Block classifier ───────────────────────────────────────────────────────

  static DrugTextBlock _classify(String line) {
    // Numbered section heading: "1. Some text..."
    if (RegExp(r'^\d+\.\s+\S').hasMatch(line)) {
      return DrugHeadingBlock(line);
    }

    // Bullet item (leading bullet already normalized to "• ").
    if (line.startsWith('• ')) {
      return DrugBulletBlock(line.substring(2).trim());
    }

    // All-caps line → major heading (min 6 chars to filter noise).
    if (line.length >= 6 &&
        RegExp(r'^[A-ZÇĞİÖŞÜ][A-ZÇĞİÖŞÜ\s\(\)\-\/\.,]+$').hasMatch(line)) {
      return DrugSubheadingBlock(line);
    }

    // Short line ending with colon → label/subheading.
    if (line.endsWith(':') && line.length < 80) {
      return DrugSubheadingBlock(line);
    }

    return DrugBodyBlock(line);
  }
}
