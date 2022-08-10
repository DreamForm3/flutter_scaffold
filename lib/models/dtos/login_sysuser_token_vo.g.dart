// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_sysuser_token_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_LoginSysUserTokenVo _$$_LoginSysUserTokenVoFromJson(
        Map<String, dynamic> json) =>
    _$_LoginSysUserTokenVo(
      token: json['token'] as String?,
      loginSysUserVo: json['loginSysUserVo'] == null
          ? null
          : LoginSysUserVo.fromJson(
              json['loginSysUserVo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_LoginSysUserTokenVoToJson(
        _$_LoginSysUserTokenVo instance) =>
    <String, dynamic>{
      'token': instance.token,
      'loginSysUserVo': instance.loginSysUserVo,
    };
