import 'package:basic_utils/basic_utils.dart';

/// 日期、时间 工具类
class ExtendDateUtils {

  static DateTime getYesterday() {
    // 获取当前时间，然后取整，然后减一天
    DateTime tempDate = DateTime.now();
    tempDate = DateTime(tempDate.year, tempDate.month, tempDate.day);
    tempDate = tempDate.subtract(Duration(days: 1));
    return tempDate;
  }
}