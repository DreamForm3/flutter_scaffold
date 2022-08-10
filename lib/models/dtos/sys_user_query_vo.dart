import 'package:freezed_annotation/freezed_annotation.dart';

part 'sys_user_query_vo.freezed.dart';
part 'sys_user_query_vo.g.dart';

@freezed
class SysUserQueryVo with _$SysUserQueryVo {
  const factory SysUserQueryVo({
  int? id,
  String? username,
  String? nickname,
  String? phone,
  String? email,
  int? gender,
  String? avatar,
  String? remark,
  int? state,
  int? departmentId,
  int? roleId,
  int? deleted,
  int? version,
  String? createTime,
  String? updateTime,
  String? departmentName,
  String? roleName,
  }) = _SysUserQueryVo;

  factory SysUserQueryVo.fromJson(Map<String, dynamic> json) =>
      _$SysUserQueryVoFromJson(json);
}
