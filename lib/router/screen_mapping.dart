import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_scaffold/screens/card_list_screen.dart';
import 'package:flutter_scaffold/screens/charts_screen.dart';
import 'package:flutter_scaffold/screens/charts_screen2.dart';
import 'package:flutter_scaffold/screens/charts_screen3.dart';
import 'package:flutter_scaffold/screens/expansion_panel_list_screen.dart';
import 'package:flutter_scaffold/screens/forgot_password.dart';
import 'package:flutter_scaffold/screens/home.dart';
import 'package:flutter_scaffold/screens/login.dart';
import 'package:flutter_scaffold/screens/nested_route.dart';
import 'package:flutter_scaffold/screens/personal_center.dart';
import 'package:flutter_scaffold/screens/register.dart';
import 'package:flutter_scaffold/screens/splash.dart';
import 'package:flutter_scaffold/screens/tab_bar_screen.dart';
import 'package:flutter_scaffold/screens/unknown.dart';
import 'package:flutter_scaffold/screens/user_list.dart';
import 'package:flutter_scaffold/screens/verify_email_address.dart';

import 'flutter_scaffold_route_configuration.dart';

/// 所有页面的路由映射
class ScreenMapping {
  /// 所有页面和 URL 的映射
  static final Map<String, ScreenPermissionWrapper> _allRoutes =
      UnmodifiableMapView({
    '/splash': ScreenPermissionWrapper(SplashScreen(), false),
    '/home': ScreenPermissionWrapper(HomeScreen(), true),
    '/login': ScreenPermissionWrapper(LoginSrceen(), false),
    '/verifyEmail': ScreenPermissionWrapper(VerifyEmailAddressSrceen(), false),
    '/register': ScreenPermissionWrapper(RegisterSrceen(), false),
    '/personalCenter': ScreenPermissionWrapper(PersonalCenterScreen(), false),
    '/forgotPassword': ScreenPermissionWrapper(ForgotPasswordSrceen(), false),
    '/expansionPanelList': ScreenPermissionWrapper(ExpansionPanelListScreen(), false),
    '/users': ScreenPermissionWrapper(CardListScreen(), false),
    '/tabBar': ScreenPermissionWrapper(TabBarScreen(), false),
    '/charts': ScreenPermissionWrapper(ChartsScreen(), false),
    '/charts2': ScreenPermissionWrapper(ChartsScreen2(), false),
    '/charts3': ScreenPermissionWrapper(ChartsScreen3(), false),

    '/nestedRoute/daily': ScreenPermissionWrapper(NestedRouteScreen(), false),
    '/nestedRoute/monthly': ScreenPermissionWrapper(NestedRouteScreen(), false),
    '/nestedRoute/annual': ScreenPermissionWrapper(NestedRouteScreen(), false),



    '/404': ScreenPermissionWrapper(UnknownScreen(), false),
  });

  /// 获取所有页面的路由映射
  static Map<String, ScreenPermissionWrapper> get allRoutes => _allRoutes;

  /// 根据路由获取相应的页面
  static Widget getScreen(FlutterScaffoldRouteConfiguration configuration) {
    if (_allRoutes.containsKey(configuration.name)) {
      return _allRoutes[configuration.name]!.screen;
    } else {
      /// 不存在的映射就返回404页面
      return _allRoutes['/404']!.screen;
    }
  }

  /// 是否是一个合法的路由
  static bool isValidConfiguration(
      FlutterScaffoldRouteConfiguration configuration) {
    return _allRoutes.containsKey(configuration.name);
  }

  /// 获取所有的路由
  static List<String> getAllLocations() {
    List<String> allLocations = _allRoutes.keys.toList();
    allLocations.sort(_sortLocations);
    return allLocations;
  }

  /// 给所有的路由排序，原则是复杂度高的路由排前面，以方便匹配路由
  static int _sortLocations(String a, String b) {
    if (a == b) return 0;
    Uri u_a = Uri.parse(a);
    Uri u_b = Uri.parse(b);
    if (u_a.pathSegments.length == u_b.pathSegments.length) {
      return a.compareTo(b);
    }
    // /分割越多的路由越排前面
    return u_b.pathSegments.length - u_a.pathSegments.length;
  }
}

/// 页面权限封装
class ScreenPermissionWrapper {
  /// 页面
  final Widget screen;
  /// 页面是否需要登陆
  final bool needLogin;
  /// 页面需要的权限
  final String? permission;

  ScreenPermissionWrapper(this.screen, this.needLogin, {this.permission});
}
