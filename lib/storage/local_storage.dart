import 'dart:convert';

import 'package:basic_utils/basic_utils.dart';
import 'package:flutter_scaffold/models/custom_json_converter.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// 本地存储
class LocalStorage {

  // 底层存储
  static SharedPreferences? _prefs;
  // 单例
  static final LocalStorage _instance = LocalStorage._();

  LocalStorage._();

  static Future<LocalStorage> getInstance() async {
    if (_prefs == null) {
      _prefs = await SharedPreferences.getInstance();
    }
    return _instance;
  }

  /// 取值
  dynamic get(String key) {
    return _prefs!.get(key);
  }

  /// 获取对象
  T? getObject<T>(String key) {
    String? jsonStr = _prefs!.getString(key);
    return StringUtils.isNullOrEmpty(jsonStr)
        ? null
        : CustomJsonConverter<T>().fromJson(json.decode(jsonStr!));
  }

  /// 存储对象，实际上是把对象json序列化存储成String
  Future<bool> setObject(String key, dynamic value) async {
    return _prefs!.setString(key, jsonEncode(value));
  }

  /// 获取String
  String? getString(String key) {
    return _prefs!.getString(key);
  }

  /// 存储String
  Future<bool> setString(String key, String value) async {
    return _prefs!.setString(key, value);
  }

  /// 获取int
  int? getInt(String key) {
    return _prefs!.getInt(key);
  }

  /// 存储int
  Future<bool> setInt(String key, int value) async {
    return _prefs!.setInt(key, value);
  }

  /// 获取double
  double? getDouble(String key) {
    return _prefs!.getDouble(key);
  }

  /// 存储int
  Future<bool> setDouble(String key, double value) async {
    return _prefs!.setDouble(key, value);
  }

  /// 获取double
  bool? getBool(String key) {
    return _prefs!.getBool(key);
  }

  /// 存储bool
  Future<bool> setBool(String key, bool value) async {
    return _prefs!.setBool(key, value);
  }

  /// 是否有某个key
  bool containsKey(String key) {
    return _prefs!.containsKey(key);
  }

  /// 清空存储
  Future<bool> clear() async {
    return _prefs!.clear();
  }
}