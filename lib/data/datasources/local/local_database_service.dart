import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pharmai/core/config/app_config.dart';
import 'package:pharmai/core/constants/app_constants.dart';
import 'package:pharmai/data/models/bookmark_model.dart';
import 'package:pharmai/data/models/icd10_code_model.dart';
import 'package:pharmai/data/models/local_profile_model.dart';

/// Single owner of the Isar instance for the entire app.
///
/// Design decisions:
///   • Lazy init: [_db] is opened on first access so app startup is not
///     blocked by I/O (ProjectRules §7 – local speed is paramount).
///   • Singleton lifetime: registered as a GetIt singleton so one Isar
///     instance is shared across all repositories.
///   • Async CRUD: every write goes through an Isar write transaction to
///     guarantee ACID semantics with no thread contention.
class LocalDatabaseService {
  Isar? _db;

  // ── Lifecycle ───────────────────────────────────────────────────────────────

  /// Returns the open [Isar] instance, opening it if not yet initialised.
  Future<Isar> get db async => _db ??= await _open();

  Future<Isar> _open() async {
    final dir = await getApplicationDocumentsDirectory();
    return Isar.open(
      [Icd10CodeModelSchema, LocalProfileModelSchema, BookmarkModelSchema],
      directory: dir.path,
      name: AppConfig.isarDbName,
    );
  }

  /// Close the database. Call during app teardown or in tests.
  Future<void> dispose() async {
    await _db?.close();
    _db = null;
  }

  // ── ICD-10 queries ──────────────────────────────────────────────────────────

  /// Prefix search on the [Icd10CodeModel.code] index.
  /// "e11" → finds E11, E11.0 … E11.9, etc.  O(log n) via index.
  /// [offset] supports pagination – pass the total results already held.
  Future<List<Icd10CodeModel>> searchByCodePrefix(
    String prefix, {
    int offset = 0,
  }) async {
    final isar = await db;
    return isar.icd10CodeModels
        .where()
        .codeStartsWith(prefix.toUpperCase())
        .filter()
        .isActiveEqualTo(true)
        .offset(offset)
        .limit(AppConstants.maxSearchResults)
        .findAll();
  }

  /// Fuzzy description search: checks whether either language description
  /// contains [query] as a substring (case-insensitive).
  ///
  /// No index covers mid-string contains, but Isar's memory-mapped store
  /// makes a full-collection filter fast enough for the target dataset size
  /// (≈70 000 ICD-10 codes fit comfortably in memory-mapped pages).
  /// [offset] supports pagination.
  Future<List<Icd10CodeModel>> searchByDescription(
    String query, {
    int offset = 0,
  }) async {
    final isar = await db;
    final normalised = query.toLowerCase();
    return isar.icd10CodeModels
        .filter()
        .isActiveEqualTo(true)
        .and()
        .group(
          (q) => q
              .descriptionTrContains(normalised, caseSensitive: false)
              .or()
              .descriptionEnContains(normalised, caseSensitive: false),
        )
        .offset(offset)
        .limit(AppConstants.maxSearchResults)
        .findAll();
  }

  /// Exact code lookup. Returns null when not found (not an error).
  Future<Icd10CodeModel?> findByExactCode(String code) async {
    final isar = await db;
    return isar.icd10CodeModels
        .where()
        .codeEqualTo(code.toUpperCase())
        .findFirst();
  }

  // ── ICD-10 writes ───────────────────────────────────────────────────────────

  /// Bulk-upsert [models] inside a single write transaction.
  /// Returns the count of records written.
  Future<int> putAllIcd10(List<Icd10CodeModel> models) async {
    final isar = await db;
    await isar.writeTxn(() => isar.icd10CodeModels.putAll(models));
    return models.length;
  }

  /// Total ICD-10 records in the store.
  Future<int> countIcd10() async {
    final isar = await db;
    return isar.icd10CodeModels.count();
  }

  /// Wipe all ICD-10 data. Used by the KVKK erasure flow.
  Future<void> clearIcd10() async {
    final isar = await db;
    await isar.writeTxn(() => isar.icd10CodeModels.clear());
  }
}
