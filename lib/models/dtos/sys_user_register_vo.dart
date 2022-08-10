
import 'package:flutter_scaffold/models/dtos/sys_user.dart';
import 'package:flutter_scaffold/models/dtos/verification_code_param.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sys_user_register_vo.freezed.dart';
part 'sys_user_register_vo.g.dart';


@freezed
class SysUserRegisterVo with _$SysUserRegisterVo {
  const factory SysUserRegisterVo({
    VerificationCodeParam? verificationCodeParam,
    SysUser? sysUser,
  }) = _SysUserRegisterVo;

  factory SysUserRegisterVo.fromJson(Map<String, dynamic> json) =>
      _$SysUserRegisterVoFromJson(json);
}




