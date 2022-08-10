// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'update_password_param.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

UpdatePasswordParam _$UpdatePasswordParamFromJson(Map<String, dynamic> json) {
  return _UpdatePasswordParam.fromJson(json);
}

/// @nodoc
class _$UpdatePasswordParamTearOff {
  const _$UpdatePasswordParamTearOff();

  _UpdatePasswordParam call(
      {int? userId,
      String? oldPassword,
      String? newPassword,
      String? confirmPassword}) {
    return _UpdatePasswordParam(
      userId: userId,
      oldPassword: oldPassword,
      newPassword: newPassword,
      confirmPassword: confirmPassword,
    );
  }

  UpdatePasswordParam fromJson(Map<String, Object?> json) {
    return UpdatePasswordParam.fromJson(json);
  }
}

/// @nodoc
const $UpdatePasswordParam = _$UpdatePasswordParamTearOff();

/// @nodoc
mixin _$UpdatePasswordParam {
  int? get userId => throw _privateConstructorUsedError;
  String? get oldPassword => throw _privateConstructorUsedError;
  String? get newPassword => throw _privateConstructorUsedError;
  String? get confirmPassword => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UpdatePasswordParamCopyWith<UpdatePasswordParam> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UpdatePasswordParamCopyWith<$Res> {
  factory $UpdatePasswordParamCopyWith(
          UpdatePasswordParam value, $Res Function(UpdatePasswordParam) then) =
      _$UpdatePasswordParamCopyWithImpl<$Res>;
  $Res call(
      {int? userId,
      String? oldPassword,
      String? newPassword,
      String? confirmPassword});
}

/// @nodoc
class _$UpdatePasswordParamCopyWithImpl<$Res>
    implements $UpdatePasswordParamCopyWith<$Res> {
  _$UpdatePasswordParamCopyWithImpl(this._value, this._then);

  final UpdatePasswordParam _value;
  // ignore: unused_field
  final $Res Function(UpdatePasswordParam) _then;

  @override
  $Res call({
    Object? userId = freezed,
    Object? oldPassword = freezed,
    Object? newPassword = freezed,
    Object? confirmPassword = freezed,
  }) {
    return _then(_value.copyWith(
      userId: userId == freezed
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int?,
      oldPassword: oldPassword == freezed
          ? _value.oldPassword
          : oldPassword // ignore: cast_nullable_to_non_nullable
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
abstract class _$UpdatePasswordParamCopyWith<$Res>
    implements $UpdatePasswordParamCopyWith<$Res> {
  factory _$UpdatePasswordParamCopyWith(_UpdatePasswordParam value,
          $Res Function(_UpdatePasswordParam) then) =
      __$UpdatePasswordParamCopyWithImpl<$Res>;
  @override
  $Res call(
      {int? userId,
      String? oldPassword,
      String? newPassword,
      String? confirmPassword});
}

/// @nodoc
class __$UpdatePasswordParamCopyWithImpl<$Res>
    extends _$UpdatePasswordParamCopyWithImpl<$Res>
    implements _$UpdatePasswordParamCopyWith<$Res> {
  __$UpdatePasswordParamCopyWithImpl(
      _UpdatePasswordParam _value, $Res Function(_UpdatePasswordParam) _then)
      : super(_value, (v) => _then(v as _UpdatePasswordParam));

  @override
  _UpdatePasswordParam get _value => super._value as _UpdatePasswordParam;

  @override
  $Res call({
    Object? userId = freezed,
    Object? oldPassword = freezed,
    Object? newPassword = freezed,
    Object? confirmPassword = freezed,
  }) {
    return _then(_UpdatePasswordParam(
      userId: userId == freezed
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int?,
      oldPassword: oldPassword == freezed
          ? _value.oldPassword
          : oldPassword // ignore: cast_nullable_to_non_nullable
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
class _$_UpdatePasswordParam implements _UpdatePasswordParam {
  const _$_UpdatePasswordParam(
      {this.userId, this.oldPassword, this.newPassword, this.confirmPassword});

  factory _$_UpdatePasswordParam.fromJson(Map<String, dynamic> json) =>
      _$$_UpdatePasswordParamFromJson(json);

  @override
  final int? userId;
  @override
  final String? oldPassword;
  @override
  final String? newPassword;
  @override
  final String? confirmPassword;

  @override
  String toString() {
    return 'UpdatePasswordParam(userId: $userId, oldPassword: $oldPassword, newPassword: $newPassword, confirmPassword: $confirmPassword)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UpdatePasswordParam &&
            const DeepCollectionEquality().equals(other.userId, userId) &&
            const DeepCollectionEquality()
                .equals(other.oldPassword, oldPassword) &&
            const DeepCollectionEquality()
                .equals(other.newPassword, newPassword) &&
            const DeepCollectionEquality()
                .equals(other.confirmPassword, confirmPassword));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(userId),
      const DeepCollectionEquality().hash(oldPassword),
      const DeepCollectionEquality().hash(newPassword),
      const DeepCollectionEquality().hash(confirmPassword));

  @JsonKey(ignore: true)
  @override
  _$UpdatePasswordParamCopyWith<_UpdatePasswordParam> get copyWith =>
      __$UpdatePasswordParamCopyWithImpl<_UpdatePasswordParam>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UpdatePasswordParamToJson(this);
  }
}

abstract class _UpdatePasswordParam implements UpdatePasswordParam {
  const factory _UpdatePasswordParam(
      {int? userId,
      String? oldPassword,
      String? newPassword,
      String? confirmPassword}) = _$_UpdatePasswordParam;

  factory _UpdatePasswordParam.fromJson(Map<String, dynamic> json) =
      _$_UpdatePasswordParam.fromJson;

  @override
  int? get userId;
  @override
  String? get oldPassword;
  @override
  String? get newPassword;
  @override
  String? get confirmPassword;
  @override
  @JsonKey(ignore: true)
  _$UpdatePasswordParamCopyWith<_UpdatePasswordParam> get copyWith =>
      throw _privateConstructorUsedError;
}
