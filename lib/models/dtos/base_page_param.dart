import 'package:json_annotation/json_annotation.dart';

import 'dart:convert';


part 'base_page_param.g.dart';

@JsonSerializable()
class BasePageParam {
  BasePageParam({
    this.pageIndex = 1,
    this.pageSize = 10,
    this.keyword,
  });

  int? pageIndex;
  int? pageSize;
  String? keyword;

  BasePageParam copyWith({
    int pageIndex = 1,
    int pageSize = 10,
    String? keyword,
  }) =>
      BasePageParam(
        pageIndex: pageIndex,
        pageSize: pageSize,
        keyword: keyword ?? this.keyword,
      );

  factory BasePageParam.fromRawJson(String str) => BasePageParam.fromJson(json.decode(str));

  static BasePageParam parseJson(Map<String, dynamic> json) => BasePageParam.fromJson(json);

  String toRawJson() => json.encode(toJson());

  factory BasePageParam.fromJson(Map<String, dynamic> json) => _$BasePageParamFromJson(json);

  Map<String, dynamic> toJson() => _$BasePageParamToJson(this);
}
