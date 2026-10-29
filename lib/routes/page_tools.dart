part of 'index.dart';

class PageTools {
  ///切换语言
  static Future<dynamic>? toLanguage() => Get.toNamed(ARoute.language);

  ///消息
  static Future<dynamic>? toMessage() => Get.toNamed(ARoute.message);

  ///关于
  static Future<dynamic>? toAbout() => Get.toNamed(ARoute.about);

  ///配网
  static Future<dynamic>? toProvision() => Get.toNamed(ARoute.provision);

  ///退出登录
  static Future<dynamic>? toLogout() => Get.offAllNamed(ARoute.login);

  ///主页
  static Future<dynamic>? toMain() => Get.offAllNamed(ARoute.main);

  ///web
  static Future<dynamic>? toWeb({required String url, required String title}) =>
      Get.toNamed(ARoute.web, arguments: {"url": url, "title": title});

  ///版本信息
  static Future<dynamic>? toVersion({required String stackId}) =>
      Get.toNamed(ARoute.version, arguments: {"stackId": stackId});

  ///告警详情
  static Future<dynamic>? toAlarmDetail({
    String? siteId,
    required String stackSn,
    String? status,
    bool? isMessage,
  }) => Get.toNamed(
    ARoute.stackAlarmDetail,
    arguments: {
      "siteId": siteId,
      "stackSn": stackSn,
      "status": status,
      "isMessage": isMessage,
    },
  );
}
