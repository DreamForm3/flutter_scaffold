// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'login_sysuser_token_vo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

LoginSysUserTokenVo _$LoginSysUserTokenVoFromJson(Map<String, dynamic> json) {
  return _LoginSysUserTokenVo.fromJson(json);
}

/// @nodoc
class _$LoginSysUserTokenVoTearOff {
  const _$LoginSysUserTokenVoTearOff();

  _LoginSysUserTokenVo call({String? token, LoginSysUserVo? loginSysUserVo}) {
    return _LoginSysUserTokenVo(
      token: token,
      loginSysUserVo: loginSysUserVo,
    );
  }

  LoginSysUserTokenVo fromJson(Map<String, Object?> json) {
    return LoginSysUserTokenVo.fromJson(json);
  }
}

/// @nodoc
const $LoginSysUserTokenVo = _$LoginSysUserTokenVoTearOff();

/// @nodoc
mixin _$LoginSysUserTokenVo {
  String? get token => throw _privateConstructorUsedError;
  LoginSysUserVo? get loginSysUserVo => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LoginSysUserTokenVoCopyWith<LoginSysUserTokenVo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginSysUserTokenVoCopyWith<$Res> {
  factory $LoginSysUserTokenVoCopyWith(
          LoginSysUserTokenVo value, $Res Function(LoginSysUserTokenVo) then) =
      _$LoginSysUserTokenVoCopyWithImpl<$Res>;
  $Res call({String? token, LoginSysUserVo? loginSysUserVo});

  $LoginSysUserVoCopyWith<$Res>? get loginSysUserVo;
}

/// @nodoc
class _$LoginSysUserTokenVoCopyWithImpl<$Res>
    implements $LoginSysUserTokenVoCopyWith<$Res> {
  _$LoginSysUserTokenVoCopyWithImpl(this._value, this._then);

  final LoginSysUserTokenVo _value;
  // ignore: unused_field
  final $Res Function(LoginSysUserTokenVo) _then;

  @override
  $Res call({
    Object? token = freezed,
    Object? loginSysUserVo = freezed,
  }) {
    return _then(_value.copyWith(
      token: token == freezed
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String?,
      loginSysUserVo: loginSysUserVo == freezed
          ? _value.loginSysUserVo
          : loginSysUserVo // ignore: cast_nullable_to_non_nullable
              as LoginSysUserVo?,
    ));
  }

  @override
  $LoginSysUserVoCopyWith<$Res>? get loginSysUserVo {
    if (_value.loginSysUserVo == null) {
      return null;
    }

    return $LoginSysUserVoCopyWith<$Res>(_value.loginSysUserVo!, (value) {
      return _then(_value.copyWith(loginSysUserVo: value));
    });
  }
}

/// @nodoc
abstract class _$LoginSysUserTokenVoCopyWith<$Res>
    implements $LoginSysUserTokenVoCopyWith<$Res> {
  factory _$LoginSysUserTokenVoCopyWith(_LoginSysUserTokenVo value,
          $Res Function(_LoginSysUserTokenVo) then) =
      __$LoginSysUserTokenVoCopyWithImpl<$Res>;
  @override
  $Res call({String? token, LoginSysUserVo? loginSysUserVo});

  @override
  $LoginSysUserVoCopyWith<$Res>? get loginSysUserVo;
}

/// @nodoc
class __$LoginSysUserTokenVoCopyWithImpl<$Res>
    extends _$LoginSysUserTokenVoCopyWithImpl<$Res>
    implements _$LoginSysUserTokenVoCopyWith<$Res> {
  __$LoginSysUserTokenVoCopyWithImpl(
      _LoginSysUserTokenVo _value, $Res Function(_LoginSysUserTokenVo) _then)
      : super(_value, (v) => _then(v as _LoginSysUserTokenVo));

  @override
  _LoginSysUserTokenVo get _value => super._value as _LoginSysUserTokenVo;

  @override
  $Res call({
    Object? token = freezed,
    Object? loginSysUserVo = freezed,
  }) {
    return _then(_LoginSysUserTokenVo(
      token: token == freezed
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String?,
      loginSysUserVo: loginSysUserVo == freezed
          ? _value.loginSysUserVo
          : loginSysUserVo // ignore: cast_nullable_to_non_nullable
              as LoginSysUserVo?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_LoginSysUserTokenVo implements _LoginSysUserTokenVo {
  const _$_LoginSysUserTokenVo({this.token, this.loginSysUserVo});

  factory _$_LoginSysUserTokenVo.fromJson(Map<String, dynamic> json) =>
      _$$_LoginSysUserTokenVoFromJson(json);

  @override
  final String? token;
  @override
  final LoginSysUserVo? loginSysUserVo;

  @override
  String toString() {
    return 'LoginSysUserTokenVo(token: $token, loginSysUserVo: $loginSysUserVo)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _LoginSysUserTokenVo &&
            const DeepCollectionEquality().equals(other.token, token) &&
            const DeepCollectionEquality()
                .equals(other.loginSysUserVo, loginSysUserVo));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(token),
      const DeepCollectionEquality().hash(loginSysUserVo));

  @JsonKey(ignore: true)
  @override
  _$LoginSysUserTokenVoCopyWith<_LoginSysUserTokenVo> get copyWith =>
      __$LoginSysUserTokenVoCopyWithImpl<_LoginSysUserTokenVo>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_LoginSysUserTokenVoToJson(this);
  }
}

abstract class _LoginSysUserTokenVo implements LoginSysUserTokenVo {
  const factory _LoginSysUserTokenVo(
      {String? token, LoginSysUserVo? loginSysUserVo}) = _$_LoginSysUserTokenVo;

  factory _LoginSysUserTokenVo.fromJson(Map<String, dynamic> json) =
      _$_LoginSysUserTokenVo.fromJson;

  @override
  String? get token;
  @override
  LoginSysUserVo? get loginSysUserVo;
  @override
  @JsonKey(ignore: true)
  _$LoginSysUserTokenVoCopyWith<_LoginSysUserTokenVo> get copyWith =>
      throw _privateConstructorUsedError;
}
