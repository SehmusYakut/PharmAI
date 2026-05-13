import 'package:isar/isar.dart';
import 'package:pharmai/core/utils/text_utils.dart';
import 'package:pharmai/domain/entities/drug.dart';

part 'drug_model.g.dart';

/// Isar collection for drug reference data.
///
/// Index strategy:
///   productName       value  — prefix / contains lookups (display field)
///   activeIngredient  value  — prefix / contains lookups (display field)
///   atcCode           value  — ATC code prefix search (e.g. "M01AB")
///   searchKey         value  — Turkish-normalised productName + activeIngredient
///                              for case/diacritic-insensitive full-text search
@collection
class DrugModel {
  Id id = Isar.autoIncrement;

  late String barcode;

  @Index(type: IndexType.value, caseSensitive: false)
  late String atcCode;

  @Index(type: IndexType.value, caseSensitive: false)
  late String activeIngredient;

  @Index(type: IndexType.value, caseSensitive: false)
  late String productName;

  late String category1;
  late String category2;
  late String category3;
  late String category4;
  late String category5;

  late String description;

  /// Normalised concatenation used for Turkish-aware search queries.
  /// Populated during seeding; never displayed to the user.
  @Index(type: IndexType.value, caseSensitive: false)
  late String searchKey;

  // ── Mappers ─────────────────────────────────────────────────────────────────

  Drug toDomain() => Drug(
        id: id,
        barcode: barcode,
        atcCode: atcCode,
        activeIngredient: activeIngredient,
        productName: productName,
        category1: category1,
        category2: category2,
        category3: category3,
        category4: category4,
        category5: category5,
        description: description,
      );

  static DrugModel fromRaw({
    required String barcode,
    required String atcCode,
    required String activeIngredient,
    required String productName,
    required String category1,
    required String category2,
    required String category3,
    required String category4,
    required String category5,
    required String description,
  }) =>
      DrugModel()
        ..barcode = barcode
        ..atcCode = atcCode
        ..activeIngredient = activeIngredient
        ..productName = productName
        ..category1 = category1
        ..category2 = category2
        ..category3 = category3
        ..category4 = category4
        ..category5 = category5
        ..description = description
        ..searchKey = TextUtils.normalize('$productName $activeIngredient');
}
