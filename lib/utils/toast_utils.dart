import 'package:flutter/material.dart';

class ToastUtils {
  /// 弹出一个简单的通知
  ///
  /// [msg] 要显示的消息
  ///
  /// [context] BuildContext
  ///
  /// [callback] 点击 OK 按钮要执行的方法
  static void showSimpleSnackBar(String msg, BuildContext context,
      {Function? callback}) {
    final snackBar = SnackBar(
      content: Text(msg),
      action: SnackBarAction(
        label: 'OK',
        onPressed: () {
          if (callback != null) callback(context);
        },
      ),
    );
    // Find the ScaffoldMessenger in the widget tree
    // and use it to show a SnackBar.
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
