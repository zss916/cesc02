import 'dart:convert';

import 'package:cesc01/generated/json/base/json_field.dart';
import 'package:cesc01/generated/json/battery_data_entity.g.dart';

export 'package:cesc01/generated/json/battery_data_entity.g.dart';

@JsonSerializable()
class BatteryDataEntity {
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
  BatteryDataSummary? summary;
  BatteryDataRunningProtection? runningProtection;
  BatteryDataEnergy? energy;
  BatteryDataTrend? trend;
  BatteryDataExtrema? extrema;
  BatteryDataDiagnosis? diagnosis;
  BatteryDataAlarmInfo? alarmInfo;
  BatteryDataSystemInfo? systemInfo;
  List<BatteryDataClusters>? clusters;

  BatteryDataEntity();

  factory BatteryDataEntity.fromJson(Map<String, dynamic> json) =>
      $BatteryDataEntityFromJson(json);

  Map<String, dynamic> toJson() => $BatteryDataEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class BatteryDataSummary {
  String? soc;
  String? soh;
  String? totalVoltage;
  String? totalCurrent;
  String? maxTemperature;
  String? maxVoltageDiff;

  BatteryDataSummary();

  factory BatteryDataSummary.fromJson(Map<String, dynamic> json) =>
      $BatteryDataSummaryFromJson(json);

  Map<String, dynamic> toJson() => $BatteryDataSummaryToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class BatteryDataRunningProtection {
  String? runStatus;
  String? chargeDischargePermission;
  String? maxChargeCurrent;
  String? maxDischargeCurrent;
  String? current1;
  String? current2;
  int? cycles;
  int? heaterStatus;

  BatteryDataRunningProtection();

  factory BatteryDataRunningProtection.fromJson(Map<String, dynamic> json) =>
      $BatteryDataRunningProtectionFromJson(json);

  Map<String, dynamic> toJson() => $BatteryDataRunningProtectionToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class BatteryDataEnergy {
  String? remainingKwh;
  String? canChargeKwh;
  String? canDischargeKwh;
  String? totalChargedKwh;
  String? totalDischargedKwh;
  String? maxTemperatureDiff;

  BatteryDataEnergy();

  factory BatteryDataEnergy.fromJson(Map<String, dynamic> json) =>
      $BatteryDataEnergyFromJson(json);

  Map<String, dynamic> toJson() => $BatteryDataEnergyToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class BatteryDataTrend {
  int? intervalMinutes;
  int? expectedPoints;
  String? timezone;
  List<BatteryDataTrendPoints>? points;

  BatteryDataTrend();

  factory BatteryDataTrend.fromJson(Map<String, dynamic> json) =>
      $BatteryDataTrendFromJson(json);

  Map<String, dynamic> toJson() => $BatteryDataTrendToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class BatteryDataTrendPoints {
  int? timestamp;
  int? soc;
  int? voltage;
  int? current;

  BatteryDataTrendPoints();

  factory BatteryDataTrendPoints.fromJson(Map<String, dynamic> json) =>
      $BatteryDataTrendPointsFromJson(json);

  Map<String, dynamic> toJson() => $BatteryDataTrendPointsToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class BatteryDataExtrema {
  BatteryDataExtremaMaxCellVoltage? maxCellVoltage;
  BatteryDataExtremaMinCellVoltage? minCellVoltage;
  BatteryDataExtremaMaxTemperature? maxTemperature;
  BatteryDataExtremaMinTemperature? minTemperature;

  BatteryDataExtrema();

  factory BatteryDataExtrema.fromJson(Map<String, dynamic> json) =>
      $BatteryDataExtremaFromJson(json);

  Map<String, dynamic> toJson() => $BatteryDataExtremaToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class BatteryDataExtremaMaxCellVoltage {
  String? value;
  int? clusterId;
  int? packNo;
  int? cellNo;

  BatteryDataExtremaMaxCellVoltage();

  factory BatteryDataExtremaMaxCellVoltage.fromJson(
    Map<String, dynamic> json,
  ) => $BatteryDataExtremaMaxCellVoltageFromJson(json);

  Map<String, dynamic> toJson() =>
      $BatteryDataExtremaMaxCellVoltageToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class BatteryDataExtremaMinCellVoltage {
  String? value;
  int? clusterId;
  int? packNo;
  int? cellNo;

  BatteryDataExtremaMinCellVoltage();

  factory BatteryDataExtremaMinCellVoltage.fromJson(
    Map<String, dynamic> json,
  ) => $BatteryDataExtremaMinCellVoltageFromJson(json);

  Map<String, dynamic> toJson() =>
      $BatteryDataExtremaMinCellVoltageToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class BatteryDataExtremaMaxTemperature {
  String? value;
  int? clusterId;
  int? packNo;
  int? probeNo;

  BatteryDataExtremaMaxTemperature();

  factory BatteryDataExtremaMaxTemperature.fromJson(
    Map<String, dynamic> json,
  ) => $BatteryDataExtremaMaxTemperatureFromJson(json);

  Map<String, dynamic> toJson() =>
      $BatteryDataExtremaMaxTemperatureToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class BatteryDataExtremaMinTemperature {
  String? value;
  int? clusterId;
  int? packNo;
  int? probeNo;

  BatteryDataExtremaMinTemperature();

  factory BatteryDataExtremaMinTemperature.fromJson(
    Map<String, dynamic> json,
  ) => $BatteryDataExtremaMinTemperatureFromJson(json);

  Map<String, dynamic> toJson() =>
      $BatteryDataExtremaMinTemperatureToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class BatteryDataDiagnosis {
  List<BatteryDataDiagnosisPacks>? packs;

  BatteryDataDiagnosis();

  factory BatteryDataDiagnosis.fromJson(Map<String, dynamic> json) =>
      $BatteryDataDiagnosisFromJson(json);

  Map<String, dynamic> toJson() => $BatteryDataDiagnosisToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class BatteryDataDiagnosisPacks {
  int? packNo;
  int? cellCount;
  int? cellTempCount;
  String? soh;
  String? environmentTemperature;
  String? heaterTemperature;
  int? balance;
  List<int>? balancingCells;
  List<BatteryDataDiagnosisPacksCellVoltages>? cellVoltages;
  List<BatteryDataDiagnosisPacksCellTemperatures>? cellTemperatures;
  List<BatteryDataDiagnosisPacksMosTemperatures>? mosTemperatures;

  BatteryDataDiagnosisPacks();

  factory BatteryDataDiagnosisPacks.fromJson(Map<String, dynamic> json) =>
      $BatteryDataDiagnosisPacksFromJson(json);

  Map<String, dynamic> toJson() => $BatteryDataDiagnosisPacksToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class BatteryDataDiagnosisPacksCellVoltages {
  int? cellNo;
  int? voltageMv;
  int? voltageV;
  bool? isMax;
  bool? isMin;
  bool? isBalancing;

  BatteryDataDiagnosisPacksCellVoltages();

  factory BatteryDataDiagnosisPacksCellVoltages.fromJson(
    Map<String, dynamic> json,
  ) => $BatteryDataDiagnosisPacksCellVoltagesFromJson(json);

  Map<String, dynamic> toJson() =>
      $BatteryDataDiagnosisPacksCellVoltagesToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class BatteryDataDiagnosisPacksCellTemperatures {
  int? probeNo;
  int? tempRawDc;
  int? tempC;
  bool? isMax;
  bool? isMin;

  BatteryDataDiagnosisPacksCellTemperatures();

  factory BatteryDataDiagnosisPacksCellTemperatures.fromJson(
    Map<String, dynamic> json,
  ) => $BatteryDataDiagnosisPacksCellTemperaturesFromJson(json);

  Map<String, dynamic> toJson() =>
      $BatteryDataDiagnosisPacksCellTemperaturesToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class BatteryDataDiagnosisPacksMosTemperatures {
  int? no;
  int? tempC;

  BatteryDataDiagnosisPacksMosTemperatures();

  factory BatteryDataDiagnosisPacksMosTemperatures.fromJson(
    Map<String, dynamic> json,
  ) => $BatteryDataDiagnosisPacksMosTemperaturesFromJson(json);

  Map<String, dynamic> toJson() =>
      $BatteryDataDiagnosisPacksMosTemperaturesToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class BatteryDataAlarmInfo {
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

  BatteryDataAlarmInfo();

  factory BatteryDataAlarmInfo.fromJson(Map<String, dynamic> json) =>
      $BatteryDataAlarmInfoFromJson(json);

  Map<String, dynamic> toJson() => $BatteryDataAlarmInfoToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class BatteryDataSystemInfo {
  String? stackSn;
  String? clusterSn;
  int? clusterNo;
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

  BatteryDataSystemInfo();

  factory BatteryDataSystemInfo.fromJson(Map<String, dynamic> json) =>
      $BatteryDataSystemInfoFromJson(json);

  Map<String, dynamic> toJson() => $BatteryDataSystemInfoToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class BatteryDataClusters {
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

  BatteryDataClusters();

  factory BatteryDataClusters.fromJson(Map<String, dynamic> json) =>
      $BatteryDataClustersFromJson(json);

  Map<String, dynamic> toJson() => $BatteryDataClustersToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
