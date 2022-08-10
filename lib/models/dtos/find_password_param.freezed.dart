// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'find_password_param.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

FindPasswordParam _$FindPasswordParamFromJson(Map<String, dynamic> json) {
  return _FindPasswordParam.fromJson(json);
}

/// @nodoc
class _$FindPasswordParamTearOff {
  const _$FindPasswordParamTearOff();

  _FindPasswordParam call(
      {String? username,
      String? verifyToken,
      String? code,
      String? newPassword,
      String? confirmPassword}) {
    return _FindPasswordParam(
      username: username,
      verifyToken: verifyToken,
      code: code,
      newPassword: newPassword,
      confirmPassword: confirmPassword,
    );
  }

  FindPasswordParam fromJson(Map<String, Object?> json) {
    return FindPasswordParam.fromJson(json);
  }
}

/// @nodoc
const $FindPasswordParam = _$FindPasswordParamTearOff();

/// @nodoc
mixin _$FindPasswordParam {
  String? get username => throw _privateConstructorUsedError;
  String? get verifyToken => throw _privateConstructorUsedError;
  String? get code => throw _privateConstructorUsedError;
  String? get newPassword => throw _privateConstructorUsedError;
  String? get confirmPassword => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FindPasswordParamCopyWith<FindPasswordParam> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FindPasswordParamCopyWith<$Res> {
  factory $FindPasswordParamCopyWith(
          FindPasswordParam value, $Res Function(FindPasswordParam) then) =
      _$FindPasswordParamCopyWithImpl<$Res>;
  $Res call(
      {String? username,
      String? verifyToken,
      String? code,
      String? newPassword,
      String? confirmPassword});
}

/// @nodoc
class _$FindPasswordParamCopyWithImpl<$Res>
    implements $FindPasswordParamCopyWith<$Res> {
  _$FindPasswordParamCopyWithImpl(this._value, this._then);

  final FindPasswordParam _value;
  // ignore: unused_field
  final $Res Function(FindPasswordParam) _then;

  @override
  $Res call({
    Object? username = freezed,
    Object? verifyToken = freezed,
    Object? code = freezed,
    Object? newPassword = freezed,
    Object? confirmPassword = freezed,
  }) {
    return _then(_value.copyWith(
      username: username == freezed
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String?,
      verifyToken: verifyToken == freezed
          ? _value.verifyToken
          : verifyToken // ignore: cast_nullable_to_non_nullable
              as String?,
      code: code == freezed
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      newPassword: newPassword == freezed
          ? _value.newPassword
          : newPassword // ignore: cast_nullable_to_non_nullable
              as String?,
      confirmPassword: confirmPassword == freezed
          ? _value.confirmPassword
          : confirmPassword // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$FindPasswordParamCopyWith<$Res>
    implements $FindPasswordParamCopyWith<$Res> {
  factory _$FindPasswordParamCopyWith(
          _FindPasswordParam value, $Res Function(_FindPasswordParam) then) =
      __$FindPasswordParamCopyWithImpl<$Res>;
  @override
  $Res call(
      {String? username,
      String? verifyToken,
      String? code,
      String? newPassword,
      String? confirmPassword});
}

/// @nodoc
class __$FindPasswordParamCopyWithImpl<$Res>
    extends _$FindPasswordParamCopyWithImpl<$Res>
    implements _$FindPasswordParamCopyWith<$Res> {
  __$FindPasswordParamCopyWithImpl(
      _FindPasswordParam _value, $Res Function(_FindPasswordParam) _then)
      : super(_value, (v) => _then(v as _FindPasswordParam));

  @override
  _FindPasswordParam get _value => super._value as _FindPasswordParam;

  @override
  $Res call({
    Object? username = freezed,
    Object? verifyToken = freezed,
    Object? code = freezed,
    Object? newPassword = freezed,
    Object? confirmPassword = freezed,
  }) {
    return _then(_FindPasswordParam(
      username: username == freezed
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String?,
      verifyToken: verifyToken == freezed
          ? _value.verifyToken
          : verifyToken // ignore: cast_nullable_to_non_nullable
              as String?,
      code: code == freezed
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      newPassword: newPassword == freezed
          ? _value.newPassword
          : newPassword // ignore: cast_nullable_to_non_nullable
              as String?,
      confirmPassword: confirmPassword == freezed
          ? _value.confirmPassword
          : confirmPassword // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_FindPasswordParam implements _FindPasswordParam {
  const _$_FindPasswordParam(
      {this.username,
      this.verifyToken,
      this.code,
      this.newPassword,
      this.confirmPassword});

  factory _$_FindPasswordParam.fromJson(Map<String, dynamic> json) =>
      _$$_FindPasswordParamFromJson(json);

  @override
  final String? username;
  @override
  final String? verifyToken;
  @override
  final String? code;
  @override
  final String? newPassword;
  @override
  final String? confirmPassword;

  @override
  String toString() {
    return 'FindPasswordParam(username: $username, verifyToken: $verifyToken, code: $code, newPassword: $newPassword, confirmPassword: $confirmPassword)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _FindPasswordParam &&
            const DeepCollectionEquality().equals(other.username, username) &&
            const DeepCollectionEquality()
                .equals(other.verifyToken, verifyToken) &&
            const DeepCollectionEquality().equals(other.code, code) &&
            const DeepCollectionEquality()
                .equals(other.newPassword, newPassword) &&
            const DeepCollectionEquality()
                .equals(other.confirmPassword, confirmPassword));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(username),
      const DeepCollectionEquality().hash(verifyToken),
      const DeepCollectionEquality().hash(code),
      const DeepCollectionEquality().hash(newPassword),
      const DeepCollectionEquality().hash(confirmPassword));

  @JsonKey(ignore: true)
  @override
  _$FindPasswordParamCopyWith<_FindPasswordParam> get copyWith =>
      __$FindPasswordParamCopyWithImpl<_FindPasswordParam>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_FindPasswordParamToJson(this);
  }
}

abstract class _FindPasswordParam implements FindPasswordParam {
  const factory _FindPasswordParam(
      {String? username,
      String? verifyToken,
      String? code,
      String? newPassword,
      String? confirmPassword}) = _$_FindPasswordParam;

  factory _FindPasswordParam.fromJson(Map<String, dynamic> json) =
      _$_FindPasswordParam.fromJson;

  @override
  String? get username;
  @override
  String? get verifyToken;
  @override
  String? get code;
  @override
  String? get newPassword;
  @override
  String? get confirmPassword;
  @override
  @JsonKey(ignore: true)
  _$FindPasswordParamCopyWith<_FindPasswordParam> get copyWith =>
      throw _privateConstructorUsedError;
}
