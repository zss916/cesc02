import 'dart:convert';

import 'package:cesc01/core/translations/lan_key.dart';
import 'package:cesc01/generated/json/base/json_field.dart';
import 'package:cesc01/generated/json/dashboard_entity.g.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

export 'package:cesc01/generated/json/dashboard_entity.g.dart';

@JsonSerializable()
class DashboardEntity {
  DashboardSummary? summary;
  DashboardSiteStatusStatistics? siteStatusStatistics;
  List<DashboardAttentionSites>? sites;
  int? refreshedAt;

  DashboardEntity();

  factory DashboardEntity.fromJson(Map<String, dynamic> json) =>
      $DashboardEntityFromJson(json);

  Map<String, dynamic> toJson() => $DashboardEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class DashboardSummary {
  ///授权范围内接入站点数
  String? connectedSiteCount;

  ///电池堆总数
  String? totalStackCount;

  ///在线电池堆数
  String? onlineStackCount;

  ///电池簇总数
  String? totalClusterCount;

  ///子 Pack 总数
  String? totalSubPackCount;

  ///存在当前告警的簇数量
  String? alarmClusterCount;

  ///接入站点总数
  String get totalSiteCount => connectedSiteCount ?? "-";

  String get showTotalStackCount => totalStackCount ?? "-";

  String get showOnlineStackCount => onlineStackCount ?? "-";

  String get showTotalClusterCount => totalClusterCount ?? "-";

  ///告警数
  String get alarmCount =>
      alarmClusterCount == null ? '-' : '$alarmClusterCount';

  DashboardSummary();

  factory DashboardSummary.fromJson(Map<String, dynamic> json) =>
      $DashboardSummaryFromJson(json);

  Map<String, dynamic> toJson() => $DashboardSummaryToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class DashboardSiteStatusStatistics {
  int? normalSiteCount;
  int? warningSiteCount;
  int? delayedSiteCount;
  int? offlineSiteCount;

  DashboardSiteStatusStatistics();

  factory DashboardSiteStatusStatistics.fromJson(Map<String, dynamic> json) =>
      $DashboardSiteStatusStatisticsFromJson(json);

  Map<String, dynamic> toJson() => $DashboardSiteStatusStatisticsToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class DashboardAttentionSites {
  String? siteId;
  String? siteName;
  String? countryRegion;
  String? commStatus;
  int? stackCount;
  int? clusterCount;
  int? packCount;

  ///站点名称
  String get showSiteName => siteName ?? '-';

  ///通信状态(ONLINE / ALARM / DELAYED / OFFLINE)
  String get showCommStatus => (commStatus ?? '-');

  ///地址
  String get showCountryRegion => countryRegion ?? '-';
  String get showStack =>
      stackCount == null ? '-' : "$stackCount ${LKey.stack.tr}";
  String get showSubTitle => "$showStack · $showCountryRegion";

  DashboardAttentionSites();

  factory DashboardAttentionSites.fromJson(Map<String, dynamic> json) =>
      $DashboardAttentionSitesFromJson(json);

  Map<String, dynamic> toJson() => $DashboardAttentionSitesToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class DashboardAttentionSitesSoc {
  int? min;
  int? max;
  String? unit;
  String? display;

  DashboardAttentionSitesSoc();

  factory DashboardAttentionSitesSoc.fromJson(Map<String, dynamic> json) =>
      $DashboardAttentionSitesSocFromJson(json);

  Map<String, dynamic> toJson() => $DashboardAttentionSitesSocToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
