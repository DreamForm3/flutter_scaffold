import 'package:flutter/material.dart';
import 'package:flutter_scaffold/router/flutter_scaffold_route_configuration.dart';
import 'package:flutter_scaffold/router/flutter_scaffold_router_delegate.dart';

class MainBottomNavigationBar extends StatefulWidget {
  /// 当前选择的 Item
  late final int currentIndex;

  MainBottomNavigationBar(this.currentIndex);

  @override
  State<StatefulWidget> createState() => _MainBottomNavigationBarState();
}

class _MainBottomNavigationBarState extends State<MainBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: const Icon(Icons.home),
          label: '主页',
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.account_circle),
          label: '我的',
        ),
      ],
      currentIndex: widget.currentIndex,
      onTap: (index) {
        // 选择不同时才执行
        if (index != widget.currentIndex) {
          FlutterScaffoldRouterDelegate delegate =
              FlutterScaffoldRouterDelegate.of(context);
          switch (index) {
            case 0:
              delegate.routeStack = [
                FlutterScaffoldRouteConfiguration("/home")
              ];
              break;
            case 1:
              delegate.routeStack = [
                FlutterScaffoldRouteConfiguration("/personalCenter")
              ];
              break;
          }
        }
      },
    );
  }
}
