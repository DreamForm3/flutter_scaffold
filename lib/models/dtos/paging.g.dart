// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paging.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Paging<T> _$PagingFromJson<T>(Map<String, dynamic> json) => Paging<T>(
      total: json['total'] as int?,
      records: (json['records'] as List<dynamic>?)
          ?.map(CustomJsonConverter<T>().fromJson)
          .toList(),
      pageIndex: json['pageIndex'] as int? ?? 1,
      pageSize: json['pageSize'] as int? ?? 10,
    );

Map<String, dynamic> _$PagingToJson<T>(Paging<T> instance) => <String, dynamic>{
      'total': instance.total,
      'records':
          instance.records?.map(CustomJsonConverter<T>().toJson).toList(),
      'pageIndex': instance.pageIndex,
      'pageSize': instance.pageSize,
    };
