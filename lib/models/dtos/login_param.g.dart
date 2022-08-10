// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_param.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_LoginParam _$$_LoginParamFromJson(Map<String, dynamic> json) =>
    _$_LoginParam(
      username: json['username'] as String?,
      password: json['password'] as String?,
      verifyToken: json['verifyToken'] as String?,
      code: json['code'] as String?,
    );

Map<String, dynamic> _$$_LoginParamToJson(_$_LoginParam instance) =>
    <String, dynamic>{
      'username': instance.username,
      'password': instance.password,
      'verifyToken': instance.verifyToken,
      'code': instance.code,
    };
