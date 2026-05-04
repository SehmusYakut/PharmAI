// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'icd10_code.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Icd10Code _$Icd10CodeFromJson(Map<String, dynamic> json) {
  return _Icd10Code.fromJson(json);
}

/// @nodoc
mixin _$Icd10Code {
  /// Full ICD-10 code, e.g. "A00.0", "E11.9".
  String get code => throw _privateConstructorUsedError;

  /// Turkish description – primary display language for TR locale.
  /// Seeded from [descriptionEn] until a Turkish dataset is available.
  String get descriptionTr => throw _privateConstructorUsedError;

  /// English description from the WHO ICD-10 CSV (column: definition).
  String get descriptionEn => throw _privateConstructorUsedError;

  /// Chapter title, e.g. "Certain infectious and parasitic diseases".
  /// Parsed from CSV column `chapter` (second line of the multi-line field).
  String get chapter => throw _privateConstructorUsedError;

  /// Chapter code range, e.g. "A00-B99".
  /// Parsed from CSV column `chapter` (third line, parentheses stripped).
  String get chapterCode => throw _privateConstructorUsedError;

  /// Block/domain title, e.g. "Intestinal infectious diseases".
  /// Parsed from CSV column `domain` (first line).
  String? get blockDescription => throw _privateConstructorUsedError;

  /// Block code range, e.g. "A00-A09".
  /// Parsed from CSV column `domain` (second line, parentheses stripped).
  String? get blockCode => throw _privateConstructorUsedError;

  /// Direct URL to the WHO ICD-10 browser entry.
  /// Useful for "open in browser" deep-links inside the app.
  String? get url => throw _privateConstructorUsedError;

  /// Whether this code is active in the current ICD-10 revision.
  bool get isActive => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $Icd10CodeCopyWith<Icd10Code> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $Icd10CodeCopyWith<$Res> {
  factory $Icd10CodeCopyWith(Icd10Code value, $Res Function(Icd10Code) then) =
      _$Icd10CodeCopyWithImpl<$Res, Icd10Code>;
  @useResult
  $Res call(
      {String code,
      String descriptionTr,
      String descriptionEn,
      String chapter,
      String chapterCode,
      String? blockDescription,
      String? blockCode,
      String? url,
      bool isActive});
}

/// @nodoc
class _$Icd10CodeCopyWithImpl<$Res, $Val extends Icd10Code>
    implements $Icd10CodeCopyWith<$Res> {
  _$Icd10CodeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? descriptionTr = null,
    Object? descriptionEn = null,
    Object? chapter = null,
    Object? chapterCode = null,
    Object? blockDescription = freezed,
    Object? blockCode = freezed,
    Object? url = freezed,
    Object? isActive = null,
  }) {
    return _then(_value.copyWith(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      descriptionTr: null == descriptionTr
          ? _value.descriptionTr
          : descriptionTr // ignore: cast_nullable_to_non_nullable
              as String,
      descriptionEn: null == descriptionEn
          ? _value.descriptionEn
          : descriptionEn // ignore: cast_nullable_to_non_nullable
              as String,
      chapter: null == chapter
          ? _value.chapter
          : chapter // ignore: cast_nullable_to_non_nullable
              as String,
      chapterCode: null == chapterCode
          ? _value.chapterCode
          : chapterCode // ignore: cast_nullable_to_non_nullable
              as String,
      blockDescription: freezed == blockDescription
          ? _value.blockDescription
          : blockDescription // ignore: cast_nullable_to_non_nullable
              as String?,
      blockCode: freezed == blockCode
          ? _value.blockCode
          : blockCode // ignore: cast_nullable_to_non_nullable
              as String?,
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$Icd10CodeImplCopyWith<$Res>
    implements $Icd10CodeCopyWith<$Res> {
  factory _$$Icd10CodeImplCopyWith(
          _$Icd10CodeImpl value, $Res Function(_$Icd10CodeImpl) then) =
      __$$Icd10CodeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String code,
      String descriptionTr,
      String descriptionEn,
      String chapter,
      String chapterCode,
      String? blockDescription,
      String? blockCode,
      String? url,
      bool isActive});
}

/// @nodoc
class __$$Icd10CodeImplCopyWithImpl<$Res>
    extends _$Icd10CodeCopyWithImpl<$Res, _$Icd10CodeImpl>
    implements _$$Icd10CodeImplCopyWith<$Res> {
  __$$Icd10CodeImplCopyWithImpl(
      _$Icd10CodeImpl _value, $Res Function(_$Icd10CodeImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? descriptionTr = null,
    Object? descriptionEn = null,
    Object? chapter = null,
    Object? chapterCode = null,
    Object? blockDescription = freezed,
    Object? blockCode = freezed,
    Object? url = freezed,
    Object? isActive = null,
  }) {
    return _then(_$Icd10CodeImpl(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      descriptionTr: null == descriptionTr
          ? _value.descriptionTr
          : descriptionTr // ignore: cast_nullable_to_non_nullable
              as String,
      descriptionEn: null == descriptionEn
          ? _value.descriptionEn
          : descriptionEn // ignore: cast_nullable_to_non_nullable
              as String,
      chapter: null == chapter
          ? _value.chapter
          : chapter // ignore: cast_nullable_to_non_nullable
              as String,
      chapterCode: null == chapterCode
          ? _value.chapterCode
          : chapterCode // ignore: cast_nullable_to_non_nullable
              as String,
      blockDescription: freezed == blockDescription
          ? _value.blockDescription
          : blockDescription // ignore: cast_nullable_to_non_nullable
              as String?,
      blockCode: freezed == blockCode
          ? _value.blockCode
          : blockCode // ignore: cast_nullable_to_non_nullable
              as String?,
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$Icd10CodeImpl implements _Icd10Code {
  const _$Icd10CodeImpl(
      {required this.code,
      required this.descriptionTr,
      required this.descriptionEn,
      required this.chapter,
      required this.chapterCode,
      this.blockDescription,
      this.blockCode,
      this.url,
      this.isActive = true});

  factory _$Icd10CodeImpl.fromJson(Map<String, dynamic> json) =>
      _$$Icd10CodeImplFromJson(json);

  /// Full ICD-10 code, e.g. "A00.0", "E11.9".
  @override
  final String code;

  /// Turkish description – primary display language for TR locale.
  /// Seeded from [descriptionEn] until a Turkish dataset is available.
  @override
  final String descriptionTr;

  /// English description from the WHO ICD-10 CSV (column: definition).
  @override
  final String descriptionEn;

  /// Chapter title, e.g. "Certain infectious and parasitic diseases".
  /// Parsed from CSV column `chapter` (second line of the multi-line field).
  @override
  final String chapter;

  /// Chapter code range, e.g. "A00-B99".
  /// Parsed from CSV column `chapter` (third line, parentheses stripped).
  @override
  final String chapterCode;

  /// Block/domain title, e.g. "Intestinal infectious diseases".
  /// Parsed from CSV column `domain` (first line).
  @override
  final String? blockDescription;

  /// Block code range, e.g. "A00-A09".
  /// Parsed from CSV column `domain` (second line, parentheses stripped).
  @override
  final String? blockCode;

  /// Direct URL to the WHO ICD-10 browser entry.
  /// Useful for "open in browser" deep-links inside the app.
  @override
  final String? url;

  /// Whether this code is active in the current ICD-10 revision.
  @override
  @JsonKey()
  final bool isActive;

  @override
  String toString() {
    return 'Icd10Code(code: $code, descriptionTr: $descriptionTr, descriptionEn: $descriptionEn, chapter: $chapter, chapterCode: $chapterCode, blockDescription: $blockDescription, blockCode: $blockCode, url: $url, isActive: $isActive)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Icd10CodeImpl &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.descriptionTr, descriptionTr) ||
                other.descriptionTr == descriptionTr) &&
            (identical(other.descriptionEn, descriptionEn) ||
                other.descriptionEn == descriptionEn) &&
            (identical(other.chapter, chapter) || other.chapter == chapter) &&
            (identical(other.chapterCode, chapterCode) ||
                other.chapterCode == chapterCode) &&
            (identical(other.blockDescription, blockDescription) ||
                other.blockDescription == blockDescription) &&
            (identical(other.blockCode, blockCode) ||
                other.blockCode == blockCode) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      code,
      descriptionTr,
      descriptionEn,
      chapter,
      chapterCode,
      blockDescription,
      blockCode,
      url,
      isActive);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$Icd10CodeImplCopyWith<_$Icd10CodeImpl> get copyWith =>
      __$$Icd10CodeImplCopyWithImpl<_$Icd10CodeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$Icd10CodeImplToJson(
      this,
    );
  }
}

abstract class _Icd10Code implements Icd10Code {
  const factory _Icd10Code(
      {required final String code,
      required final String descriptionTr,
      required final String descriptionEn,
      required final String chapter,
      required final String chapterCode,
      final String? blockDescription,
      final String? blockCode,
      final String? url,
      final bool isActive}) = _$Icd10CodeImpl;

  factory _Icd10Code.fromJson(Map<String, dynamic> json) =
      _$Icd10CodeImpl.fromJson;

  @override

  /// Full ICD-10 code, e.g. "A00.0", "E11.9".
  String get code;
  @override

  /// Turkish description – primary display language for TR locale.
  /// Seeded from [descriptionEn] until a Turkish dataset is available.
  String get descriptionTr;
  @override

  /// English description from the WHO ICD-10 CSV (column: definition).
  String get descriptionEn;
  @override

  /// Chapter title, e.g. "Certain infectious and parasitic diseases".
  /// Parsed from CSV column `chapter` (second line of the multi-line field).
  String get chapter;
  @override

  /// Chapter code range, e.g. "A00-B99".
  /// Parsed from CSV column `chapter` (third line, parentheses stripped).
  String get chapterCode;
  @override

  /// Block/domain title, e.g. "Intestinal infectious diseases".
  /// Parsed from CSV column `domain` (first line).
  String? get blockDescription;
  @override

  /// Block code range, e.g. "A00-A09".
  /// Parsed from CSV column `domain` (second line, parentheses stripped).
  String? get blockCode;
  @override

  /// Direct URL to the WHO ICD-10 browser entry.
  /// Useful for "open in browser" deep-links inside the app.
  String? get url;
  @override

  /// Whether this code is active in the current ICD-10 revision.
  bool get isActive;
  @override
  @JsonKey(ignore: true)
  _$$Icd10CodeImplCopyWith<_$Icd10CodeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
