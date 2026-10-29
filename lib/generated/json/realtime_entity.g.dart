import 'package:cesc01/core/network/bean/realtime_entity.dart';
import 'package:cesc01/generated/json/base/json_convert_content.dart';

RealtimeEntity $RealtimeEntityFromJson(Map<String, dynamic> json) {
  final RealtimeEntity realtimeEntity = RealtimeEntity();
  final RealtimeSummary? summary = jsonConvert.convert<RealtimeSummary>(
    json['summary'],
  );
  if (summary != null) {
    realtimeEntity.summary = summary;
  }
  final RealtimePage? page = jsonConvert.convert<RealtimePage>(json['page']);
  if (page != null) {
    realtimeEntity.page = page;
  }
  return realtimeEntity;
}

Map<String, dynamic> $RealtimeEntityToJson(RealtimeEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['summary'] = entity.summary?.toJson();
  data['page'] = entity.page?.toJson();
  return data;
}

extension RealtimeEntityExtension on RealtimeEntity {
  RealtimeEntity copyWith({RealtimeSummary? summary, RealtimePage? page}) {
    return RealtimeEntity()
      ..summary = summary ?? this.summary
      ..page = page ?? this.page;
  }
}

RealtimeSummary $RealtimeSummaryFromJson(Map<String, dynamic> json) {
  final RealtimeSummary realtimeSummary = RealtimeSummary();
  final int? normalSiteCount = jsonConvert.convert<int>(
    json['normalSiteCount'],
  );
  if (normalSiteCount != null) {
    realtimeSummary.normalSiteCount = normalSiteCount;
  }
  final int? visibleSiteCount = jsonConvert.convert<int>(
    json['visibleSiteCount'],
  );
  if (visibleSiteCount != null) {
    realtimeSummary.visibleSiteCount = visibleSiteCount;
  }
  final int? onlinePackCount = jsonConvert.convert<int>(
    json['onlinePackCount'],
  );
  if (onlinePackCount != null) {
    realtimeSummary.onlinePackCount = onlinePackCount;
  }
  final int? totalPackCount = jsonConvert.convert<int>(json['totalPackCount']);
  if (totalPackCount != null) {
    realtimeSummary.totalPackCount = totalPackCount;
  }
  final int? activeAlarmCount = jsonConvert.convert<int>(
    json['activeAlarmCount'],
  );
  if (activeAlarmCount != null) {
    realtimeSummary.activeAlarmCount = activeAlarmCount;
  }
  final int? abnormalPackCount = jsonConvert.convert<int>(
    json['abnormalPackCount'],
  );
  if (abnormalPackCount != null) {
    realtimeSummary.abnormalPackCount = abnormalPackCount;
  }
  return realtimeSummary;
}

Map<String, dynamic> $RealtimeSummaryToJson(RealtimeSummary entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['normalSiteCount'] = entity.normalSiteCount;
  data['visibleSiteCount'] = entity.visibleSiteCount;
  data['onlinePackCount'] = entity.onlinePackCount;
  data['totalPackCount'] = entity.totalPackCount;
  data['activeAlarmCount'] = entity.activeAlarmCount;
  data['abnormalPackCount'] = entity.abnormalPackCount;
  return data;
}

extension RealtimeSummaryExtension on RealtimeSummary {
  RealtimeSummary copyWith({
    int? normalSiteCount,
    int? visibleSiteCount,
    int? onlinePackCount,
    int? totalPackCount,
    int? activeAlarmCount,
    int? abnormalPackCount,
  }) {
    return RealtimeSummary()
      ..normalSiteCount = normalSiteCount ?? this.normalSiteCount
      ..visibleSiteCount = visibleSiteCount ?? this.visibleSiteCount
      ..onlinePackCount = onlinePackCount ?? this.onlinePackCount
      ..totalPackCount = totalPackCount ?? this.totalPackCount
      ..activeAlarmCount = activeAlarmCount ?? this.activeAlarmCount
      ..abnormalPackCount = abnormalPackCount ?? this.abnormalPackCount;
  }
}

RealtimePage $RealtimePageFromJson(Map<String, dynamic> json) {
  final RealtimePage realtimePage = RealtimePage();
  final int? total = jsonConvert.convert<int>(json['total']);
  if (total != null) {
    realtimePage.total = total;
  }
  final int? totalPage = jsonConvert.convert<int>(json['totalPage']);
  if (totalPage != null) {
    realtimePage.totalPage = totalPage;
  }
  final int? pageNum = jsonConvert.convert<int>(json['pageNum']);
  if (pageNum != null) {
    realtimePage.pageNum = pageNum;
  }
  final int? pageSize = jsonConvert.convert<int>(json['pageSize']);
  if (pageSize != null) {
    realtimePage.pageSize = pageSize;
  }
  final bool? hasNext = jsonConvert.convert<bool>(json['hasNext']);
  if (hasNext != null) {
    realtimePage.hasNext = hasNext;
  }
  final List<RealtimePageList>? list = (json['list'] as List<dynamic>?)
      ?.map((e) => jsonConvert.convert<RealtimePageList>(e) as RealtimePageList)
      .toList();
  if (list != null) {
    realtimePage.list = list;
  }
  return realtimePage;
}

Map<String, dynamic> $RealtimePageToJson(RealtimePage entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['total'] = entity.total;
  data['totalPage'] = entity.totalPage;
  data['pageNum'] = entity.pageNum;
  data['pageSize'] = entity.pageSize;
  data['hasNext'] = entity.hasNext;
  data['list'] = entity.list?.map((v) => v.toJson()).toList();
  return data;
}

extension RealtimePageExtension on RealtimePage {
  RealtimePage copyWith({
    int? total,
    int? totalPage,
    int? pageNum,
    int? pageSize,
    bool? hasNext,
    List<RealtimePageList>? list,
  }) {
    return RealtimePage()
      ..total = total ?? this.total
      ..totalPage = totalPage ?? this.totalPage
      ..pageNum = pageNum ?? this.pageNum
      ..pageSize = pageSize ?? this.pageSize
      ..hasNext = hasNext ?? this.hasNext
      ..list = list ?? this.list;
  }
}

RealtimePageList $RealtimePageListFromJson(Map<String, dynamic> json) {
  final RealtimePageList realtimePageList = RealtimePageList();
  final String? siteId = jsonConvert.convert<String>(json['siteId']);
  if (siteId != null) {
    realtimePageList.siteId = siteId;
  }
  final String? siteName = jsonConvert.convert<String>(json['siteName']);
  if (siteName != null) {
    realtimePageList.siteName = siteName;
  }
  final String? countryRegion = jsonConvert.convert<String>(
    json['countryRegion'],
  );
  if (countryRegion != null) {
    realtimePageList.countryRegion = countryRegion;
  }
  final String? runStatus = jsonConvert.convert<String>(json['runStatus']);
  if (runStatus != null) {
    realtimePageList.runStatus = runStatus;
  }
  final String? commStatus = jsonConvert.convert<String>(json['commStatus']);
  if (commStatus != null) {
    realtimePageList.commStatus = commStatus;
  }
  final int? totalStackCount = jsonConvert.convert<int>(
    json['totalStackCount'],
  );
  if (totalStackCount != null) {
    realtimePageList.totalStackCount = totalStackCount;
  }
  final int? totalClusterCount = jsonConvert.convert<int>(
    json['totalClusterCount'],
  );
  if (totalClusterCount != null) {
    realtimePageList.totalClusterCount = totalClusterCount;
  }
  final int? activeAlarmCount = jsonConvert.convert<int>(
    json['activeAlarmCount'],
  );
  if (activeAlarmCount != null) {
    realtimePageList.activeAlarmCount = activeAlarmCount;
  }
  final RealtimePageListSoc? soc = jsonConvert.convert<RealtimePageListSoc>(
    json['soc'],
  );
  if (soc != null) {
    realtimePageList.soc = soc;
  }
  final RealtimePageListSoh? soh = jsonConvert.convert<RealtimePageListSoh>(
    json['soh'],
  );
  if (soh != null) {
    realtimePageList.soh = soh;
  }
  final RealtimePageListTotalVoltage? totalVoltage = jsonConvert
      .convert<RealtimePageListTotalVoltage>(json['totalVoltage']);
  if (totalVoltage != null) {
    realtimePageList.totalVoltage = totalVoltage;
  }
  final RealtimePageListTotalCurrent? totalCurrent = jsonConvert
      .convert<RealtimePageListTotalCurrent>(json['totalCurrent']);
  if (totalCurrent != null) {
    realtimePageList.totalCurrent = totalCurrent;
  }
  final RealtimePageListMaxTemperature? maxTemperature = jsonConvert
      .convert<RealtimePageListMaxTemperature>(json['maxTemperature']);
  if (maxTemperature != null) {
    realtimePageList.maxTemperature = maxTemperature;
  }
  final bool? chargeDisabled = jsonConvert.convert<bool>(
    json['chargeDisabled'],
  );
  if (chargeDisabled != null) {
    realtimePageList.chargeDisabled = chargeDisabled;
  }
  final bool? dischargeDisabled = jsonConvert.convert<bool>(
    json['dischargeDisabled'],
  );
  if (dischargeDisabled != null) {
    realtimePageList.dischargeDisabled = dischargeDisabled;
  }
  final String? lastDataTime = jsonConvert.convert<String>(
    json['lastDataTime'],
  );
  if (lastDataTime != null) {
    realtimePageList.lastDataTime = lastDataTime;
  }
  return realtimePageList;
}

Map<String, dynamic> $RealtimePageListToJson(RealtimePageList entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['siteId'] = entity.siteId;
  data['siteName'] = entity.siteName;
  data['countryRegion'] = entity.countryRegion;
  data['runStatus'] = entity.runStatus;
  data['commStatus'] = entity.commStatus;
  data['totalStackCount'] = entity.totalStackCount;
  data['totalClusterCount'] = entity.totalClusterCount;
  data['activeAlarmCount'] = entity.activeAlarmCount;
  data['soc'] = entity.soc?.toJson();
  data['soh'] = entity.soh?.toJson();
  data['totalVoltage'] = entity.totalVoltage?.toJson();
  data['totalCurrent'] = entity.totalCurrent?.toJson();
  data['maxTemperature'] = entity.maxTemperature?.toJson();
  data['chargeDisabled'] = entity.chargeDisabled;
  data['dischargeDisabled'] = entity.dischargeDisabled;
  data['lastDataTime'] = entity.lastDataTime;
  return data;
}

extension RealtimePageListExtension on RealtimePageList {
  RealtimePageList copyWith({
    String? siteId,
    String? siteName,
    String? countryRegion,
    String? runStatus,
    String? commStatus,
    int? totalStackCount,
    int? totalClusterCount,
    int? activeAlarmCount,
    RealtimePageListSoc? soc,
    RealtimePageListSoh? soh,
    RealtimePageListTotalVoltage? totalVoltage,
    RealtimePageListTotalCurrent? totalCurrent,
    RealtimePageListMaxTemperature? maxTemperature,
    bool? chargeDisabled,
    bool? dischargeDisabled,
    String? lastDataTime,
  }) {
    return RealtimePageList()
      ..siteId = siteId ?? this.siteId
      ..siteName = siteName ?? this.siteName
      ..countryRegion = countryRegion ?? this.countryRegion
      ..runStatus = runStatus ?? this.runStatus
      ..commStatus = commStatus ?? this.commStatus
      ..totalStackCount = totalStackCount ?? this.totalStackCount
      ..totalClusterCount = totalClusterCount ?? this.totalClusterCount
      ..activeAlarmCount = activeAlarmCount ?? this.activeAlarmCount
      ..soc = soc ?? this.soc
      ..soh = soh ?? this.soh
      ..totalVoltage = totalVoltage ?? this.totalVoltage
      ..totalCurrent = totalCurrent ?? this.totalCurrent
      ..maxTemperature = maxTemperature ?? this.maxTemperature
      ..chargeDisabled = chargeDisabled ?? this.chargeDisabled
      ..dischargeDisabled = dischargeDisabled ?? this.dischargeDisabled
      ..lastDataTime = lastDataTime ?? this.lastDataTime;
  }
}

RealtimePageListSoc $RealtimePageListSocFromJson(Map<String, dynamic> json) {
  final RealtimePageListSoc realtimePageListSoc = RealtimePageListSoc();
  final int? min = jsonConvert.convert<int>(json['min']);
  if (min != null) {
    realtimePageListSoc.min = min;
  }
  final int? max = jsonConvert.convert<int>(json['max']);
  if (max != null) {
    realtimePageListSoc.max = max;
  }
  final String? unit = jsonConvert.convert<String>(json['unit']);
  if (unit != null) {
    realtimePageListSoc.unit = unit;
  }
  final String? display = jsonConvert.convert<String>(json['display']);
  if (display != null) {
    realtimePageListSoc.display = display;
  }
  return realtimePageListSoc;
}

Map<String, dynamic> $RealtimePageListSocToJson(RealtimePageListSoc entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['min'] = entity.min;
  data['max'] = entity.max;
  data['unit'] = entity.unit;
  data['display'] = entity.display;
  return data;
}

extension RealtimePageListSocExtension on RealtimePageListSoc {
  RealtimePageListSoc copyWith({
    int? min,
    int? max,
    String? unit,
    String? display,
  }) {
    return RealtimePageListSoc()
      ..min = min ?? this.min
      ..max = max ?? this.max
      ..unit = unit ?? this.unit
      ..display = display ?? this.display;
  }
}

RealtimePageListSoh $RealtimePageListSohFromJson(Map<String, dynamic> json) {
  final RealtimePageListSoh realtimePageListSoh = RealtimePageListSoh();
  final int? min = jsonConvert.convert<int>(json['min']);
  if (min != null) {
    realtimePageListSoh.min = min;
  }
  final int? max = jsonConvert.convert<int>(json['max']);
  if (max != null) {
    realtimePageListSoh.max = max;
  }
  final String? unit = jsonConvert.convert<String>(json['unit']);
  if (unit != null) {
    realtimePageListSoh.unit = unit;
  }
  final String? display = jsonConvert.convert<String>(json['display']);
  if (display != null) {
    realtimePageListSoh.display = display;
  }
  return realtimePageListSoh;
}

Map<String, dynamic> $RealtimePageListSohToJson(RealtimePageListSoh entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['min'] = entity.min;
  data['max'] = entity.max;
  data['unit'] = entity.unit;
  data['display'] = entity.display;
  return data;
}

extension RealtimePageListSohExtension on RealtimePageListSoh {
  RealtimePageListSoh copyWith({
    int? min,
    int? max,
    String? unit,
    String? display,
  }) {
    return RealtimePageListSoh()
      ..min = min ?? this.min
      ..max = max ?? this.max
      ..unit = unit ?? this.unit
      ..display = display ?? this.display;
  }
}

RealtimePageListTotalVoltage $RealtimePageListTotalVoltageFromJson(
  Map<String, dynamic> json,
) {
  final RealtimePageListTotalVoltage realtimePageListTotalVoltage =
      RealtimePageListTotalVoltage();
  final int? min = jsonConvert.convert<int>(json['min']);
  if (min != null) {
    realtimePageListTotalVoltage.min = min;
  }
  final int? max = jsonConvert.convert<int>(json['max']);
  if (max != null) {
    realtimePageListTotalVoltage.max = max;
  }
  final String? unit = jsonConvert.convert<String>(json['unit']);
  if (unit != null) {
    realtimePageListTotalVoltage.unit = unit;
  }
  final String? display = jsonConvert.convert<String>(json['display']);
  if (display != null) {
    realtimePageListTotalVoltage.display = display;
  }
  return realtimePageListTotalVoltage;
}

Map<String, dynamic> $RealtimePageListTotalVoltageToJson(
  RealtimePageListTotalVoltage entity,
) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['min'] = entity.min;
  data['max'] = entity.max;
  data['unit'] = entity.unit;
  data['display'] = entity.display;
  return data;
}

extension RealtimePageListTotalVoltageExtension
    on RealtimePageListTotalVoltage {
  RealtimePageListTotalVoltage copyWith({
    int? min,
    int? max,
    String? unit,
    String? display,
  }) {
    return RealtimePageListTotalVoltage()
      ..min = min ?? this.min
      ..max = max ?? this.max
      ..unit = unit ?? this.unit
      ..display = display ?? this.display;
  }
}

RealtimePageListTotalCurrent $RealtimePageListTotalCurrentFromJson(
  Map<String, dynamic> json,
) {
  final RealtimePageListTotalCurrent realtimePageListTotalCurrent =
      RealtimePageListTotalCurrent();
  final int? min = jsonConvert.convert<int>(json['min']);
  if (min != null) {
    realtimePageListTotalCurrent.min = min;
  }
  final int? max = jsonConvert.convert<int>(json['max']);
  if (max != null) {
    realtimePageListTotalCurrent.max = max;
  }
  final String? unit = jsonConvert.convert<String>(json['unit']);
  if (unit != null) {
    realtimePageListTotalCurrent.unit = unit;
  }
  final String? display = jsonConvert.convert<String>(json['display']);
  if (display != null) {
    realtimePageListTotalCurrent.display = display;
  }
  return realtimePageListTotalCurrent;
}

Map<String, dynamic> $RealtimePageListTotalCurrentToJson(
  RealtimePageListTotalCurrent entity,
) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['min'] = entity.min;
  data['max'] = entity.max;
  data['unit'] = entity.unit;
  data['display'] = entity.display;
  return data;
}

extension RealtimePageListTotalCurrentExtension
    on RealtimePageListTotalCurrent {
  RealtimePageListTotalCurrent copyWith({
    int? min,
    int? max,
    String? unit,
    String? display,
  }) {
    return RealtimePageListTotalCurrent()
      ..min = min ?? this.min
      ..max = max ?? this.max
      ..unit = unit ?? this.unit
      ..display = display ?? this.display;
  }
}

RealtimePageListMaxTemperature $RealtimePageListMaxTemperatureFromJson(
  Map<String, dynamic> json,
) {
  final RealtimePageListMaxTemperature realtimePageListMaxTemperature =
      RealtimePageListMaxTemperature();
  final int? min = jsonConvert.convert<int>(json['min']);
  if (min != null) {
    realtimePageListMaxTemperature.min = min;
  }
  final int? max = jsonConvert.convert<int>(json['max']);
  if (max != null) {
    realtimePageListMaxTemperature.max = max;
  }
  final String? unit = jsonConvert.convert<String>(json['unit']);
  if (unit != null) {
    realtimePageListMaxTemperature.unit = unit;
  }
  final String? display = jsonConvert.convert<String>(json['display']);
  if (display != null) {
    realtimePageListMaxTemperature.display = display;
  }
  return realtimePageListMaxTemperature;
}

Map<String, dynamic> $RealtimePageListMaxTemperatureToJson(
  RealtimePageListMaxTemperature entity,
) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['min'] = entity.min;
  data['max'] = entity.max;
  data['unit'] = entity.unit;
  data['display'] = entity.display;
  return data;
}

extension RealtimePageListMaxTemperatureExtension
    on RealtimePageListMaxTemperature {
  RealtimePageListMaxTemperature copyWith({
    int? min,
    int? max,
    String? unit,
    String? display,
  }) {
    return RealtimePageListMaxTemperature()
      ..min = min ?? this.min
      ..max = max ?? this.max
      ..unit = unit ?? this.unit
      ..display = display ?? this.display;
  }
}
