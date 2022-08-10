// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'sys_user_register_vo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SysUserRegisterVo _$SysUserRegisterVoFromJson(Map<String, dynamic> json) {
  return _SysUserRegisterVo.fromJson(json);
}

/// @nodoc
class _$SysUserRegisterVoTearOff {
  const _$SysUserRegisterVoTearOff();

  _SysUserRegisterVo call(
      {VerificationCodeParam? verificationCodeParam, SysUser? sysUser}) {
    return _SysUserRegisterVo(
      verificationCodeParam: verificationCodeParam,
      sysUser: sysUser,
    );
  }

  SysUserRegisterVo fromJson(Map<String, Object?> json) {
    return SysUserRegisterVo.fromJson(json);
  }
}

/// @nodoc
const $SysUserRegisterVo = _$SysUserRegisterVoTearOff();

/// @nodoc
mixin _$SysUserRegisterVo {
  VerificationCodeParam? get verificationCodeParam =>
      throw _privateConstructorUsedError;
  SysUser? get sysUser => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SysUserRegisterVoCopyWith<SysUserRegisterVo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SysUserRegisterVoCopyWith<$Res> {
  factory $SysUserRegisterVoCopyWith(
          SysUserRegisterVo value, $Res Function(SysUserRegisterVo) then) =
      _$SysUserRegisterVoCopyWithImpl<$Res>;
  $Res call({VerificationCodeParam? verificationCodeParam, SysUser? sysUser});

  $VerificationCodeParamCopyWith<$Res>? get verificationCodeParam;
  $SysUserCopyWith<$Res>? get sysUser;
}

/// @nodoc
class _$SysUserRegisterVoCopyWithImpl<$Res>
    implements $SysUserRegisterVoCopyWith<$Res> {
  _$SysUserRegisterVoCopyWithImpl(this._value, this._then);

  final SysUserRegisterVo _value;
  // ignore: unused_field
  final $Res Function(SysUserRegisterVo) _then;

  @override
  $Res call({
    Object? verificationCodeParam = freezed,
    Object? sysUser = freezed,
  }) {
    return _then(_value.copyWith(
      verificationCodeParam: verificationCodeParam == freezed
          ? _value.verificationCodeParam
          : verificationCodeParam // ignore: cast_nullable_to_non_nullable
              as VerificationCodeParam?,
      sysUser: sysUser == freezed
          ? _value.sysUser
          : sysUser // ignore: cast_nullable_to_non_nullable
              as SysUser?,
    ));
  }

  @override
  $VerificationCodeParamCopyWith<$Res>? get verificationCodeParam {
    if (_value.verificationCodeParam == null) {
      return null;
    }

    return $VerificationCodeParamCopyWith<$Res>(_value.verificationCodeParam!,
        (value) {
      return _then(_value.copyWith(verificationCodeParam: value));
    });
  }

  @override
  $SysUserCopyWith<$Res>? get sysUser {
    if (_value.sysUser == null) {
      return null;
    }

    return $SysUserCopyWith<$Res>(_value.sysUser!, (value) {
      return _then(_value.copyWith(sysUser: value));
    });
  }
}

/// @nodoc
abstract class _$SysUserRegisterVoCopyWith<$Res>
    implements $SysUserRegisterVoCopyWith<$Res> {
  factory _$SysUserRegisterVoCopyWith(
          _SysUserRegisterVo value, $Res Function(_SysUserRegisterVo) then) =
      __$SysUserRegisterVoCopyWithImpl<$Res>;
  @override
  $Res call({VerificationCodeParam? verificationCodeParam, SysUser? sysUser});

  @override
  $VerificationCodeParamCopyWith<$Res>? get verificationCodeParam;
  @override
  $SysUserCopyWith<$Res>? get sysUser;
}

/// @nodoc
class __$SysUserRegisterVoCopyWithImpl<$Res>
    extends _$SysUserRegisterVoCopyWithImpl<$Res>
    implements _$SysUserRegisterVoCopyWith<$Res> {
  __$SysUserRegisterVoCopyWithImpl(
      _SysUserRegisterVo _value, $Res Function(_SysUserRegisterVo) _then)
      : super(_value, (v) => _then(v as _SysUserRegisterVo));

  @override
  _SysUserRegisterVo get _value => super._value as _SysUserRegisterVo;

  @override
  $Res call({
    Object? verificationCodeParam = freezed,
    Object? sysUser = freezed,
  }) {
    return _then(_SysUserRegisterVo(
      verificationCodeParam: verificationCodeParam == freezed
          ? _value.verificationCodeParam
          : verificationCodeParam // ignore: cast_nullable_to_non_nullable
              as VerificationCodeParam?,
      sysUser: sysUser == freezed
          ? _value.sysUser
          : sysUser // ignore: cast_nullable_to_non_nullable
              as SysUser?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_SysUserRegisterVo implements _SysUserRegisterVo {
  const _$_SysUserRegisterVo({this.verificationCodeParam, this.sysUser});

  factory _$_SysUserRegisterVo.fromJson(Map<String, dynamic> json) =>
      _$$_SysUserRegisterVoFromJson(json);

  @override
  final VerificationCodeParam? verificationCodeParam;
  @override
  final SysUser? sysUser;

  @override
  String toString() {
    return 'SysUserRegisterVo(verificationCodeParam: $verificationCodeParam, sysUser: $sysUser)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SysUserRegisterVo &&
            const DeepCollectionEquality()
                .equals(other.verificationCodeParam, verificationCodeParam) &&
            const DeepCollectionEquality().equals(other.sysUser, sysUser));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(verificationCodeParam),
      const DeepCollectionEquality().hash(sysUser));

  @JsonKey(ignore: true)
  @override
  _$SysUserRegisterVoCopyWith<_SysUserRegisterVo> get copyWith =>
      __$SysUserRegisterVoCopyWithImpl<_SysUserRegisterVo>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SysUserRegisterVoToJson(this);
  }
}

abstract class _SysUserRegisterVo implements SysUserRegisterVo {
  const factory _SysUserRegisterVo(
      {VerificationCodeParam? verificationCodeParam,
      SysUser? sysUser}) = _$_SysUserRegisterVo;

  factory _SysUserRegisterVo.fromJson(Map<String, dynamic> json) =
      _$_SysUserRegisterVo.fromJson;

  @override
  VerificationCodeParam? get verificationCodeParam;
  @override
  SysUser? get sysUser;
  @override
  @JsonKey(ignore: true)
  _$SysUserRegisterVoCopyWith<_SysUserRegisterVo> get copyWith =>
      throw _privateConstructorUsedError;
}
