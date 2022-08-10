// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sys_user_query_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_SysUserQueryVo _$$_SysUserQueryVoFromJson(Map<String, dynamic> json) =>
    _$_SysUserQueryVo(
      id: json['id'] as int?,
      username: json['username'] as String?,
      nickname: json['nickname'] as String?,
      phone: json['phone'] as String?,
      email: json['email'] as String?,
      gender: json['gender'] as int?,
      avatar: json['avatar'] as String?,
      remark: json['remark'] as String?,
      state: json['state'] as int?,
      departmentId: json['departmentId'] as int?,
      roleId: json['roleId'] as int?,
      deleted: json['deleted'] as int?,
      version: json['version'] as int?,
      createTime: json['createTime'] as String?,
      updateTime: json['updateTime'] as String?,
      departmentName: json['departmentName'] as String?,
      roleName: json['roleName'] as String?,
    );

Map<String, dynamic> _$$_SysUserQueryVoToJson(_$_SysUserQueryVo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'nickname': instance.nickname,
      'phone': instance.phone,
      'email': instance.email,
      'gender': instance.gender,
      'avatar': instance.avatar,
      'remark': instance.remark,
      'state': instance.state,
      'departmentId': instance.departmentId,
      'roleId': instance.roleId,
      'deleted': instance.deleted,
      'version': instance.version,
      'createTime': instance.createTime,
      'updateTime': instance.updateTime,
      'departmentName': instance.departmentName,
      'roleName': instance.roleName,
    };
