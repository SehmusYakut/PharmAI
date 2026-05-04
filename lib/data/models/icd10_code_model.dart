import 'package:isar/isar.dart';
import 'package:pharmai/domain/entities/icd10_code.dart';

part 'icd10_code_model.g.dart';

/// Isar collection — data layer only.
///
/// Clean Architecture boundary:
///   • This file imports Isar; [Icd10Code] (domain entity) never imports this.
///   • [toDomain] / [fromDomain] are the only crossing points between layers.
///
/// ── Index strategy for Fuzzy Search (ProjectRules §6) ────────────────────────
///
///  Field            IndexType   Purpose
///  ───────────────  ──────────  ────────────────────────────────────────────
///  code             value       Prefix search ("E11" → E11.0…E11.9)  O(log n)
///  descriptionEn    value       Prefix query; *contains* falls back to
///  descriptionTr    value       full scan (fast on memory-mapped Isar store)
///  chapterCode      hash        Equality filter to narrow by chapter
///  blockCode        hash        Equality filter to narrow by block/domain
///  isActive         value       Pre-filter: only return active codes
///
///  Note: IndexType.value enables startsWith + equalTo + sorting.
///        IndexType.hash enables equalTo only (smaller index, faster for
///        exact-match category filters like chapterCode / blockCode).
@collection
class Icd10CodeModel {
  // ── Primary key ─────────────────────────────────────────────────────────────

  Id id = Isar.autoIncrement;

  // ── Search fields (IndexType.value for prefix + fuzzy contains) ─────────────

  /// Full ICD-10 code, e.g. "A00.0", "E11.9".
  /// Prefix index → searchByCodePrefix("E11") uses O(log n) index scan.
  @Index(type: IndexType.value, caseSensitive: false)
  late String code;

  /// English description from the WHO dataset (CSV column: definition).
  /// Fuzzy search via descriptionEnContains() uses this index for prefix
  /// queries and falls back to a memory-mapped full-scan for mid-string
  /// matches — acceptable for the ≈70 k ICD-10 dataset size.
  @Index(type: IndexType.value, caseSensitive: false)
  late String descriptionEn;

  /// Turkish description — seeded from [descriptionEn] until a TR translation
  /// dataset is integrated.  Same index strategy as [descriptionEn].
  @Index(type: IndexType.value, caseSensitive: false)
  late String descriptionTr;

  // ── Category / filter fields (IndexType.hash for equality filtering) ─────────

  /// Chapter title, e.g. "Certain infectious and parasitic diseases".
  /// Parsed from CSV `chapter` field, second line of the multi-line value.
  late String chapter;

  /// Chapter code range, e.g. "A00-B99".
  /// Hash-indexed so the UI can filter by chapter without a full scan.
  @Index(type: IndexType.hash, caseSensitive: false)
  late String chapterCode;

  /// Block/domain title, e.g. "Intestinal infectious diseases".
  /// Parsed from CSV `domain` field, first line.
  String? blockDescription;

  /// Block code range, e.g. "A00-A09".
  /// Hash-indexed for block-level filtering (nullable — top-level chapter
  /// codes may not belong to a named sub-block).
  @Index(type: IndexType.hash, caseSensitive: false)
  String? blockCode;

  // ── Metadata ─────────────────────────────────────────────────────────────────

  /// Direct URL to the WHO ICD-10 browser entry.
  /// Not indexed — we never query by URL.
  String? url;

  /// Active-code filter applied to every search query.
  @Index(type: IndexType.value)
  late bool isActive;

  // ── Mapper ───────────────────────────────────────────────────────────────────

  /// Converts to a pure domain entity — no Isar types escape this layer.
  Icd10Code toDomain() => Icd10Code(
        code: code,
        descriptionEn: descriptionEn,
        descriptionTr: descriptionTr,
        chapter: chapter,
        chapterCode: chapterCode,
        blockDescription: blockDescription,
        blockCode: blockCode,
        url: url,
        isActive: isActive,
      );

  /// Builds a storable model from a domain entity.
  static Icd10CodeModel fromDomain(Icd10Code entity) => Icd10CodeModel()
    ..code = entity.code
    ..descriptionEn = entity.descriptionEn
    ..descriptionTr = entity.descriptionTr
    ..chapter = entity.chapter
    ..chapterCode = entity.chapterCode
    ..blockDescription = entity.blockDescription
    ..blockCode = entity.blockCode
    ..url = entity.url
    ..isActive = entity.isActive;
}
