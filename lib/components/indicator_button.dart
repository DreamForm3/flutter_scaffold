import 'package:flutter/material.dart';

// typedef VoidCallback = void Function(BuildContext context);

/// 带环形进度指示器的按钮
class IndicatorButton extends StatelessWidget {
  const IndicatorButton(this.text, this.processFlag, {this.onPressed, this.style});

  /// 按钮文字
  final String text;
  /// 当前是否正在处理，ture 时 button 上面会显示一个环形进度指示器
  final bool processFlag;
  /// 按钮 onPressed 回调
  final void Function(BuildContext context)? onPressed;
  /// 按钮样式
  final ButtonStyle? style;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      // 正在处理的话显示一个进度指示器，并且不能再点击
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(text),
        if (processFlag) SizedBox(width: 8, height: 32),
        if (processFlag)
          SizedBox.square(
              child: Padding(
                padding: EdgeInsets.fromLTRB(8, 4, 0, 4),
                child: CircularProgressIndicator(),
              ),
              dimension: 32)
      ]),
      onPressed: processFlag
          ? null
          : () {
              if (onPressed != null) onPressed!(context);
            },
      style: style,
    );
  }
}
