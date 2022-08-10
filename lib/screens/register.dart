import 'dart:async';

import 'package:basic_utils/basic_utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scaffold/api/base_api.dart';
import 'package:flutter_scaffold/components/indicator_button.dart';
import 'package:flutter_scaffold/components/password_field.dart';
import 'package:flutter_scaffold/components/verification_code_field.dart';
import 'package:flutter_scaffold/models/dtos/api_result.dart';
import 'package:flutter_scaffold/router/flutter_scaffold_route_configuration.dart';
import 'package:flutter_scaffold/router/flutter_scaffold_router_delegate.dart';
import 'package:flutter_scaffold/utils/extend_string_utils.dart';
import 'package:flutter_scaffold/utils/toast_utils.dart';

/// 登陆页
class RegisterSrceen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RegisterState();
}

class _RegisterState extends State<RegisterSrceen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nickNameController = TextEditingController();
  final TextEditingController _verifyCodeController = TextEditingController();

  late BaseApi _baseApi;

  // 处理状态
  bool _processing = false;

  String? _email;
  String? _verifyToken;
  bool illegalRequest = false;

  void setVerifyToken(String token) => _verifyToken = token;

  final _formKey = GlobalKey<FormState>();



  @override
  void initState() {
    super.initState();

    _baseApi = BaseApi.instance;
  }


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    FlutterScaffoldRouterDelegate delegate = FlutterScaffoldRouterDelegate.of(context);
    FlutterScaffoldRouteConfiguration configuration = delegate.currentConfiguration!;
    if (configuration.params == null) {
      illegalRequest = true;
    } else {
      _email = configuration.params!['email'];
      _verifyToken = configuration.params!['verifyToken'];
      if (_email == null || _verifyToken == null) {
        illegalRequest = true;
      }
    }

    // 缺少必要参数，说明不是从邮箱校验页面过来的，需要回到邮箱校验页面
    if (illegalRequest) {
      Future.delayed(Duration.zero, () {
        AlertDialog dialog = AlertDialog(
          title: Text('还未校验邮箱'),
          content: Text('在正式注册前，需要先校验邮箱'),
          actions: [TextButton(onPressed: () {
            // 关闭 AlertDialog
            Navigator.of(context).pop();
            delegate.routeStack = [
              FlutterScaffoldRouteConfiguration("/login"),
              FlutterScaffoldRouteConfiguration("/verifyEmail")
            ];
          }, child: Text('OK'))],
        );
        showDialog(
            context: context,
            builder: (BuildContext context) => dialog,
            barrierDismissible: false);
      });
    } else {
      _emailController.text = _email!;
      // 用户名直接取邮箱前面的部分
      _usernameController.text = _email!.substring(0, _email!.indexOf('@'));
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _verifyCodeController.dispose();
    _nickNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            SizedBox(height: 80.0),
            Column(
              children: <Widget>[
                Image.asset('assets/images/flutter-logo.png'),
                SizedBox(height: 16.0),
                Text(
                  'STEP2 完善信息完成注册',
                  style: Theme.of(context).textTheme.headline5,
                ),
              ],
            ),
            SizedBox(height: 120.0),
            VerificationCodeField(
              readOnly: true,
              verifyTokenSetter: setVerifyToken,
              controller: _emailController,
              labelText: '邮箱',
              icon: Icons.email,
              startCountdownOnInitState: true,
            ),
            // spacer
            SizedBox(height: 12.0),
            TextFormField(
              controller: _verifyCodeController,
              validator: _validateVerifyCode,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                icon: Icon(Icons.vpn_key),
                // filled: true,
                labelText: '验证码',
              ),
            ),
            SizedBox(height: 12.0),
            TextFormField(
              controller: _usernameController,
              validator: _validateUsername,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                icon: Icon(Icons.person),
                // filled: true,
                labelText: '用户名',
              ),
            ),
            // spacer
            SizedBox(height: 12.0),

            PasswordField(
              controller: _passwordController,
              validator: _validatePassword,
              textInputAction: TextInputAction.next,
              labelText: '密码',
            ),
            TextFormField(
              controller: _nickNameController,
              validator: _validateNickName,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                icon: Icon(Icons.face),
                // filled: true,
                labelText: '昵称',
              ),
            ),
            ButtonBar(
              children: <Widget>[
                OutlinedButton(
                  child: Text('清空'),
                  onPressed: _processing ? null : () {
                    _verifyCodeController.clear();
                    _usernameController.clear();
                    _passwordController.clear();
                    _nickNameController.clear();
                  },
                ),
                IndicatorButton('注册', _processing, onPressed: _register),

              ],
            ),
            SizedBox(height: 12.0),


          ],
        ),
      )),
    );
  }

  /// 注册方法
  void _register(BuildContext context) async {
    // 校验输入信息
    if (!_formKey.currentState!.validate()) {
      ToastUtils.showSimpleSnackBar('请先完善注册信息', context);
      return;
    }

    // 标记为正在处理
    setState(() {
      _processing = true;
    });

    try {
      dynamic response = await _baseApi.register(
          _email!,
          _verifyToken!,
          _verifyCodeController.text,
          _usernameController.text,
          _passwordController.text,
          _nickNameController.text);

      if (response is Response) {
        // 注册成功后继续登陆
        if (response.statusCode == 200) {
          ToastUtils.showSimpleSnackBar('注册成功，正在为您登陆', context);
          response = await _baseApi.login(
              _usernameController.text, _passwordController.text,
              context: context);
          // 登陆成功，跳转到首页
          if (response is Response && response.statusCode == 200) {
            FlutterScaffoldRouterDelegate delegate = FlutterScaffoldRouterDelegate.of(context);
            // 登陆成功后需要清空整个路由栈然后跳转到主页
            delegate.routeStack = [FlutterScaffoldRouteConfiguration("/home")];
          }
        } else {
          // 注册失败，通知用户错误信息
          ApiResult<String> apiResult =
              ApiResult<String>.fromJson(response.data);
          String errorMsg = apiResult.message ?? '注册失败，请检查输入信息';

          // 此时的错误信息数据必须让用户知晓，需要用 Dialog，
          // 什么时候用 Dialog、Banner、Snackbar 参见 https://material.io/components/dialogs#usage
          AlertDialog dialog = AlertDialog(
            title: Text('注册失败'),
            content: Text(errorMsg),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, 'OK'),
                child: const Text('OK'),
              ),
            ],
          );
          showDialog(context: context, builder: (BuildContext context) => dialog);
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

  String? _validateUsername(String? username) {
    return ExtendStringUtils.isNullOrEmptyOrBlank(username) ? '请输入用户名' : null;
  }

  String? _validatePassword(String? password) {
    return StringUtils.isNullOrEmpty(password) ? '请输入密码' : null;
  }

  String? _validateVerifyCode(String? verifyCode) {
    return StringUtils.isNullOrEmpty(verifyCode) ? '请输入验证码' : null;
  }

  String? _validateNickName(String? nickName) {
    return StringUtils.isNullOrEmpty(nickName) ? '请输入昵称' : null;
  }


}