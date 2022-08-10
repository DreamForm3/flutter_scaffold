// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'verification_code_param.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

VerificationCodeParam _$VerificationCodeParamFromJson(
    Map<String, dynamic> json) {
  return _VerificationCodeParam.fromJson(json);
}

/// @nodoc
class _$VerificationCodeParamTearOff {
  const _$VerificationCodeParamTearOff();

  _VerificationCodeParam call(
      {String? verifyToken, String? code, String? receiveClient}) {
    return _VerificationCodeParam(
      verifyToken: verifyToken,
      code: code,
      receiveClient: receiveClient,
    );
  }

  VerificationCodeParam fromJson(Map<String, Object?> json) {
    return VerificationCodeParam.fromJson(json);
  }
}

/// @nodoc
const $VerificationCodeParam = _$VerificationCodeParamTearOff();

/// @nodoc
mixin _$VerificationCodeParam {
  String? get verifyToken => throw _privateConstructorUsedError;
  String? get code => throw _privateConstructorUsedError;
  String? get receiveClient => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $VerificationCodeParamCopyWith<VerificationCodeParam> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VerificationCodeParamCopyWith<$Res> {
  factory $VerificationCodeParamCopyWith(VerificationCodeParam value,
          $Res Function(VerificationCodeParam) then) =
      _$VerificationCodeParamCopyWithImpl<$Res>;
  $Res call({String? verifyToken, String? code, String? receiveClient});
}

/// @nodoc
class _$VerificationCodeParamCopyWithImpl<$Res>
    implements $VerificationCodeParamCopyWith<$Res> {
  _$VerificationCodeParamCopyWithImpl(this._value, this._then);

  final VerificationCodeParam _value;
  // ignore: unused_field
  final $Res Function(VerificationCodeParam) _then;

  @override
  $Res call({
    Object? verifyToken = freezed,
    Object? code = freezed,
    Object? receiveClient = freezed,
  }) {
    return _then(_value.copyWith(
      verifyToken: verifyToken == freezed
          ? _value.verifyToken
          : verifyToken // ignore: cast_nullable_to_non_nullable
              as String?,
      code: code == freezed
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      receiveClient: receiveClient == freezed
          ? _value.receiveClient
          : receiveClient // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$VerificationCodeParamCopyWith<$Res>
    implements $VerificationCodeParamCopyWith<$Res> {
  factory _$VerificationCodeParamCopyWith(_VerificationCodeParam value,
          $Res Function(_VerificationCodeParam) then) =
      __$VerificationCodeParamCopyWithImpl<$Res>;
  @override
  $Res call({String? verifyToken, String? code, String? receiveClient});
}

/// @nodoc
class __$VerificationCodeParamCopyWithImpl<$Res>
    extends _$VerificationCodeParamCopyWithImpl<$Res>
    implements _$VerificationCodeParamCopyWith<$Res> {
  __$VerificationCodeParamCopyWithImpl(_VerificationCodeParam _value,
      $Res Function(_VerificationCodeParam) _then)
      : super(_value, (v) => _then(v as _VerificationCodeParam));

  @override
  _VerificationCodeParam get _value => super._value as _VerificationCodeParam;

  @override
  $Res call({
    Object? verifyToken = freezed,
    Object? code = freezed,
    Object? receiveClient = freezed,
  }) {
    return _then(_VerificationCodeParam(
      verifyToken: verifyToken == freezed
          ? _value.verifyToken
          : verifyToken // ignore: cast_nullable_to_non_nullable
              as String?,
      code: code == freezed
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      receiveClient: receiveClient == freezed
          ? _value.receiveClient
          : receiveClient // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_VerificationCodeParam implements _VerificationCodeParam {
  const _$_VerificationCodeParam(
      {this.verifyToken, this.code, this.receiveClient});

  factory _$_VerificationCodeParam.fromJson(Map<String, dynamic> json) =>
      _$$_VerificationCodeParamFromJson(json);

  @override
  final String? verifyToken;
  @override
  final String? code;
  @override
  final String? receiveClient;

  @override
  String toString() {
    return 'VerificationCodeParam(verifyToken: $verifyToken, code: $code, receiveClient: $receiveClient)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _VerificationCodeParam &&
            const DeepCollectionEquality()
                .equals(other.verifyToken, verifyToken) &&
            const DeepCollectionEquality().equals(other.code, code) &&
            const DeepCollectionEquality()
                .equals(other.receiveClient, receiveClient));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(verifyToken),
      const DeepCollectionEquality().hash(code),
      const DeepCollectionEquality().hash(receiveClient));

  @JsonKey(ignore: true)
  @override
  _$VerificationCodeParamCopyWith<_VerificationCodeParam> get copyWith =>
      __$VerificationCodeParamCopyWithImpl<_VerificationCodeParam>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_VerificationCodeParamToJson(this);
  }
}

abstract class _VerificationCodeParam implements VerificationCodeParam {
  const factory _VerificationCodeParam(
      {String? verifyToken,
      String? code,
      String? receiveClient}) = _$_VerificationCodeParam;

  factory _VerificationCodeParam.fromJson(Map<String, dynamic> json) =
      _$_VerificationCodeParam.fromJson;

  @override
  String? get verifyToken;
  @override
  String? get code;
  @override
  String? get receiveClient;
  @override
  @JsonKey(ignore: true)
  _$VerificationCodeParamCopyWith<_VerificationCodeParam> get copyWith =>
      throw _privateConstructorUsedError;
}
