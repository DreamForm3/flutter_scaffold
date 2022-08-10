// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_page_param.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserPageParam _$UserPageParamFromJson(Map<String, dynamic> json) =>
    UserPageParam(
      pageIndex: json['pageIndex'] as int?,
      pageSize: json['pageSize'] as int?,
      keyword: json['keyword'] as String?,
      username: json['username'] as String?,
      nickname: json['nickname'] as String?,
    );

Map<String, dynamic> _$UserPageParamToJson(UserPageParam instance) =>
    <String, dynamic>{
      'pageIndex': instance.pageIndex,
      'pageSize': instance.pageSize,
      'keyword': instance.keyword,
      'username': instance.username,
      'nickname': instance.nickname,
    };
