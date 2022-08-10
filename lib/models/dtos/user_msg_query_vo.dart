// To parse this JSON data, do
//
//     final userMsgQueryVo = userMsgQueryVoFromJson(jsonString);

import 'package:flutter_scaffold/models/enums/user_msg_status.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'user_msg_query_vo.freezed.dart';
part 'user_msg_query_vo.g.dart';

@freezed
abstract class UserMsgQueryVo with _$UserMsgQueryVo {
  const factory UserMsgQueryVo({
    int? sendUser,
    int? receiveUser,
    String? title,
    String? content,
    UserMsgStatus? status,
    int? replyId,
    String? sentTime,
    String? receiveTime,
    String? replyTime,
    String? bak1,
    String? bak2,
    String? bak3,
    String? bak4,
    String? bak5,
  }) = _UserMsgQueryVo;

  factory UserMsgQueryVo.fromJson(Map<String, dynamic> json) => _$UserMsgQueryVoFromJson(json);
}
