import 'package:freezed_annotation/freezed_annotation.dart';

part 'sys_user.freezed.dart';
part 'sys_user.g.dart';

@freezed
class SysUser with _$SysUser {
  const factory SysUser({
    int? id,
    String? username,
    String? nickname,
    int? version,
    bool? isDelete,
    String? password,
    DateTime? createTime,
    String? salt,
    String? phone,
    DateTime? updateTime,
    String? email,
    int? gender,
    String? avatar,
    String? remark,
    int? state,
    int? departmentId,
    int? roleId,
}) = _SysUser;

  factory SysUser.fromJson(Map<String, dynamic> json) =>
      _$SysUserFromJson(json);
}
