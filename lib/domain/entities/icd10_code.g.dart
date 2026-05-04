// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'icd10_code.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$Icd10CodeImpl _$$Icd10CodeImplFromJson(Map<String, dynamic> json) =>
    _$Icd10CodeImpl(
      code: json['code'] as String,
      descriptionTr: json['descriptionTr'] as String,
      descriptionEn: json['descriptionEn'] as String,
      chapter: json['chapter'] as String,
      chapterCode: json['chapterCode'] as String,
      blockDescription: json['blockDescription'] as String?,
      blockCode: json['blockCode'] as String?,
      isActive: json['isActive'] as bool? ?? true,
    );

Map<String, dynamic> _$$Icd10CodeImplToJson(_$Icd10CodeImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'descriptionTr': instance.descriptionTr,
      'descriptionEn': instance.descriptionEn,
      'chapter': instance.chapter,
      'chapterCode': instance.chapterCode,
      'blockDescription': instance.blockDescription,
      'blockCode': instance.blockCode,
      'isActive': instance.isActive,
    };
