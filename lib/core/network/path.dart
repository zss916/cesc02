class ApiPath {
  ///host
  static const String baseUrl = "http://192.168.8.35:10003";

  static const String mockUrl = "https://api.mock.com";

  //static const String baseUrl = mockUrl;

  ///APP 端账号密码登录
  static const String postLogin = "/house-power/platform/v1/auth/login/app";

  ///获取当前登录用户信息
  static const String getUserInfo = "/house-power/platform/v1/auth/me";

  ///注销当前登录会话
  static const String postLogout = "/house-power/platform/v1/auth/logout";

  ///统计当前账号可见站点
  static const String getDashboard =
      "/house-power/platform/v1/dashboard/overview";

  ///查询站点实时运行统计与列表
  static const String postRealTimeList =
      "/house-power/platform/v1/sites/realtime/page";

  ///查询单站概览数据
  static String getSiteOverview({required String siteId}) =>
      "/house-power/platform/v1/sites/$siteId/overview";

  ///分页查询电池包列表
  static const String postBatteryList =
      "/house-power/platform/v1/battery-clusters/page";

  ///查询电池包详情
  static String getBatteryDetail({required String clusterId}) =>
      "/house-power/platform/v1/battery-clusters/$clusterId/detail";

  ///查询告警详情
  static String getAlarmDetail({required String alarmId}) =>
      "/house-power/platform/v1/alarms/$alarmId";

  ///查询可见站点中的告警列表
  static const String postAlarmList = "/house-power/platform/v1/alarms/page";

  ///查询一个站点+电池堆的告警明细
  static const String getStackAlarmDetail =
      "/house-power/platform/v1/alarms/stack-detail";

  ///查询站点下拉选项
  static const String getSites = "/house-power/platform/v1/sites/options";

  ///向站点绑定电池包
  static String postBindSite({required String siteId}) =>
      "/house-power/platform/v1/sites/$siteId/bind-batteries";

  ///创建站点并绑定电池包。
  static const String createAndBindingSite = "/house-power/platform/v1/sites";

  ///查询当前筛选范围内的站点、电池堆、告警簇数量
  static const String getAlarmsSummary =
      "/house-power/platform/v1/alarms/summary";

  ///查询单站下挂载的电池堆列表
  static String getBatteryStack({required String siteId}) =>
      "/house-power/platform/v1/sites/$siteId/battery-stacks";

  ///单站概览：查询堆主控与下属簇的版本详情
  static String getVersionInfo({required String stackId}) =>
      "/house-power/platform/v1/battery-stacks/$stackId/versions";

  ///电池数据页：堆数据 / 簇数据
  static String getBatteryData({required String stackId}) =>
      "/house-power/platform/v1/battery-stacks/$stackId/data";

  ///查询当前账号数据范围内的最新通
  static const String getNotifications =
      "/house-power/platform/v1/notifications";

  ///根据站点查询堆簇的下拉数据
  static String getStackAndClusterOptions({required String siteId}) =>
      "/house-power/platform/v1/sites/$siteId/options";

  ///电池数据页：堆数据 / 簇数据。
  static String getStackAndCluster({required String stackId}) =>
      "/house-power/platform/v1/battery-stacks/$stackId/data";
}
