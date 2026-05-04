// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'icd10_code_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetIcd10CodeModelCollection on Isar {
  IsarCollection<Icd10CodeModel> get icd10CodeModels => this.collection();
}

const Icd10CodeModelSchema = CollectionSchema(
  name: r'Icd10CodeModel',
  id: 2333586716619814528,
  properties: {
    r'blockCode': PropertySchema(
      id: 0,
      name: r'blockCode',
      type: IsarType.string,
    ),
    r'blockDescription': PropertySchema(
      id: 1,
      name: r'blockDescription',
      type: IsarType.string,
    ),
    r'chapter': PropertySchema(
      id: 2,
      name: r'chapter',
      type: IsarType.string,
    ),
    r'chapterCode': PropertySchema(
      id: 3,
      name: r'chapterCode',
      type: IsarType.string,
    ),
    r'code': PropertySchema(
      id: 4,
      name: r'code',
      type: IsarType.string,
    ),
    r'descriptionEn': PropertySchema(
      id: 5,
      name: r'descriptionEn',
      type: IsarType.string,
    ),
    r'descriptionTr': PropertySchema(
      id: 6,
      name: r'descriptionTr',
      type: IsarType.string,
    ),
    r'isActive': PropertySchema(
      id: 7,
      name: r'isActive',
      type: IsarType.bool,
    ),
    r'url': PropertySchema(
      id: 8,
      name: r'url',
      type: IsarType.string,
    )
  },
  estimateSize: _icd10CodeModelEstimateSize,
  serialize: _icd10CodeModelSerialize,
  deserialize: _icd10CodeModelDeserialize,
  deserializeProp: _icd10CodeModelDeserializeProp,
  idName: r'id',
  indexes: {
    r'code': IndexSchema(
      id: 329780482934683790,
      name: r'code',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'code',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'descriptionEn': IndexSchema(
      id: 2985529149843430803,
      name: r'descriptionEn',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'descriptionEn',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'descriptionTr': IndexSchema(
      id: 4977730737974374443,
      name: r'descriptionTr',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'descriptionTr',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'chapterCode': IndexSchema(
      id: -6731229965406187674,
      name: r'chapterCode',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'chapterCode',
          type: IndexType.hash,
          caseSensitive: false,
        )
      ],
    ),
    r'blockCode': IndexSchema(
      id: -8995861301483755440,
      name: r'blockCode',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'blockCode',
          type: IndexType.hash,
          caseSensitive: false,
        )
      ],
    ),
    r'isActive': IndexSchema(
      id: 8092228061260947457,
      name: r'isActive',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'isActive',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _icd10CodeModelGetId,
  getLinks: _icd10CodeModelGetLinks,
  attach: _icd10CodeModelAttach,
  version: '3.1.0+1',
);

int _icd10CodeModelEstimateSize(
  Icd10CodeModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.blockCode;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.blockDescription;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.chapter.length * 3;
  bytesCount += 3 + object.chapterCode.length * 3;
  bytesCount += 3 + object.code.length * 3;
  bytesCount += 3 + object.descriptionEn.length * 3;
  bytesCount += 3 + object.descriptionTr.length * 3;
  {
    final value = object.url;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _icd10CodeModelSerialize(
  Icd10CodeModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.blockCode);
  writer.writeString(offsets[1], object.blockDescription);
  writer.writeString(offsets[2], object.chapter);
  writer.writeString(offsets[3], object.chapterCode);
  writer.writeString(offsets[4], object.code);
  writer.writeString(offsets[5], object.descriptionEn);
  writer.writeString(offsets[6], object.descriptionTr);
  writer.writeBool(offsets[7], object.isActive);
  writer.writeString(offsets[8], object.url);
}

Icd10CodeModel _icd10CodeModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Icd10CodeModel();
  object.blockCode = reader.readStringOrNull(offsets[0]);
  object.blockDescription = reader.readStringOrNull(offsets[1]);
  object.chapter = reader.readString(offsets[2]);
  object.chapterCode = reader.readString(offsets[3]);
  object.code = reader.readString(offsets[4]);
  object.descriptionEn = reader.readString(offsets[5]);
  object.descriptionTr = reader.readString(offsets[6]);
  object.id = id;
  object.isActive = reader.readBool(offsets[7]);
  object.url = reader.readStringOrNull(offsets[8]);
  return object;
}

P _icd10CodeModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
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
      return (reader.readBool(offset)) as P;
    case 8:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _icd10CodeModelGetId(Icd10CodeModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _icd10CodeModelGetLinks(Icd10CodeModel object) {
  return [];
}

void _icd10CodeModelAttach(
    IsarCollection<dynamic> col, Id id, Icd10CodeModel object) {
  object.id = id;
}

extension Icd10CodeModelQueryWhereSort
    on QueryBuilder<Icd10CodeModel, Icd10CodeModel, QWhere> {
  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterWhere> anyCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'code'),
      );
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterWhere> anyDescriptionEn() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'descriptionEn'),
      );
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterWhere> anyDescriptionTr() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'descriptionTr'),
      );
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterWhere> anyIsActive() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'isActive'),
      );
    });
  }
}

extension Icd10CodeModelQueryWhere
    on QueryBuilder<Icd10CodeModel, Icd10CodeModel, QWhereClause> {
  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterWhereClause> idNotEqualTo(
      Id id) {
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

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterWhereClause> idBetween(
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

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterWhereClause> codeEqualTo(
      String code) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'code',
        value: [code],
      ));
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterWhereClause>
      codeNotEqualTo(String code) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'code',
              lower: [],
              upper: [code],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'code',
              lower: [code],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'code',
              lower: [code],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'code',
              lower: [],
              upper: [code],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterWhereClause>
      codeGreaterThan(
    String code, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'code',
        lower: [code],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterWhereClause> codeLessThan(
    String code, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'code',
        lower: [],
        upper: [code],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterWhereClause> codeBetween(
    String lowerCode,
    String upperCode, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'code',
        lower: [lowerCode],
        includeLower: includeLower,
        upper: [upperCode],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterWhereClause>
      codeStartsWith(String CodePrefix) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'code',
        lower: [CodePrefix],
        upper: ['$CodePrefix\u{FFFFF}'],
      ));
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterWhereClause>
      codeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'code',
        value: [''],
      ));
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterWhereClause>
      codeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.lessThan(
              indexName: r'code',
              upper: [''],
            ))
            .addWhereClause(IndexWhereClause.greaterThan(
              indexName: r'code',
              lower: [''],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.greaterThan(
              indexName: r'code',
              lower: [''],
            ))
            .addWhereClause(IndexWhereClause.lessThan(
              indexName: r'code',
              upper: [''],
            ));
      }
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterWhereClause>
      descriptionEnEqualTo(String descriptionEn) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'descriptionEn',
        value: [descriptionEn],
      ));
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterWhereClause>
      descriptionEnNotEqualTo(String descriptionEn) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'descriptionEn',
              lower: [],
              upper: [descriptionEn],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'descriptionEn',
              lower: [descriptionEn],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'descriptionEn',
              lower: [descriptionEn],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'descriptionEn',
              lower: [],
              upper: [descriptionEn],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterWhereClause>
      descriptionEnGreaterThan(
    String descriptionEn, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'descriptionEn',
        lower: [descriptionEn],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterWhereClause>
      descriptionEnLessThan(
    String descriptionEn, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'descriptionEn',
        lower: [],
        upper: [descriptionEn],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterWhereClause>
      descriptionEnBetween(
    String lowerDescriptionEn,
    String upperDescriptionEn, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'descriptionEn',
        lower: [lowerDescriptionEn],
        includeLower: includeLower,
        upper: [upperDescriptionEn],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterWhereClause>
      descriptionEnStartsWith(String DescriptionEnPrefix) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'descriptionEn',
        lower: [DescriptionEnPrefix],
        upper: ['$DescriptionEnPrefix\u{FFFFF}'],
      ));
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterWhereClause>
      descriptionEnIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'descriptionEn',
        value: [''],
      ));
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterWhereClause>
      descriptionEnIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.lessThan(
              indexName: r'descriptionEn',
              upper: [''],
            ))
            .addWhereClause(IndexWhereClause.greaterThan(
              indexName: r'descriptionEn',
              lower: [''],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.greaterThan(
              indexName: r'descriptionEn',
              lower: [''],
            ))
            .addWhereClause(IndexWhereClause.lessThan(
              indexName: r'descriptionEn',
              upper: [''],
            ));
      }
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterWhereClause>
      descriptionTrEqualTo(String descriptionTr) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'descriptionTr',
        value: [descriptionTr],
      ));
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterWhereClause>
      descriptionTrNotEqualTo(String descriptionTr) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'descriptionTr',
              lower: [],
              upper: [descriptionTr],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'descriptionTr',
              lower: [descriptionTr],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'descriptionTr',
              lower: [descriptionTr],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'descriptionTr',
              lower: [],
              upper: [descriptionTr],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterWhereClause>
      descriptionTrGreaterThan(
    String descriptionTr, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'descriptionTr',
        lower: [descriptionTr],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterWhereClause>
      descriptionTrLessThan(
    String descriptionTr, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'descriptionTr',
        lower: [],
        upper: [descriptionTr],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterWhereClause>
      descriptionTrBetween(
    String lowerDescriptionTr,
    String upperDescriptionTr, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'descriptionTr',
        lower: [lowerDescriptionTr],
        includeLower: includeLower,
        upper: [upperDescriptionTr],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterWhereClause>
      descriptionTrStartsWith(String DescriptionTrPrefix) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'descriptionTr',
        lower: [DescriptionTrPrefix],
        upper: ['$DescriptionTrPrefix\u{FFFFF}'],
      ));
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterWhereClause>
      descriptionTrIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'descriptionTr',
        value: [''],
      ));
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterWhereClause>
      descriptionTrIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.lessThan(
              indexName: r'descriptionTr',
              upper: [''],
            ))
            .addWhereClause(IndexWhereClause.greaterThan(
              indexName: r'descriptionTr',
              lower: [''],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.greaterThan(
              indexName: r'descriptionTr',
              lower: [''],
            ))
            .addWhereClause(IndexWhereClause.lessThan(
              indexName: r'descriptionTr',
              upper: [''],
            ));
      }
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterWhereClause>
      chapterCodeEqualTo(String chapterCode) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'chapterCode',
        value: [chapterCode],
      ));
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterWhereClause>
      chapterCodeNotEqualTo(String chapterCode) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'chapterCode',
              lower: [],
              upper: [chapterCode],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'chapterCode',
              lower: [chapterCode],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'chapterCode',
              lower: [chapterCode],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'chapterCode',
              lower: [],
              upper: [chapterCode],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterWhereClause>
      blockCodeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'blockCode',
        value: [null],
      ));
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterWhereClause>
      blockCodeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'blockCode',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterWhereClause>
      blockCodeEqualTo(String? blockCode) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'blockCode',
        value: [blockCode],
      ));
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterWhereClause>
      blockCodeNotEqualTo(String? blockCode) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'blockCode',
              lower: [],
              upper: [blockCode],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'blockCode',
              lower: [blockCode],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'blockCode',
              lower: [blockCode],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'blockCode',
              lower: [],
              upper: [blockCode],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterWhereClause>
      isActiveEqualTo(bool isActive) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'isActive',
        value: [isActive],
      ));
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterWhereClause>
      isActiveNotEqualTo(bool isActive) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isActive',
              lower: [],
              upper: [isActive],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isActive',
              lower: [isActive],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isActive',
              lower: [isActive],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isActive',
              lower: [],
              upper: [isActive],
              includeUpper: false,
            ));
      }
    });
  }
}

extension Icd10CodeModelQueryFilter
    on QueryBuilder<Icd10CodeModel, Icd10CodeModel, QFilterCondition> {
  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterFilterCondition>
      blockCodeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'blockCode',
      ));
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterFilterCondition>
      blockCodeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'blockCode',
      ));
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterFilterCondition>
      blockCodeEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'blockCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterFilterCondition>
      blockCodeGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'blockCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterFilterCondition>
      blockCodeLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'blockCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterFilterCondition>
      blockCodeBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'blockCode',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterFilterCondition>
      blockCodeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'blockCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterFilterCondition>
      blockCodeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'blockCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterFilterCondition>
      blockCodeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'blockCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterFilterCondition>
      blockCodeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'blockCode',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterFilterCondition>
      blockCodeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'blockCode',
        value: '',
      ));
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterFilterCondition>
      blockCodeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'blockCode',
        value: '',
      ));
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterFilterCondition>
      blockDescriptionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'blockDescription',
      ));
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterFilterCondition>
      blockDescriptionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'blockDescription',
      ));
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterFilterCondition>
      blockDescriptionEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'blockDescription',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterFilterCondition>
      blockDescriptionGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'blockDescription',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterFilterCondition>
      blockDescriptionLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'blockDescription',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterFilterCondition>
      blockDescriptionBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'blockDescription',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterFilterCondition>
      blockDescriptionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'blockDescription',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterFilterCondition>
      blockDescriptionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'blockDescription',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterFilterCondition>
      blockDescriptionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'blockDescription',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterFilterCondition>
      blockDescriptionMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'blockDescription',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterFilterCondition>
      blockDescriptionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'blockDescription',
        value: '',
      ));
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterFilterCondition>
      blockDescriptionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'blockDescription',
        value: '',
      ));
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterFilterCondition>
      chapterEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'chapter',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterFilterCondition>
      chapterGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'chapter',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterFilterCondition>
      chapterLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'chapter',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterFilterCondition>
      chapterBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'chapter',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterFilterCondition>
      chapterStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'chapter',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterFilterCondition>
      chapterEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'chapter',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterFilterCondition>
      chapterContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'chapter',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterFilterCondition>
      chapterMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'chapter',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterFilterCondition>
      chapterIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'chapter',
        value: '',
      ));
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterFilterCondition>
      chapterIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'chapter',
        value: '',
      ));
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterFilterCondition>
      chapterCodeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'chapterCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterFilterCondition>
      chapterCodeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'chapterCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterFilterCondition>
      chapterCodeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'chapterCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterFilterCondition>
      chapterCodeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'chapterCode',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterFilterCondition>
      chapterCodeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'chapterCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterFilterCondition>
      chapterCodeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'chapterCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterFilterCondition>
      chapterCodeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'chapterCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterFilterCondition>
      chapterCodeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'chapterCode',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterFilterCondition>
      chapterCodeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'chapterCode',
        value: '',
      ));
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterFilterCondition>
      chapterCodeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'chapterCode',
        value: '',
      ));
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterFilterCondition>
      codeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'code',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterFilterCondition>
      codeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'code',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterFilterCondition>
      codeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'code',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterFilterCondition>
      codeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'code',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterFilterCondition>
      codeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'code',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterFilterCondition>
      codeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'code',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterFilterCondition>
      codeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'code',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterFilterCondition>
      codeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'code',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterFilterCondition>
      codeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'code',
        value: '',
      ));
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterFilterCondition>
      codeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'code',
        value: '',
      ));
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterFilterCondition>
      descriptionEnEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'descriptionEn',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterFilterCondition>
      descriptionEnGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'descriptionEn',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterFilterCondition>
      descriptionEnLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'descriptionEn',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterFilterCondition>
      descriptionEnBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'descriptionEn',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterFilterCondition>
      descriptionEnStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'descriptionEn',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterFilterCondition>
      descriptionEnEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'descriptionEn',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterFilterCondition>
      descriptionEnContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'descriptionEn',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterFilterCondition>
      descriptionEnMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'descriptionEn',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterFilterCondition>
      descriptionEnIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'descriptionEn',
        value: '',
      ));
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterFilterCondition>
      descriptionEnIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'descriptionEn',
        value: '',
      ));
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterFilterCondition>
      descriptionTrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'descriptionTr',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterFilterCondition>
      descriptionTrGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'descriptionTr',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterFilterCondition>
      descriptionTrLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'descriptionTr',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterFilterCondition>
      descriptionTrBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'descriptionTr',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterFilterCondition>
      descriptionTrStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'descriptionTr',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterFilterCondition>
      descriptionTrEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'descriptionTr',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterFilterCondition>
      descriptionTrContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'descriptionTr',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterFilterCondition>
      descriptionTrMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'descriptionTr',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterFilterCondition>
      descriptionTrIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'descriptionTr',
        value: '',
      ));
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterFilterCondition>
      descriptionTrIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'descriptionTr',
        value: '',
      ));
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterFilterCondition>
      idGreaterThan(
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

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterFilterCondition>
      idLessThan(
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

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterFilterCondition>
      isActiveEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isActive',
        value: value,
      ));
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterFilterCondition>
      urlIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'url',
      ));
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterFilterCondition>
      urlIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'url',
      ));
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterFilterCondition>
      urlEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'url',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterFilterCondition>
      urlGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'url',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterFilterCondition>
      urlLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'url',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterFilterCondition>
      urlBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'url',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterFilterCondition>
      urlStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'url',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterFilterCondition>
      urlEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'url',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterFilterCondition>
      urlContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'url',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterFilterCondition>
      urlMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'url',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterFilterCondition>
      urlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'url',
        value: '',
      ));
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterFilterCondition>
      urlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'url',
        value: '',
      ));
    });
  }
}

extension Icd10CodeModelQueryObject
    on QueryBuilder<Icd10CodeModel, Icd10CodeModel, QFilterCondition> {}

extension Icd10CodeModelQueryLinks
    on QueryBuilder<Icd10CodeModel, Icd10CodeModel, QFilterCondition> {}

extension Icd10CodeModelQuerySortBy
    on QueryBuilder<Icd10CodeModel, Icd10CodeModel, QSortBy> {
  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterSortBy> sortByBlockCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'blockCode', Sort.asc);
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterSortBy>
      sortByBlockCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'blockCode', Sort.desc);
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterSortBy>
      sortByBlockDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'blockDescription', Sort.asc);
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterSortBy>
      sortByBlockDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'blockDescription', Sort.desc);
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterSortBy> sortByChapter() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chapter', Sort.asc);
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterSortBy>
      sortByChapterDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chapter', Sort.desc);
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterSortBy>
      sortByChapterCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chapterCode', Sort.asc);
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterSortBy>
      sortByChapterCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chapterCode', Sort.desc);
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterSortBy> sortByCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'code', Sort.asc);
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterSortBy> sortByCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'code', Sort.desc);
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterSortBy>
      sortByDescriptionEn() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'descriptionEn', Sort.asc);
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterSortBy>
      sortByDescriptionEnDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'descriptionEn', Sort.desc);
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterSortBy>
      sortByDescriptionTr() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'descriptionTr', Sort.asc);
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterSortBy>
      sortByDescriptionTrDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'descriptionTr', Sort.desc);
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterSortBy> sortByIsActive() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isActive', Sort.asc);
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterSortBy>
      sortByIsActiveDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isActive', Sort.desc);
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterSortBy> sortByUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'url', Sort.asc);
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterSortBy> sortByUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'url', Sort.desc);
    });
  }
}

extension Icd10CodeModelQuerySortThenBy
    on QueryBuilder<Icd10CodeModel, Icd10CodeModel, QSortThenBy> {
  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterSortBy> thenByBlockCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'blockCode', Sort.asc);
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterSortBy>
      thenByBlockCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'blockCode', Sort.desc);
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterSortBy>
      thenByBlockDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'blockDescription', Sort.asc);
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterSortBy>
      thenByBlockDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'blockDescription', Sort.desc);
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterSortBy> thenByChapter() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chapter', Sort.asc);
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterSortBy>
      thenByChapterDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chapter', Sort.desc);
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterSortBy>
      thenByChapterCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chapterCode', Sort.asc);
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterSortBy>
      thenByChapterCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chapterCode', Sort.desc);
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterSortBy> thenByCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'code', Sort.asc);
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterSortBy> thenByCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'code', Sort.desc);
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterSortBy>
      thenByDescriptionEn() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'descriptionEn', Sort.asc);
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterSortBy>
      thenByDescriptionEnDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'descriptionEn', Sort.desc);
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterSortBy>
      thenByDescriptionTr() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'descriptionTr', Sort.asc);
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterSortBy>
      thenByDescriptionTrDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'descriptionTr', Sort.desc);
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterSortBy> thenByIsActive() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isActive', Sort.asc);
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterSortBy>
      thenByIsActiveDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isActive', Sort.desc);
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterSortBy> thenByUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'url', Sort.asc);
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QAfterSortBy> thenByUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'url', Sort.desc);
    });
  }
}

extension Icd10CodeModelQueryWhereDistinct
    on QueryBuilder<Icd10CodeModel, Icd10CodeModel, QDistinct> {
  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QDistinct> distinctByBlockCode(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'blockCode', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QDistinct>
      distinctByBlockDescription({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'blockDescription',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QDistinct> distinctByChapter(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'chapter', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QDistinct> distinctByChapterCode(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'chapterCode', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QDistinct> distinctByCode(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'code', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QDistinct>
      distinctByDescriptionEn({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'descriptionEn',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QDistinct>
      distinctByDescriptionTr({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'descriptionTr',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QDistinct> distinctByIsActive() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isActive');
    });
  }

  QueryBuilder<Icd10CodeModel, Icd10CodeModel, QDistinct> distinctByUrl(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'url', caseSensitive: caseSensitive);
    });
  }
}

extension Icd10CodeModelQueryProperty
    on QueryBuilder<Icd10CodeModel, Icd10CodeModel, QQueryProperty> {
  QueryBuilder<Icd10CodeModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Icd10CodeModel, String?, QQueryOperations> blockCodeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'blockCode');
    });
  }

  QueryBuilder<Icd10CodeModel, String?, QQueryOperations>
      blockDescriptionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'blockDescription');
    });
  }

  QueryBuilder<Icd10CodeModel, String, QQueryOperations> chapterProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'chapter');
    });
  }

  QueryBuilder<Icd10CodeModel, String, QQueryOperations> chapterCodeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'chapterCode');
    });
  }

  QueryBuilder<Icd10CodeModel, String, QQueryOperations> codeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'code');
    });
  }

  QueryBuilder<Icd10CodeModel, String, QQueryOperations>
      descriptionEnProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'descriptionEn');
    });
  }

  QueryBuilder<Icd10CodeModel, String, QQueryOperations>
      descriptionTrProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'descriptionTr');
    });
  }

  QueryBuilder<Icd10CodeModel, bool, QQueryOperations> isActiveProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isActive');
    });
  }

  QueryBuilder<Icd10CodeModel, String?, QQueryOperations> urlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'url');
    });
  }
}
