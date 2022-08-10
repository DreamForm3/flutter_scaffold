
import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scaffold/router/flutter_scaffold_route_configuration.dart';
import 'package:flutter_scaffold/router/screen_mapping.dart';
import 'package:flutter_scaffold/storage/local_storage.dart';
import 'package:flutter_scaffold/utils/const_values.dart';

/// 路由代理，所有的路由逻辑在这里实现
class FlutterScaffoldRouterDelegate extends RouterDelegate<FlutterScaffoldRouteConfiguration>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<FlutterScaffoldRouteConfiguration> {

  /// 本地存储
  LocalStorage? _storage;
  /// 初始化状态，处于初始化状态时，只会显示splash页面
  bool _initializing;
  /// 收到的初始化路由
  FlutterScaffoldRouteConfiguration? _initialRoute;

  /// 路由栈
  final _routeStack = <FlutterScaffoldRouteConfiguration>[];


  FlutterScaffoldRouterDelegate() : _initializing = true {
    _init();
  }

  /// 页面组件可以通过 FlutterScaffoldRouterDelegate.of(context) 来获取 RouterDelegate 对象
  static FlutterScaffoldRouterDelegate of(BuildContext context) {
    final delegate = Router.of(context).routerDelegate;
    assert(delegate is FlutterScaffoldRouterDelegate, 'Delegate type must match');
    return delegate as FlutterScaffoldRouterDelegate;
  }

  /// 初始化方法
  _init() async {
    // 初始化本地存储
    _storage = await LocalStorage.getInstance();
    assert(_storage != null);
    _initializing = false;
    // 初始化后清空路由栈，然后去系统给的初始化页面或者主页
    FlutterScaffoldRouteConfiguration target = (_initialRoute == null || _initialRoute!.name == '/splash')
        ? FlutterScaffoldRouteConfiguration('/home')
        : _initialRoute!;
    FlutterScaffoldRouteConfiguration? last = _routeStack.isNotEmpty ? _routeStack.last : null;
    // 需要去的页面和当前路由栈不同时去往目标页面
    if (target != last) {
      _routeStack.clear();
      setNewRoutePath(target);
      notifyListeners();
    }
  }

  /// 获取当前的路由栈
  List<FlutterScaffoldRouteConfiguration> get routeStack => List.unmodifiable(_routeStack);

  /// 重设整个路由栈
  set routeStack(List<FlutterScaffoldRouteConfiguration> stack) {
    _routeStack.clear();
    _routeStack.addAll(stack);
    notifyListeners();
  }

  /// 压入一个新的路由
  void push(FlutterScaffoldRouteConfiguration newRoute) {
    _routeStack.add(newRoute);
    notifyListeners();
  }

  /// 弹出最后一个路由
  FlutterScaffoldRouteConfiguration? pop() {
    FlutterScaffoldRouteConfiguration? configuration;
    if (_routeStack.isNotEmpty) {
      configuration = _routeStack.removeLast();
    }
    notifyListeners();
    return configuration;
  }

  /// 移除某个路由
  void remove(FlutterScaffoldRouteConfiguration route) {
    _routeStack.remove(route);
    notifyListeners();
  }

  @override
  Future<void> setNewRoutePath(FlutterScaffoldRouteConfiguration configuration) {
    // 校验页面权限
    if (ScreenMapping.allRoutes[configuration.name]!.needLogin) {
      // App 处于初始化状态时，如果新的路由是需要登陆的，则先显示 /splash 启动页面
      if (_initializing) {
        print('路由初始化中，收到路由：' + configuration.name);
        configuration.name = '/splash';
      } else {
        bool needLogin = false;
        // 检查 token
        String? userToken = _storage!.getString(ConstValues.USER_AUTH_TOKEN);
        if (StringUtils.isNullOrEmpty(userToken)) {
          needLogin = true;
        }

        if (needLogin) {
          // 需要登陆，清空路由栈
          _routeStack.clear();
          configuration.name = '/login';
        }
      }
    }

    // 路由栈为空或者新的路由和上一次的不同才压入路由栈
    if (_routeStack.isEmpty || _routeStack.last != configuration) {
      // 如果路由栈里最后一个路由的URL和新的一致，只是参数不同的话，需要先把最后一个拿掉
      if (_routeStack.isNotEmpty && _routeStack.last.name == configuration.name) {
        _routeStack.removeLast();
      }
      // 系统调用 setNewRoutePath 后会再调用 build 方法，因此这里不需要调用 notifyListeners 来通知路由 rebuild
      _routeStack.add(configuration);
    }

    return SynchronousFuture<void>(null);
  }

  @override
  Future<void> setInitialRoutePath(FlutterScaffoldRouteConfiguration configuration) {
    // 记录系统给的初始化路由
    _initialRoute = configuration;
    return setNewRoutePath(configuration);
  }

  @override
  Future<bool> popRoute() {
    print('Pop Route');
    return super.popRoute();
  }

  bool _onPopPage(Route<dynamic> route, dynamic result) {
    if (!route.didPop(result)) {
      return false;
    }
    pop();
    return true;
  }

  /// 根据路由栈创建 Navigator 的 pages
  List<Page> _buildPageList() {
    List<FlutterScaffoldRouteConfiguration> _stackToBuild =
        _routeStack.isNotEmpty
            ? _routeStack
            : [FlutterScaffoldRouteConfiguration('/splash')];

    List<Page> pageList = <Page>[];
    for (FlutterScaffoldRouteConfiguration configuration in _stackToBuild) {
      pageList.add(MaterialPage<FlutterScaffoldRouteConfiguration>(
          child: ScreenMapping.getScreen(configuration),
          key: ValueKey(configuration.name),
          arguments: configuration.params));
    }

    return pageList;
  }

  @override
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: _buildPageList(),
      onPopPage: _onPopPage,
    );
  }

  @override
  FlutterScaffoldRouteConfiguration? get currentConfiguration {
    // 当前的路由就是路由栈的最后一个
    return _routeStack.isEmpty ? null : _routeStack.last;
  }

}

