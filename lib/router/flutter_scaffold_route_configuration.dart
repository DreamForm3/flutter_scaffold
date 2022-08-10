import 'package:equatable/equatable.dart';

class FlutterScaffoldRouteConfiguration extends Equatable {
  /// 路由的名字，同时也作为web中页面的URL，例如/login
  String name;
  // 是否要清空已有的路由栈
  bool clearRouteStack = false;
  /// 路由的参数
  Map<String, dynamic>? params;

  FlutterScaffoldRouteConfiguration(this.name, {this.clearRouteStack = false, this.params});

  @override
  List<Object?> get props => [name, params];
}