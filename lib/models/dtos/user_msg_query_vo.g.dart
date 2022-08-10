// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_msg_query_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserMsgQueryVo _$$_UserMsgQueryVoFromJson(Map<String, dynamic> json) =>
    _$_UserMsgQueryVo(
      sendUser: json['sendUser'] as int?,
      receiveUser: json['receiveUser'] as int?,
      title: json['title'] as String?,
      content: json['content'] as String?,
      status: $enumDecodeNullable(_$UserMsgStatusEnumMap, json['status']),
      replyId: json['replyId'] as int?,
      sentTime: json['sentTime'] as String?,
      receiveTime: json['receiveTime'] as String?,
      replyTime: json['replyTime'] as String?,
      bak1: json['bak1'] as String?,
      bak2: json['bak2'] as String?,
      bak3: json['bak3'] as String?,
      bak4: json['bak4'] as String?,
      bak5: json['bak5'] as String?,
    );

Map<String, dynamic> _$$_UserMsgQueryVoToJson(_$_UserMsgQueryVo instance) =>
    <String, dynamic>{
      'sendUser': instance.sendUser,
      'receiveUser': instance.receiveUser,
      'title': instance.title,
      'content': instance.content,
      'status': _$UserMsgStatusEnumMap[instance.status],
      'replyId': instance.replyId,
      'sentTime': instance.sentTime,
      'receiveTime': instance.receiveTime,
      'replyTime': instance.replyTime,
      'bak1': instance.bak1,
      'bak2': instance.bak2,
      'bak3': instance.bak3,
      'bak4': instance.bak4,
      'bak5': instance.bak5,
    };

const _$UserMsgStatusEnumMap = {
  UserMsgStatus.UNREAD: 'UNREAD',
  UserMsgStatus.READ: 'READ',
  UserMsgStatus.REPLIED: 'REPLIED',
};
