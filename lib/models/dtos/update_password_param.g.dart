// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_password_param.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UpdatePasswordParam _$$_UpdatePasswordParamFromJson(
        Map<String, dynamic> json) =>
    _$_UpdatePasswordParam(
      userId: json['userId'] as int?,
      oldPassword: json['oldPassword'] as String?,
      newPassword: json['newPassword'] as String?,
      confirmPassword: json['confirmPassword'] as String?,
    );

Map<String, dynamic> _$$_UpdatePasswordParamToJson(
        _$_UpdatePasswordParam instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'oldPassword': instance.oldPassword,
      'newPassword': instance.newPassword,
      'confirmPassword': instance.confirmPassword,
    };
