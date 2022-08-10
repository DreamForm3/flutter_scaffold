
import 'package:basic_utils/basic_utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scaffold/api/base_api.dart';
import 'package:flutter_scaffold/components/indicator_button.dart';
import 'package:flutter_scaffold/components/password_field.dart';
import 'package:flutter_scaffold/models/dtos/api_result.dart';
import 'package:flutter_scaffold/models/dtos/sys_user_query_vo.dart';
import 'package:flutter_scaffold/utils/toast_utils.dart';

class ChangePasswordScreen extends StatefulWidget {
  ChangePasswordScreen(
      {Key? key,
      required this.baseApi,
      required this.loginUserInfo})
      : super(key: key);

  final BaseApi baseApi;
  final SysUserQueryVo loginUserInfo;

  @override
  State<StatefulWidget> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePasswordScreen> {
  // 是否正在初始化数据
  bool _processing = false;

  // 旧密码输入框组件
  final TextEditingController _oldPasswordController = TextEditingController();
  // 新密码输入框组件
  final TextEditingController _newPasswordController = TextEditingController();
  // 重复密码输入框组件
  final TextEditingController _repeatPasswordController = TextEditingController();

  // declare a GlobalKey
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

  }


  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _repeatPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('修改密码'),
        ),
        body: Form(
          key: _formKey,
          child: ListView(padding: EdgeInsets.all(16.0), children: [
            PasswordField(
              labelText: '旧密码',
              controller: _oldPasswordController,
              validator: _validateOldPassword,
              textInputAction: TextInputAction.next,
            ),
            PasswordField(
              labelText: '新密码',
              controller: _newPasswordController,
              validator: _validateNewPassword,
              textInputAction: TextInputAction.next,
            ),
            PasswordField(
              labelText: '确认密码',
              controller: _repeatPasswordController,
              validator: _validateRepeatPassword,
              textInputAction: TextInputAction.done,
            ),
            IndicatorButton('修改密码', _processing,
                onPressed: (BuildContext context) => {_changePass(context)}
                ),
          ]),
        ));
  }

  /// 校验旧密码
  String? _validateOldPassword(String? oldPass) {
    return StringUtils.isNullOrEmpty(oldPass) ? '请输入旧密码' : null;
  }

  /// 校验新密码
  String? _validateNewPassword(String? newPass) {
    if (StringUtils.isNullOrEmpty(newPass)) {
      return '请输入新密码';
    } else if (newPass == _oldPasswordController.text) {
      return '新密码不能与旧密码相同';
    }
    return null;
  }

  /// 校验确认密码
  String? _validateRepeatPassword(String? repeatPass) {
    if (StringUtils.isNullOrEmpty(repeatPass)) {
      return '请输入确认密码';
    } else if (repeatPass != _newPasswordController.text) {
      return '新密码两次输入值不一样';
    }
    return null;
  }


  /// 更新用户信息
  void _changePass(BuildContext context) async {
    // 校验表单输入项
    if (!_formKey.currentState!.validate()) {
      ToastUtils.showSimpleSnackBar('请检查表单输入项', context);
      return;
    }

    // 标记为正在处理
    setState(() {
      _processing = true;
    });

    try {
      dynamic response = await widget.baseApi.changePassword(
          userId: widget.loginUserInfo.id!,
          oldPassword: _oldPasswordController.text,
          newPassword: _newPasswordController.text,
          repeatPassword: _repeatPasswordController.text);

      if (response is Response) {
        // 更新成功后返回个人中心
        if (response.statusCode == 200) {
          ToastUtils.showSimpleSnackBar('密码修改成功', context);
          Navigator.of(context).pop();
        } else {
          // 更新失败，通知用户错误信息
          ApiResult<bool> apiResult =
          ApiResult<bool>.fromJson(response.data);
          String errorMsg = apiResult.message ?? '修改密码失败，请稍后再试';
          ToastUtils.showSimpleSnackBar(errorMsg, context);
        }
      }
    } catch (e) {
      ToastUtils.showSimpleSnackBar('oops 什么东西不对劲', context);
      print(e);
    }

    // 取消正在处理标记
    setState(() {
      _processing = false;
    });
  }
}
