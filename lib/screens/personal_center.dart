
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scaffold/api/base_api.dart';
import 'package:flutter_scaffold/components/main_bottom_navigation_bar.dart';
import 'package:flutter_scaffold/components/simple_list_item.dart';
import 'package:flutter_scaffold/models/dtos/api_result.dart';
import 'package:flutter_scaffold/models/dtos/sys_user_query_vo.dart';
import 'package:flutter_scaffold/router/flutter_scaffold_route_configuration.dart';
import 'package:flutter_scaffold/router/flutter_scaffold_router_delegate.dart';
import 'package:flutter_scaffold/screens/change_password.dart';
import 'package:flutter_scaffold/screens/modify_user_profile.dart';
import 'package:flutter_scaffold/storage/local_storage.dart';
import 'package:flutter_scaffold/utils/const_values.dart';
import 'package:flutter_scaffold/utils/toast_utils.dart';

class PersonalCenterScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PersonalCenterState();
}

class _PersonalCenterState extends State<PersonalCenterScreen> {
  late BaseApi _baseApi;
  late LocalStorage _storage;
  // 是否正在初始化数据
  late bool _processing;
  Map<String, String>? _imageHttpHeaders;
  SysUserQueryVo? _loginUserInfo;

  // 头像大小
  double avatarWidth = 80.0, avatarHeight = 80.0;
  // 默认头像
  late final Image defaultAvatar;
  // 加载错误图片
  late final Image loadErrorImage;
  // SliverAppBar 背景图片
  late final Image appBarBGImage;



  @override
  void initState() {
    super.initState();
    defaultAvatar = Image.asset(
      'assets/images/baseline_face_black_48dp.png',
      width: avatarWidth,
      height: avatarHeight,
    );
    loadErrorImage = Image.asset(
      'assets/images/outline_broken_image_black_48dp.png',
      width: avatarWidth,
      height: avatarHeight,
    );
    appBarBGImage = Image.asset(
        'assets/images/personal_center_bg.jpg',
        fit: BoxFit.cover);
  }


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _processing = true;
    _init();
  }

  void _init() async {
    // 初始化本地存储
    _storage = await LocalStorage.getInstance();
    _baseApi = BaseApi.instance;
    // 设置 token
    String? userToken = _storage.getString(ConstValues.USER_AUTH_TOKEN);
    if (userToken != null) {
      _imageHttpHeaders = {'token': userToken};
    }
    try {
      // 获取当前登陆用户的详情
      dynamic response = await _baseApi.getLoginUserInfo(context: context);
      if (response is Response && response.statusCode == 200) {
        ApiResult<SysUserQueryVo> apiResult = ApiResult<SysUserQueryVo>.fromJson(response.data);
        _loginUserInfo = apiResult.data;
      } else {
        ToastUtils.showSimpleSnackBar('获取个人信息失败', context);
      }
    } catch (e) {
      ToastUtils.showSimpleSnackBar('oops 什么东西不对劲', context);
      print(e);
    }

    setState(() {
      _processing = false;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            expandedHeight: 160,
            title: Text('个人中心'),
            flexibleSpace: FlexibleSpaceBar(
              background: appBarBGImage,
            ),
            actions: [
              IconButton(
                  onPressed: _processing ? null : _showProfileDialog,
                  icon: Icon(Icons.edit),
                  tooltip: '编辑个人资料'),
              IconButton(
                  onPressed: _processing ? null : _showChangePasswordDialog,
                  icon: Icon(Icons.password),
                  tooltip: '修改密码'),
              IconButton(
                  onPressed: _processing ? null : _showLogoutDialog,
                  icon: Icon(Icons.logout),
                  tooltip: '退出当前账号'),
            ],
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              SimpleListItem(
                thumbnail: ((!_processing &&
                    _loginUserInfo != null &&
                    _loginUserInfo!.avatar != null)
                    ? CachedNetworkImage(
                  fit: BoxFit.cover,
                  width: avatarWidth,
                  height: avatarHeight,
                  placeholder: (context, url) => defaultAvatar,
                  errorWidget: (context, url, error) => loadErrorImage,
                  imageUrl: BaseApi.getImageURL(_loginUserInfo!.avatar!),
                  httpHeaders: _imageHttpHeaders,
                )
                    : defaultAvatar),
                title: (!_processing &&
                    _loginUserInfo != null &&
                    _loginUserInfo!.nickname != null)
                    ? _loginUserInfo!.nickname!
                    : '',
                subtitle: (!_processing &&
                    _loginUserInfo != null &&
                    _loginUserInfo!.remark != null)
                    ? _loginUserInfo!.remark!
                    : '',
              ),
              ListTile(
                leading: Icon(Icons.phone_iphone_outlined),
                title: Text('手机号码'),
                subtitle: Text((!_processing &&
                    _loginUserInfo != null &&
                    _loginUserInfo!.phone != null)
                    ? _loginUserInfo!.phone!
                    : ''),
              ),
              ListTile(
                leading: Icon(Icons.email_outlined),
                title: Text('邮箱'),
                subtitle: Text((!_processing &&
                    _loginUserInfo != null &&
                    _loginUserInfo!.email != null)
                    ? _loginUserInfo!.email!
                    : ''),
              ),
              SizedBox(height: 400),
            ]),
          ),
        ],
      ),

      bottomNavigationBar: MainBottomNavigationBar(1),
    );
  }

  /// 弹出个人信息编辑全屏对话框
  void _showProfileDialog() async {
    SysUserQueryVo? newProfile = await Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) {
          return ModifyUserProfileScreen(
              baseApi: _baseApi,
              storage: _storage,
              imageHttpHeaders: _imageHttpHeaders!,
              loginUserInfo: _loginUserInfo!);
        },
        fullscreenDialog: true));

    if (newProfile != null) {
      // 更新用户资料
      setState(() {
        _loginUserInfo = newProfile;
      });
    }
  }

  /// 弹出修改密码全屏对话框
  void _showChangePasswordDialog() async {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) {
          return ChangePasswordScreen(
              baseApi: _baseApi,
              loginUserInfo: _loginUserInfo!);
        },
        fullscreenDialog: true));

  }

  /// 退出当前账号对话框
  Future<void> _showLogoutDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('退出当前账号？'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('退出当前账号后会回到登陆页面，是否继续？'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('取消'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('确认'),
              onPressed: () {
                _logout(context);
              },
            ),
          ],
        );
      },
    );
  }

  /// 退出登陆
  void _logout(BuildContext context) async {
    // 标记正在处理
    setState(() {
      _processing = true;
    });

    // 调用后端 logout 接口
    try {
      dynamic response = await _baseApi.logout(context: context);
    } catch (e) {
      // 即使后端调用失败也不用提示了
      print(e);
    }
    // 清除本地缓存
    bool status = await _storage.clear();
    // 回到登录页
    FlutterScaffoldRouterDelegate delegate = FlutterScaffoldRouterDelegate.of(context);
    delegate.routeStack = [FlutterScaffoldRouteConfiguration("/login")];

    setState(() {
      _processing = false;
    });
  }
}