import 'package:csv/csv.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:pharmai/data/models/icd10_code_model.dart';

/// Parses `assets/data/icd10_codes.csv` into [Icd10CodeModel] objects ready
/// for bulk-insert into Isar.
///
/// ── CSV structure ────────────────────────────────────────────────────────────
///
///  Col 0  (unnamed)  row index — discarded
///  Col 1  url        WHO ICD-10 browser URL
///  Col 2  chapter    3-line quoted field:
///                      line 0 → "Chapter {Roman}"   (e.g. "Chapter I")
///                      line 1 → chapter name        (e.g. "Certain infectious…")
///                      line 2 → "(A00-B99)"         → chapterCode after strip
///  Col 3  domain     2-line quoted field:
///                      line 0 → block name          → blockDescription
///                      line 1 → "(A00-A09)"         → blockCode after strip
///  Col 4  sub-code   ICD-10 code string             → code
///  Col 5  definition English description             → descriptionEn + descriptionTr seed
///
/// Because `chapter` and `domain` contain embedded newlines inside RFC 4180
/// quotes, simple line-splitting is invalid — the [csv] package is used for
/// correct tokenisation.
abstract class Icd10CsvParser {
  Icd10CsvParser._();

  static const String _assetPath = 'assets/data/icd10_codes.csv';

  // Column indices (0-based after CSV tokenisation).
  static const int _colUrl = 1;
  static const int _colChapter = 2;
  static const int _colDomain = 3;
  static const int _colCode = 4;
  static const int _colDefinition = 5;

  /// Loads the bundled CSV asset and returns a parsed list of models.
  ///
  /// Call this once at first launch (or after a reset) and feed the result to
  /// [LocalDatabaseService.putAllIcd10] for bulk insert.
  static Future<List<Icd10CodeModel>> parseFromAssets() async {
    final raw = await rootBundle.loadString(_assetPath);
    return compute(_parseCsvData, raw);
  }

  /// Parses raw CSV content already loaded in memory.
  ///
  /// Use this inside background isolates where asset loading is handled
  /// externally and synchronous parsing is preferred.
  static List<Icd10CodeModel> parseRaw(String raw) => _parseCsvData(raw);

  static List<Icd10CodeModel> _parseCsvData(String raw) {
    // CsvToListConverter handles RFC 4180 quoting, including fields that
    // contain embedded newlines (the `chapter` and `domain` columns).
    final rows = const CsvToListConverter(
      shouldParseNumbers: false,
      eol: '\n',
    ).convert(raw);

    // Row 0 is the header — skip it.
    return rows
        .skip(1)
        .where((row) => row.length > _colDefinition)
        .map(_rowToModel)
        .toList();
  }

  // ── Row → model ─────────────────────────────────────────────────────────────

  static Icd10CodeModel _rowToModel(List<dynamic> row) {
    final code = _str(row, _colCode);
    final definition = _str(row, _colDefinition);
    final url = _strOrNull(row, _colUrl);

    final (chapter, chapterCode) = _parseChapter(_str(row, _colChapter));
    final (blockDescription, blockCode) = _parseDomain(_str(row, _colDomain));

    return Icd10CodeModel()
      ..code = code
      ..descriptionEn = definition
      // Seed descriptionTr from English until a Turkish dataset is integrated.
      ..descriptionTr = definition
      ..chapter = chapter
      ..chapterCode = chapterCode
      ..blockDescription = blockDescription
      ..blockCode = blockCode
      ..url = url
      ..isActive = true;
  }

  // ── Field parsers ────────────────────────────────────────────────────────────

  /// Parses the multi-line `chapter` field.
  ///
  /// Input (after CSV tokenisation, embedded \n preserved):
  ///   "Chapter I\nCertain infectious and parasitic diseases\n(A00-B99)"
  ///
  /// Returns (chapterName, chapterCode).
  static (String, String) _parseChapter(String raw) {
    final lines = raw.split('\n').map((l) => l.trim()).toList();
    // line 0: "Chapter I"  → not stored separately (derivable from chapterCode)
    // line 1: chapter name
    // line 2: "(A00-B99)"  → strip parens
    final name = lines.length >= 2 ? lines[1] : raw.trim();
    final code = lines.length >= 3 ? _stripParens(lines[2]) : '';
    return (name, code);
  }

  /// Parses the multi-line `domain` field.
  ///
  /// Input: "Intestinal infectious diseases\n(A00-A09)"
  ///
  /// Returns (blockDescription, blockCode), both nullable via empty-to-null.
  static (String?, String?) _parseDomain(String raw) {
    final lines = raw.split('\n').map((l) => l.trim()).toList();
    final desc = lines.isNotEmpty ? lines[0] : '';
    final code = lines.length >= 2 ? _stripParens(lines[1]) : '';
    return (desc.isEmpty ? null : desc, code.isEmpty ? null : code);
  }

  /// Removes surrounding parentheses: "(A00-B99)" → "A00-B99".
  static String _stripParens(String s) =>
      s.replaceAll(RegExp(r'[()]'), '').trim();

  // ── Safe accessors ───────────────────────────────────────────────────────────

  static String _str(List<dynamic> row, int col) =>
      (row[col] as String? ?? '').trim();

  static String? _strOrNull(List<dynamic> row, int col) {
    final v = (row[col] as String? ?? '').trim();
    return v.isEmpty ? null : v;
  }
}
