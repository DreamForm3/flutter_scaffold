import 'package:flutter/material.dart';
import 'package:flutter_scaffold/router/flutter_scaffold_route_configuration.dart';
import 'package:flutter_scaffold/router/screen_mapping.dart';
import 'package:flutter_scaffold/utils/const_values.dart';

import 'flutter_scaffold_router_delegate.dart';

/// 路由解析，主要任务是把浏览器的 URL 解析成我们需要的 FlutterScaffoldRouteConfiguration
class FlutterScaffoldRouteInformationParser
    extends RouteInformationParser<FlutterScaffoldRouteConfiguration> {
  FlutterScaffoldRouterDelegate routerDelegate;

  FlutterScaffoldRouteInformationParser(this.routerDelegate);

  /// 解析系统给的路由参数
  @override
  Future<FlutterScaffoldRouteConfiguration> parseRouteInformation(
      RouteInformation routeInformation) async {
    if (routeInformation.location == null) {
      // 没能匹配上任何有效路由
      return FlutterScaffoldRouteConfiguration("/404");
    }

    String infoLocation = routeInformation.location ?? '/';

    Uri incomeUri = Uri.parse(infoLocation);
    // 主页
    if (incomeUri.pathSegments.isEmpty ||
        (incomeUri.pathSegments.length == 1 &&
            incomeUri.pathSegments[0] == "/")) {
      return FlutterScaffoldRouteConfiguration("/home");
    }

    // 传入的路由和系统所有的合法路由进行比较
    List<String> locations = ScreenMapping.getAllLocations();
    for (String location in locations) {
      if (infoLocation.startsWith(location)) {
        Uri routeUri = Uri.parse(location);
        // 匹配上了某个路由
        if (routeUri.pathSegments[routeUri.pathSegments.length - 1] ==
            incomeUri.pathSegments[routeUri.pathSegments.length - 1]) {
          FlutterScaffoldRouteConfiguration configuration =
              FlutterScaffoldRouteConfiguration(location);
          Map<String, dynamic> routeParams = {};
          Map<String, String> queryParameters = incomeUri.queryParameters;
          if (queryParameters.isNotEmpty) {
            // URL 的查询参数
            routeParams[ConstValues.QUERY_PARAMETERS] = queryParameters;
          }
          if (incomeUri.pathSegments.length > routeUri.pathSegments.length) {
            // 说明有 PathVariable
            routeParams[ConstValues.PATH_VARIABLES] =
                incomeUri.pathSegments.sublist(routeUri.pathSegments.length);
          }
          if (routeParams.isNotEmpty) {
            configuration.params = routeParams;
          }
          return configuration;
        }
      }
    }

    // 没能匹配上任何有效路由
    return FlutterScaffoldRouteConfiguration("/404");
  }

  /// 把路由信息恢复成 URL
  @override
  RouteInformation restoreRouteInformation(
      FlutterScaffoldRouteConfiguration configuration) {
    // 如果是非法路由返回 /404
    String location = ScreenMapping.isValidConfiguration(configuration)
        ? configuration.name
        : '/404';
    if (configuration.params != null && configuration.params!.isNotEmpty) {
      List<String>? pathVariables = configuration.params![ConstValues.PATH_VARIABLES];
      // 拼接 pathVariables 到 URL 后面
      if (pathVariables != null && pathVariables.isNotEmpty) {
        // URL 最后一个不是 / 就把 / 加在最后
        if (location.lastIndexOf('/') < location.length - 1) {
          location += '/';
        }
        location += pathVariables.join('/');
      }
      Map<String, String>? queryParameters = configuration.params![ConstValues.QUERY_PARAMETERS];
      // 拼接 URL 查询参数
      if (queryParameters != null && queryParameters.isNotEmpty) {
        location += '?';
        for(MapEntry<String, String> entry in queryParameters.entries) {
          location += entry.key + '=' + entry.value + '&';
        }
        // 去掉最后的 & 符号
        location = location.substring(0, location.length -1);
      }
    }
    return RouteInformation(location: location);
  }
}
