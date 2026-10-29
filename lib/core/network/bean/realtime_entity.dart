import 'dart:convert';

import 'package:cesc01/core/translations/lan_key.dart';
import 'package:cesc01/generated/json/base/json_field.dart';
import 'package:cesc01/generated/json/realtime_entity.g.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

export 'package:cesc01/generated/json/realtime_entity.g.dart';

@JsonSerializable()
class RealtimeEntity {
  RealtimeSummary? summary;
  RealtimePage? page;

  RealtimeEntity();

  factory RealtimeEntity.fromJson(Map<String, dynamic> json) =>
      $RealtimeEntityFromJson(json);

  Map<String, dynamic> toJson() => $RealtimeEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class RealtimeSummary {
  int? normalSiteCount;
  int? visibleSiteCount;
  int? onlinePackCount;
  int? totalPackCount;
  int? activeAlarmCount;
  int? abnormalPackCount;

  RealtimeSummary();

  factory RealtimeSummary.fromJson(Map<String, dynamic> json) =>
      $RealtimeSummaryFromJson(json);

  Map<String, dynamic> toJson() => $RealtimeSummaryToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class RealtimePage {
  int? total;
  int? totalPage;
  int? pageNum;
  int? pageSize;
  bool? hasNext;
  List<RealtimePageList>? list;

  RealtimePage();

  factory RealtimePage.fromJson(Map<String, dynamic> json) =>
      $RealtimePageFromJson(json);

  Map<String, dynamic> toJson() => $RealtimePageToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class RealtimePageList {
  String? siteId;
  String? siteName;
  String? countryRegion;
  String? runStatus;
  String? commStatus;
  int? totalStackCount;
  int? totalClusterCount;
  int? activeAlarmCount;
  RealtimePageListSoc? soc;
  RealtimePageListSoh? soh;
  RealtimePageListTotalVoltage? totalVoltage;
  RealtimePageListTotalCurrent? totalCurrent;
  RealtimePageListMaxTemperature? maxTemperature;
  bool? chargeDisabled;
  bool? dischargeDisabled;
  String? lastDataTime;

  /// int? onlinePackCount;
  /// int? abnormalPackCount;

  ///站点名称
  String get showSiteName => siteName ?? '-';

  ///站点地址详情
  String get showSiteAddress => countryRegion ?? '- · -';

  ///运行状态
  String get showRuntimeStatus => commStatus ?? '-';

  ///是否隐藏
  bool get runtimeStatusVisibility => commStatus != null;

  String get showTotalStackCount =>
      totalStackCount == null ? '-' : '${totalStackCount ?? 0}${LKey.stack.tr}';

  String get showTotalClusterCount => totalClusterCount == null
      ? '-'
      : '${totalClusterCount ?? 0}${LKey.cluster.tr}';

  ///设备数量
  String get packRate => "$showTotalStackCount/$showTotalClusterCount";

  ///soc
  String get showSocRange => soc?.display ?? "-";

  ///最高温度
  String get showMaxTemp => maxTemperature?.display ?? "-";

  String get showLastDataTime => lastDataTime ?? '--';

  int get alarmCount => activeAlarmCount ?? 0;

  RealtimePageList();

  factory RealtimePageList.fromJson(Map<String, dynamic> json) =>
      $RealtimePageListFromJson(json);

  Map<String, dynamic> toJson() => $RealtimePageListToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class RealtimePageListSoc {
  int? min;
  int? max;
  String? unit;
  String? display;

  RealtimePageListSoc();

  factory RealtimePageListSoc.fromJson(Map<String, dynamic> json) =>
      $RealtimePageListSocFromJson(json);

  Map<String, dynamic> toJson() => $RealtimePageListSocToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class RealtimePageListSoh {
  int? min;
  int? max;
  String? unit;
  String? display;

  RealtimePageListSoh();

  factory RealtimePageListSoh.fromJson(Map<String, dynamic> json) =>
      $RealtimePageListSohFromJson(json);

  Map<String, dynamic> toJson() => $RealtimePageListSohToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class RealtimePageListTotalVoltage {
  int? min;
  int? max;
  String? unit;
  String? display;

  RealtimePageListTotalVoltage();

  factory RealtimePageListTotalVoltage.fromJson(Map<String, dynamic> json) =>
      $RealtimePageListTotalVoltageFromJson(json);

  Map<String, dynamic> toJson() => $RealtimePageListTotalVoltageToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class RealtimePageListTotalCurrent {
  int? min;
  int? max;
  String? unit;
  String? display;

  RealtimePageListTotalCurrent();

  factory RealtimePageListTotalCurrent.fromJson(Map<String, dynamic> json) =>
      $RealtimePageListTotalCurrentFromJson(json);

  Map<String, dynamic> toJson() => $RealtimePageListTotalCurrentToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class RealtimePageListMaxTemperature {
  int? min;
  int? max;
  String? unit;
  String? display;

  RealtimePageListMaxTemperature();

  factory RealtimePageListMaxTemperature.fromJson(Map<String, dynamic> json) =>
      $RealtimePageListMaxTemperatureFromJson(json);

  Map<String, dynamic> toJson() => $RealtimePageListMaxTemperatureToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
