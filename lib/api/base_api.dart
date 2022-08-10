import 'dart:convert'; // for the utf8.encode method
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scaffold/app_config.dart';
import 'package:flutter_scaffold/models/dtos/api_result.dart';
import 'package:flutter_scaffold/models/dtos/login_sysuser_vo.dart';
import 'package:flutter_scaffold/models/dtos/paging.dart';
import 'package:flutter_scaffold/models/dtos/find_password_param.dart';
import 'package:flutter_scaffold/models/dtos/login_param.dart';
import 'package:flutter_scaffold/models/dtos/login_sysuser_token_vo.dart';
import 'package:flutter_scaffold/models/dtos/sys_user.dart';
import 'package:flutter_scaffold/models/dtos/sys_user_query_vo.dart';
import 'package:flutter_scaffold/models/dtos/sys_user_register_vo.dart';
import 'package:flutter_scaffold/models/dtos/update_password_param.dart';
import 'package:flutter_scaffold/models/dtos/user_msg_query_vo.dart';
import 'package:flutter_scaffold/models/dtos/verification_code_param.dart';
import 'package:flutter_scaffold/models/dtos/user_page_param.dart';
import 'package:flutter_scaffold/models/enums/http_method.dart';
import 'package:flutter_scaffold/router/flutter_scaffold_route_configuration.dart';
import 'package:flutter_scaffold/router/flutter_scaffold_router_delegate.dart';
import 'package:flutter_scaffold/storage/local_storage.dart';
import 'package:flutter_scaffold/utils/const_values.dart';
import 'package:flutter_scaffold/utils/crypto_utils.dart';
import 'package:flutter_scaffold/utils/toast_utils.dart';
import 'package:image_picker/image_picker.dart';

/// 基础网络请求封装
class BaseApi {

  // 后端服务 URL，从 Android 模拟器访问 PC 本地地址时，需要使用 10.0.2.2
  static final String _baseURL =
      (!kIsWeb && Platform.isAndroid && AppConfig.baseURL.contains('localhost'))
          ? AppConfig.baseURL.replaceFirst('localhost', '10.0.2.2')
          : AppConfig.baseURL;

  static get baseURL => _baseURL;

  static String getImageURL(String imagePath) {
    return _baseURL + imagePath;
  }

  late Dio _dio;
  late LocalStorage _storage;
  late FlutterScaffoldRouterDelegate _routerDelegate;


  // Must be top-level function
  _parseAndDecode(String response) {
    return jsonDecode(response);
  }

  parseJson(String text) {
    return compute(_parseAndDecode, text);
  }

  // 私有化构造方法、单例
  BaseApi._() {
    _dio = new Dio(BaseOptions(baseUrl: _baseURL));
    // (_dio.transformer as DefaultTransformer).jsonDecodeCallback = parseJson;
    // _dio.transformer = FlutterTransformer();
  }
  static final BaseApi _instance = BaseApi._();
  static BaseApi get instance => _instance;

  /// 初始化方法
  initInterceptors(LocalStorage localStorage, FlutterScaffoldRouterDelegate flutterScaffoldRouterDelegate) async {
    // 初始化本地存储和路由代理
    _storage = localStorage;
    _routerDelegate = flutterScaffoldRouterDelegate;
    // 设置拦截器
    _dio.interceptors.add(InterceptorsWrapper(
        onRequest:(options, handler){
          // 设置 token
          String? userToken = _storage.getString(ConstValues.USER_AUTH_TOKEN);
          if (userToken != null) {
            options.headers['token'] = userToken;
          }

          // Do something before request is sent
          return handler.next(options); //continue
          // If you want to resolve the request with some custom data，
          // you can resolve a `Response` object eg: return `dio.resolve(response)`.
          // If you want to reject the request with a error message,
          // you can reject a `DioError` object eg: return `dio.reject(dioError)`
        },
        onResponse:(response,handler) {
          _checkLoginStatus(response);
          // Do something with response data
          return handler.next(response); // continue
          // If you want to reject the request with a error message,
          // you can reject a `DioError` object eg: return `dio.reject(dioError)`
        },
        onError: (DioError e, handler) {
          // Do something with response error
          return  handler.next(e);//continue
          // If you want to resolve the request with some custom data，
          // you can resolve a `Response` object eg: return `dio.resolve(response)`.
        }
    ));
  }



  /// 基础网络请求方法
  ///
  /// [method] 必须参数，值只能是枚举[HttpMethod]中的值
  ///
  /// [path] 请求的路径，相对路径，比如/book
  ///
  /// [pathVariables] 是路径变量，传入String数组，比如传入List 'articles','121'则代表路径变量是/articles/121，请求路径是/book，最终会拼接成/book/articles/121
  ///
  /// [data] 传输到后端的RequestBody对象
  ///
  /// [options] 是[Dio]的[Options]
  ///
  /// [context] 是[BuildContext]如果传入可以在网络请求错误时显示通知
  Future<dynamic> baseRequest<T>(
    HttpMethod method,
    String path, {
    List<String>? pathVariables,
    Map<String, dynamic>? queryParameters,
    dynamic? data,
    Options? options,
    BuildContext? context,
  }) async {
    // 如果有路径变量，要把路径变量拼接在path后面
    if (pathVariables != null && pathVariables.isNotEmpty) {
      if (!path.endsWith('/')) {
        path += '/';
      }
      path += pathVariables.join('/');
    }
    try {
      final Response response = await _dio.request(
            path,
            data: data,
            options: _checkOptions(getHttpMethodName(method), options),
            queryParameters: queryParameters,
          );

      return response;
    } catch (e) {
      bool showToast = false;
      if (e is DioError) {
        switch (e.type) {
          case DioErrorType.response:
            _checkLoginStatus(e.response!);
            return e.response;
          case DioErrorType.connectTimeout:
          case DioErrorType.sendTimeout:
          case DioErrorType.receiveTimeout:
            showToast = true;
            break;
          case DioErrorType.other:
            if (e.error is IOException) {
              showToast = true;
            }
            break;
        }

        // 弹出通知
        if (showToast && context != null) {
          ToastUtils.showSimpleSnackBar('oops 网络似乎不给力', context);
        }
      }
      return e;
    }
  }

  Options _checkOptions(method, Options? options) {
    options ??= Options();
    options.method ??= method;
    // 默认 60 秒超时
    options.sendTimeout ??= 60 * 1000;
    return options;
  }

  /// 根据服务器返回的数据检查登陆状态
  void _checkLoginStatus(Response response) async {
    // 没有登陆，需要重新登陆
    if (response.statusCode == 401) {
      Map<String, dynamic> params = {
        ConstValues.TOKEN_TIMEOUT: true,
        ConstValues.RESTORE_ROUTE_STACK: _routerDelegate.routeStack
      };
      _routerDelegate.routeStack = [FlutterScaffoldRouteConfiguration('/login', params: params)];
    }
    // 后台服务要求刷新 token
    else if (response.statusCode == 460 && response.headers['token'] != null) {
      String newToken = response.headers['token']!.first;
      _storage.setString(ConstValues.USER_AUTH_TOKEN, newToken);
    }
  }

  /// 登陆方法
  Future<dynamic> login(
    String username,
    String password, {
    BuildContext? context,
  }) async {
    // 原始密码明文：123456
    // 原始密码前端加密：sha256(123456)
    Digest digest = sha256.convert(utf8.encode(password));
    String encryptPassword = digest.toString();
    LoginParam param = LoginParam(username: username, password: encryptPassword);
    dynamic response = await baseRequest<ApiResult<LoginSysUserTokenVo>>(
        HttpMethod.POST, '/login',
        data: param,
        context: context);
    // token 记录到本地存储里面
    if (response is Response && response.statusCode == 200) {
      ApiResult<LoginSysUserTokenVo> apiResult = ApiResult<LoginSysUserTokenVo>.fromJson(response.data);
      _storage.setString(ConstValues.USER_AUTH_TOKEN, apiResult.data!.token!);
      _storage.setObject(ConstValues.LOGIN_USER, apiResult.data!.loginSysUserVo);
    }
    return response;
  }

  /// 获取验证码
  Future<dynamic> getVerificationCode(
    String email, {
    BuildContext? context,
  }) async {
    Map<String, dynamic> queryParameters = {'email': email};
    dynamic response = await baseRequest<ApiResult<LoginSysUserTokenVo>>(
        HttpMethod.GET, '/verificationCode/email',
        queryParameters: queryParameters,
        context: context);
    return response;
  }

  /// 根据用户名获取验证码
  Future<dynamic> getVerificationCodeByUsername(
    String username, {
    BuildContext? context,
  }) async {
    Map<String, dynamic> queryParameters = {'username': username};
    dynamic response = await baseRequest<ApiResult<LoginSysUserTokenVo>>(
        HttpMethod.GET, '/verificationCode/username',
        queryParameters: queryParameters, context: context);
    return response;
  }

  /// 用户注册
  Future<dynamic> register(String email, String verifyToken, String verifyCode,
      String username, String password, String nickName, {
        BuildContext? context,
      }) async {
    // 原始密码明文：123456
    // 原始密码前端加密：sha256(123456)
    SysUserRegisterVo registerVo = SysUserRegisterVo(
        verificationCodeParam: VerificationCodeParam(
            verifyToken: verifyToken,
            code: verifyCode,
            receiveClient: email),
        sysUser: SysUser(
            username: username,
            password: CryptoUtils.sha256Encode(password),
            nickname: nickName,
            email: email));
    dynamic response = await baseRequest<ApiResult<String>>(
        HttpMethod.POST, '/register',
        data: registerVo,
        context: context);
    return response;
  }

  /// 获取当前登陆用户的详情
  Future<dynamic> getLoginUserInfo({BuildContext? context,}) async {
    LoginSysUserVo? loginSysUser = _storage.getObject<LoginSysUserVo>(ConstValues.LOGIN_USER);
    dynamic response = await baseRequest<ApiResult<SysUserQueryVo>>(
        HttpMethod.GET, '/sysUsers',
        pathVariables: [loginSysUser!.id.toString()],
        context: context);
    return response;
  }

  /// 更新用户信息
  Future<dynamic> updateUserProfile({
    required SysUserQueryVo newProfile,
    XFile? newAvatarImage,
    BuildContext? context,
  }) async {
    Map<String, dynamic> map = Map<String, dynamic>();
    String rawJson = json.encode(newProfile.toJson());
    map['sysUserBase64Json'] = CryptoUtils.base64Encode(rawJson);
    if (newAvatarImage != null) {
      map['avatarFile'] = await MultipartFile.fromFile(newAvatarImage.path,
          filename: newAvatarImage.name);
    }
    FormData formData = FormData.fromMap(map);
    dynamic response = await baseRequest<ApiResult<SysUserQueryVo>>(
        HttpMethod.PUT, '/sysUsers/updateProfile',
        data: formData, context: context);
    return response;
  }

  /// 修改用户密码
  Future<dynamic> changePassword({
    required int userId,
    required String oldPassword,
    required String newPassword,
    required String repeatPassword,
    BuildContext? context,
  }) async {
    // 发送到后端前先SHA-256加密
    UpdatePasswordParam updatePasswordParam = UpdatePasswordParam(
      userId: userId,
      oldPassword: CryptoUtils.sha256Encode(oldPassword),
      newPassword: CryptoUtils.sha256Encode(newPassword),
      confirmPassword: CryptoUtils.sha256Encode(repeatPassword),
    );

    dynamic response = await baseRequest<ApiResult<bool>>(
        HttpMethod.POST, '/sysUsers/updatePassword',
        data: updatePasswordParam, context: context);
    return response;
  }

  /// Logout
  Future<dynamic> logout({BuildContext? context}) async {
    dynamic response = await baseRequest<ApiResult<String>>(
        HttpMethod.POST, '/logout',
        context: context);
    return response;
  }

  /// 找回密码
  Future<dynamic> findPassword(
    String username,
    String newPassword,
    String repeatPassword,
    String verifyToken,
    String code, {
    BuildContext? context,
  }) async {
    // 发送到后端前先SHA-256加密
    FindPasswordParam findPasswordParam = FindPasswordParam(
      username: username,
      newPassword: CryptoUtils.sha256Encode(newPassword),
      confirmPassword: CryptoUtils.sha256Encode(repeatPassword),
      verifyToken: verifyToken,
      code: code,
    );

    dynamic response = await baseRequest<ApiResult<bool>>(
        HttpMethod.POST, '/findPassword',
        data: findPasswordParam,
        context: context);
    return response;
  }

  /// 获取系统用户分页列表
  Future<dynamic> getSysUserPageList({
    UserPageParam? userPageParam,
    BuildContext? context,
  }) async {
    dynamic response = await baseRequest<ApiResult<Paging<SysUserQueryVo>>>(
        HttpMethod.GET, '/sysUsers',
        queryParameters: userPageParam?.toJson(),
        context: context);
    return response;
  }

  /// 获取用户消息分页列表
  Future<dynamic> getUserMsgPageList({BuildContext? context,}) async {
    dynamic response = await baseRequest<ApiResult<Paging<UserMsgQueryVo>>>(
        HttpMethod.GET, '/userMsgs',
        data: null,
        context: context);
    return response;
  }

  /// 获取用户消息详情
  Future<dynamic> getUserMsgDetail(int msgId, {BuildContext? context,}) async {

    dynamic response = await baseRequest<ApiResult<UserMsgQueryVo>>(
        HttpMethod.GET, '/userMsgs',
        pathVariables: [msgId.toString()],
        context: context);
    return response;
  }

}