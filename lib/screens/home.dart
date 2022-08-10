import 'package:flutter/material.dart';
import 'package:flutter_scaffold/api/base_api.dart';
import 'package:flutter_scaffold/components/grid_tile.dart';
import 'package:flutter_scaffold/components/main_bottom_navigation_bar.dart';
import 'package:flutter_scaffold/router/flutter_scaffold_route_configuration.dart';
import 'package:flutter_scaffold/router/flutter_scaffold_router_delegate.dart';
import 'package:layout/layout.dart';
import 'package:card_swiper/card_swiper.dart';


class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<HomeScreen> {
  late BaseApi _baseApi;

  late List<Image> _swiper_images;

  @override
  void initState() {
    super.initState();
    _swiper_images = [

      Image.asset('assets/images/home_swiper_image_1.jpg', fit: BoxFit.cover),
      Image.asset('assets/images/home_swiper_image_2.jpg', fit: BoxFit.cover),
      Image.asset('assets/images/home_swiper_image_3.jpg', fit: BoxFit.cover),
      Image.asset('assets/images/home_swiper_image_4.jpg', fit: BoxFit.cover),
      Image.asset('assets/images/home_swiper_image_5.jpg', fit: BoxFit.cover),
    ];
    _baseApi = BaseApi.instance;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            expandedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(
              background: FlutterLogo(),
              title: Text('Flutter 脚手架'),
              centerTitle: true,
            ),
            actions: [],
          ),

          // 轮播图区域
          SliverPadding(
            padding: EdgeInsets.symmetric(
                horizontal: context.layout.margin,
                vertical: context.layout.margin),
            sliver: SliverFixedExtentList(
              // 固定宽高比是 16 ：9，需要考虑 padding
              itemExtent:
                  (context.layout.width - context.layout.margin * 2) * 9 / 16 +
                      context.layout.margin * 2,
              delegate: SliverChildListDelegate([
                Swiper(
                  itemBuilder: (BuildContext context, int index) {
                    return _swiper_images[index];
                  },
                  autoplay: true,
                  itemCount: _swiper_images.length,
                  pagination: SwiperPagination(),
                  // control: SwiperControl(),
                ),
              ]),
            ),
          ),

          // 功能区域
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: context.layout.margin, vertical: 0),
            sliver: SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: context.layout.columns,
                    mainAxisSpacing: context.layout.gutter,
                    crossAxisSpacing: context.layout.gutter),
                delegate: SliverChildListDelegate([
                  GridTileButton(
                    icon: Icon(
                      Icons.people_outlined,
                    ),
                    label: Text('用户列表'),
                    tooltip: '查看所有用户',
                    onPressed: () {
                      FlutterScaffoldRouterDelegate delegate = FlutterScaffoldRouterDelegate.of(context);
                      // 转到用户列表页面
                      delegate.push(FlutterScaffoldRouteConfiguration('/users'));
                    },
                  ),

                  GridTileButton(
                    icon: Icon(
                      Icons.people_outlined,
                    ),
                    label: Text('用户列表'),
                    tooltip: '查看所有用户',
                    onPressed: () {},
                  ),
                  GridTileButton(
                    icon: Icon(Icons.people_outlined),
                    label: Text('用户列表'),
                    tooltip: '查看所有用户',
                    onPressed: () {},
                  ),
                  GridTileButton(
                    icon: Icon(Icons.people_outlined),
                    label: Text('用户列表'),
                    tooltip: '查看所有用户',
                    onPressed: () {},
                  ),
                  GridTileButton(
                    icon: Icon(Icons.alt_route_outlined),
                    label: Text('嵌套路由'),
                    tooltip: '查看嵌套路由页面',
                    onPressed: () {
                      FlutterScaffoldRouterDelegate delegate = FlutterScaffoldRouterDelegate.of(context);
                      // 转到嵌套路由页面
                      delegate.push(FlutterScaffoldRouteConfiguration('/nestedRoute/monthly'));
                    },
                  ),
                  GridTileButton(
                    icon: Icon(Icons.table_chart),
                    label: Text('标签页'),
                    tooltip: '查看标签页页面',
                    onPressed: () {
                      FlutterScaffoldRouterDelegate delegate = FlutterScaffoldRouterDelegate.of(context);
                      // 转到折叠面板页面
                      delegate.push(FlutterScaffoldRouteConfiguration('/tabBar'));
                    },
                  ),
                  GridTileButton(
                    icon: Icon(Icons.view_list),
                    label: Text('折叠面板'),
                    tooltip: '查看折叠面板',
                    onPressed: () {
                      FlutterScaffoldRouterDelegate delegate = FlutterScaffoldRouterDelegate.of(context);
                      // 转到折叠面板页面
                      delegate.push(FlutterScaffoldRouteConfiguration('/expansionPanelList'));
                    },
                  ),
                ])),
          ),

          // 新闻公告区域
          SliverPadding(
            padding: EdgeInsets.symmetric(
                horizontal: context.layout.margin,
                vertical: context.layout.margin),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('说明', style: Theme.of(context).textTheme.headline6,),
                  Text('Flutter 脚手架是方便构建 Flutter 应用的基础框架。'
                      '脚手架已经实现了常用的基础框架，例如路由、网络请求、本地存储；'
                      '同样还有基本的页面结构和基础功能，例如主页、个人中心页面；'
                      '登陆、注册、找回密码、修改个人资料等。'
                  )
                ],)
              ]),
            ),
          ),

        ],
      ),
      bottomNavigationBar: MainBottomNavigationBar(0),
    );
  }
}