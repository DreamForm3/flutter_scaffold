// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'login_sysuser_vo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

LoginSysUserVo _$LoginSysUserVoFromJson(Map<String, dynamic> json) {
  return _LoginSysUserVo.fromJson(json);
}

/// @nodoc
class _$LoginSysUserVoTearOff {
  const _$LoginSysUserVoTearOff();

  _LoginSysUserVo call(
      {int? id,
      String? username,
      String? nickname,
      int? gender,
      int? state,
      int? departmentId,
      String? departmentName,
      int? roleId,
      String? roleName,
      String? roleCode,
      List<String>? permissionCodes}) {
    return _LoginSysUserVo(
      id: id,
      username: username,
      nickname: nickname,
      gender: gender,
      state: state,
      departmentId: departmentId,
      departmentName: departmentName,
      roleId: roleId,
      roleName: roleName,
      roleCode: roleCode,
      permissionCodes: permissionCodes,
    );
  }

  LoginSysUserVo fromJson(Map<String, Object?> json) {
    return LoginSysUserVo.fromJson(json);
  }
}

/// @nodoc
const $LoginSysUserVo = _$LoginSysUserVoTearOff();

/// @nodoc
mixin _$LoginSysUserVo {
  int? get id => throw _privateConstructorUsedError;

  /// 用户名
  String? get username => throw _privateConstructorUsedError;

  /// 昵称
  String? get nickname => throw _privateConstructorUsedError;

  /// 性别，0：女，1：男，默认1
  int? get gender => throw _privateConstructorUsedError;

  /// 状态，0：禁用，1：启用，2：锁定
  int? get state => throw _privateConstructorUsedError;

  /// 部门id
  int? get departmentId => throw _privateConstructorUsedError;

  /// 部门名称
  String? get departmentName => throw _privateConstructorUsedError;

  /// 角色id
  int? get roleId => throw _privateConstructorUsedError;

  /// 角色名称
  String? get roleName => throw _privateConstructorUsedError;

  /// 角色编码
  String? get roleCode => throw _privateConstructorUsedError;

  /// 权限编码列表
  List<String>? get permissionCodes => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LoginSysUserVoCopyWith<LoginSysUserVo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginSysUserVoCopyWith<$Res> {
  factory $LoginSysUserVoCopyWith(
          LoginSysUserVo value, $Res Function(LoginSysUserVo) then) =
      _$LoginSysUserVoCopyWithImpl<$Res>;
  $Res call(
      {int? id,
      String? username,
      String? nickname,
      int? gender,
      int? state,
      int? departmentId,
      String? departmentName,
      int? roleId,
      String? roleName,
      String? roleCode,
      List<String>? permissionCodes});
}

/// @nodoc
class _$LoginSysUserVoCopyWithImpl<$Res>
    implements $LoginSysUserVoCopyWith<$Res> {
  _$LoginSysUserVoCopyWithImpl(this._value, this._then);

  final LoginSysUserVo _value;
  // ignore: unused_field
  final $Res Function(LoginSysUserVo) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? username = freezed,
    Object? nickname = freezed,
    Object? gender = freezed,
    Object? state = freezed,
    Object? departmentId = freezed,
    Object? departmentName = freezed,
    Object? roleId = freezed,
    Object? roleName = freezed,
    Object? roleCode = freezed,
    Object? permissionCodes = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      username: username == freezed
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String?,
      nickname: nickname == freezed
          ? _value.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String?,
      gender: gender == freezed
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as int?,
      state: state == freezed
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as int?,
      departmentId: departmentId == freezed
          ? _value.departmentId
          : departmentId // ignore: cast_nullable_to_non_nullable
              as int?,
      departmentName: departmentName == freezed
          ? _value.departmentName
          : departmentName // ignore: cast_nullable_to_non_nullable
              as String?,
      roleId: roleId == freezed
          ? _value.roleId
          : roleId // ignore: cast_nullable_to_non_nullable
              as int?,
      roleName: roleName == freezed
          ? _value.roleName
          : roleName // ignore: cast_nullable_to_non_nullable
              as String?,
      roleCode: roleCode == freezed
          ? _value.roleCode
          : roleCode // ignore: cast_nullable_to_non_nullable
              as String?,
      permissionCodes: permissionCodes == freezed
          ? _value.permissionCodes
          : permissionCodes // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc
abstract class _$LoginSysUserVoCopyWith<$Res>
    implements $LoginSysUserVoCopyWith<$Res> {
  factory _$LoginSysUserVoCopyWith(
          _LoginSysUserVo value, $Res Function(_LoginSysUserVo) then) =
      __$LoginSysUserVoCopyWithImpl<$Res>;
  @override
  $Res call(
      {int? id,
      String? username,
      String? nickname,
      int? gender,
      int? state,
      int? departmentId,
      String? departmentName,
      int? roleId,
      String? roleName,
      String? roleCode,
      List<String>? permissionCodes});
}

/// @nodoc
class __$LoginSysUserVoCopyWithImpl<$Res>
    extends _$LoginSysUserVoCopyWithImpl<$Res>
    implements _$LoginSysUserVoCopyWith<$Res> {
  __$LoginSysUserVoCopyWithImpl(
      _LoginSysUserVo _value, $Res Function(_LoginSysUserVo) _then)
      : super(_value, (v) => _then(v as _LoginSysUserVo));

  @override
  _LoginSysUserVo get _value => super._value as _LoginSysUserVo;

  @override
  $Res call({
    Object? id = freezed,
    Object? username = freezed,
    Object? nickname = freezed,
    Object? gender = freezed,
    Object? state = freezed,
    Object? departmentId = freezed,
    Object? departmentName = freezed,
    Object? roleId = freezed,
    Object? roleName = freezed,
    Object? roleCode = freezed,
    Object? permissionCodes = freezed,
  }) {
    return _then(_LoginSysUserVo(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      username: username == freezed
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String?,
      nickname: nickname == freezed
          ? _value.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String?,
      gender: gender == freezed
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as int?,
      state: state == freezed
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as int?,
      departmentId: departmentId == freezed
          ? _value.departmentId
          : departmentId // ignore: cast_nullable_to_non_nullable
              as int?,
      departmentName: departmentName == freezed
          ? _value.departmentName
          : departmentName // ignore: cast_nullable_to_non_nullable
              as String?,
      roleId: roleId == freezed
          ? _value.roleId
          : roleId // ignore: cast_nullable_to_non_nullable
              as int?,
      roleName: roleName == freezed
          ? _value.roleName
          : roleName // ignore: cast_nullable_to_non_nullable
              as String?,
      roleCode: roleCode == freezed
          ? _value.roleCode
          : roleCode // ignore: cast_nullable_to_non_nullable
              as String?,
      permissionCodes: permissionCodes == freezed
          ? _value.permissionCodes
          : permissionCodes // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_LoginSysUserVo implements _LoginSysUserVo {
  const _$_LoginSysUserVo(
      {this.id,
      this.username,
      this.nickname,
      this.gender,
      this.state,
      this.departmentId,
      this.departmentName,
      this.roleId,
      this.roleName,
      this.roleCode,
      this.permissionCodes});

  factory _$_LoginSysUserVo.fromJson(Map<String, dynamic> json) =>
      _$$_LoginSysUserVoFromJson(json);

  @override
  final int? id;
  @override

  /// 用户名
  final String? username;
  @override

  /// 昵称
  final String? nickname;
  @override

  /// 性别，0：女，1：男，默认1
  final int? gender;
  @override

  /// 状态，0：禁用，1：启用，2：锁定
  final int? state;
  @override

  /// 部门id
  final int? departmentId;
  @override

  /// 部门名称
  final String? departmentName;
  @override

  /// 角色id
  final int? roleId;
  @override

  /// 角色名称
  final String? roleName;
  @override

  /// 角色编码
  final String? roleCode;
  @override

  /// 权限编码列表
  final List<String>? permissionCodes;

  @override
  String toString() {
    return 'LoginSysUserVo(id: $id, username: $username, nickname: $nickname, gender: $gender, state: $state, departmentId: $departmentId, departmentName: $departmentName, roleId: $roleId, roleName: $roleName, roleCode: $roleCode, permissionCodes: $permissionCodes)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _LoginSysUserVo &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.username, username) &&
            const DeepCollectionEquality().equals(other.nickname, nickname) &&
            const DeepCollectionEquality().equals(other.gender, gender) &&
            const DeepCollectionEquality().equals(other.state, state) &&
            const DeepCollectionEquality()
                .equals(other.departmentId, departmentId) &&
            const DeepCollectionEquality()
                .equals(other.departmentName, departmentName) &&
            const DeepCollectionEquality().equals(other.roleId, roleId) &&
            const DeepCollectionEquality().equals(other.roleName, roleName) &&
            const DeepCollectionEquality().equals(other.roleCode, roleCode) &&
            const DeepCollectionEquality()
                .equals(other.permissionCodes, permissionCodes));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(username),
      const DeepCollectionEquality().hash(nickname),
      const DeepCollectionEquality().hash(gender),
      const DeepCollectionEquality().hash(state),
      const DeepCollectionEquality().hash(departmentId),
      const DeepCollectionEquality().hash(departmentName),
      const DeepCollectionEquality().hash(roleId),
      const DeepCollectionEquality().hash(roleName),
      const DeepCollectionEquality().hash(roleCode),
      const DeepCollectionEquality().hash(permissionCodes));

  @JsonKey(ignore: true)
  @override
  _$LoginSysUserVoCopyWith<_LoginSysUserVo> get copyWith =>
      __$LoginSysUserVoCopyWithImpl<_LoginSysUserVo>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_LoginSysUserVoToJson(this);
  }
}

abstract class _LoginSysUserVo implements LoginSysUserVo {
  const factory _LoginSysUserVo(
      {int? id,
      String? username,
      String? nickname,
      int? gender,
      int? state,
      int? departmentId,
      String? departmentName,
      int? roleId,
      String? roleName,
      String? roleCode,
      List<String>? permissionCodes}) = _$_LoginSysUserVo;

  factory _LoginSysUserVo.fromJson(Map<String, dynamic> json) =
      _$_LoginSysUserVo.fromJson;

  @override
  int? get id;
  @override

  /// 用户名
  String? get username;
  @override

  /// 昵称
  String? get nickname;
  @override

  /// 性别，0：女，1：男，默认1
  int? get gender;
  @override

  /// 状态，0：禁用，1：启用，2：锁定
  int? get state;
  @override

  /// 部门id
  int? get departmentId;
  @override

  /// 部门名称
  String? get departmentName;
  @override

  /// 角色id
  int? get roleId;
  @override

  /// 角色名称
  String? get roleName;
  @override

  /// 角色编码
  String? get roleCode;
  @override

  /// 权限编码列表
  List<String>? get permissionCodes;
  @override
  @JsonKey(ignore: true)
  _$LoginSysUserVoCopyWith<_LoginSysUserVo> get copyWith =>
      throw _privateConstructorUsedError;
}
