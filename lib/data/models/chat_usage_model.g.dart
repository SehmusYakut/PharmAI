// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_usage_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetChatUsageModelCollection on Isar {
  IsarCollection<ChatUsageModel> get chatUsageModels => this.collection();
}

const ChatUsageModelSchema = CollectionSchema(
  name: r'ChatUsageModel',
  id: -6203505022483063543,
  properties: {
    r'firebaseUid': PropertySchema(
      id: 0,
      name: r'firebaseUid',
      type: IsarType.string,
    ),
    r'isPremium': PropertySchema(
      id: 1,
      name: r'isPremium',
      type: IsarType.bool,
    ),
    r'queryCount': PropertySchema(
      id: 2,
      name: r'queryCount',
      type: IsarType.long,
    )
  },
  estimateSize: _chatUsageModelEstimateSize,
  serialize: _chatUsageModelSerialize,
  deserialize: _chatUsageModelDeserialize,
  deserializeProp: _chatUsageModelDeserializeProp,
  idName: r'id',
  indexes: {
    r'firebaseUid': IndexSchema(
      id: 7058360298604664992,
      name: r'firebaseUid',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'firebaseUid',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _chatUsageModelGetId,
  getLinks: _chatUsageModelGetLinks,
  attach: _chatUsageModelAttach,
  version: '3.1.0+1',
);

int _chatUsageModelEstimateSize(
  ChatUsageModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.firebaseUid.length * 3;
  return bytesCount;
}

void _chatUsageModelSerialize(
  ChatUsageModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.firebaseUid);
  writer.writeBool(offsets[1], object.isPremium);
  writer.writeLong(offsets[2], object.queryCount);
}

ChatUsageModel _chatUsageModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ChatUsageModel();
  object.firebaseUid = reader.readString(offsets[0]);
  object.id = id;
  object.isPremium = reader.readBool(offsets[1]);
  object.queryCount = reader.readLong(offsets[2]);
  return object;
}

P _chatUsageModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readBool(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _chatUsageModelGetId(ChatUsageModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _chatUsageModelGetLinks(ChatUsageModel object) {
  return [];
}

void _chatUsageModelAttach(
    IsarCollection<dynamic> col, Id id, ChatUsageModel object) {
  object.id = id;
}

extension ChatUsageModelByIndex on IsarCollection<ChatUsageModel> {
  Future<ChatUsageModel?> getByFirebaseUid(String firebaseUid) {
    return getByIndex(r'firebaseUid', [firebaseUid]);
  }

  ChatUsageModel? getByFirebaseUidSync(String firebaseUid) {
    return getByIndexSync(r'firebaseUid', [firebaseUid]);
  }

  Future<bool> deleteByFirebaseUid(String firebaseUid) {
    return deleteByIndex(r'firebaseUid', [firebaseUid]);
  }

  bool deleteByFirebaseUidSync(String firebaseUid) {
    return deleteByIndexSync(r'firebaseUid', [firebaseUid]);
  }

  Future<List<ChatUsageModel?>> getAllByFirebaseUid(
      List<String> firebaseUidValues) {
    final values = firebaseUidValues.map((e) => [e]).toList();
    return getAllByIndex(r'firebaseUid', values);
  }

  List<ChatUsageModel?> getAllByFirebaseUidSync(
      List<String> firebaseUidValues) {
    final values = firebaseUidValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'firebaseUid', values);
  }

  Future<int> deleteAllByFirebaseUid(List<String> firebaseUidValues) {
    final values = firebaseUidValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'firebaseUid', values);
  }

  int deleteAllByFirebaseUidSync(List<String> firebaseUidValues) {
    final values = firebaseUidValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'firebaseUid', values);
  }

  Future<Id> putByFirebaseUid(ChatUsageModel object) {
    return putByIndex(r'firebaseUid', object);
  }

  Id putByFirebaseUidSync(ChatUsageModel object, {bool saveLinks = true}) {
    return putByIndexSync(r'firebaseUid', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByFirebaseUid(List<ChatUsageModel> objects) {
    return putAllByIndex(r'firebaseUid', objects);
  }

  List<Id> putAllByFirebaseUidSync(List<ChatUsageModel> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'firebaseUid', objects, saveLinks: saveLinks);
  }
}

extension ChatUsageModelQueryWhereSort
    on QueryBuilder<ChatUsageModel, ChatUsageModel, QWhere> {
  QueryBuilder<ChatUsageModel, ChatUsageModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension ChatUsageModelQueryWhere
    on QueryBuilder<ChatUsageModel, ChatUsageModel, QWhereClause> {
  QueryBuilder<ChatUsageModel, ChatUsageModel, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<ChatUsageModel, ChatUsageModel, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<ChatUsageModel, ChatUsageModel, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<ChatUsageModel, ChatUsageModel, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<ChatUsageModel, ChatUsageModel, QAfterWhereClause> idBetween(
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

  QueryBuilder<ChatUsageModel, ChatUsageModel, QAfterWhereClause>
      firebaseUidEqualTo(String firebaseUid) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'firebaseUid',
        value: [firebaseUid],
      ));
    });
  }

  QueryBuilder<ChatUsageModel, ChatUsageModel, QAfterWhereClause>
      firebaseUidNotEqualTo(String firebaseUid) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'firebaseUid',
              lower: [],
              upper: [firebaseUid],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'firebaseUid',
              lower: [firebaseUid],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'firebaseUid',
              lower: [firebaseUid],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'firebaseUid',
              lower: [],
              upper: [firebaseUid],
              includeUpper: false,
            ));
      }
    });
  }
}

extension ChatUsageModelQueryFilter
    on QueryBuilder<ChatUsageModel, ChatUsageModel, QFilterCondition> {
  QueryBuilder<ChatUsageModel, ChatUsageModel, QAfterFilterCondition>
      firebaseUidEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'firebaseUid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatUsageModel, ChatUsageModel, QAfterFilterCondition>
      firebaseUidGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'firebaseUid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatUsageModel, ChatUsageModel, QAfterFilterCondition>
      firebaseUidLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'firebaseUid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatUsageModel, ChatUsageModel, QAfterFilterCondition>
      firebaseUidBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'firebaseUid',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatUsageModel, ChatUsageModel, QAfterFilterCondition>
      firebaseUidStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'firebaseUid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatUsageModel, ChatUsageModel, QAfterFilterCondition>
      firebaseUidEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'firebaseUid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatUsageModel, ChatUsageModel, QAfterFilterCondition>
      firebaseUidContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'firebaseUid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatUsageModel, ChatUsageModel, QAfterFilterCondition>
      firebaseUidMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'firebaseUid',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatUsageModel, ChatUsageModel, QAfterFilterCondition>
      firebaseUidIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'firebaseUid',
        value: '',
      ));
    });
  }

  QueryBuilder<ChatUsageModel, ChatUsageModel, QAfterFilterCondition>
      firebaseUidIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'firebaseUid',
        value: '',
      ));
    });
  }

  QueryBuilder<ChatUsageModel, ChatUsageModel, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ChatUsageModel, ChatUsageModel, QAfterFilterCondition>
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

  QueryBuilder<ChatUsageModel, ChatUsageModel, QAfterFilterCondition>
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

  QueryBuilder<ChatUsageModel, ChatUsageModel, QAfterFilterCondition> idBetween(
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

  QueryBuilder<ChatUsageModel, ChatUsageModel, QAfterFilterCondition>
      isPremiumEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isPremium',
        value: value,
      ));
    });
  }

  QueryBuilder<ChatUsageModel, ChatUsageModel, QAfterFilterCondition>
      queryCountEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'queryCount',
        value: value,
      ));
    });
  }

  QueryBuilder<ChatUsageModel, ChatUsageModel, QAfterFilterCondition>
      queryCountGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'queryCount',
        value: value,
      ));
    });
  }

  QueryBuilder<ChatUsageModel, ChatUsageModel, QAfterFilterCondition>
      queryCountLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'queryCount',
        value: value,
      ));
    });
  }

  QueryBuilder<ChatUsageModel, ChatUsageModel, QAfterFilterCondition>
      queryCountBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'queryCount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension ChatUsageModelQueryObject
    on QueryBuilder<ChatUsageModel, ChatUsageModel, QFilterCondition> {}

extension ChatUsageModelQueryLinks
    on QueryBuilder<ChatUsageModel, ChatUsageModel, QFilterCondition> {}

extension ChatUsageModelQuerySortBy
    on QueryBuilder<ChatUsageModel, ChatUsageModel, QSortBy> {
  QueryBuilder<ChatUsageModel, ChatUsageModel, QAfterSortBy>
      sortByFirebaseUid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'firebaseUid', Sort.asc);
    });
  }

  QueryBuilder<ChatUsageModel, ChatUsageModel, QAfterSortBy>
      sortByFirebaseUidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'firebaseUid', Sort.desc);
    });
  }

  QueryBuilder<ChatUsageModel, ChatUsageModel, QAfterSortBy> sortByIsPremium() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPremium', Sort.asc);
    });
  }

  QueryBuilder<ChatUsageModel, ChatUsageModel, QAfterSortBy>
      sortByIsPremiumDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPremium', Sort.desc);
    });
  }

  QueryBuilder<ChatUsageModel, ChatUsageModel, QAfterSortBy>
      sortByQueryCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'queryCount', Sort.asc);
    });
  }

  QueryBuilder<ChatUsageModel, ChatUsageModel, QAfterSortBy>
      sortByQueryCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'queryCount', Sort.desc);
    });
  }
}

extension ChatUsageModelQuerySortThenBy
    on QueryBuilder<ChatUsageModel, ChatUsageModel, QSortThenBy> {
  QueryBuilder<ChatUsageModel, ChatUsageModel, QAfterSortBy>
      thenByFirebaseUid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'firebaseUid', Sort.asc);
    });
  }

  QueryBuilder<ChatUsageModel, ChatUsageModel, QAfterSortBy>
      thenByFirebaseUidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'firebaseUid', Sort.desc);
    });
  }

  QueryBuilder<ChatUsageModel, ChatUsageModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<ChatUsageModel, ChatUsageModel, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<ChatUsageModel, ChatUsageModel, QAfterSortBy> thenByIsPremium() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPremium', Sort.asc);
    });
  }

  QueryBuilder<ChatUsageModel, ChatUsageModel, QAfterSortBy>
      thenByIsPremiumDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPremium', Sort.desc);
    });
  }

  QueryBuilder<ChatUsageModel, ChatUsageModel, QAfterSortBy>
      thenByQueryCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'queryCount', Sort.asc);
    });
  }

  QueryBuilder<ChatUsageModel, ChatUsageModel, QAfterSortBy>
      thenByQueryCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'queryCount', Sort.desc);
    });
  }
}

extension ChatUsageModelQueryWhereDistinct
    on QueryBuilder<ChatUsageModel, ChatUsageModel, QDistinct> {
  QueryBuilder<ChatUsageModel, ChatUsageModel, QDistinct> distinctByFirebaseUid(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'firebaseUid', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ChatUsageModel, ChatUsageModel, QDistinct>
      distinctByIsPremium() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isPremium');
    });
  }

  QueryBuilder<ChatUsageModel, ChatUsageModel, QDistinct>
      distinctByQueryCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'queryCount');
    });
  }
}

extension ChatUsageModelQueryProperty
    on QueryBuilder<ChatUsageModel, ChatUsageModel, QQueryProperty> {
  QueryBuilder<ChatUsageModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<ChatUsageModel, String, QQueryOperations> firebaseUidProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'firebaseUid');
    });
  }

  QueryBuilder<ChatUsageModel, bool, QQueryOperations> isPremiumProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isPremium');
    });
  }

  QueryBuilder<ChatUsageModel, int, QQueryOperations> queryCountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'queryCount');
    });
  }
}
