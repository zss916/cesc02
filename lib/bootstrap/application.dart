import 'dart:async';

import 'package:cesc01/bootstrap/app_initializer.dart';
import 'package:cesc01/bootstrap/network_initializer.dart';
import 'package:cesc01/bootstrap/service_initializer.dart';
import 'package:cesc01/bootstrap/storage_initializer.dart';
import 'package:cesc01/bootstrap/system_ui_initializer.dart';
import 'package:cesc01/bootstrap/totast_initializer.dart';
import 'package:flutter/material.dart';

/// 应用全局入口配置
///
/// 负责聚合所有 [AppInitializer] 并按顺序执行，避免初始化逻辑集中在本类中
class Application {
  Application._();

  /*
  /// 主题 - 使用响应式变量
  static final Rx<TDThemeData> themeData = TDThemeData.defaultData().obs;

  /// 主题模式 - 默认跟随系统
  static final Rx<ThemeMode> themeMode = ThemeMode.system.obs;

  /// 主题颜色名称 - 默认主题
  static final RxString themeColorName = 'theme'.obs;

  /// 应用语言 - 默认简体中文
  static final Rx<Locale> locale = const Locale('zh', 'CN').obs;
*/

  /// 初始化器列表，按顺序执行
  ///
  /// 测试时可替换为 mock 实现
  static List<AppInitializer> initializers = [
    SystemUiInitializer(),
    ServiceInitializer(),
    NetworkInitializer(),
    ToastInitializer(),
    StorageInitializer(),
    //ThemeInitializer(),
  ];

  /// 页面初始化
  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    for (final initializer in initializers) {
      await initializer.init();
    }
  }
}
