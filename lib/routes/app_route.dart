part of 'index.dart';

class ARoute {
  static const message = '/message';
  static const about = '/about';
  static const login = '/login';
  static const main = '/main';
  static const provision = '/provision';
  static const web = '/web';
  static const language = '/language';
  static const stackAlarmDetail = '/stackAlarmDetail';
  static const version = '/version';

  static final List<GetPage> routes = [
    GetPage(name: version, page: () => VersionInfoPage()),
    GetPage(name: stackAlarmDetail, page: () => StackAlarmDetailPage()),
    GetPage(name: login, page: () => LoginPage()),
    GetPage(name: message, page: () => MessagePage()),
    GetPage(name: about, page: () => AboutPage()),
    GetPage(name: main, page: () => MainPage(), middlewares: [AuthGuard()]),
    GetPage(name: provision, page: () => ProvisionPage()),
    GetPage(name: web, page: () => WebPage()),
    GetPage(name: language, page: () => LanguagePage()),
  ];

  /// 蓝牙权限提示dialog
  static const String blePermissionTipDialog = "blePermissionTipDialog";
  static const String systemBleTipDialog = "systemBleTipDialog";
  static const String locationServiceDialog = "locationServiceDialog";
  static const String logoutDialog = "logoutDialog";
  static const String authScopeDialog = "authScopeDialog";
  static const String notifyDialog = "notifyDialog";
  static const String orgDialog = "orgDialog";
  static const String configErrorSheet = "configErrorSheet";
  static const String configTimeOutSheet = "configTimeOutSheet";
  static const String configNetworkSheet = "configNetworkSheet";
  static const String selectPlaceSheet = "selectPlaceSheet";
  static const String selectCountryAndStatesSheet =
      "selectCountryAndStatesSheet";
  static const String filterSite = "filterSite";
}
