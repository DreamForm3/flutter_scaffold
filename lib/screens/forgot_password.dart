
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

// typedef VoidCallback = void Function();

/// 登陆页
class ForgotPasswordSrceen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPasswordSrceen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _repeatPasswordController = TextEditingController();
  final TextEditingController _verifyCodeController = TextEditingController();

  late BaseApi _baseApi;

  // 处理状态
  bool _processing = false;
  // 当前步骤
  int _currentStep = 0;


  String? _username;
  String? _verifyToken;

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

    // 如果给了用户名，就把用户填充到输入框上
    FlutterScaffoldRouterDelegate delegate = FlutterScaffoldRouterDelegate.of(context);
    FlutterScaffoldRouteConfiguration configuration = delegate.currentConfiguration!;
    if (configuration.params != null) {
      _username = configuration.params!['username'];
      if (_username != null) {
        _usernameController.text = _username!;
      }
    }

  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _verifyCodeController.dispose();
    _repeatPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('忘记密码'),
        actions: [],
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Stepper(
              physics: ClampingScrollPhysics(),
              currentStep: _currentStep,
              onStepCancel: () {
                setState(() {
                  _currentStep--;
                });
              },
              onStepContinue: () {
                setState(() {
                  _currentStep++;
                });
              },
              onStepTapped: (int index) {
                setState(() {
                  _currentStep = index;
                });
              },
              controlsBuilder: _stepperControl,
              steps: [
                Step(
                  title: Text('获取验证码'),
                  subtitle: Text('输入用户名并且从账号绑定的邮箱获取验证码'),
                  content: Column(
                    children: [
                      VerificationCodeField(
                        verifyTokenSetter: setVerifyToken,
                        controller: _usernameController,
                        validator: _validateUsername,
                        textInputAction: TextInputAction.next,
                        labelText: '用户名',
                        icon: Icons.person,
                      ),
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
                    ],
                  ),
                ),
                Step(
                  title: Text('重置密码'),
                  subtitle: Text('输入新的密码并重置密码'),
                  content: Column(
                    // physics: ClampingScrollPhysics(),
                    // padding: EdgeInsets.symmetric(horizontal: 24.0),
                    children: [
                      PasswordField(
                        controller: _passwordController,
                        validator: _validatePassword,
                        textInputAction: TextInputAction.next,
                        labelText: '密码',
                      ),
                      PasswordField(
                        labelText: '确认密码',
                        controller: _repeatPasswordController,
                        validator: _validateRepeatPassword,
                        textInputAction: TextInputAction.done,
                      ),
                    ],
                  ),
                ),
              ]),
        ),
      ),
    );
  }

  /// Stepper 的控制器
  Widget _stepperControl(BuildContext context, ControlsDetails details) {
    if (_currentStep == 0) {
      return ButtonBar(
        children: <Widget>[
          ElevatedButton(onPressed: details.onStepContinue, child: Text('继续')),
        ],
      );
    } else {
      return ButtonBar(
        children: <Widget>[
          OutlinedButton(
            child: Text('上一步'),
            onPressed: details.onStepCancel,
          ),

          IndicatorButton('继续', _processing,
              onPressed: _findPassword),
        ],
      );
    }
  }


  /// 找回密码方法
  void _findPassword(BuildContext context) async {
    // 校验输入信息
    if (!_formKey.currentState!.validate()) {
      ToastUtils.showSimpleSnackBar('请先完善各个步骤的信息', context);
      return;
    }

    // 标记为正在处理
    setState(() {
      _processing = true;
    });

    try {
      dynamic response = await _baseApi.findPassword(
        _usernameController.text,
        _passwordController.text,
        _repeatPasswordController.text,
        _verifyToken!,
        _verifyCodeController.text,);

      if (response is Response) {
        // 找回密码成功后继续登陆
        if (response.statusCode == 200) {
          ToastUtils.showSimpleSnackBar('密码找回成功，正在为您登陆', context);
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
          // 找回密码失败，通知用户错误信息
          ApiResult<String> apiResult =
              ApiResult<String>.fromJson(response.data);
          String errorMsg = apiResult.message ?? '密码找回失败，请检查输入信息';

          // 此时的错误信息数据必须让用户知晓，需要用 Dialog，
          // 什么时候用 Dialog、Banner、Snackbar 参见 https://material.io/components/dialogs#usage
          AlertDialog dialog = AlertDialog(
            title: Text('密码找回失败'),
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

  /// 校验确认密码
  String? _validateRepeatPassword(String? repeatPass) {
    if (StringUtils.isNullOrEmpty(repeatPass)) {
      return '请输入确认密码';
    } else if (repeatPass != _passwordController.text) {
      return '新密码两次输入值不一样';
    }
    return null;
  }


}