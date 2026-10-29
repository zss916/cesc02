import 'dart:convert';

import 'package:cesc01/core/translations/lan_key.dart';
import 'package:cesc01/generated/json/base/json_field.dart';
import 'package:cesc01/generated/json/site_over_view_data_entity.g.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

export 'package:cesc01/generated/json/site_over_view_data_entity.g.dart';

@JsonSerializable()
class SiteOverViewDataEntity {
  int? siteId;
  String? siteName;
  String? countryRegion;
  String? address;
  String? commStatus;
  String? runStatus;
  int? totalStackCount;
  int? onlineStackCount;
  int? totalClusterCount;
  int? totalSubPackCount;
  int? alarmClusterCount;
  int? alarmStackCount;
  SiteOverViewDataStackStatusDistribution? stackStatusDistribution;
  List<SiteOverViewDataStacks>? stacks;

  List<SiteOverViewDataStacks> get showStacks => stacks ?? [];

  int get showOnlineStackCount => onlineStackCount ?? 0;

  int get showTotalStackCount => totalStackCount ?? 0;

  String get showBatteryStackTitle => totalStackCount == null
      ? '-'
      : LKey.batteryStackCount.trArgs(["$showTotalStackCount"]);

  String get showTotalClusterCount =>
      totalClusterCount == null ? '-' : '${totalClusterCount ?? 0}';

  String get showTotalSubPackCount =>
      totalSubPackCount == null ? '-' : '${totalSubPackCount ?? 0}';

  String get showAlarmClusterCount =>
      alarmClusterCount == null ? '-' : '${alarmClusterCount ?? 0}';

  String get totalStackCountValue =>
      totalStackCount == null ? '-' : '${totalStackCount ?? 0}';

  String get onlineStackCountValue =>
      onlineStackCount == null ? '-' : '${onlineStackCount ?? 0}';

  ///在线电芯
  String get showOnlineCell => "$onlineStackCountValue / $totalStackCountValue";

  ///国家
  String get showCountryRegion => countryRegion ?? "-";

  ///地址
  String get showAddress => address ?? '-';

  ///国家 · 地址
  String get showSubTitle => '$showCountryRegion · $showAddress';

  ///站点名称
  String get showSiteName => siteName ?? '-';

  ///运行状态
  String get showRuntimeStatus => runStatus ?? '-';

  ///通信状态
  String get showCommStatus => commStatus ?? '-';

  SiteOverViewDataEntity();

  factory SiteOverViewDataEntity.fromJson(Map<String, dynamic> json) =>
      $SiteOverViewDataEntityFromJson(json);

  Map<String, dynamic> toJson() => $SiteOverViewDataEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class SiteOverViewDataStackStatusDistribution {
  int? online;
  int? alarm;
  int? delayed;
  int? offline;

  String get showOnline => '${online ?? 0}';

  String get showAlarm => '${alarm ?? 0}';

  String get showDelayed => '${delayed ?? 0}';

  String get showOffline => '${offline ?? 0}';

  SiteOverViewDataStackStatusDistribution();

  factory SiteOverViewDataStackStatusDistribution.fromJson(
    Map<String, dynamic> json,
  ) => $SiteOverViewDataStackStatusDistributionFromJson(json);

  Map<String, dynamic> toJson() =>
      $SiteOverViewDataStackStatusDistributionToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class SiteOverViewDataStacks {
  String? stackId;
  String? stackName;
  String? stackSn;
  String? firmwareVersion;
  int? sysMode;
  int? clusterCount;
  int? packCount;
  String? commStatus;
  String? runStatus;
  int? alarmClusterCount;
  String? soc;
  String? soh;
  String? totalVoltage;
  String? totalCurrent;
  String? maxTemperature;
  String? maxVoltageDiff;
  String? lastDataTime;

  String get showStackName => stackName ?? "-";

  String get showStackSn => stackSn ?? "-";

  String get showCommStatus => commStatus ?? "-";

  String get showFirmwareVersion => firmwareVersion ?? "--";

  int get showSysMode => sysMode ?? -1;

  String get showClusterCount =>
      clusterCount == null ? '-' : '${clusterCount ?? 0} ${LKey.cluster.tr}';

  String get showPackCount =>
      packCount == null ? '-' : '${packCount ?? 0} Pack';

  String get showEndTitle => "$showClusterCount · $showPackCount";

  String get showLastDataTime => lastDataTime ?? "-";

  String get showSoc => soc ?? "-";

  String get showSoh => soh ?? "-";

  String get showTotalVoltage => totalVoltage ?? "-";

  String get showTotalCurrent => totalCurrent ?? "-";

  String get showMaxTemperature => maxTemperature ?? "-";

  String get showMaxVoltageDiff => maxVoltageDiff ?? "-";

  SiteOverViewDataStacks();

  factory SiteOverViewDataStacks.fromJson(Map<String, dynamic> json) =>
      $SiteOverViewDataStacksFromJson(json);

  Map<String, dynamic> toJson() => $SiteOverViewDataStacksToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
