import 'dart:convert';

import 'package:cesc01/generated/json/base/json_field.dart';
import 'package:cesc01/generated/json/site_overview_entity.g.dart';

export 'package:cesc01/generated/json/site_overview_entity.g.dart';

@JsonSerializable()
class SiteOverviewEntity {
  String? siteId;
  String? siteName;
  String? countryRegion;
  String? address;
  String? runStatus;
  String? commStatus;

  ///
  String? siteCode;
  String? timezone;
  String? siteType;
  String? updateTime;
  int? onlinePackCount;
  int? totalPackCount;
  double? soc;
  String? socRange;
  String? sohRange;
  int? alarmCount;
  String? totalVoltageRange;
  String? totalCurrentRange;
  String? maxTemperatureRange;
  String? remainingCapacity;
  String? cycles;
  String? maxChargeCurrent;
  String? maxDischargeCurrent;
  String? canChargeCapacity;
  String? canDischargeCapacity;
  String? maintenanceCycles;
  String? dataTime;

  List<SiteOverviewTrendPoints>? trendPoints;
  List<SiteOverviewCharge>? chargeDischargeTrendPoints;

  SiteOverviewEntity();

  String get showAlarmCount => alarmCount == null ? '-' : '${alarmCount ?? 0}';

  ///站点类型
  String get showSiteType => siteType ?? '--';

  ///地址
  String get showAddress => address == null ? "--" : (address ?? '');

  ///站点名称
  String get showSiteName => siteName ?? '-';

  ///运行状态
  String get showRuntimeStatus => runStatus ?? '-';

  ///通信状态
  String get showCommStatus => commStatus ?? '-';

  ///soc  (0/0%)
  String get showSocRange => (socRange ?? '--');

  ///soh (0-0%)
  String get showSohRange => (sohRange ?? '--');

  ///在线电芯
  String get showOnlineCell =>
      "${(onlinePackCount ?? 0)} / ${totalPackCount ?? 0}";

  ///总电压(0.0–0.0 V)
  String get showTotalVoltage => totalVoltageRange ?? "--";

  ///最高温度(0.0–0.0 °C)°C
  String get showMaxTempRange => maxTemperatureRange ?? "--";

  ///充放电数据
  List<SiteOverviewCharge> get chargeDischargeData =>
      chargeDischargeTrendPoints ?? [];

  ///实时数据
  List<SiteOverviewTrendPoints> get showTrendPoints => trendPoints ?? [];

  factory SiteOverviewEntity.fromJson(Map<String, dynamic> json) =>
      $SiteOverviewEntityFromJson(json);

  Map<String, dynamic> toJson() => $SiteOverviewEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class SiteOverviewTrendPoints {
  int? timestamp;
  String? timeLabel;
  double? soc;
  double? socMin;
  double? socMax;
  double? current;
  double? temperature;
  double? voltage;

  DateTime showTime() {
    final num n = (timestamp ?? 0) as num;
    final DateTime parsed = n > 1e12
        ? DateTime.fromMillisecondsSinceEpoch(n.toInt())
        : DateTime.fromMillisecondsSinceEpoch((n.toInt() * 1000));
    return DateTime(
      parsed.year,
      parsed.month,
      parsed.day,
      parsed.hour,
      parsed.minute,
    );
  }

  SiteOverviewTrendPoints();

  factory SiteOverviewTrendPoints.fromJson(Map<String, dynamic> json) =>
      $SiteOverviewTrendPointsFromJson(json);

  Map<String, dynamic> toJson() => $SiteOverviewTrendPointsToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class SiteOverviewCharge {
  String? date;
  String? triggerTime;
  int? endTimestamp;
  int? timestamp;
  double? chargeAh;
  double? dischargeAh;
  String? unit;

  double get showChargeAh => chargeAh ?? 0;
  double get showDischargeAh => dischargeAh ?? 0;

  SiteOverviewCharge();

  factory SiteOverviewCharge.fromJson(Map<String, dynamic> json) =>
      $SiteOverviewChargeFromJson(json);

  Map<String, dynamic> toJson() => $SiteOverviewChargeToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
