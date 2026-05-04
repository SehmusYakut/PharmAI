import 'package:isar/isar.dart';
import 'package:pharmai/domain/entities/icd10_code.dart';

part 'icd10_code_model.g.dart';

/// Isar collection – data layer only.
///
/// Clean Architecture boundary:
///   • This class imports Isar and owns persistence concerns.
///   • The domain entity [Icd10Code] never imports this file.
///   • [toDomain] / [fromDomain] are the only crossing points.
@collection
class Icd10CodeModel {
  /// Isar auto-increment primary key.
  Id id = Isar.autoIncrement;

  /// Full ICD-10 code string, e.g. "E11.9".
  ///
  /// [IndexType.value] stores the original string and supports:
  ///   • Exact match  → .codeEqualTo('E11.9')
  ///   • Prefix match → .codeStartsWith('E11')  (used by code search)
  ///   • Sorting
  @Index(type: IndexType.value, caseSensitive: false)
  late String code;

  /// Turkish description.
  ///
  /// [IndexType.value] stores the full string and enables prefix queries.
  /// Substring / fuzzy matching (ProjectRules §6) is handled at query time
  /// via Isar's filter().descriptionTrContains() – no extra index needed
  /// because Isar's memory-mapped reads are fast enough for local-only data.
  @Index(type: IndexType.value, caseSensitive: false)
  late String descriptionTr;

  /// English description – same strategy as [descriptionTr].
  @Index(type: IndexType.value, caseSensitive: false)
  late String descriptionEn;

  late String chapter;
  late String chapterCode;

  String? blockDescription;
  String? blockCode;

  @Index()
  late bool isActive;

  // ── Mapper ──────────────────────────────────────────────────────────────────

  /// Convert to pure domain entity (no Isar types leak out).
  Icd10Code toDomain() => Icd10Code(
        code: code,
        descriptionTr: descriptionTr,
        descriptionEn: descriptionEn,
        chapter: chapter,
        chapterCode: chapterCode,
        blockDescription: blockDescription,
        blockCode: blockCode,
        isActive: isActive,
      );

  /// Build a model from a domain entity, ready to be persisted.
  static Icd10CodeModel fromDomain(Icd10Code entity) => Icd10CodeModel()
    ..code = entity.code
    ..descriptionTr = entity.descriptionTr
    ..descriptionEn = entity.descriptionEn
    ..chapter = entity.chapter
    ..chapterCode = entity.chapterCode
    ..blockDescription = entity.blockDescription
    ..blockCode = entity.blockCode
    ..isActive = entity.isActive;
}
