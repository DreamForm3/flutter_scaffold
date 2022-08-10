// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sys_user_register_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_SysUserRegisterVo _$$_SysUserRegisterVoFromJson(Map<String, dynamic> json) =>
    _$_SysUserRegisterVo(
      verificationCodeParam: json['verificationCodeParam'] == null
          ? null
          : VerificationCodeParam.fromJson(
              json['verificationCodeParam'] as Map<String, dynamic>),
      sysUser: json['sysUser'] == null
          ? null
          : SysUser.fromJson(json['sysUser'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_SysUserRegisterVoToJson(
        _$_SysUserRegisterVo instance) =>
    <String, dynamic>{
      'verificationCodeParam': instance.verificationCodeParam,
      'sysUser': instance.sysUser,
    };
