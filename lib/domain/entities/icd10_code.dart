import 'package:freezed_annotation/freezed_annotation.dart';

part 'icd10_code.freezed.dart';
part 'icd10_code.g.dart';

/// Pure domain entity – no Isar, no Flutter dependencies.
///
/// Immutable via freezed; JSON support is included so the entity can be
/// deserialised from bundled assets (e.g. a seed JSON file shipped with the
/// app) without touching the data layer.
@freezed
class Icd10Code with _$Icd10Code {
  const factory Icd10Code({
    /// Full ICD-10 code, e.g. "E11.9"
    required String code,

    /// Turkish description – primary display language for TR locale.
    required String descriptionTr,

    /// English description – fallback and reference.
    required String descriptionEn,

    /// Top-level chapter title, e.g.
    /// "Endocrine, nutritional and metabolic diseases"
    required String chapter,

    /// Chapter range code, e.g. "E00-E89"
    required String chapterCode,

    /// Narrower block title, e.g. "Diabetes mellitus" (nullable – not all
    /// codes belong to a named block)
    String? blockDescription,

    /// Block code range, e.g. "E10-E14"
    String? blockCode,

    /// Whether this code is current in the active ICD-10 revision.
    @Default(true) bool isActive,
  }) = _Icd10Code;

  factory Icd10Code.fromJson(Map<String, dynamic> json) =>
      _$Icd10CodeFromJson(json);
}
