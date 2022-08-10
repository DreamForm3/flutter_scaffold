import 'package:json_annotation/json_annotation.dart';
import 'package:basic_utils/basic_utils.dart';

import 'dtos/api_result.dart';
import 'dtos/find_password_param.dart';
import 'dtos/login_param.dart';
import 'dtos/login_sysuser_token_vo.dart';
import 'dtos/login_sysuser_vo.dart';
import 'dtos/paging.dart';
import 'dtos/sys_user.dart';
import 'dtos/sys_user_query_vo.dart';
import 'dtos/sys_user_register_vo.dart';
import 'dtos/update_password_param.dart';
import 'dtos/user_msg_query_vo.dart';
import 'dtos/verification_code_param.dart';

class CustomJsonConverter<T> implements JsonConverter<T, Object?> {
  const CustomJsonConverter();

  @override
  T fromJson(json) {
    if (json is Map<String, dynamic>) {
      String genericStr = T.toString();
      SimpleGenericType simpleGenericType = _parseGenerics(genericStr);
      switch (simpleGenericType.classType) {
        case 'ApiResult':
          return ApiResult.fromJson(json) as T;
        case 'Paging':
          // Paging 一般情况下内部还有嵌套泛型需要特殊处理
          if (simpleGenericType.genericType != null) {
            switch (simpleGenericType.genericType) {
              case 'UserMsgQueryVo':
                return Paging<UserMsgQueryVo>.fromJson(json) as T;
              case 'SysUserQueryVo':
                return Paging<SysUserQueryVo>.fromJson(json) as T;
            }
          }
          return Paging.fromJson(json) as T;
        case 'LoginParam':
          return LoginParam.fromJson(json) as T;
        case 'LoginSysUserTokenVo':
          return LoginSysUserTokenVo.fromJson(json) as T;
        case 'LoginSysUserVo':
          return LoginSysUserVo.fromJson(json) as T;
        case 'SysUserRegisterVo':
          return SysUserRegisterVo.fromJson(json) as T;
        case 'SysUser':
          return SysUser.fromJson(json) as T;
        case 'VerificationCodeParam':
          return VerificationCodeParam.fromJson(json) as T;
        case 'SysUserQueryVo':
          return SysUserQueryVo.fromJson(json) as T;
        case 'UpdatePasswordParam':
          return UpdatePasswordParam.fromJson(json) as T;
        case 'FindPasswordParam':
          return FindPasswordParam.fromJson(json) as T;
        case 'UserMsgQueryVo':
          return UserMsgQueryVo.fromJson(json) as T;
      }
    }

    return json as T;
  }

  @override
  Object? toJson(T object) => object;

  SimpleGenericType _parseGenerics(String generics) {
    if (StringUtils.isNullOrEmpty(generics)) {
      return SimpleGenericType(classType: 'dynamic');
    }
    // 有泛型
    if (generics.contains('<')) {
      String classTypeStr = generics.substring(0, generics.indexOf('<'));
      String genericTypeStr = generics.substring(
          generics.indexOf('<') + 1, generics.lastIndexOf('>'));
      return SimpleGenericType(
          classType: classTypeStr, genericType: genericTypeStr);
    }
    // 没有泛型了
    else {
      // 如果最后一位是 ? 需要去掉
      if (generics.endsWith("?")) {
        generics = generics.substring(0, generics.length - 1);
      }
      return SimpleGenericType(classType: generics);
    }
  }
}

/// 一个简单的泛型封装，[classType] 是类的类型，[genericType]是类上泛型的类型
/// 例如 ApiResult<LoginSysUserTokenVo>，classType = ApiResult，genericType = LoginSysUserTokenVo
class SimpleGenericType {
  String classType;
  String? genericType;

  SimpleGenericType({required this.classType, this.genericType});
}
