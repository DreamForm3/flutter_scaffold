import 'package:basic_utils/basic_utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scaffold/api/base_api.dart';
import 'package:flutter_scaffold/components/indicator_button.dart';
import 'package:flutter_scaffold/components/password_field.dart';
import 'package:flutter_scaffold/models/dtos/api_result.dart';
import 'package:flutter_scaffold/models/dtos/login_sysuser_token_vo.dart';
import 'package:flutter_scaffold/models/dtos/login_sysuser_vo.dart';
import 'package:flutter_scaffold/router/flutter_scaffold_route_configuration.dart';
import 'package:flutter_scaffold/router/flutter_scaffold_router_delegate.dart';
import 'package:flutter_scaffold/storage/local_storage.dart';
import 'package:flutter_scaffold/utils/const_values.dart';
import 'package:flutter_scaffold/utils/extend_string_utils.dart';
import 'package:flutter_scaffold/utils/toast_utils.dart';

/// 登陆页
class LoginSrceen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginState();
}

class _LoginState extends State<LoginSrceen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  late BaseApi _baseApi;

  // 登陆处理状态
  bool _logingIn = false;

  List<FlutterScaffoldRouteConfiguration>? restoreRouteStack;

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
    // 是因为 token 超时需要重新登陆的
    if (configuration.params != null
        && configuration.params![ConstValues.TOKEN_TIMEOUT] == true) {
      restoreRouteStack = configuration.params![ConstValues.RESTORE_ROUTE_STACK];
      _fillUsername();
      Future.delayed(Duration.zero, () {
        AlertDialog dialog = AlertDialog(
          title: Text('重新登陆'),
          content: Text('您上次的登陆已过期，请重新登陆'),
          actions: [
            TextButton(
                onPressed: () {
                  // 关闭 AlertDialog
                  Navigator.of(context).pop();
                },
                child: Text('OK'))
          ],
        );
        showDialog(
            context: context,
            builder: (BuildContext context) => dialog);
      });
    }
  }

  /// 填充用户名
  void _fillUsername() async {
    LocalStorage storage = await LocalStorage.getInstance();
    LoginSysUserVo? user = storage.getObject<LoginSysUserVo>(ConstValues.LOGIN_USER);
    if (user != null) {
      _usernameController.text = user.username!;
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
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
            SizedBox(height: 16.0),
            Column(
              children: <Widget>[
                // Image.asset('assets/images/flutter-logo.png'),
                FlutterLogo(size: 240),
                SizedBox(height: 16.0),
                Text(
                  'Flutter Scaffold Login',
                  style: Theme.of(context).textTheme.headline5,
                ),
              ],
            ),
            SizedBox(height: 32.0),
            TextFormField(
              controller: _usernameController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: _getErrorMsg4Username,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                icon: Icon(Icons.person),
                labelText: 'Username',
              ),
            ),
            // spacer
            SizedBox(height: 12.0),

            PasswordField(
              labelText: 'Password',
              controller: _passwordController,
              textInputAction: TextInputAction.done,
              validator: _getErrorMsg4Password,
            ),

            ButtonBar(
              children: <Widget>[
                OutlinedButton(
                  child: Text('Clear'),
                  onPressed: _logingIn ? null : () {
                    _usernameController.clear();
                    _passwordController.clear();
                  },
                ),
                IndicatorButton('Login', _logingIn, onPressed: _login),

              ],
            ),
            SizedBox(height: 12.0),
            Divider(
              height: 20,
              thickness: 1,
              indent: 0,
              endIndent: 0,
            ),
            Row(
              children: <Widget>[
                TextButton(
                  child: Text('Forgot your passwords?'),
                  onPressed: _logingIn
                      ? null
                      : () {
                          FlutterScaffoldRouterDelegate delegate =
                              FlutterScaffoldRouterDelegate.of(context);
                          // 转到找回密码页面
                          delegate.push(FlutterScaffoldRouteConfiguration(
                              '/forgotPassword',
                              params: {'username': _usernameController.text}));
                        },
                ),
                // 把两侧 button 中间的空白位置占满
                Expanded(
                  child: Row(),
                ),
                TextButton(
                  child: Text('Register'),
                  onPressed: _logingIn ? null : () {
                    FlutterScaffoldRouterDelegate delegate = FlutterScaffoldRouterDelegate.of(context);
                    // 转到邮箱校验页面
                    delegate.push(FlutterScaffoldRouteConfiguration('/verifyEmail'));
                  },
                ),
              ],
            ),
          ],
        ),
      )),
    );
  }

  /// 登陆方法
  void _login(BuildContext context) async {
    // 校验用户名、密码
    if (!_formKey.currentState!.validate()) {
      ToastUtils.showSimpleSnackBar('请输入用户名和密码', context);
      return;
    }

      // 标记为正在登陆
      setState(() {
        _logingIn = true;
      });

      try {
        dynamic response = await _baseApi.login(
            _usernameController.text, _passwordController.text,
            context: context);
        // 登陆成功，跳转到首页
        if (response is Response) {
          if (response.statusCode == 200) {
            FlutterScaffoldRouterDelegate delegate = FlutterScaffoldRouterDelegate.of(context);
            // 登陆成功后需要清空整个路由栈然后跳转到主页或者恢复之前的路由栈
            if (restoreRouteStack != null) {
              delegate.routeStack = restoreRouteStack!;
            } else {
              delegate.routeStack = [FlutterScaffoldRouteConfiguration("/home")];
            }
          } else {
            ApiResult<LoginSysUserTokenVo> apiResult =
              ApiResult<LoginSysUserTokenVo>.fromJson(response.data);
            ToastUtils.showSimpleSnackBar(apiResult.message?? '登陆失败，请稍后再试', context);
          }
        }
      } catch (e) {
        ToastUtils.showSimpleSnackBar('oops 什么东西不对劲', context);
        print(e);
      }

      // 取消正在登陆标记
      setState(() {
        _logingIn = false;
      });
  }

  String? _getErrorMsg4Username(String? username) {
    return ExtendStringUtils.isNullOrEmptyOrBlank(username) ? 'Please enter your username' : null;
  }

  String? _getErrorMsg4Password(String? password) {
    return StringUtils.isNullOrEmpty(password) ? 'Please enter your password' : null;
  }
}