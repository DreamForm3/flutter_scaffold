import 'dart:math' as math;
import 'dart:ui' show lerpDouble;
import 'package:flutter/material.dart';

/// 可以点击的格子，格子是方形的，
/// 类似于带 icon 的 [TextButton] ，但是 icon 在上 label 在下。
/// 必须提供一个 icon 和一个 label。
class GridTileButton extends TextButton {
  GridTileButton({
    Key? key,
    required VoidCallback? onPressed,
    ValueChanged<bool>? onHover,
    ValueChanged<bool>? onFocusChange,
    ButtonStyle? style,
    FocusNode? focusNode,
    bool? autofocus,
    Clip? clipBehavior,
    required Widget icon,
    required Widget label,
    String? tooltip,
  }) : assert(icon != null),
        assert(label != null),
        super(
        key: key,
        onPressed: onPressed,
        onHover: onHover,
        onFocusChange: onFocusChange,
        style: style,
        focusNode: focusNode,
        autofocus: autofocus ?? false,
        clipBehavior: clipBehavior ?? Clip.none,
        child: _GridTileButtonChild(icon: icon, label: label, tooltip: tooltip,),
      );

  @override
  ButtonStyle defaultStyleOf(BuildContext context) {
    final EdgeInsetsGeometry scaledPadding = ButtonStyleButton.scaledPadding(
      const EdgeInsets.all(8),
      const EdgeInsets.symmetric(horizontal: 4),
      const EdgeInsets.symmetric(horizontal: 4),
      MediaQuery.maybeOf(context)?.textScaleFactor ?? 1,
    );
    return super.defaultStyleOf(context).copyWith(
      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(scaledPadding),
    );
  }
}

class _GridTileButtonChild extends StatelessWidget {
  const _GridTileButtonChild({
    Key? key,
    required this.label,
    required this.icon,
    this.tooltip,
  }) : super(key: key);

  final Widget label;
  final Widget icon;
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    final double scale = MediaQuery.maybeOf(context)?.textScaleFactor ?? 1;
    final double gap = scale <= 1 ? 8 : lerpDouble(8, 4, math.min(scale - 1, 1))!;

    Widget result = AspectRatio(
      aspectRatio: 1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          IconTheme.merge(
            data: IconThemeData(
              size: 40,
            ),
            child: icon,
          ),
          // SizedBox(height: gap),
          label
        ],
      ),
    );

    // 如果提供了 tooltip 则在外面再包一层
    if (tooltip != null) {
      result = Tooltip(
        message: tooltip,
        child: result,
      );
    }

    return result;
  }
}