import 'package:json_annotation/json_annotation.dart';
import 'package:flutter_scaffold/models/custom_json_converter.dart';


part 'paging.g.dart';

/// 服务端返回的分页数据封装
@JsonSerializable()
class Paging<T> {

  int? total;
  @CustomJsonConverter() List<T>? records;
  int? pageIndex;
  int? pageSize;

  Paging({
    this.total,
    this.records,
    this.pageIndex = 1,
    this.pageSize = 10,
  });

  factory Paging.fromJson(Map<String, dynamic> json) => _$PagingFromJson(json);

  Map<String, dynamic> toJson() => _$PagingToJson(this);
}
