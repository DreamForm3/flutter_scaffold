import 'dart:convert'; // for the utf8.encode method
import 'package:crypto/crypto.dart';

class CryptoUtils {

  /// 把字符串进行 SHA-256 加密
  static String sha256Encode(String source) {
    return sha256.convert(utf8.encode(source)).toString();
  }

  /// 把字符串进行 BASE64 加密
  static String base64Encode(String source) {
    return base64.encode(utf8.encode(source));
  }

  /// 把字符串进行 BASE64 解密
  static String base64Decode(String source) {
    return utf8.decode(base64.decode(source));
  }
}