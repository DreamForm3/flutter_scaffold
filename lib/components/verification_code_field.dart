import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scaffold/api/base_api.dart';
import 'package:flutter_scaffold/models/dtos/api_result.dart';
import 'package:flutter_scaffold/utils/extend_string_utils.dart';
import 'package:flutter_scaffold/utils/toast_utils.dart';

/// 获取邮箱验证码输入框
class VerificationCodeField extends StatefulWidget {
  VerificationCodeField({
    Key? key,
    this.restorationId,
    this.fieldKey,
    this.hintText,
    this.labelText,
    this.helperText,
    this.errorText,
    this.readOnly = false,
    this.icon,
    this.onSaved,
    this.validator,
    this.onFieldSubmitted,
    required this.verifyTokenSetter,
    required this.controller,
    this.focusNode,
    this.textInputAction,
    this.startCountdownOnInitState = false,
    this.timeOutInSeconds = 60,
  }) : super(key: key);

  final String? restorationId;
  final Key? fieldKey;
  final String? hintText;
  final String? labelText;
  final String? helperText;
  final bool readOnly;
  final IconData? icon;
  final FormFieldSetter<String>? onSaved;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onFieldSubmitted;
  final void Function(String value) verifyTokenSetter;
  final TextEditingController controller;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;

  final bool startCountdownOnInitState;
  final int timeOutInSeconds;

  String? errorText;

  @override
  _VerificationCodeFieldState createState() => _VerificationCodeFieldState();
}

class _VerificationCodeFieldState extends State<VerificationCodeField> with RestorationMixin {

  late BaseApi _baseApi;
  // 是否要倒计时
  bool _pending = false;
  // 倒计时
  int timeCounter = 0;

  @override
  void initState() {
    super.initState();
    _baseApi = BaseApi.instance;
    if (widget.startCountdownOnInitState) {
      _startCountDown();
    }
  }

  @override
  String? get restorationId => widget.restorationId;

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {

  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: widget.fieldKey,
      // restorationId: 'password_text_field',
      readOnly: widget.readOnly,
      keyboardType: TextInputType.visiblePassword,
      focusNode: widget.focusNode,
      controller: widget.controller,
      onSaved: widget.onSaved,
      validator: widget.validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onFieldSubmitted: widget.onFieldSubmitted,
      textInputAction: widget.textInputAction,
      decoration: InputDecoration(
        icon: widget.icon != null ? Icon(widget.icon) : null,
        hintText: widget.hintText,
        labelText: widget.labelText,
        helperText: widget.helperText,
        errorText: widget.errorText,
        suffixText: _pending ? (timeCounter.toString() + '秒') : null,
        suffixIcon: IconButton(
          icon: Icon(Icons.send),
          tooltip: '发送验证码',
          onPressed: _pending ? null : _sendCode,
        ),
      ),
    );
  }

  /// 发送验证码
  Future<void> _sendCode() async {
    // 没有通过校验直接返回
    if (widget.validator != null && widget.validator!(widget.controller.text) != null) {
      return;
    }
    _startCountDown();
    try {
      dynamic response;
      String target = widget.controller.text;
      // 根据目标调用不同的获取验证码的方法
      if (ExtendStringUtils.isEmail(target)) {
        response = await _baseApi.getVerificationCode(target);
      } else {
        response = await _baseApi.getVerificationCodeByUsername(target);
      }

      if (response is Response) {
        String toastMsg;
        ApiResult apiResult = ApiResult.fromJson(response.data);
        if (response.statusCode == 200) {
          widget.verifyTokenSetter(apiResult.data['verifyToken']);
          widget.errorText = null;
          toastMsg = '验证码已发送到邮箱';
        } else {
          _stopCountDown();
          toastMsg = apiResult.message ?? '获取验证码失败';
        }
        ToastUtils.showSimpleSnackBar(toastMsg, context);
      }
    } catch (e) {
      _stopCountDown();
      ToastUtils.showSimpleSnackBar('oops 什么东西不对劲', context);
      print(e);
    }
  }

  void _startCountDown() async {
    setState(() {
      _pending = true;
      timeCounter = widget.timeOutInSeconds;
    });
    _timerUpdate();
  }

  void _stopCountDown() async {
    setState(() {
      _pending = false;
      timeCounter = 0;
    });
  }

  /// 更新倒计时
  void _timerUpdate() {
    Timer(const Duration(seconds: 1), () async {
      setState(() {
        timeCounter--;
      });
      if (timeCounter > 0)
        _timerUpdate();
      else
        _pending = false;
    });
  }
}