import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_password_param.freezed.dart';
part 'update_password_param.g.dart';

@freezed
class UpdatePasswordParam with _$UpdatePasswordParam {
  const factory UpdatePasswordParam({
    int? userId,
    String? oldPassword,
    String? newPassword,
    String? confirmPassword,
}) = _UpdatePasswordParam;

  factory UpdatePasswordParam.fromJson(Map<String, dynamic> json) =>
      _$UpdatePasswordParamFromJson(json);
}

