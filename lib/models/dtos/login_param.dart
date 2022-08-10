
import 'package:freezed_annotation/freezed_annotation.dart';

/// 登录参数，登陆时发送给后端服务
part 'login_param.freezed.dart';
part 'login_param.g.dart';

@freezed
class LoginParam with _$LoginParam {
  const factory LoginParam({
  String? username,
  String? password,
  String? verifyToken,
  String? code,}) = _LoginParam;

  factory LoginParam.fromJson(Map<String, dynamic> json) =>
      _$LoginParamFromJson(json);
}

