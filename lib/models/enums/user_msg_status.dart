/// 用户消息状态
enum UserMsgStatus {
  /// 未读
  UNREAD,
  /// 已读
  READ,
  /// 已回复
  REPLIED,

}

String getUserMsgStatusName(UserMsgStatus method) {
  return method.toString().substring(method.toString().indexOf('.') + 1);
}