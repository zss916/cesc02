import 'package:cesc01/core/helper/userData/user_helper.dart';
import 'package:cesc01/routes/index.dart';
import 'package:flutter/material.dart';

import 'route_guard.dart';

/// 登录态导航拦截能力
///
/// 受保护页面通过 GetX Middleware 自动校验全局用户状态。
///
/// 认证路由守卫
///
/// 拦截需要登录态的页面，未登录时重定向到登录页。
class AuthGuard extends RouteGuard {
  /// 创建认证路由守卫
  AuthGuard();

  @override
  RouteSettings? redirect(String? route) {
    final isLoggedIn = UserHelper.instance.isLoginIn;
    if (!isLoggedIn) {
      return const RouteSettings(name: ARoute.login);
    }
    return null;
  }
}
