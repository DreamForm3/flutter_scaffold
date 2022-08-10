import 'package:flutter/material.dart';
import 'package:flutter_scaffold/router/flutter_scaffold_route_configuration.dart';
import 'package:flutter_scaffold/router/flutter_scaffold_router_delegate.dart';

/// 嵌套路由（二级底部导航栏）页面
class NestedRouteScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NestedRouteState();
}

class _NestedRouteState extends State<NestedRouteScreen> {
  // 折叠面板状态
  bool _panelState = false;

  final List<String> _secondaryRoutes = ['/daily', '/monthly', '/annual'];
  final List<String> _screenNames = ['日报', '月报', '年报'];

  late final int _currentIndex;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _currentIndex = _getRouteIndex(context);
  }

  @override
  void dispose() {
    super.dispose();
  }

  int _getRouteIndex(BuildContext context) {
    // FlutterScaffoldRouterDelegate delegate = FlutterScaffoldRouterDelegate.of(context);
    // FlutterScaffoldRouteConfiguration? configuration = delegate.currentConfiguration;
    // String currentPath = configuration?.name;
    int index = 0;
    FlutterScaffoldRouterDelegate delegate =
        FlutterScaffoldRouterDelegate.of(context);
    if (delegate != null) {
      FlutterScaffoldRouteConfiguration? currentRoute =
          delegate.currentConfiguration;
      if (currentRoute != null) {
        String secondaryPath =
            currentRoute.name.substring(currentRoute.name.lastIndexOf('/'));
        index = _secondaryRoutes.indexOf(secondaryPath);
      }
    }

    return index > 0 ? index : 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(0xff, 0xff, 0x8a, 0x65),
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(_screenNames[_currentIndex]),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
            child: Column(
          children: [
            ExpansionPanelList(
              // 主折叠面板折叠状态的回调
              expansionCallback: (int panelIndex, bool isExpanded) {
                setState(() {
                  _panelState = !_panelState;
                });
              },
              elevation: 0,
              children: <ExpansionPanel>[
                ExpansionPanel(
                  backgroundColor: Color.fromARGB(0xFF, 0xFA, 0xFA, 0xFA),
                  headerBuilder: (BuildContext context, bool isExpanded) {
                    return ListTile(title: Text('芦村污水厂'));
                  },
                  body: Padding(
                      padding: EdgeInsets.fromLTRB(32, 0, 0, 0),
                      child: Column(
                        children: [
                          Divider(),
                          ListTile(
                              title: Text('芦村一二三期'),
                              trailing: Icon(Icons.chevron_right),
                              onTap: () {
                                _gotoChartsScreen(context);
                              }),
                          Divider(),
                          ListTile(
                              title: Text('芦村四期'),
                              trailing: Icon(Icons.chevron_right),
                              onTap: () {
                                _gotoChartsScreen(context);
                              }),
                          Divider(),
                          ListTile(
                              title: Text('芦村全厂'),
                              trailing: Icon(Icons.chevron_right),
                              onTap: () {
                                _gotoChartsScreen(context);
                              }),
                        ],
                      )),
                  canTapOnHeader: true,
                  isExpanded: _panelState,
                ),
              ],
            ),
            Divider(),
            ListTile(
                title: Text('太湖污水厂'),
                trailing: Icon(Icons.chevron_right),
                onTap: () {
                  FlutterScaffoldRouterDelegate delegate =
                  FlutterScaffoldRouterDelegate.of(context);
                  // 转到折叠面板页面
                  delegate.push(FlutterScaffoldRouteConfiguration('/charts3'));
                }),
            Divider(),
            ListTile(
                title: Text('城北污水厂'),
                trailing: Icon(Icons.chevron_right),
                onTap: () {
                  FlutterScaffoldRouterDelegate delegate =
                  FlutterScaffoldRouterDelegate.of(context);
                  // 转到折叠面板页面
                  delegate.push(FlutterScaffoldRouteConfiguration('/charts2'));
                }),
            Divider(),
          ],
        )),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Color.fromARGB(0xFF, 0xC1, 0x4D, 0x20),
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.today),
            label: '日报',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.date_range),
            label: '月报',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.event_note),
            label: '年报',
          ),
        ],
        currentIndex: _currentIndex,
        onTap: (index) {
          // 选择不同时才执行，切换时把最后一个路由弹出，换上新的
          if (index != _currentIndex) {
            FlutterScaffoldRouterDelegate delegate =
                FlutterScaffoldRouterDelegate.of(context);
            List<FlutterScaffoldRouteConfiguration> stack =
                delegate.routeStack.sublist(0, delegate.routeStack.length - 1);
            stack.add(FlutterScaffoldRouteConfiguration(
                "/nestedRoute" + _secondaryRoutes[index]));
            delegate.routeStack = stack;
          }
        },
      ),
    );
  }

  void _gotoChartsScreen(BuildContext context) {
    FlutterScaffoldRouterDelegate delegate =
        FlutterScaffoldRouterDelegate.of(context);
    // 转到折叠面板页面
    delegate.push(FlutterScaffoldRouteConfiguration('/charts'));
  }
}
