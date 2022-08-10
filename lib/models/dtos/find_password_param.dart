import 'package:freezed_annotation/freezed_annotation.dart';

part 'find_password_param.freezed.dart';

part 'find_password_param.g.dart';

@freezed
class FindPasswordParam with _$FindPasswordParam {
  const factory FindPasswordParam({
    String? username,
    String? verifyToken,
    String? code,
    String? newPassword,
    String? confirmPassword}) = _FindPasswordParam;

  factory FindPasswordParam.fromJson(Map<String, dynamic> json) =>
      _$FindPasswordParamFromJson(json);
}
