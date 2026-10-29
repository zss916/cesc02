import 'dart:convert';

import 'package:cesc01/core/helper/device_status.dart';
import 'package:cesc01/core/translations/lan_key.dart';
import 'package:cesc01/generated/json/base/json_field.dart';
import 'package:cesc01/generated/json/battery_detail_entity.g.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

export 'package:cesc01/generated/json/battery_detail_entity.g.dart';

@JsonSerializable()
class BatteryDetailEntity {
  int? packId;
  String? packName;
  String? modelName;
  String? sn;
  String? runStatus;
  String? commStatus;
  String? statusDesc;
  String? reportTime;
  String? dataValidDesc;

  BatteryDetailKeyMetrics? keyMetrics;
  BatteryDetailAdvancedDiagnosis? advancedDiagnosis;
  BatteryDetailSystemInfo? systemInfo;

  BatteryDetailEntity();

  ///充电
  String get showStatusDesc => statusDesc ?? '-';

  String get showSOC => keyMetrics?.core?.showSoc ?? "-";

  String get showModelName => modelName ?? '-';

  String get showPackName => packName ?? '-';

  String get showSN => sn ?? '-';

  String get showTitle => '${packName ?? '-'} · ${sn ?? '-'}';

  String get showRuntimeStatus => runStatus ?? '-';

  String get showCommStatus => commStatus ?? '-';

  factory BatteryDetailEntity.fromJson(Map<String, dynamic> json) =>
      $BatteryDetailEntityFromJson(json);

  Map<String, dynamic> toJson() => $BatteryDetailEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class BatteryDetailKeyMetrics {
  BatteryDetailKeyMetricsCore? core;
  BatteryDetailKeyMetricsExtrema? extrema;
  BatteryDetailKeyMetricsCapacity? capacity;

  List<(String, String)> get list => [
    (LKey.runningStatus.tr, (core?.showRunStatusDesc ?? '-').runningTitle),
    ('SOC', core?.showSoc ?? "-"),
    ('SOH', core?.showSoh ?? "-"),
    (LKey.totalVoltage.tr, core?.showTotalVoltage ?? "-"),
    (LKey.totalCurrent.tr, core?.showTotalCurrent ?? "-"),
    (LKey.remainingCapacity.tr, core?.showRemainingCapacity ?? "-"),
    (LKey.maxTemp.tr, core?.showMaxTemp ?? "-"),
    (LKey.maxVoltageDiff.tr, core?.showMaxVoltageDiff ?? "-"),
    (LKey.chargeCurrent.tr, capacity?.showCanChargeCapacity ?? "-"),
    (LKey.dischargeCurrent.tr, capacity?.showCanDischargeCapacity ?? "-"),
    (LKey.numberOfCycles.tr, capacity?.showCycles ?? "-"),
    (LKey.currentAlarms.tr, core?.showAlarmCount ?? "-"),
  ];

  BatteryDetailKeyMetrics();

  factory BatteryDetailKeyMetrics.fromJson(Map<String, dynamic> json) =>
      $BatteryDetailKeyMetricsFromJson(json);

  Map<String, dynamic> toJson() => $BatteryDetailKeyMetricsToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class BatteryDetailKeyMetricsCore {
  String? runStatus;
  String? soc;
  String? soh;
  String? totalVoltage;
  String? totalCurrent;
  String? remainingCapacity;
  String? maxTemperature;
  String? maxVoltageDiff;
  String? chargeDischargePermission;
  String? maxChargeCurrent;
  String? maxDischargeCurrent;
  int? alarmCount;
  String? alarmCountDesc;

  String get showRunStatusDesc => runStatus ?? "-";

  ///76%
  String get showSoc => soc == null ? "-" : '$soc';

  ///98%
  String get showSoh => soh == null ? "-" : '$soh';

  ///407.8 V
  String get showTotalVoltage => totalVoltage == null ? "-" : '$totalVoltage';

  ///8.4 A
  String get showTotalCurrent => totalCurrent == null ? "-" : '$totalCurrent';

  ///76 Ah
  String get showRemainingCapacity =>
      remainingCapacity == null ? "-" : '$remainingCapacity';

  ///28.3 °C
  String get showMaxTemp => maxTemperature == null ? "-" : '$maxTemperature';

  ///36 mV
  String get showMaxVoltageDiff =>
      maxVoltageDiff == null ? "-" : '$maxVoltageDiff';

  ///0条
  String get showAlarmCount => alarmCount == null ? "-" : '${alarmCount ?? 0}';

  BatteryDetailKeyMetricsCore();

  factory BatteryDetailKeyMetricsCore.fromJson(Map<String, dynamic> json) =>
      $BatteryDetailKeyMetricsCoreFromJson(json);

  Map<String, dynamic> toJson() => $BatteryDetailKeyMetricsCoreToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class BatteryDetailKeyMetricsExtrema {
  String? maxCellVoltage;
  String? maxCellVoltagePosition;
  String? minCellVoltage;
  String? minCellVoltagePosition;
  String? maxTempExtrema;
  String? maxTempPosition;
  String? minTempExtrema;
  String? minTempPosition;
  String? maxTempDiff;
  String? maxTempDiffPosition;

  ///最高单体电压(V)
  String get showMaxCellVoltage =>
      maxCellVoltage == null ? "-" : "$maxCellVoltage";

  ///最低单体电压(V)
  String get showMinCellVoltage =>
      minCellVoltage == null ? "-" : "$minCellVoltage";

  ///最低温度(°C)
  String get showMinTempExtrema =>
      minTempExtrema == null ? "-" : "$minTempExtrema";

  ///最高温度(°C)
  String get showMaxTempExtrema =>
      maxTempExtrema == null ? "-" : "$maxTempExtrema";

  ///1-9
  String get showMaxCellVoltagePosition =>
      maxCellVoltagePosition == null ? "-" : "$maxCellVoltagePosition";

  ///1-11
  String get showMinCellVoltagePosition =>
      minCellVoltagePosition == null ? "-" : "$minCellVoltagePosition";

  ///Pack1
  String get showMaxTempDiffPosition =>
      maxTempDiffPosition == null ? "-" : "$maxTempDiffPosition";

  List<(String, String, String)> get list => [
    (LKey.maxCellVoltage.tr, showMaxCellVoltage, showMaxCellVoltagePosition),
    (LKey.minCellVoltage.tr, showMinCellVoltage, showMinCellVoltagePosition),
    (
      "${LKey.maxTemp.tr}/${LKey.minTemp.tr}",
      "$showMaxTempExtrema/$showMinTempExtrema",
      showMaxTempDiffPosition,
    ),
  ];

  BatteryDetailKeyMetricsExtrema();

  factory BatteryDetailKeyMetricsExtrema.fromJson(Map<String, dynamic> json) =>
      $BatteryDetailKeyMetricsExtremaFromJson(json);

  Map<String, dynamic> toJson() => $BatteryDetailKeyMetricsExtremaToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class BatteryDetailKeyMetricsCapacity {
  String? canChargeCapacity;
  String? canDischargeCapacity;
  String? totalChargedEnergy;
  String? totalDischargedEnergy;
  String? cycles;
  String? heaterStatusDesc;
  String? balanceStatusDesc;
  List<BatteryDetailKeyMetricsCapacityBalancingPacks>? balancingPacks;
  String? environmentTemperature;

  ///循环次数
  String get showCycles => cycles ?? "-";

  ///24 Ah
  String get showCanChargeCapacity => canChargeCapacity ?? "-";

  ///76 Ah
  String get showCanDischargeCapacity => canDischargeCapacity ?? '-';

  BatteryDetailKeyMetricsCapacity();

  factory BatteryDetailKeyMetricsCapacity.fromJson(Map<String, dynamic> json) =>
      $BatteryDetailKeyMetricsCapacityFromJson(json);

  Map<String, dynamic> toJson() => $BatteryDetailKeyMetricsCapacityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class BatteryDetailKeyMetricsCapacityBalancingPacks {
  int? packIdx;
  String? packLabel;
  List<int>? cells;

  BatteryDetailKeyMetricsCapacityBalancingPacks();

  factory BatteryDetailKeyMetricsCapacityBalancingPacks.fromJson(
    Map<String, dynamic> json,
  ) => $BatteryDetailKeyMetricsCapacityBalancingPacksFromJson(json);

  Map<String, dynamic> toJson() =>
      $BatteryDetailKeyMetricsCapacityBalancingPacksToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class BatteryDetailAdvancedDiagnosis {
  String? current1;
  String? current2;
  String? mosMaxTemperature;
  String? heaterTemperature;
  int? packCount;

  List<BatteryDetailAdvancedDiagnosisPacks>? packs;

  List<BatteryDetailAdvancedDiagnosisPacks> get showPacks =>
      packs ?? <BatteryDetailAdvancedDiagnosisPacks>[];

  ///电池通道1(A)
  String get showCurrent1 => current1 == null ? "-" : "$current1";

  ///电池通道2(A)
  String get showCurrent2 => current2 == null ? "-" : "$current2";

  ///MOS最高温度(°C)
  String get showMosMaxTemperature =>
      mosMaxTemperature == null ? "-" : "$mosMaxTemperature";

  ///加热温度(°C)
  String get showHeaterTemperature =>
      heaterTemperature == null ? "-" : "$heaterTemperature";

  List<(String, String)> get list => [
    (LKey.current1.tr, showCurrent1),
    (LKey.current2.tr, showCurrent2),
    (LKey.mosMaxTemperature.tr, showMosMaxTemperature),
    (LKey.heaterTemperature.tr, showHeaterTemperature),
  ];

  BatteryDetailAdvancedDiagnosis();

  factory BatteryDetailAdvancedDiagnosis.fromJson(Map<String, dynamic> json) =>
      $BatteryDetailAdvancedDiagnosisFromJson(json);

  Map<String, dynamic> toJson() => $BatteryDetailAdvancedDiagnosisToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class BatteryDetailAdvancedDiagnosisPacks {
  int? packIdx;
  String? packLabel;
  String? cellPositionPrefix;
  String? cellCountDesc;
  String? cellTempCountDesc;
  int? cellCount;
  int? cellTempCount;
  String? packDesignCapacity;
  List<BatteryDetailAdvancedDiagnosisPacksCellVoltages>? cellVoltages;
  List<BatteryDetailAdvancedDiagnosisPacksCellTemperatures>? cellTemperatures;
  List<BatteryDetailAdvancedDiagnosisPacksMosTemperatures>? mosTemperatures;

  String get showPackLabel => packLabel ?? '-';

  String get showCellPositionPrefix => cellPositionPrefix ?? '-';

  List<BatteryDetailAdvancedDiagnosisPacksCellTemperatures>
  get showCellTemperatures => cellTemperatures ?? [];

  List<BatteryDetailAdvancedDiagnosisPacksCellVoltages> get showCellVoltages =>
      cellVoltages ?? [];

  BatteryDetailAdvancedDiagnosisPacks();

  factory BatteryDetailAdvancedDiagnosisPacks.fromJson(
    Map<String, dynamic> json,
  ) => $BatteryDetailAdvancedDiagnosisPacksFromJson(json);

  Map<String, dynamic> toJson() =>
      $BatteryDetailAdvancedDiagnosisPacksToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class BatteryDetailAdvancedDiagnosisPacksCellVoltages {
  int? cellNo;
  String? positionLabel;
  double? voltageMv;
  double? voltageV;
  bool? isMax;
  bool? isMin;
  bool? isBalancing;

  String get showPositionLabel => positionLabel ?? '-';

  String get showVoltageV => voltageV == null ? '-' : '${voltageV ?? 0}';

  bool get showIsMax => isMax ?? false;

  bool get showIsMin => isMin ?? false;

  // 0 普通, 1 最高(橙), 2 最低(蓝)

  int showMark() {
    if (showIsMax) {
      return 1;
    } else if (showIsMin) {
      return 2;
    } else {
      return 0;
    }
  }

  BatteryDetailAdvancedDiagnosisPacksCellVoltages();

  factory BatteryDetailAdvancedDiagnosisPacksCellVoltages.fromJson(
    Map<String, dynamic> json,
  ) => $BatteryDetailAdvancedDiagnosisPacksCellVoltagesFromJson(json);

  Map<String, dynamic> toJson() =>
      $BatteryDetailAdvancedDiagnosisPacksCellVoltagesToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class BatteryDetailAdvancedDiagnosisPacksCellTemperatures {
  int? probeNo;
  String? positionLabel;
  int? tempRawDc;
  double? tempC;
  bool? isMax;
  bool? isMin;

  // String get showPack => probeNo == null ? '' : "Pack$probeNo";

  String get showPositionLabel => positionLabel ?? "-";

  // String get showTitle => showPositionLabel;

  String get showTempC => tempC == null ? "-" : "${tempC ?? 0}°C";

  BatteryDetailAdvancedDiagnosisPacksCellTemperatures();

  factory BatteryDetailAdvancedDiagnosisPacksCellTemperatures.fromJson(
    Map<String, dynamic> json,
  ) => $BatteryDetailAdvancedDiagnosisPacksCellTemperaturesFromJson(json);

  Map<String, dynamic> toJson() =>
      $BatteryDetailAdvancedDiagnosisPacksCellTemperaturesToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class BatteryDetailAdvancedDiagnosisPacksMosTemperatures {
  int? no;
  String? positionLabel;
  double? tempC;

  String get showPack => no == null ? '' : "Pack$no";

  String get showPositionLabel => positionLabel ?? "-";

  String get showTitle => "$showPack$showPositionLabel";

  String get showTempC => tempC == null ? "-" : "${tempC ?? 0}°C";

  BatteryDetailAdvancedDiagnosisPacksMosTemperatures();

  factory BatteryDetailAdvancedDiagnosisPacksMosTemperatures.fromJson(
    Map<String, dynamic> json,
  ) => $BatteryDetailAdvancedDiagnosisPacksMosTemperaturesFromJson(json);

  Map<String, dynamic> toJson() =>
      $BatteryDetailAdvancedDiagnosisPacksMosTemperaturesToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class BatteryDetailSystemInfo {
  String? bmsFirmware;
  String? softwareVersion;
  String? hardwareVersion;
  String? bootVersion;
  String? designCapacity;
  int? packCount;
  int? cellCount;
  int? cellTempCount;
  String? deviceSn;
  String? deviceModel;
  String? platformReceiveTime;
  String? dataValidDesc;

  ///BMS固件
  String get showBmsFirmware => bmsFirmware ?? "-";

  ///软件版本
  String get showSoftwareVersion => softwareVersion ?? "-";

  ///硬件版本
  String get showHardwareVersion => hardwareVersion ?? "-";

  ///Boot版本
  String get showBootVersion => bootVersion ?? "-";

  ///设计容量
  String get showDesignCapacity => designCapacity ?? '-';

  ///Pack数量
  String get showPackCount => packCount == null ? "-" : "$packCount";

  ///单体数量
  String get showCellCount => cellCount == null ? "-" : "$cellCount";

  ///温度通道
  String get showCellTempCount =>
      cellTempCount == null ? "-" : "$cellTempCount";

  ///最后数据
  String get showPlatformReceiveTime => platformReceiveTime ?? "-";

  List<(String, String)> get list => [
    (LKey.bmsFirmware.tr, showBmsFirmware),
    (LKey.softwareVersion.tr, showSoftwareVersion),
    (LKey.hardwareVersion.tr, showHardwareVersion),
    (LKey.bootVersion.tr, showBootVersion),
    (LKey.designCapacity.tr, showDesignCapacity),
    (LKey.packCount.tr, showPackCount),
    (LKey.cellCount.tr, showCellCount),
    (LKey.cellTempCount.tr, showCellTempCount),
    (LKey.lastData.tr, showPlatformReceiveTime),
  ];

  BatteryDetailSystemInfo();

  factory BatteryDetailSystemInfo.fromJson(Map<String, dynamic> json) =>
      $BatteryDetailSystemInfoFromJson(json);

  Map<String, dynamic> toJson() => $BatteryDetailSystemInfoToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
