// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verification_code_param.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_VerificationCodeParam _$$_VerificationCodeParamFromJson(
        Map<String, dynamic> json) =>
    _$_VerificationCodeParam(
      verifyToken: json['verifyToken'] as String?,
      code: json['code'] as String?,
      receiveClient: json['receiveClient'] as String?,
    );

Map<String, dynamic> _$$_VerificationCodeParamToJson(
        _$_VerificationCodeParam instance) =>
    <String, dynamic>{
      'verifyToken': instance.verifyToken,
      'code': instance.code,
      'receiveClient': instance.receiveClient,
    };
