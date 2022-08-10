import 'package:basic_utils/basic_utils.dart';

/// 扩展 StringUtils
class ExtendStringUtils {

  /// 检查 String 是否是 null 或者是空字符或者全是空白字符
  static bool isNullOrEmptyOrBlank(String? str) {
    return (StringUtils.isNullOrEmpty(str) ||
            StringUtils.isNullOrEmpty(str!.trim()))
        ? true
        : false;
  }

  /// 检查两个字符串是否一样，如果都是空或者相等返回 true 否则返回 false
  static bool isSame(String? a, String? b) {
    return (a == null && b == null || a == b) ? true : false;
  }

  /// 正则校验是否是中国大陆手机号
  static bool isChinaMainLandMobile(String str) {
    return RegExp(
        r"^1([38][0-9]|4[579]|5[0-3,5-9]|6[6]|7[0135678]|9[89])\d{8}$")
        .hasMatch(str);
  }

  /// 正则校验是否是邮箱
  static bool isEmail(String str) {
    return RegExp(
        r"^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$")
        .hasMatch(str);
  }

  /// 正则校验是否是URL
  static bool isUrl(String value) {
    return RegExp(
        r"^((https|http|ftp|rtsp|mms)?:\/\/)[^\s]+")
        .hasMatch(value);
  }

  /// 正则校验是否是中国大陆身份证
  static bool isIdCard(String value) {
    return RegExp(
        r"\d{17}[\d|x]|\d{15}")
        .hasMatch(value);
  }

  /// 正则校验是否是中文
  static bool isChinese(String value) {
    return RegExp(
        r"[\u4e00-\u9fa5]")
        .hasMatch(value);
  }
}