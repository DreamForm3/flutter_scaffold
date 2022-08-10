
import 'package:flutter_scaffold/models/custom_json_converter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';


part 'api_result.g.dart';

/// 服务端返回数据封装
@JsonSerializable()
class ApiResult<T> {

  int? code;
  bool? success;
  String? message;
  @CustomJsonConverter() T? data;
  DateTime? time;

  ApiResult({
    this.code,
    this.success,
    this.message,
    this.data,
    this.time,
  });

  factory ApiResult.fromJson(Map<String, dynamic> json) =>
      _$ApiResultFromJson(json);

  Map<String, dynamic> toJson() => _$ApiResultToJson(this);
}
