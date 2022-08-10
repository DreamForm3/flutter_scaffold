// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_sysuser_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_LoginSysUserVo _$$_LoginSysUserVoFromJson(Map<String, dynamic> json) =>
    _$_LoginSysUserVo(
      id: json['id'] as int?,
      username: json['username'] as String?,
      nickname: json['nickname'] as String?,
      gender: json['gender'] as int?,
      state: json['state'] as int?,
      departmentId: json['departmentId'] as int?,
      departmentName: json['departmentName'] as String?,
      roleId: json['roleId'] as int?,
      roleName: json['roleName'] as String?,
      roleCode: json['roleCode'] as String?,
      permissionCodes: (json['permissionCodes'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$_LoginSysUserVoToJson(_$_LoginSysUserVo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'nickname': instance.nickname,
      'gender': instance.gender,
      'state': instance.state,
      'departmentId': instance.departmentId,
      'departmentName': instance.departmentName,
      'roleId': instance.roleId,
      'roleName': instance.roleName,
      'roleCode': instance.roleCode,
      'permissionCodes': instance.permissionCodes,
    };
