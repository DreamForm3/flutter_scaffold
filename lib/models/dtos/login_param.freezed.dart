// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'login_param.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

LoginParam _$LoginParamFromJson(Map<String, dynamic> json) {
  return _LoginParam.fromJson(json);
}

/// @nodoc
class _$LoginParamTearOff {
  const _$LoginParamTearOff();

  _LoginParam call(
      {String? username, String? password, String? verifyToken, String? code}) {
    return _LoginParam(
      username: username,
      password: password,
      verifyToken: verifyToken,
      code: code,
    );
  }

  LoginParam fromJson(Map<String, Object?> json) {
    return LoginParam.fromJson(json);
  }
}

/// @nodoc
const $LoginParam = _$LoginParamTearOff();

/// @nodoc
mixin _$LoginParam {
  String? get username => throw _privateConstructorUsedError;
  String? get password => throw _privateConstructorUsedError;
  String? get verifyToken => throw _privateConstructorUsedError;
  String? get code => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LoginParamCopyWith<LoginParam> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginParamCopyWith<$Res> {
  factory $LoginParamCopyWith(
          LoginParam value, $Res Function(LoginParam) then) =
      _$LoginParamCopyWithImpl<$Res>;
  $Res call(
      {String? username, String? password, String? verifyToken, String? code});
}

/// @nodoc
class _$LoginParamCopyWithImpl<$Res> implements $LoginParamCopyWith<$Res> {
  _$LoginParamCopyWithImpl(this._value, this._then);

  final LoginParam _value;
  // ignore: unused_field
  final $Res Function(LoginParam) _then;

  @override
  $Res call({
    Object? username = freezed,
    Object? password = freezed,
    Object? verifyToken = freezed,
    Object? code = freezed,
  }) {
    return _then(_value.copyWith(
      username: username == freezed
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String?,
      password: password == freezed
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String?,
      verifyToken: verifyToken == freezed
          ? _value.verifyToken
          : verifyToken // ignore: cast_nullable_to_non_nullable
              as String?,
      code: code == freezed
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$LoginParamCopyWith<$Res> implements $LoginParamCopyWith<$Res> {
  factory _$LoginParamCopyWith(
          _LoginParam value, $Res Function(_LoginParam) then) =
      __$LoginParamCopyWithImpl<$Res>;
  @override
  $Res call(
      {String? username, String? password, String? verifyToken, String? code});
}

/// @nodoc
class __$LoginParamCopyWithImpl<$Res> extends _$LoginParamCopyWithImpl<$Res>
    implements _$LoginParamCopyWith<$Res> {
  __$LoginParamCopyWithImpl(
      _LoginParam _value, $Res Function(_LoginParam) _then)
      : super(_value, (v) => _then(v as _LoginParam));

  @override
  _LoginParam get _value => super._value as _LoginParam;

  @override
  $Res call({
    Object? username = freezed,
    Object? password = freezed,
    Object? verifyToken = freezed,
    Object? code = freezed,
  }) {
    return _then(_LoginParam(
      username: username == freezed
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String?,
      password: password == freezed
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String?,
      verifyToken: verifyToken == freezed
          ? _value.verifyToken
          : verifyToken // ignore: cast_nullable_to_non_nullable
              as String?,
      code: code == freezed
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_LoginParam implements _LoginParam {
  const _$_LoginParam(
      {this.username, this.password, this.verifyToken, this.code});

  factory _$_LoginParam.fromJson(Map<String, dynamic> json) =>
      _$$_LoginParamFromJson(json);

  @override
  final String? username;
  @override
  final String? password;
  @override
  final String? verifyToken;
  @override
  final String? code;

  @override
  String toString() {
    return 'LoginParam(username: $username, password: $password, verifyToken: $verifyToken, code: $code)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _LoginParam &&
            const DeepCollectionEquality().equals(other.username, username) &&
            const DeepCollectionEquality().equals(other.password, password) &&
            const DeepCollectionEquality()
                .equals(other.verifyToken, verifyToken) &&
            const DeepCollectionEquality().equals(other.code, code));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(username),
      const DeepCollectionEquality().hash(password),
      const DeepCollectionEquality().hash(verifyToken),
      const DeepCollectionEquality().hash(code));

  @JsonKey(ignore: true)
  @override
  _$LoginParamCopyWith<_LoginParam> get copyWith =>
      __$LoginParamCopyWithImpl<_LoginParam>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_LoginParamToJson(this);
  }
}

abstract class _LoginParam implements LoginParam {
  const factory _LoginParam(
      {String? username,
      String? password,
      String? verifyToken,
      String? code}) = _$_LoginParam;

  factory _LoginParam.fromJson(Map<String, dynamic> json) =
      _$_LoginParam.fromJson;

  @override
  String? get username;
  @override
  String? get password;
  @override
  String? get verifyToken;
  @override
  String? get code;
  @override
  @JsonKey(ignore: true)
  _$LoginParamCopyWith<_LoginParam> get copyWith =>
      throw _privateConstructorUsedError;
}
