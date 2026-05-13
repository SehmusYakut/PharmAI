// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drug_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetDrugModelCollection on Isar {
  IsarCollection<DrugModel> get drugModels => this.collection();
}

const DrugModelSchema = CollectionSchema(
  name: r'DrugModel',
  id: 4929961659508556113,
  properties: {
    r'activeIngredient': PropertySchema(
      id: 0,
      name: r'activeIngredient',
      type: IsarType.string,
    ),
    r'atcCode': PropertySchema(
      id: 1,
      name: r'atcCode',
      type: IsarType.string,
    ),
    r'barcode': PropertySchema(
      id: 2,
      name: r'barcode',
      type: IsarType.string,
    ),
    r'category1': PropertySchema(
      id: 3,
      name: r'category1',
      type: IsarType.string,
    ),
    r'category2': PropertySchema(
      id: 4,
      name: r'category2',
      type: IsarType.string,
    ),
    r'category3': PropertySchema(
      id: 5,
      name: r'category3',
      type: IsarType.string,
    ),
    r'category4': PropertySchema(
      id: 6,
      name: r'category4',
      type: IsarType.string,
    ),
    r'category5': PropertySchema(
      id: 7,
      name: r'category5',
      type: IsarType.string,
    ),
    r'description': PropertySchema(
      id: 8,
      name: r'description',
      type: IsarType.string,
    ),
    r'productName': PropertySchema(
      id: 9,
      name: r'productName',
      type: IsarType.string,
    ),
    r'searchKey': PropertySchema(
      id: 10,
      name: r'searchKey',
      type: IsarType.string,
    )
  },
  estimateSize: _drugModelEstimateSize,
  serialize: _drugModelSerialize,
  deserialize: _drugModelDeserialize,
  deserializeProp: _drugModelDeserializeProp,
  idName: r'id',
  indexes: {
    r'atcCode': IndexSchema(
      id: -4541710301771656030,
      name: r'atcCode',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'atcCode',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'activeIngredient': IndexSchema(
      id: 8357372621150651587,
      name: r'activeIngredient',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'activeIngredient',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'productName': IndexSchema(
      id: 4701636579502142930,
      name: r'productName',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'productName',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'searchKey': IndexSchema(
      id: -1673253136872295656,
      name: r'searchKey',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'searchKey',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _drugModelGetId,
  getLinks: _drugModelGetLinks,
  attach: _drugModelAttach,
  version: '3.1.0+1',
);

int _drugModelEstimateSize(
  DrugModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.activeIngredient.length * 3;
  bytesCount += 3 + object.atcCode.length * 3;
  bytesCount += 3 + object.barcode.length * 3;
  bytesCount += 3 + object.category1.length * 3;
  bytesCount += 3 + object.category2.length * 3;
  bytesCount += 3 + object.category3.length * 3;
  bytesCount += 3 + object.category4.length * 3;
  bytesCount += 3 + object.category5.length * 3;
  bytesCount += 3 + object.description.length * 3;
  bytesCount += 3 + object.productName.length * 3;
  bytesCount += 3 + object.searchKey.length * 3;
  return bytesCount;
}

void _drugModelSerialize(
  DrugModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.activeIngredient);
  writer.writeString(offsets[1], object.atcCode);
  writer.writeString(offsets[2], object.barcode);
  writer.writeString(offsets[3], object.category1);
  writer.writeString(offsets[4], object.category2);
  writer.writeString(offsets[5], object.category3);
  writer.writeString(offsets[6], object.category4);
  writer.writeString(offsets[7], object.category5);
  writer.writeString(offsets[8], object.description);
  writer.writeString(offsets[9], object.productName);
  writer.writeString(offsets[10], object.searchKey);
}

DrugModel _drugModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = DrugModel();
  object.activeIngredient = reader.readString(offsets[0]);
  object.atcCode = reader.readString(offsets[1]);
  object.barcode = reader.readString(offsets[2]);
  object.category1 = reader.readString(offsets[3]);
  object.category2 = reader.readString(offsets[4]);
  object.category3 = reader.readString(offsets[5]);
  object.category4 = reader.readString(offsets[6]);
  object.category5 = reader.readString(offsets[7]);
  object.description = reader.readString(offsets[8]);
  object.id = id;
  object.productName = reader.readString(offsets[9]);
  object.searchKey = reader.readString(offsets[10]);
  return object;
}

P _drugModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    case 7:
      return (reader.readString(offset)) as P;
    case 8:
      return (reader.readString(offset)) as P;
    case 9:
      return (reader.readString(offset)) as P;
    case 10:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _drugModelGetId(DrugModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _drugModelGetLinks(DrugModel object) {
  return [];
}

void _drugModelAttach(IsarCollection<dynamic> col, Id id, DrugModel object) {
  object.id = id;
}

extension DrugModelQueryWhereSort
    on QueryBuilder<DrugModel, DrugModel, QWhere> {
  QueryBuilder<DrugModel, DrugModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterWhere> anyAtcCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'atcCode'),
      );
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterWhere> anyActiveIngredient() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'activeIngredient'),
      );
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterWhere> anyProductName() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'productName'),
      );
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterWhere> anySearchKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'searchKey'),
      );
    });
  }
}

extension DrugModelQueryWhere
    on QueryBuilder<DrugModel, DrugModel, QWhereClause> {
  QueryBuilder<DrugModel, DrugModel, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterWhereClause> atcCodeEqualTo(
      String atcCode) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'atcCode',
        value: [atcCode],
      ));
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterWhereClause> atcCodeNotEqualTo(
      String atcCode) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'atcCode',
              lower: [],
              upper: [atcCode],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'atcCode',
              lower: [atcCode],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'atcCode',
              lower: [atcCode],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'atcCode',
              lower: [],
              upper: [atcCode],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterWhereClause> atcCodeGreaterThan(
    String atcCode, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'atcCode',
        lower: [atcCode],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterWhereClause> atcCodeLessThan(
    String atcCode, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'atcCode',
        lower: [],
        upper: [atcCode],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterWhereClause> atcCodeBetween(
    String lowerAtcCode,
    String upperAtcCode, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'atcCode',
        lower: [lowerAtcCode],
        includeLower: includeLower,
        upper: [upperAtcCode],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterWhereClause> atcCodeStartsWith(
      String AtcCodePrefix) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'atcCode',
        lower: [AtcCodePrefix],
        upper: ['$AtcCodePrefix\u{FFFFF}'],
      ));
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterWhereClause> atcCodeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'atcCode',
        value: [''],
      ));
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterWhereClause> atcCodeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.lessThan(
              indexName: r'atcCode',
              upper: [''],
            ))
            .addWhereClause(IndexWhereClause.greaterThan(
              indexName: r'atcCode',
              lower: [''],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.greaterThan(
              indexName: r'atcCode',
              lower: [''],
            ))
            .addWhereClause(IndexWhereClause.lessThan(
              indexName: r'atcCode',
              upper: [''],
            ));
      }
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterWhereClause> activeIngredientEqualTo(
      String activeIngredient) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'activeIngredient',
        value: [activeIngredient],
      ));
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterWhereClause>
      activeIngredientNotEqualTo(String activeIngredient) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'activeIngredient',
              lower: [],
              upper: [activeIngredient],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'activeIngredient',
              lower: [activeIngredient],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'activeIngredient',
              lower: [activeIngredient],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'activeIngredient',
              lower: [],
              upper: [activeIngredient],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterWhereClause>
      activeIngredientGreaterThan(
    String activeIngredient, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'activeIngredient',
        lower: [activeIngredient],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterWhereClause>
      activeIngredientLessThan(
    String activeIngredient, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'activeIngredient',
        lower: [],
        upper: [activeIngredient],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterWhereClause> activeIngredientBetween(
    String lowerActiveIngredient,
    String upperActiveIngredient, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'activeIngredient',
        lower: [lowerActiveIngredient],
        includeLower: includeLower,
        upper: [upperActiveIngredient],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterWhereClause>
      activeIngredientStartsWith(String ActiveIngredientPrefix) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'activeIngredient',
        lower: [ActiveIngredientPrefix],
        upper: ['$ActiveIngredientPrefix\u{FFFFF}'],
      ));
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterWhereClause>
      activeIngredientIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'activeIngredient',
        value: [''],
      ));
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterWhereClause>
      activeIngredientIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.lessThan(
              indexName: r'activeIngredient',
              upper: [''],
            ))
            .addWhereClause(IndexWhereClause.greaterThan(
              indexName: r'activeIngredient',
              lower: [''],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.greaterThan(
              indexName: r'activeIngredient',
              lower: [''],
            ))
            .addWhereClause(IndexWhereClause.lessThan(
              indexName: r'activeIngredient',
              upper: [''],
            ));
      }
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterWhereClause> productNameEqualTo(
      String productName) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'productName',
        value: [productName],
      ));
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterWhereClause> productNameNotEqualTo(
      String productName) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'productName',
              lower: [],
              upper: [productName],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'productName',
              lower: [productName],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'productName',
              lower: [productName],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'productName',
              lower: [],
              upper: [productName],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterWhereClause> productNameGreaterThan(
    String productName, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'productName',
        lower: [productName],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterWhereClause> productNameLessThan(
    String productName, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'productName',
        lower: [],
        upper: [productName],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterWhereClause> productNameBetween(
    String lowerProductName,
    String upperProductName, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'productName',
        lower: [lowerProductName],
        includeLower: includeLower,
        upper: [upperProductName],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterWhereClause> productNameStartsWith(
      String ProductNamePrefix) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'productName',
        lower: [ProductNamePrefix],
        upper: ['$ProductNamePrefix\u{FFFFF}'],
      ));
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterWhereClause> productNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'productName',
        value: [''],
      ));
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterWhereClause>
      productNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.lessThan(
              indexName: r'productName',
              upper: [''],
            ))
            .addWhereClause(IndexWhereClause.greaterThan(
              indexName: r'productName',
              lower: [''],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.greaterThan(
              indexName: r'productName',
              lower: [''],
            ))
            .addWhereClause(IndexWhereClause.lessThan(
              indexName: r'productName',
              upper: [''],
            ));
      }
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterWhereClause> searchKeyEqualTo(
      String searchKey) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'searchKey',
        value: [searchKey],
      ));
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterWhereClause> searchKeyNotEqualTo(
      String searchKey) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'searchKey',
              lower: [],
              upper: [searchKey],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'searchKey',
              lower: [searchKey],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'searchKey',
              lower: [searchKey],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'searchKey',
              lower: [],
              upper: [searchKey],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterWhereClause> searchKeyGreaterThan(
    String searchKey, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'searchKey',
        lower: [searchKey],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterWhereClause> searchKeyLessThan(
    String searchKey, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'searchKey',
        lower: [],
        upper: [searchKey],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterWhereClause> searchKeyBetween(
    String lowerSearchKey,
    String upperSearchKey, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'searchKey',
        lower: [lowerSearchKey],
        includeLower: includeLower,
        upper: [upperSearchKey],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterWhereClause> searchKeyStartsWith(
      String SearchKeyPrefix) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'searchKey',
        lower: [SearchKeyPrefix],
        upper: ['$SearchKeyPrefix\u{FFFFF}'],
      ));
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterWhereClause> searchKeyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'searchKey',
        value: [''],
      ));
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterWhereClause> searchKeyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.lessThan(
              indexName: r'searchKey',
              upper: [''],
            ))
            .addWhereClause(IndexWhereClause.greaterThan(
              indexName: r'searchKey',
              lower: [''],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.greaterThan(
              indexName: r'searchKey',
              lower: [''],
            ))
            .addWhereClause(IndexWhereClause.lessThan(
              indexName: r'searchKey',
              upper: [''],
            ));
      }
    });
  }
}

extension DrugModelQueryFilter
    on QueryBuilder<DrugModel, DrugModel, QFilterCondition> {
  QueryBuilder<DrugModel, DrugModel, QAfterFilterCondition>
      activeIngredientEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'activeIngredient',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterFilterCondition>
      activeIngredientGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'activeIngredient',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterFilterCondition>
      activeIngredientLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'activeIngredient',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterFilterCondition>
      activeIngredientBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'activeIngredient',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterFilterCondition>
      activeIngredientStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'activeIngredient',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterFilterCondition>
      activeIngredientEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'activeIngredient',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterFilterCondition>
      activeIngredientContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'activeIngredient',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterFilterCondition>
      activeIngredientMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'activeIngredient',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterFilterCondition>
      activeIngredientIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'activeIngredient',
        value: '',
      ));
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterFilterCondition>
      activeIngredientIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'activeIngredient',
        value: '',
      ));
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterFilterCondition> atcCodeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'atcCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterFilterCondition> atcCodeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'atcCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterFilterCondition> atcCodeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'atcCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterFilterCondition> atcCodeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'atcCode',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterFilterCondition> atcCodeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'atcCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterFilterCondition> atcCodeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'atcCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterFilterCondition> atcCodeContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'atcCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterFilterCondition> atcCodeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'atcCode',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterFilterCondition> atcCodeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'atcCode',
        value: '',
      ));
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterFilterCondition>
      atcCodeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'atcCode',
        value: '',
      ));
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterFilterCondition> barcodeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'barcode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterFilterCondition> barcodeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'barcode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterFilterCondition> barcodeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'barcode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterFilterCondition> barcodeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'barcode',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterFilterCondition> barcodeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'barcode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterFilterCondition> barcodeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'barcode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterFilterCondition> barcodeContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'barcode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterFilterCondition> barcodeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'barcode',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterFilterCondition> barcodeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'barcode',
        value: '',
      ));
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterFilterCondition>
      barcodeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'barcode',
        value: '',
      ));
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterFilterCondition> category1EqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'category1',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterFilterCondition>
      category1GreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'category1',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterFilterCondition> category1LessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'category1',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterFilterCondition> category1Between(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'category1',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterFilterCondition> category1StartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'category1',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterFilterCondition> category1EndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'category1',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterFilterCondition> category1Contains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'category1',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterFilterCondition> category1Matches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'category1',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterFilterCondition> category1IsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'category1',
        value: '',
      ));
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterFilterCondition>
      category1IsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'category1',
        value: '',
      ));
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterFilterCondition> category2EqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'category2',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterFilterCondition>
      category2GreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'category2',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterFilterCondition> category2LessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'category2',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterFilterCondition> category2Between(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'category2',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterFilterCondition> category2StartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'category2',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterFilterCondition> category2EndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'category2',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterFilterCondition> category2Contains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'category2',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterFilterCondition> category2Matches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'category2',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterFilterCondition> category2IsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'category2',
        value: '',
      ));
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterFilterCondition>
      category2IsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'category2',
        value: '',
      ));
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterFilterCondition> category3EqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'category3',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterFilterCondition>
      category3GreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'category3',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterFilterCondition> category3LessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'category3',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterFilterCondition> category3Between(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'category3',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterFilterCondition> category3StartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'category3',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterFilterCondition> category3EndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'category3',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterFilterCondition> category3Contains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'category3',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterFilterCondition> category3Matches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'category3',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterFilterCondition> category3IsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'category3',
        value: '',
      ));
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterFilterCondition>
      category3IsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'category3',
        value: '',
      ));
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterFilterCondition> category4EqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'category4',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterFilterCondition>
      category4GreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'category4',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterFilterCondition> category4LessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'category4',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterFilterCondition> category4Between(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'category4',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterFilterCondition> category4StartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'category4',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterFilterCondition> category4EndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'category4',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterFilterCondition> category4Contains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'category4',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterFilterCondition> category4Matches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'category4',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterFilterCondition> category4IsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'category4',
        value: '',
      ));
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterFilterCondition>
      category4IsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'category4',
        value: '',
      ));
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterFilterCondition> category5EqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'category5',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterFilterCondition>
      category5GreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'category5',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterFilterCondition> category5LessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'category5',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterFilterCondition> category5Between(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'category5',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterFilterCondition> category5StartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'category5',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterFilterCondition> category5EndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'category5',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterFilterCondition> category5Contains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'category5',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterFilterCondition> category5Matches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'category5',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterFilterCondition> category5IsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'category5',
        value: '',
      ));
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterFilterCondition>
      category5IsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'category5',
        value: '',
      ));
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterFilterCondition> descriptionEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterFilterCondition>
      descriptionGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterFilterCondition> descriptionLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterFilterCondition> descriptionBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'description',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterFilterCondition>
      descriptionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterFilterCondition> descriptionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterFilterCondition> descriptionContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterFilterCondition> descriptionMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'description',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterFilterCondition>
      descriptionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterFilterCondition>
      descriptionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterFilterCondition> productNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'productName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterFilterCondition>
      productNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'productName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterFilterCondition> productNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'productName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterFilterCondition> productNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'productName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterFilterCondition>
      productNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'productName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterFilterCondition> productNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'productName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterFilterCondition> productNameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'productName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterFilterCondition> productNameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'productName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterFilterCondition>
      productNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'productName',
        value: '',
      ));
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterFilterCondition>
      productNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'productName',
        value: '',
      ));
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterFilterCondition> searchKeyEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'searchKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterFilterCondition>
      searchKeyGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'searchKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterFilterCondition> searchKeyLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'searchKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterFilterCondition> searchKeyBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'searchKey',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterFilterCondition> searchKeyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'searchKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterFilterCondition> searchKeyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'searchKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterFilterCondition> searchKeyContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'searchKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterFilterCondition> searchKeyMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'searchKey',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterFilterCondition> searchKeyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'searchKey',
        value: '',
      ));
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterFilterCondition>
      searchKeyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'searchKey',
        value: '',
      ));
    });
  }
}

extension DrugModelQueryObject
    on QueryBuilder<DrugModel, DrugModel, QFilterCondition> {}

extension DrugModelQueryLinks
    on QueryBuilder<DrugModel, DrugModel, QFilterCondition> {}

extension DrugModelQuerySortBy on QueryBuilder<DrugModel, DrugModel, QSortBy> {
  QueryBuilder<DrugModel, DrugModel, QAfterSortBy> sortByActiveIngredient() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activeIngredient', Sort.asc);
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterSortBy>
      sortByActiveIngredientDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activeIngredient', Sort.desc);
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterSortBy> sortByAtcCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'atcCode', Sort.asc);
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterSortBy> sortByAtcCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'atcCode', Sort.desc);
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterSortBy> sortByBarcode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'barcode', Sort.asc);
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterSortBy> sortByBarcodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'barcode', Sort.desc);
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterSortBy> sortByCategory1() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category1', Sort.asc);
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterSortBy> sortByCategory1Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category1', Sort.desc);
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterSortBy> sortByCategory2() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category2', Sort.asc);
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterSortBy> sortByCategory2Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category2', Sort.desc);
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterSortBy> sortByCategory3() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category3', Sort.asc);
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterSortBy> sortByCategory3Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category3', Sort.desc);
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterSortBy> sortByCategory4() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category4', Sort.asc);
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterSortBy> sortByCategory4Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category4', Sort.desc);
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterSortBy> sortByCategory5() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category5', Sort.asc);
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterSortBy> sortByCategory5Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category5', Sort.desc);
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterSortBy> sortByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterSortBy> sortByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterSortBy> sortByProductName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'productName', Sort.asc);
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterSortBy> sortByProductNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'productName', Sort.desc);
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterSortBy> sortBySearchKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'searchKey', Sort.asc);
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterSortBy> sortBySearchKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'searchKey', Sort.desc);
    });
  }
}

extension DrugModelQuerySortThenBy
    on QueryBuilder<DrugModel, DrugModel, QSortThenBy> {
  QueryBuilder<DrugModel, DrugModel, QAfterSortBy> thenByActiveIngredient() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activeIngredient', Sort.asc);
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterSortBy>
      thenByActiveIngredientDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activeIngredient', Sort.desc);
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterSortBy> thenByAtcCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'atcCode', Sort.asc);
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterSortBy> thenByAtcCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'atcCode', Sort.desc);
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterSortBy> thenByBarcode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'barcode', Sort.asc);
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterSortBy> thenByBarcodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'barcode', Sort.desc);
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterSortBy> thenByCategory1() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category1', Sort.asc);
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterSortBy> thenByCategory1Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category1', Sort.desc);
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterSortBy> thenByCategory2() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category2', Sort.asc);
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterSortBy> thenByCategory2Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category2', Sort.desc);
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterSortBy> thenByCategory3() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category3', Sort.asc);
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterSortBy> thenByCategory3Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category3', Sort.desc);
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterSortBy> thenByCategory4() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category4', Sort.asc);
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterSortBy> thenByCategory4Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category4', Sort.desc);
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterSortBy> thenByCategory5() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category5', Sort.asc);
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterSortBy> thenByCategory5Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category5', Sort.desc);
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterSortBy> thenByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterSortBy> thenByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterSortBy> thenByProductName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'productName', Sort.asc);
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterSortBy> thenByProductNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'productName', Sort.desc);
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterSortBy> thenBySearchKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'searchKey', Sort.asc);
    });
  }

  QueryBuilder<DrugModel, DrugModel, QAfterSortBy> thenBySearchKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'searchKey', Sort.desc);
    });
  }
}

extension DrugModelQueryWhereDistinct
    on QueryBuilder<DrugModel, DrugModel, QDistinct> {
  QueryBuilder<DrugModel, DrugModel, QDistinct> distinctByActiveIngredient(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'activeIngredient',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DrugModel, DrugModel, QDistinct> distinctByAtcCode(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'atcCode', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DrugModel, DrugModel, QDistinct> distinctByBarcode(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'barcode', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DrugModel, DrugModel, QDistinct> distinctByCategory1(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'category1', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DrugModel, DrugModel, QDistinct> distinctByCategory2(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'category2', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DrugModel, DrugModel, QDistinct> distinctByCategory3(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'category3', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DrugModel, DrugModel, QDistinct> distinctByCategory4(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'category4', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DrugModel, DrugModel, QDistinct> distinctByCategory5(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'category5', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DrugModel, DrugModel, QDistinct> distinctByDescription(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'description', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DrugModel, DrugModel, QDistinct> distinctByProductName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'productName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DrugModel, DrugModel, QDistinct> distinctBySearchKey(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'searchKey', caseSensitive: caseSensitive);
    });
  }
}

extension DrugModelQueryProperty
    on QueryBuilder<DrugModel, DrugModel, QQueryProperty> {
  QueryBuilder<DrugModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<DrugModel, String, QQueryOperations> activeIngredientProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'activeIngredient');
    });
  }

  QueryBuilder<DrugModel, String, QQueryOperations> atcCodeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'atcCode');
    });
  }

  QueryBuilder<DrugModel, String, QQueryOperations> barcodeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'barcode');
    });
  }

  QueryBuilder<DrugModel, String, QQueryOperations> category1Property() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'category1');
    });
  }

  QueryBuilder<DrugModel, String, QQueryOperations> category2Property() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'category2');
    });
  }

  QueryBuilder<DrugModel, String, QQueryOperations> category3Property() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'category3');
    });
  }

  QueryBuilder<DrugModel, String, QQueryOperations> category4Property() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'category4');
    });
  }

  QueryBuilder<DrugModel, String, QQueryOperations> category5Property() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'category5');
    });
  }

  QueryBuilder<DrugModel, String, QQueryOperations> descriptionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'description');
    });
  }

  QueryBuilder<DrugModel, String, QQueryOperations> productNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'productName');
    });
  }

  QueryBuilder<DrugModel, String, QQueryOperations> searchKeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'searchKey');
    });
  }
}
