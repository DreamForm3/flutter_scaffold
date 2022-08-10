import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

import 'base_page_param.dart';

part 'user_page_param.g.dart';

@JsonSerializable()
class UserPageParam extends BasePageParam {
  UserPageParam({
    int? pageIndex,
    int? pageSize,
    String? keyword,
    this.username,
    this.nickname,
  }) : super(
      pageIndex: pageIndex,
      pageSize: pageSize,
      keyword: keyword,
  );


  String? username;
  String? nickname;

  UserPageParam copyWith({
    int pageIndex = 1,
    int pageSize = 10,
    String? keyword,
    String? username,
    String? nickname,
  }) =>
      UserPageParam(
        pageIndex: pageIndex,
        pageSize: pageSize,
        keyword: keyword ?? this.keyword,
        username: username ?? this.username,
        nickname: nickname ?? this.nickname,
      );

  factory UserPageParam.fromRawJson(String str) => UserPageParam.fromJson(json.decode(str));

  static UserPageParam parseJson(Map<String, dynamic> json) => UserPageParam.fromJson(json);

  String toRawJson() => json.encode(toJson());

  factory UserPageParam.fromJson(Map<String, dynamic> json) => _$UserPageParamFromJson(json);

  Map<String, dynamic> toJson() => _$UserPageParamToJson(this);
}
