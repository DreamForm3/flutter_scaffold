import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scaffold/api/base_api.dart';
import 'package:flutter_scaffold/components/exception_indicators/empty_list_indicator.dart';
import 'package:flutter_scaffold/components/exception_indicators/error_indicator.dart';
import 'package:flutter_scaffold/components/user_profile_card.dart';
import 'package:flutter_scaffold/models/dtos/api_result.dart';
import 'package:flutter_scaffold/models/dtos/sys_user_query_vo.dart';
import 'package:flutter_scaffold/models/dtos/user_page_param.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:flutter_scaffold/models/dtos/paging.dart';

class CardListScreen extends StatefulWidget {


  @override
  State<StatefulWidget> createState()  => _CardListScreenState();
}

class _CardListScreenState extends State<CardListScreen> {

  late BaseApi _baseApi;

  // 分页控制器
  final _pagingController = PagingController<int, SysUserQueryVo>(
    firstPageKey: 1,
  );


  @override
  void initState() {
    super.initState();
    _baseApi = BaseApi.instance;
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }


  // 获取用户列表数据
  _fetchPage(int pageKey) async {
    try {
      final dynamic response = await _baseApi.getSysUserPageList(
          userPageParam: UserPageParam(pageIndex: pageKey));
      if (response is Response && response.statusCode == 200) {
        ApiResult<Paging<SysUserQueryVo>> apiResult =
            ApiResult<Paging<SysUserQueryVo>>.fromJson(response.data);
        Paging<SysUserQueryVo> newPage = apiResult.data!;
        int pageSize = newPage.pageSize?? 10;
        int pageIndex = newPage.pageIndex?? pageKey;
        int total = newPage.total?? 0;

        final isLastPage = pageSize * pageIndex >= total;
        final newItems = newPage.records!;

        if (isLastPage) {
          _pagingController.appendLastPage(newItems);
        } else {
          final nextPageKey = pageKey + 1;
          _pagingController.appendPage(newItems, nextPageKey);
        }
      } else {
        _pagingController.error = '请求错误，请稍后再试';
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('用户列表'), actions: [],),
      body: RefreshIndicator(
        onRefresh: () => Future.sync(
              () => _pagingController.refresh(),
        ),
        child: PagedListView.separated(
          pagingController: _pagingController,
          builderDelegate: PagedChildBuilderDelegate<SysUserQueryVo>(
            itemBuilder: (context, userProfile, index) => UserProfileCard(
              userProfile: userProfile,
            ),
            firstPageErrorIndicatorBuilder: (context) => ErrorIndicator(
              error: _pagingController.error,
              onTryAgain: () => _pagingController.refresh(),
            ),
            noItemsFoundIndicatorBuilder: (context) => EmptyListIndicator(),
          ),
          padding: const EdgeInsets.all(16),
          separatorBuilder: (context, index) => const SizedBox(
            height: 16,
          ),
        ),
      ),
    );
  }

}