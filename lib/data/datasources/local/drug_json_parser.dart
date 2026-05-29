import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:pharmai/data/models/drug_model.dart';

/// Parses `assets/data/drugs_data.json` (PHPMyAdmin JSON export) into
/// [DrugModel] objects ready for bulk-insert into Isar.
///
/// JSON structure:
///   [ {"type":"header",...},
///     {"type":"database",...},
///     {"type":"table","name":"ilac","data": [ {drug record}, ... ]} ]
///
/// Parsing runs in a background isolate via [compute] so the UI never freezes
/// during first-launch seeding (file is ~55 MB).
abstract class DrugJsonParser {
  DrugJsonParser._();

  static const String _assetPath = 'assets/data/drugs_data.json';

  /// Loads the bundled JSON asset and returns parsed drug models.
  /// Call once at first launch and feed the result to
  /// [LocalDatabaseService.putAllDrugs] for bulk insert.
  static Future<List<DrugModel>> parseFromAssets() async {
    final data = await rootBundle.load(_assetPath);
    return compute(_parseByteData, data);
  }

  /// Parses raw JSON content already loaded in memory.
  ///
  /// Use this in background isolates when asset loading is performed
  /// separately from parsing.
  static List<DrugModel> parseRaw(String raw) => _parseJsonData(raw);

  static List<DrugModel> _parseByteData(ByteData data) {
    final raw = utf8.decode(
      data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes),
    );
    return _parseJsonData(raw);
  }

  // Top-level function required by compute().
  static List<DrugModel> _parseJsonData(String raw) {
    final root = jsonDecode(raw);
    if (root is! List) return [];

    // Find the table entry that holds the actual drug records.
    final tableEntry = root.firstWhere(
      (e) => e is Map && e['type'] == 'table',
      orElse: () => null,
    );
    if (tableEntry == null) return [];

    final data = (tableEntry as Map)['data'];
    if (data is! List) return [];

    final models = <DrugModel>[];
    for (final entry in data) {
      if (entry is! Map) continue;
      final m = _entryToModel(entry);
      if (m != null) models.add(m);
    }
    return models;
  }

  static DrugModel? _entryToModel(Map entry) {
    try {
      return DrugModel.fromRaw(
        barcode: _s(entry, 'barcode'),
        atcCode: _s(entry, 'ATC_code'),
        activeIngredient: _s(entry, 'Active_Ingredient'),
        productName: _s(entry, 'Product_Name'),
        category1: _s(entry, 'Category_1'),
        category2: _s(entry, 'Category_2'),
        category3: _s(entry, 'Category_3'),
        category4: _s(entry, 'Category_4'),
        category5: _s(entry, 'Category_5'),
        description: _s(entry, 'Description'),
      );
    } catch (_) {
      return null; // Skip malformed records.
    }
  }

  static String _s(Map entry, String key) =>
      (entry[key] as String? ?? '').trim();
}
