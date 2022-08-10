// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_msg_page_param.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserMsgPageParam _$$_UserMsgPageParamFromJson(Map<String, dynamic> json) =>
    _$_UserMsgPageParam(
      pageIndex: json['pageIndex'] as int?,
      pageSize: json['pageSize'] as int?,
      keyword: json['keyword'] as String?,
      sendUser: json['sendUser'] as int?,
      receiveUser: json['receiveUser'] as int?,
      title: json['title'] as String?,
      content: json['content'] as String?,
      statusList: (json['statusList'] as List<dynamic>?)
          ?.map((e) => $enumDecode(_$UserMsgStatusEnumMap, e))
          .toList(),
      replyId: json['replyId'] as int?,
      sentTimeStart: json['sentTimeStart'] == null
          ? null
          : DateTime.parse(json['sentTimeStart'] as String),
      sentTimeEnd: json['sentTimeEnd'] == null
          ? null
          : DateTime.parse(json['sentTimeEnd'] as String),
      receiveTimeStart: json['receiveTimeStart'] == null
          ? null
          : DateTime.parse(json['receiveTimeStart'] as String),
      receiveTimeEnd: json['receiveTimeEnd'] == null
          ? null
          : DateTime.parse(json['receiveTimeEnd'] as String),
      replyTimeStart: json['replyTimeStart'] == null
          ? null
          : DateTime.parse(json['replyTimeStart'] as String),
      replyTimeEnd: json['replyTimeEnd'] == null
          ? null
          : DateTime.parse(json['replyTimeEnd'] as String),
    );

Map<String, dynamic> _$$_UserMsgPageParamToJson(_$_UserMsgPageParam instance) =>
    <String, dynamic>{
      'pageIndex': instance.pageIndex,
      'pageSize': instance.pageSize,
      'keyword': instance.keyword,
      'sendUser': instance.sendUser,
      'receiveUser': instance.receiveUser,
      'title': instance.title,
      'content': instance.content,
      'statusList':
          instance.statusList?.map((e) => _$UserMsgStatusEnumMap[e]).toList(),
      'replyId': instance.replyId,
      'sentTimeStart': instance.sentTimeStart?.toIso8601String(),
      'sentTimeEnd': instance.sentTimeEnd?.toIso8601String(),
      'receiveTimeStart': instance.receiveTimeStart?.toIso8601String(),
      'receiveTimeEnd': instance.receiveTimeEnd?.toIso8601String(),
      'replyTimeStart': instance.replyTimeStart?.toIso8601String(),
      'replyTimeEnd': instance.replyTimeEnd?.toIso8601String(),
    };

const _$UserMsgStatusEnumMap = {
  UserMsgStatus.UNREAD: 'UNREAD',
  UserMsgStatus.READ: 'READ',
  UserMsgStatus.REPLIED: 'REPLIED',
};
