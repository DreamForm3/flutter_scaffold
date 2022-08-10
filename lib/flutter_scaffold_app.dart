import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_scaffold/app_config.dart';
import 'package:flutter_scaffold/api/base_api.dart';
import 'package:flutter_scaffold/router/flutter_scaffold_route_information_parser.dart';
import 'package:flutter_scaffold/storage/local_storage.dart';
import 'package:provider/provider.dart';
import 'package:flutter_scaffold/router/flutter_scaffold_router_delegate.dart';
import 'package:layout/layout.dart';

class FlutterScaffoldApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FlutterScaffoldAppState();
}

class _FlutterScaffoldAppState extends State<FlutterScaffoldApp> {
  // 确保初始化 App 的配置
  AppConfig _appConfig = AppConfig.instance;
  late RouteInformationProvider routeInformationProvider;
  late LocalStorage localStorage;
  late FlutterScaffoldRouterDelegate routerDelegate;
  late FlutterScaffoldRouteInformationParser routeInformationParser;
  late BackButtonDispatcher backButtonDispatcher;
  late BaseApi baseApi;

  @override
  void initState() {
    super.initState();

    // 初始路由是 /splash 启动页面
    routeInformationProvider = PlatformRouteInformationProvider(
      initialRouteInformation: const RouteInformation(
        location: '/splash',
      ),
    );
    routerDelegate = FlutterScaffoldRouterDelegate();
    routeInformationParser = FlutterScaffoldRouteInformationParser(routerDelegate);
    backButtonDispatcher = RootBackButtonDispatcher();
    _init();
  }

  void _init() async {
    // 初始化本地存储
    localStorage = await LocalStorage.getInstance();
    baseApi = BaseApi.instance;
    // 初始化网络请求的拦截器
    baseApi.initInterceptors(localStorage, routerDelegate);
  }

  @override
  Widget build(BuildContext context) {
    // return MultiProvider(
    //   providers: [
    //
    //   ],
    //   child: MaterialApp.router(
    //     routerDelegate: routerDelegate,
    //     routeInformationParser: routeInformationParser,
    //   ),
    // );
    return Layout(
      child: MaterialApp.router(
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('zh', 'CH'),
          const Locale('en', 'US'),
        ],
        // locale: const Locale('zh'),
        restorationScopeId: 'app_router',
        // routeInformationProvider: routeInformationProvider,
        routerDelegate: routerDelegate,
        routeInformationParser: routeInformationParser,
        backButtonDispatcher: backButtonDispatcher,
      ),
    );
  }
}