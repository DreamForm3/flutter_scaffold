

/// 应用配置
class AppConfig {
  /// 当前环境
  static const ENV = String.fromEnvironment('ENV', defaultValue: 'test');

  /// 后端服务地址
  static late final String baseURL;

  /// 初始化配置
  AppConfig._() {
    print('当前环境为：' + ENV);
    // 初始化生产环境的配置
    switch(ENV) {
      case 'prod':
        // 生产环境后台
        baseURL = 'https://someURL';
        break;
      case 'test':
        // 测试环境后台
        baseURL = 'https://xxxx.xxxxxx.com/flutterScaffold';
        break;
      case 'dev':
      default:
        // 本地开发环境后台
        baseURL = 'http://localhost:8656/flutterScaffold';
        break;
    }
  }
  static final AppConfig instance = AppConfig._();


}