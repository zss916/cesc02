import 'package:cesc01/core/network/bean/dashboard_entity.dart';
import 'package:cesc01/generated/json/base/json_convert_content.dart';

DashboardEntity $DashboardEntityFromJson(Map<String, dynamic> json) {
  final DashboardEntity dashboardEntity = DashboardEntity();
  final DashboardSummary? summary = jsonConvert.convert<DashboardSummary>(
    json['summary'],
  );
  if (summary != null) {
    dashboardEntity.summary = summary;
  }
  final DashboardSiteStatusStatistics? siteStatusStatistics = jsonConvert
      .convert<DashboardSiteStatusStatistics>(json['siteStatusStatistics']);
  if (siteStatusStatistics != null) {
    dashboardEntity.siteStatusStatistics = siteStatusStatistics;
  }
  final List<DashboardAttentionSites>? sites = (json['sites'] as List<dynamic>?)
      ?.map(
        (e) =>
            jsonConvert.convert<DashboardAttentionSites>(e)
                as DashboardAttentionSites,
      )
      .toList();
  if (sites != null) {
    dashboardEntity.sites = sites;
  }
  final int? refreshedAt = jsonConvert.convert<int>(json['refreshedAt']);
  if (refreshedAt != null) {
    dashboardEntity.refreshedAt = refreshedAt;
  }
  return dashboardEntity;
}

Map<String, dynamic> $DashboardEntityToJson(DashboardEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['summary'] = entity.summary?.toJson();
  data['siteStatusStatistics'] = entity.siteStatusStatistics?.toJson();
  data['sites'] = entity.sites?.map((v) => v.toJson()).toList();
  data['refreshedAt'] = entity.refreshedAt;
  return data;
}

extension DashboardEntityExtension on DashboardEntity {
  DashboardEntity copyWith({
    DashboardSummary? summary,
    DashboardSiteStatusStatistics? siteStatusStatistics,
    List<DashboardAttentionSites>? sites,
    int? refreshedAt,
  }) {
    return DashboardEntity()
      ..summary = summary ?? this.summary
      ..siteStatusStatistics = siteStatusStatistics ?? this.siteStatusStatistics
      ..sites = sites ?? this.sites
      ..refreshedAt = refreshedAt ?? this.refreshedAt;
  }
}

DashboardSummary $DashboardSummaryFromJson(Map<String, dynamic> json) {
  final DashboardSummary dashboardSummary = DashboardSummary();
  final String? connectedSiteCount = jsonConvert.convert<String>(
    json['connectedSiteCount'],
  );
  if (connectedSiteCount != null) {
    dashboardSummary.connectedSiteCount = connectedSiteCount;
  }
  final String? totalStackCount = jsonConvert.convert<String>(
    json['totalStackCount'],
  );
  if (totalStackCount != null) {
    dashboardSummary.totalStackCount = totalStackCount;
  }
  final String? onlineStackCount = jsonConvert.convert<String>(
    json['onlineStackCount'],
  );
  if (onlineStackCount != null) {
    dashboardSummary.onlineStackCount = onlineStackCount;
  }
  final String? totalClusterCount = jsonConvert.convert<String>(
    json['totalClusterCount'],
  );
  if (totalClusterCount != null) {
    dashboardSummary.totalClusterCount = totalClusterCount;
  }
  final String? totalSubPackCount = jsonConvert.convert<String>(
    json['totalSubPackCount'],
  );
  if (totalSubPackCount != null) {
    dashboardSummary.totalSubPackCount = totalSubPackCount;
  }
  final String? alarmClusterCount = jsonConvert.convert<String>(
    json['alarmClusterCount'],
  );
  if (alarmClusterCount != null) {
    dashboardSummary.alarmClusterCount = alarmClusterCount;
  }
  return dashboardSummary;
}

Map<String, dynamic> $DashboardSummaryToJson(DashboardSummary entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['connectedSiteCount'] = entity.connectedSiteCount;
  data['totalStackCount'] = entity.totalStackCount;
  data['onlineStackCount'] = entity.onlineStackCount;
  data['totalClusterCount'] = entity.totalClusterCount;
  data['totalSubPackCount'] = entity.totalSubPackCount;
  data['alarmClusterCount'] = entity.alarmClusterCount;
  return data;
}

extension DashboardSummaryExtension on DashboardSummary {
  DashboardSummary copyWith({
    String? connectedSiteCount,
    String? totalStackCount,
    String? onlineStackCount,
    String? totalClusterCount,
    String? totalSubPackCount,
    String? alarmClusterCount,
  }) {
    return DashboardSummary()
      ..connectedSiteCount = connectedSiteCount ?? this.connectedSiteCount
      ..totalStackCount = totalStackCount ?? this.totalStackCount
      ..onlineStackCount = onlineStackCount ?? this.onlineStackCount
      ..totalClusterCount = totalClusterCount ?? this.totalClusterCount
      ..totalSubPackCount = totalSubPackCount ?? this.totalSubPackCount
      ..alarmClusterCount = alarmClusterCount ?? this.alarmClusterCount;
  }
}

DashboardSiteStatusStatistics $DashboardSiteStatusStatisticsFromJson(
  Map<String, dynamic> json,
) {
  final DashboardSiteStatusStatistics dashboardSiteStatusStatistics =
      DashboardSiteStatusStatistics();
  final int? normalSiteCount = jsonConvert.convert<int>(
    json['normalSiteCount'],
  );
  if (normalSiteCount != null) {
    dashboardSiteStatusStatistics.normalSiteCount = normalSiteCount;
  }
  final int? warningSiteCount = jsonConvert.convert<int>(
    json['warningSiteCount'],
  );
  if (warningSiteCount != null) {
    dashboardSiteStatusStatistics.warningSiteCount = warningSiteCount;
  }
  final int? delayedSiteCount = jsonConvert.convert<int>(
    json['delayedSiteCount'],
  );
  if (delayedSiteCount != null) {
    dashboardSiteStatusStatistics.delayedSiteCount = delayedSiteCount;
  }
  final int? offlineSiteCount = jsonConvert.convert<int>(
    json['offlineSiteCount'],
  );
  if (offlineSiteCount != null) {
    dashboardSiteStatusStatistics.offlineSiteCount = offlineSiteCount;
  }
  return dashboardSiteStatusStatistics;
}

Map<String, dynamic> $DashboardSiteStatusStatisticsToJson(
  DashboardSiteStatusStatistics entity,
) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['normalSiteCount'] = entity.normalSiteCount;
  data['warningSiteCount'] = entity.warningSiteCount;
  data['delayedSiteCount'] = entity.delayedSiteCount;
  data['offlineSiteCount'] = entity.offlineSiteCount;
  return data;
}

extension DashboardSiteStatusStatisticsExtension
    on DashboardSiteStatusStatistics {
  DashboardSiteStatusStatistics copyWith({
    int? normalSiteCount,
    int? warningSiteCount,
    int? delayedSiteCount,
    int? offlineSiteCount,
  }) {
    return DashboardSiteStatusStatistics()
      ..normalSiteCount = normalSiteCount ?? this.normalSiteCount
      ..warningSiteCount = warningSiteCount ?? this.warningSiteCount
      ..delayedSiteCount = delayedSiteCount ?? this.delayedSiteCount
      ..offlineSiteCount = offlineSiteCount ?? this.offlineSiteCount;
  }
}

DashboardAttentionSites $DashboardAttentionSitesFromJson(
  Map<String, dynamic> json,
) {
  final DashboardAttentionSites dashboardAttentionSites =
      DashboardAttentionSites();
  final String? siteId = jsonConvert.convert<String>(json['siteId']);
  if (siteId != null) {
    dashboardAttentionSites.siteId = siteId;
  }
  final String? siteName = jsonConvert.convert<String>(json['siteName']);
  if (siteName != null) {
    dashboardAttentionSites.siteName = siteName;
  }
  final String? countryRegion = jsonConvert.convert<String>(
    json['countryRegion'],
  );
  if (countryRegion != null) {
    dashboardAttentionSites.countryRegion = countryRegion;
  }
  final String? commStatus = jsonConvert.convert<String>(json['commStatus']);
  if (commStatus != null) {
    dashboardAttentionSites.commStatus = commStatus;
  }
  final int? stackCount = jsonConvert.convert<int>(json['stackCount']);
  if (stackCount != null) {
    dashboardAttentionSites.stackCount = stackCount;
  }
  final int? clusterCount = jsonConvert.convert<int>(json['clusterCount']);
  if (clusterCount != null) {
    dashboardAttentionSites.clusterCount = clusterCount;
  }
  final int? packCount = jsonConvert.convert<int>(json['packCount']);
  if (packCount != null) {
    dashboardAttentionSites.packCount = packCount;
  }
  return dashboardAttentionSites;
}

Map<String, dynamic> $DashboardAttentionSitesToJson(
  DashboardAttentionSites entity,
) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['siteId'] = entity.siteId;
  data['siteName'] = entity.siteName;
  data['countryRegion'] = entity.countryRegion;
  data['commStatus'] = entity.commStatus;
  data['stackCount'] = entity.stackCount;
  data['clusterCount'] = entity.clusterCount;
  data['packCount'] = entity.packCount;
  return data;
}

extension DashboardAttentionSitesExtension on DashboardAttentionSites {
  DashboardAttentionSites copyWith({
    String? siteId,
    String? siteName,
    String? countryRegion,
    String? commStatus,
    int? stackCount,
    int? clusterCount,
    int? packCount,
  }) {
    return DashboardAttentionSites()
      ..siteId = siteId ?? this.siteId
      ..siteName = siteName ?? this.siteName
      ..countryRegion = countryRegion ?? this.countryRegion
      ..commStatus = commStatus ?? this.commStatus
      ..stackCount = stackCount ?? this.stackCount
      ..clusterCount = clusterCount ?? this.clusterCount
      ..packCount = packCount ?? this.packCount;
  }
}

DashboardAttentionSitesSoc $DashboardAttentionSitesSocFromJson(
  Map<String, dynamic> json,
) {
  final DashboardAttentionSitesSoc dashboardAttentionSitesSoc =
      DashboardAttentionSitesSoc();
  final int? min = jsonConvert.convert<int>(json['min']);
  if (min != null) {
    dashboardAttentionSitesSoc.min = min;
  }
  final int? max = jsonConvert.convert<int>(json['max']);
  if (max != null) {
    dashboardAttentionSitesSoc.max = max;
  }
  final String? unit = jsonConvert.convert<String>(json['unit']);
  if (unit != null) {
    dashboardAttentionSitesSoc.unit = unit;
  }
  final String? display = jsonConvert.convert<String>(json['display']);
  if (display != null) {
    dashboardAttentionSitesSoc.display = display;
  }
  return dashboardAttentionSitesSoc;
}

Map<String, dynamic> $DashboardAttentionSitesSocToJson(
  DashboardAttentionSitesSoc entity,
) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['min'] = entity.min;
  data['max'] = entity.max;
  data['unit'] = entity.unit;
  data['display'] = entity.display;
  return data;
}

extension DashboardAttentionSitesSocExtension on DashboardAttentionSitesSoc {
  DashboardAttentionSitesSoc copyWith({
    int? min,
    int? max,
    String? unit,
    String? display,
  }) {
    return DashboardAttentionSitesSoc()
      ..min = min ?? this.min
      ..max = max ?? this.max
      ..unit = unit ?? this.unit
      ..display = display ?? this.display;
  }
}
