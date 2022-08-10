// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiResult<T> _$ApiResultFromJson<T>(Map<String, dynamic> json) => ApiResult<T>(
      code: json['code'] as int?,
      success: json['success'] as bool?,
      message: json['message'] as String?,
      data: CustomJsonConverter<T?>().fromJson(json['data']),
      time:
          json['time'] == null ? null : DateTime.parse(json['time'] as String),
    );

Map<String, dynamic> _$ApiResultToJson<T>(ApiResult<T> instance) =>
    <String, dynamic>{
      'code': instance.code,
      'success': instance.success,
      'message': instance.message,
      'data': CustomJsonConverter<T?>().toJson(instance.data),
      'time': instance.time?.toIso8601String(),
    };
