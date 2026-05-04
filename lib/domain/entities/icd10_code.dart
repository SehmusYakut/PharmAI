import 'package:freezed_annotation/freezed_annotation.dart';

part 'icd10_code.freezed.dart';
part 'icd10_code.g.dart';

/// Pure domain entity – no Isar, no Flutter dependencies.
///
/// Field mapping from assets/data/icd10_codes.csv:
///   CSV column   │ parse step              │ entity field
///   ─────────────┼─────────────────────────┼──────────────────
///   sub-code     │ direct                  │ code
///   definition   │ direct                  │ descriptionEn
///   definition   │ copy until TR available │ descriptionTr
///   chapter[1]   │ split on \n, line 1     │ chapter
///   chapter[2]   │ split on \n, line 2     │ chapterCode  (strip parens)
///   domain[0]    │ split on \n, line 0     │ blockDescription
///   domain[1]    │ split on \n, line 1     │ blockCode    (strip parens)
///   url          │ direct                  │ url
@freezed
class Icd10Code with _$Icd10Code {
  const factory Icd10Code({
    /// Full ICD-10 code, e.g. "A00.0", "E11.9".
    required String code,

    /// Turkish description – primary display language for TR locale.
    /// Seeded from [descriptionEn] until a Turkish dataset is available.
    required String descriptionTr,

    /// English description from the WHO ICD-10 CSV (column: definition).
    required String descriptionEn,

    /// Chapter title, e.g. "Certain infectious and parasitic diseases".
    /// Parsed from CSV column `chapter` (second line of the multi-line field).
    required String chapter,

    /// Chapter code range, e.g. "A00-B99".
    /// Parsed from CSV column `chapter` (third line, parentheses stripped).
    required String chapterCode,

    /// Block/domain title, e.g. "Intestinal infectious diseases".
    /// Parsed from CSV column `domain` (first line).
    String? blockDescription,

    /// Block code range, e.g. "A00-A09".
    /// Parsed from CSV column `domain` (second line, parentheses stripped).
    String? blockCode,

    /// Direct URL to the WHO ICD-10 browser entry.
    /// Useful for "open in browser" deep-links inside the app.
    String? url,

    /// Whether this code is active in the current ICD-10 revision.
    @Default(true) bool isActive,
  }) = _Icd10Code;

  factory Icd10Code.fromJson(Map<String, dynamic> json) =>
      _$Icd10CodeFromJson(json);
}
