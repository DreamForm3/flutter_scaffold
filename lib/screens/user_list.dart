import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scaffold/api/base_api.dart';
import 'package:flutter_scaffold/models/dtos/paging.dart';
import 'package:flutter_scaffold/models/dtos/api_result.dart';
import 'package:flutter_scaffold/models/dtos/sys_user_query_vo.dart';
import 'package:flutter_scaffold/models/dtos/user_msg_query_vo.dart';
import 'package:flutter_scaffold/storage/local_storage.dart';
import 'package:flutter_scaffold/utils/const_values.dart';
import 'package:flutter_scaffold/utils/toast_utils.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/// 用户列表页面
class UserListScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _UserListState();
}

class _UserListState extends State<UserListScreen> {
  // 网络请求封装
  late BaseApi _baseApi;

  // 本地存储
  late LocalStorage _storage;

  // 是否正在初始化数据
  bool _processing = false;

  // 网络图片 http header
  Map<String, String>? _imageHttpHeaders;

  // 当前页码
  int _currentPage = 1;

  // 总页数
  int _totalPage = 0;

  // 每页数量
  int _pageSize = 10;

  // 用户数据
  List<SysUserQueryVo> _userDataList = [];

  @override
  void initState() {
    super.initState();
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

    _fetchUserData(true);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  List<String> items = ["1", "2", "3", "4", "5", "6", "7", "8"];
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // 请求后台获取数据

    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    items.add((items.length + 1).toString());
    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }

  // 请求后台数据
  void _fetchUserData(bool append) async {

    try {
      // 获取当前登陆用户的详情
      dynamic response = await _baseApi.getUserMsgPageList(context: context);
      if (response is Response && response.statusCode == 200) {
        Map<String, dynamic> responseData = response.data;
        ApiResult<Paging<UserMsgQueryVo>> paging = ApiResult.fromJson(responseData);

      } else {
        ToastUtils.showSimpleSnackBar('获取个人信息失败', context);
      }
    } catch (e) {
      ToastUtils.showSimpleSnackBar('oops 什么东西不对劲', context);
      print(e);
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text('用户列表'),
      ),
      body: SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        header: MaterialClassicHeader(),
        footer: CustomFooter(
          builder: (BuildContext context, LoadStatus? mode) {
            Widget body;
            if (mode == LoadStatus.idle) {
              body = Text("pull up load");
            } else if (mode == LoadStatus.loading) {
              body = CircularProgressIndicator();
            } else if (mode == LoadStatus.failed) {
              body = Text("Load Failed!Click retry!");
            } else if (mode == LoadStatus.canLoading) {
              body = Text("release to load more");
            } else {
              body = Text("No more Data");
            }
            return Container(
              height: 55.0,
              child: Center(child: body),
            );
          },
        ),
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: ListView.builder(
          itemBuilder: (c, i) => Card(child: Center(child: Text(items[i]))),
          itemExtent: 100.0,
          itemCount: items.length,
        ),
      ),
    );
  }
}
