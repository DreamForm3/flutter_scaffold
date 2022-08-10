import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_sysuser_vo.freezed.dart';
part 'login_sysuser_vo.g.dart';
/// 登陆用户信息
@freezed
class LoginSysUserVo with _$LoginSysUserVo {
  const factory LoginSysUserVo({
    int? id,
    /// 用户名
    String? username,
    /// 昵称
    String? nickname,
    /// 性别，0：女，1：男，默认1
    int? gender,
    /// 状态，0：禁用，1：启用，2：锁定
    int? state,
    /// 部门id
    int? departmentId,
    /// 部门名称
    String? departmentName,
    /// 角色id
    int? roleId,
    /// 角色名称
    String? roleName,
    /// 角色编码
    String? roleCode,
    /// 权限编码列表
    List<String>? permissionCodes,


  }) = _LoginSysUserVo;

  factory LoginSysUserVo.fromJson(Map<String, dynamic> json) =>
      _$LoginSysUserVoFromJson(json);
}