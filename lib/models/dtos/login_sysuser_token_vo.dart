
import 'package:freezed_annotation/freezed_annotation.dart';

import 'login_sysuser_vo.dart';

part 'login_sysuser_token_vo.freezed.dart';
part 'login_sysuser_token_vo.g.dart';

/// 登录用户信息TokenVO，用于接收后端返回的用户登陆信息
@freezed
class LoginSysUserTokenVo with _$LoginSysUserTokenVo {
  const factory LoginSysUserTokenVo({
  String? token,

  LoginSysUserVo? loginSysUserVo,

  }) = _LoginSysUserTokenVo;

  factory LoginSysUserTokenVo.fromJson(Map<String, dynamic> json) =>
      _$LoginSysUserTokenVoFromJson(json);
}



