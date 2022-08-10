import 'package:basic_utils/basic_utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scaffold/api/base_api.dart';
import 'package:flutter_scaffold/components/indicator_button.dart';
import 'package:flutter_scaffold/models/dtos/api_result.dart';
import 'package:flutter_scaffold/router/flutter_scaffold_route_configuration.dart';
import 'package:flutter_scaffold/router/flutter_scaffold_router_delegate.dart';
import 'package:flutter_scaffold/utils/extend_string_utils.dart';
import 'package:flutter_scaffold/utils/toast_utils.dart';

/// 校验邮箱页面
class VerifyEmailAddressSrceen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _VerifyEmailAddressState();
}

class _VerifyEmailAddressState extends State<VerifyEmailAddressSrceen> {
  final TextEditingController _emailController = TextEditingController();

  late BaseApi _baseApi;

  // 校验邮箱处理状态
  bool _verifying = false;
  // 邮箱是否合法
  bool _emailVerified = false;

  String? _verifyToken;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    _baseApi = BaseApi.instance;
  }

  @override
  void dispose() {
    _emailController.dispose();
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
                  'STEP1  校验邮箱',
                  style: Theme.of(context).textTheme.headline5,
                ),

              ],
            ),
            SizedBox(height: 120.0),
            TextFormField(
              readOnly: _emailVerified,
              controller: _emailController,
              validator: _validateEmail,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                icon: Icon(Icons.email),
                labelText: '邮箱',
                suffixIcon: _emailVerified ? Icon(Icons.verified) : null
              ),
            ),
            // spacer
            SizedBox(height: 12.0),
            _emailVerified
                ? ElevatedButton(
                    child: Text('继续'),
                    onPressed: () {
                      _emailVerifySuccess(context);
                    },
                  )
                : ButtonBar(
                    children: <Widget>[
                      OutlinedButton(
                        child: Text('Clear'),
                        onPressed: _verifying ? null : () {
                          _emailController.clear();
                        },
                      ),
                      IndicatorButton('校验', _verifying, onPressed: _verifyEmailAddress),
                    ],
                  ),
            SizedBox(height: 12.0),
          ],
        ),
      )),
    );
  }

  /// 校验邮箱方法
  void _verifyEmailAddress(BuildContext context) async {
    if (!_formKey.currentState!.validate()) {
       return;
    }

    // 标记为正在校验邮箱
    setState(() {
      _verifying = true;
    });

    try {
      dynamic response =
          await _baseApi.getVerificationCode(_emailController.text);
      // 校验邮箱成功，跳转到首页
      if (response is Response) {
        ApiResult apiResult =
            ApiResult.fromJson(response.data);
        if (response.statusCode == 200) {
          _verifyToken = apiResult.data['verifyToken'];
          _emailVerified = true;
          String msg = '邮箱校验成功，验证码已发送到邮箱，请继续';
          ToastUtils.showSimpleSnackBar(msg, context);
        } else {
          AlertDialog dialog = AlertDialog(
            title: Text(apiResult.message ?? '邮箱校验失败'),
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
        }
      }
    } catch (e) {
      ToastUtils.showSimpleSnackBar('oops 什么东西不对劲', context);
      print(e);
    }

    // 取消正在校验邮箱标记
    setState(() {
      _verifying = false;
    });
  }

  String? _validateEmail(String? email) {
    if (StringUtils.isNullOrEmpty(email)) {
      return '请输入邮箱';
    } else if (!ExtendStringUtils.isEmail(email!)) {
      return '邮箱格式不正确';
    }
    return null;
  }


  void _emailVerifySuccess(BuildContext context) {
    FlutterScaffoldRouterDelegate delegate = FlutterScaffoldRouterDelegate.of(context);
    Map<String, dynamic> params = {
      'email': _emailController.text,
      'verifyToken': _verifyToken
    };
    // 校验邮箱成功后跳转到注册页面
    delegate.push(FlutterScaffoldRouteConfiguration('/register', params: params));
  }
}