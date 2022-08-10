// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'find_password_param.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_FindPasswordParam _$$_FindPasswordParamFromJson(Map<String, dynamic> json) =>
    _$_FindPasswordParam(
      username: json['username'] as String?,
      verifyToken: json['verifyToken'] as String?,
      code: json['code'] as String?,
      newPassword: json['newPassword'] as String?,
      confirmPassword: json['confirmPassword'] as String?,
    );

Map<String, dynamic> _$$_FindPasswordParamToJson(
        _$_FindPasswordParam instance) =>
    <String, dynamic>{
      'username': instance.username,
      'verifyToken': instance.verifyToken,
      'code': instance.code,
      'newPassword': instance.newPassword,
      'confirmPassword': instance.confirmPassword,
    };
