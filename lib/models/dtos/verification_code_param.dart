import 'package:freezed_annotation/freezed_annotation.dart';

part 'verification_code_param.freezed.dart';
part 'verification_code_param.g.dart';

@freezed
class VerificationCodeParam with _$VerificationCodeParam {
  const factory VerificationCodeParam({
    String? verifyToken,
    String? code,
    String? receiveClient,
}) = _VerificationCodeParam;

  factory VerificationCodeParam.fromJson(Map<String, dynamic> json) =>
      _$VerificationCodeParamFromJson(json);
}
