import 'package:flutter_scaffold/models/enums/user_msg_status.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'user_msg_page_param.freezed.dart';
part 'user_msg_page_param.g.dart';

@freezed
class UserMsgPageParam with _$UserMsgPageParam {
  const factory UserMsgPageParam({
    int? pageIndex,
    int? pageSize,
    String? keyword,
    int? sendUser,
    int? receiveUser,
    String? title,
    String? content,
    List<UserMsgStatus>? statusList,
    int? replyId,
    DateTime? sentTimeStart,
    DateTime? sentTimeEnd,
    DateTime? receiveTimeStart,
    DateTime? receiveTimeEnd,
    DateTime? replyTimeStart,
    DateTime? replyTimeEnd,
  }) = _UserMsgPageParam;

  factory UserMsgPageParam.fromJson(Map<String, dynamic> json) => _$UserMsgPageParamFromJson(json);
}
