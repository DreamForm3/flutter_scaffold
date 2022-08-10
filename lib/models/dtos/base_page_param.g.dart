// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_page_param.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BasePageParam _$BasePageParamFromJson(Map<String, dynamic> json) =>
    BasePageParam(
      pageIndex: json['pageIndex'] as int? ?? 1,
      pageSize: json['pageSize'] as int? ?? 10,
      keyword: json['keyword'] as String?,
    );

Map<String, dynamic> _$BasePageParamToJson(BasePageParam instance) =>
    <String, dynamic>{
      'pageIndex': instance.pageIndex,
      'pageSize': instance.pageSize,
      'keyword': instance.keyword,
    };
