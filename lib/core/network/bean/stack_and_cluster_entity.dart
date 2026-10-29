import 'dart:convert';

import 'package:cesc01/generated/json/base/json_field.dart';
import 'package:cesc01/generated/json/stack_and_cluster_entity.g.dart';

export 'package:cesc01/generated/json/stack_and_cluster_entity.g.dart';

@JsonSerializable()
class StackAndClusterEntity {
  String? scope;
  int? stackId;
  int? clusterId;
  String? stackSn;
  String? clusterSn;
  String? stackName;
  String? clusterName;
  String? firmwareVersion;
  int? sysMode;
  String? commStatus;
  int? clusterCount;
  int? packCount;
  int? alarmClusterCount;
  String? lastDataTime;
  String? timezone;
  StackAndClusterSummary? summary;
  StackAndClusterRunningProtection? runningProtection;
  StackAndClusterEnergy? energy;
  StackAndClusterTrend? trend;
  StackAndClusterExtrema? extrema;
  StackAndClusterDiagnosis? diagnosis;
  StackAndClusterAlarmInfo? alarmInfo;
  StackAndClusterSystemInfo? systemInfo;
  List<StackAndClusterClusters>? clusters;

  String get showCommStatus => commStatus ?? '-';

  String get showClusterSn => clusterSn ?? '-';

  String get showLastDataTime => lastDataTime ?? '-';

  String get showClusterCount =>
      clusterCount == null ? '-' : "${clusterCount ?? 0}";

  String get showFirmwareVersion => firmwareVersion ?? '-';

  String get showClusterName => clusterName ?? '-';

  String get showStackName => stackName ?? '-';

  String get showPackCount => packCount == null ? "-" : '${packCount ?? 0}';

  StackAndClusterEntity();

  factory StackAndClusterEntity.fromJson(Map<String, dynamic> json) =>
      $StackAndClusterEntityFromJson(json);

  Map<String, dynamic> toJson() => $StackAndClusterEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class StackAndClusterSummary {
  String? soc;
  String? soh;
  String? totalVoltage;
  String? totalCurrent;
  String? maxTemperature;
  String? maxVoltageDiff;

  String get showSoc => soc ?? '-';
  String get showSoh => soh ?? '-';
  String get showTotalVoltage => totalVoltage ?? '-';
  String get showTotalCurrent => totalCurrent ?? '-';
  String get showMaxTemperature => maxTemperature ?? '-';
  String get showMaxVoltageDiff => maxVoltageDiff ?? '-';

  StackAndClusterSummary();

  factory StackAndClusterSummary.fromJson(Map<String, dynamic> json) =>
      $StackAndClusterSummaryFromJson(json);

  Map<String, dynamic> toJson() => $StackAndClusterSummaryToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class StackAndClusterRunningProtection {
  ///运行状态：SELF_CHECK / WAITING_FOR_ADDRESS / STANDBY / CHARGING / DISCHARGING / SLEEP / FAULT_PROTECTION；离线为 null。

  String? runStatus;
  String? chargeDischargePermission;
  String? maxChargeCurrent;
  String? maxDischargeCurrent;
  String? current1;
  String? current2;
  int? cycles;
  int? heaterStatus;

  int get showHeaterStatus => heaterStatus ?? -1;
  String get showCycles => cycles == null ? '-' : '${cycles ?? 0}';
  String get showRunStatus => runStatus ?? '-';
  String get showMaxChargeCurrent => maxChargeCurrent ?? '-';
  String get showMaxDischargeCurrent => maxDischargeCurrent ?? '-';

  StackAndClusterRunningProtection();

  factory StackAndClusterRunningProtection.fromJson(
    Map<String, dynamic> json,
  ) => $StackAndClusterRunningProtectionFromJson(json);

  Map<String, dynamic> toJson() =>
      $StackAndClusterRunningProtectionToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class StackAndClusterEnergy {
  String? remainingKwh;
  String? canChargeKwh;
  String? canDischargeKwh;
  String? totalChargedKwh;
  String? totalDischargedKwh;
  String? maxTemperatureDiff;

  String get showMaxTemperatureDiff => maxTemperatureDiff ?? '--';
  String get showRemainingKwh => remainingKwh ?? '--';
  String get showCanChargeKwh => canChargeKwh ?? '--';
  String get showCanDischargeKwh => canDischargeKwh ?? '--';
  String get showTotalChargedKwh => totalChargedKwh ?? '--';
  String get showTotalDischargedKwh => totalDischargedKwh ?? '--';

  StackAndClusterEnergy();

  factory StackAndClusterEnergy.fromJson(Map<String, dynamic> json) =>
      $StackAndClusterEnergyFromJson(json);

  Map<String, dynamic> toJson() => $StackAndClusterEnergyToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class StackAndClusterTrend {
  int? intervalMinutes;
  int? expectedPoints;
  String? timezone;
  List<StackAndClusterTrendPoints>? points;

  StackAndClusterTrend();

  factory StackAndClusterTrend.fromJson(Map<String, dynamic> json) =>
      $StackAndClusterTrendFromJson(json);

  Map<String, dynamic> toJson() => $StackAndClusterTrendToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class StackAndClusterTrendPoints {
  int? timestamp;
  double? soc;
  double? voltage;
  double? current;

  StackAndClusterTrendPoints();

  factory StackAndClusterTrendPoints.fromJson(Map<String, dynamic> json) =>
      $StackAndClusterTrendPointsFromJson(json);

  Map<String, dynamic> toJson() => $StackAndClusterTrendPointsToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class StackAndClusterExtrema {
  StackAndClusterExtremaMaxCellVoltage? maxCellVoltage;
  StackAndClusterExtremaMinCellVoltage? minCellVoltage;
  StackAndClusterExtremaMaxTemperature? maxTemperature;
  StackAndClusterExtremaMinTemperature? minTemperature;

  String formatData({int? a, int? b, int? c}) {
    final list = [
      if (a != null) '簇 $a',
      if (b != null) 'Pack $b',
      if (c != null) '单体 $c',
    ];
    return list.isEmpty ? '--' : list.join(' / ');
  }

  String get showMaxCellVoltage => maxCellVoltage?.value ?? '-';
  String get showMaxCellVoltageTitle => formatData(
    a: maxCellVoltage?.clusterId,
    b: maxCellVoltage?.packNo,
    c: maxCellVoltage?.cellNo,
  );

  ///
  String get showMinCellVoltage => minCellVoltage?.value ?? '-';
  String get showMinCellVoltageTitle => formatData(
    a: minCellVoltage?.clusterId,
    b: minCellVoltage?.packNo,
    c: minCellVoltage?.cellNo,
  );

  ///
  String get showMaxTemperature => maxTemperature?.value ?? '-';
  String get showMaxTemperatureTitle => formatData(
    a: maxTemperature?.clusterId,
    b: maxTemperature?.packNo,
    c: maxTemperature?.probeNo,
  );

  ///
  String get showMinTemperature => minTemperature?.value ?? '-';
  String get showMinTemperatureTitle => formatData(
    a: minTemperature?.clusterId,
    b: minTemperature?.packNo,
    c: minTemperature?.probeNo,
  );

  StackAndClusterExtrema();

  factory StackAndClusterExtrema.fromJson(Map<String, dynamic> json) =>
      $StackAndClusterExtremaFromJson(json);

  Map<String, dynamic> toJson() => $StackAndClusterExtremaToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class StackAndClusterExtremaMaxCellVoltage {
  String? value;
  int? clusterId;
  int? packNo;
  int? cellNo;

  StackAndClusterExtremaMaxCellVoltage();

  factory StackAndClusterExtremaMaxCellVoltage.fromJson(
    Map<String, dynamic> json,
  ) => $StackAndClusterExtremaMaxCellVoltageFromJson(json);

  Map<String, dynamic> toJson() =>
      $StackAndClusterExtremaMaxCellVoltageToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class StackAndClusterExtremaMinCellVoltage {
  String? value;
  int? clusterId;
  int? packNo;
  int? cellNo;

  StackAndClusterExtremaMinCellVoltage();

  factory StackAndClusterExtremaMinCellVoltage.fromJson(
    Map<String, dynamic> json,
  ) => $StackAndClusterExtremaMinCellVoltageFromJson(json);

  Map<String, dynamic> toJson() =>
      $StackAndClusterExtremaMinCellVoltageToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class StackAndClusterExtremaMaxTemperature {
  String? value;
  int? clusterId;
  int? packNo;
  int? probeNo;

  StackAndClusterExtremaMaxTemperature();

  factory StackAndClusterExtremaMaxTemperature.fromJson(
    Map<String, dynamic> json,
  ) => $StackAndClusterExtremaMaxTemperatureFromJson(json);

  Map<String, dynamic> toJson() =>
      $StackAndClusterExtremaMaxTemperatureToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class StackAndClusterExtremaMinTemperature {
  String? value;
  int? clusterId;
  int? packNo;
  int? probeNo;

  StackAndClusterExtremaMinTemperature();

  factory StackAndClusterExtremaMinTemperature.fromJson(
    Map<String, dynamic> json,
  ) => $StackAndClusterExtremaMinTemperatureFromJson(json);

  Map<String, dynamic> toJson() =>
      $StackAndClusterExtremaMinTemperatureToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class StackAndClusterDiagnosis {
  List<StackAndClusterDiagnosisPacks>? packs;

  List<StackAndClusterDiagnosisPacks> get showPacks => packs ?? [];

  StackAndClusterDiagnosis();

  factory StackAndClusterDiagnosis.fromJson(Map<String, dynamic> json) =>
      $StackAndClusterDiagnosisFromJson(json);

  Map<String, dynamic> toJson() => $StackAndClusterDiagnosisToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class StackAndClusterDiagnosisPacks {
  String? packNo;
  int? cellCount;
  int? cellTempCount;
  String? soh;
  String? environmentTemperature;
  String? heaterTemperature;
  int? balance;
  List<int>? balancingCells;
  List<StackAndClusterDiagnosisPacksCellVoltages>? cellVoltages;
  List<StackAndClusterDiagnosisPacksCellTemperatures>? cellTemperatures;
  List<StackAndClusterDiagnosisPacksMosTemperatures>? mosTemperatures;

  StackAndClusterDiagnosisPacks();

  factory StackAndClusterDiagnosisPacks.fromJson(Map<String, dynamic> json) =>
      $StackAndClusterDiagnosisPacksFromJson(json);

  Map<String, dynamic> toJson() => $StackAndClusterDiagnosisPacksToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class StackAndClusterDiagnosisPacksCellVoltages {
  String? cellNo;
  num? voltageMv;
  num? voltageV;
  bool? isMax;
  bool? isMin;
  bool? isBalancing;

  StackAndClusterDiagnosisPacksCellVoltages();

  factory StackAndClusterDiagnosisPacksCellVoltages.fromJson(
    Map<String, dynamic> json,
  ) => $StackAndClusterDiagnosisPacksCellVoltagesFromJson(json);

  Map<String, dynamic> toJson() =>
      $StackAndClusterDiagnosisPacksCellVoltagesToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class StackAndClusterDiagnosisPacksCellTemperatures {
  int? probeNo;
  int? tempRawDc;
  int? tempC;
  bool? isMax;
  bool? isMin;

  StackAndClusterDiagnosisPacksCellTemperatures();

  factory StackAndClusterDiagnosisPacksCellTemperatures.fromJson(
    Map<String, dynamic> json,
  ) => $StackAndClusterDiagnosisPacksCellTemperaturesFromJson(json);

  Map<String, dynamic> toJson() =>
      $StackAndClusterDiagnosisPacksCellTemperaturesToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class StackAndClusterDiagnosisPacksMosTemperatures {
  int? no;
  int? tempC;

  StackAndClusterDiagnosisPacksMosTemperatures();

  factory StackAndClusterDiagnosisPacksMosTemperatures.fromJson(
    Map<String, dynamic> json,
  ) => $StackAndClusterDiagnosisPacksMosTemperaturesFromJson(json);

  Map<String, dynamic> toJson() =>
      $StackAndClusterDiagnosisPacksMosTemperaturesToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class StackAndClusterAlarmInfo {
  String? status;
  int? siteId;
  String? siteName;
  String? domainType;
  String? stackSn;
  String? stackName;
  String? clusterSn;
  String? clusterName;
  int? alarmLevel;
  int? packNo;
  int? cellNo;

  ///ACTIVE / NONE
  String get showStatus => status ?? "-";
  String get showSiteName => siteName ?? "-";
  String get showClusterName => clusterName ?? "-";
  String get showStackName => stackName ?? "-";
  String get showStackSn => stackSn ?? "-";
  int get showAlarmLevel => alarmLevel ?? -2;

  ///CLUSTER, STACK
  String get showDomainType => domainType ?? "-";

  StackAndClusterAlarmInfo();

  factory StackAndClusterAlarmInfo.fromJson(Map<String, dynamic> json) =>
      $StackAndClusterAlarmInfoFromJson(json);

  Map<String, dynamic> toJson() => $StackAndClusterAlarmInfoToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class StackAndClusterSystemInfo {
  String? stackSn;
  String? clusterSn;
  String? clusterNo;
  String? softwareVersion;
  String? hardwareVersion;
  String? bootVersion;
  int? designMah;
  String? designCapacity;
  int? packCount;
  int? packCellCount;
  int? packTempCount;
  int? sysMode;
  int? accessMode;

  int get showAccessMode => accessMode ?? -1;
  String get showClusterNo => clusterNo ?? '-';
  String get showStackSn => stackSn ?? '-';
  String get showClusterSn => clusterSn ?? '-';
  String get showSoftwareVersion => softwareVersion ?? '-';
  String get showHardwareVersion => hardwareVersion ?? '-';
  String get showBootVersion => bootVersion ?? '-';
  String get showDesignCapacity => designCapacity ?? '-';
  String get showPackCount => packCount == null ? "-" : '${packCount ?? 0}';
  int get showMode => sysMode ?? -1;
  String get showPackCellCount =>
      packCellCount == null ? "-" : '${packCellCount ?? 0}';
  String get showPackTempCount =>
      packTempCount == null ? "-" : '${packTempCount ?? 0}';

  StackAndClusterSystemInfo();

  factory StackAndClusterSystemInfo.fromJson(Map<String, dynamic> json) =>
      $StackAndClusterSystemInfoFromJson(json);

  Map<String, dynamic> toJson() => $StackAndClusterSystemInfoToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class StackAndClusterClusters {
  int? clusterId;
  String? clusterSn;
  int? clusterNo;
  String? clusterName;
  int? packCount;
  String? commStatus;
  String? soc;
  String? soh;
  String? totalVoltage;
  String? totalCurrent;
  String? maxTemperature;
  String? maxVoltageDiff;
  String? lastDataTime;

  StackAndClusterClusters();

  factory StackAndClusterClusters.fromJson(Map<String, dynamic> json) =>
      $StackAndClusterClustersFromJson(json);

  Map<String, dynamic> toJson() => $StackAndClusterClustersToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
