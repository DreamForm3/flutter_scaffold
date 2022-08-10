// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sys_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_SysUser _$$_SysUserFromJson(Map<String, dynamic> json) => _$_SysUser(
      id: json['id'] as int?,
      username: json['username'] as String?,
      nickname: json['nickname'] as String?,
      version: json['version'] as int?,
      isDelete: json['isDelete'] as bool?,
      password: json['password'] as String?,
      createTime: json['createTime'] == null
          ? null
          : DateTime.parse(json['createTime'] as String),
      salt: json['salt'] as String?,
      phone: json['phone'] as String?,
      updateTime: json['updateTime'] == null
          ? null
          : DateTime.parse(json['updateTime'] as String),
      email: json['email'] as String?,
      gender: json['gender'] as int?,
      avatar: json['avatar'] as String?,
      remark: json['remark'] as String?,
      state: json['state'] as int?,
      departmentId: json['departmentId'] as int?,
      roleId: json['roleId'] as int?,
    );

Map<String, dynamic> _$$_SysUserToJson(_$_SysUser instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'nickname': instance.nickname,
      'version': instance.version,
      'isDelete': instance.isDelete,
      'password': instance.password,
      'createTime': instance.createTime?.toIso8601String(),
      'salt': instance.salt,
      'phone': instance.phone,
      'updateTime': instance.updateTime?.toIso8601String(),
      'email': instance.email,
      'gender': instance.gender,
      'avatar': instance.avatar,
      'remark': instance.remark,
      'state': instance.state,
      'departmentId': instance.departmentId,
      'roleId': instance.roleId,
    };
