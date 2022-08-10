import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

/// 继承了 flutter_form_builder: ^7.0.0 包里面的 FormBuilderFieldOption 修改
/// An option for fields with selection options.
///
/// The type `T` is the type of the value the entry represents. All the entries
/// in a given menu must represent values with consistent types.
class CustomFormBuilderFieldOption<T> extends FormBuilderFieldOption<T> {

  final Widget? avatar;

  /// Creates an option for fields with selection options
  const CustomFormBuilderFieldOption({
    Key? key,
    required T value,
    Widget? child,
    this.avatar
  }) : super(key: key, value: value, child: child);

}
