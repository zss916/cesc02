import 'package:cesc01/core/network/bean/battery_data_entity.dart';
import 'package:cesc01/generated/json/base/json_convert_content.dart';

BatteryDataEntity $BatteryDataEntityFromJson(Map<String, dynamic> json) {
  final BatteryDataEntity batteryDataEntity = BatteryDataEntity();
  final String? scope = jsonConvert.convert<String>(json['scope']);
  if (scope != null) {
    batteryDataEntity.scope = scope;
  }
  final int? stackId = jsonConvert.convert<int>(json['stackId']);
  if (stackId != null) {
    batteryDataEntity.stackId = stackId;
  }
  final int? clusterId = jsonConvert.convert<int>(json['clusterId']);
  if (clusterId != null) {
    batteryDataEntity.clusterId = clusterId;
  }
  final String? stackSn = jsonConvert.convert<String>(json['stackSn']);
  if (stackSn != null) {
    batteryDataEntity.stackSn = stackSn;
  }
  final String? clusterSn = jsonConvert.convert<String>(json['clusterSn']);
  if (clusterSn != null) {
    batteryDataEntity.clusterSn = clusterSn;
  }
  final String? stackName = jsonConvert.convert<String>(json['stackName']);
  if (stackName != null) {
    batteryDataEntity.stackName = stackName;
  }
  final String? clusterName = jsonConvert.convert<String>(json['clusterName']);
  if (clusterName != null) {
    batteryDataEntity.clusterName = clusterName;
  }
  final String? firmwareVersion = jsonConvert.convert<String>(
    json['firmwareVersion'],
  );
  if (firmwareVersion != null) {
    batteryDataEntity.firmwareVersion = firmwareVersion;
  }
  final int? sysMode = jsonConvert.convert<int>(json['sysMode']);
  if (sysMode != null) {
    batteryDataEntity.sysMode = sysMode;
  }
  final String? commStatus = jsonConvert.convert<String>(json['commStatus']);
  if (commStatus != null) {
    batteryDataEntity.commStatus = commStatus;
  }
  final int? clusterCount = jsonConvert.convert<int>(json['clusterCount']);
  if (clusterCount != null) {
    batteryDataEntity.clusterCount = clusterCount;
  }
  final int? packCount = jsonConvert.convert<int>(json['packCount']);
  if (packCount != null) {
    batteryDataEntity.packCount = packCount;
  }
  final int? alarmClusterCount = jsonConvert.convert<int>(
    json['alarmClusterCount'],
  );
  if (alarmClusterCount != null) {
    batteryDataEntity.alarmClusterCount = alarmClusterCount;
  }
  final String? lastDataTime = jsonConvert.convert<String>(
    json['lastDataTime'],
  );
  if (lastDataTime != null) {
    batteryDataEntity.lastDataTime = lastDataTime;
  }
  final String? timezone = jsonConvert.convert<String>(json['timezone']);
  if (timezone != null) {
    batteryDataEntity.timezone = timezone;
  }
  final BatteryDataSummary? summary = jsonConvert.convert<BatteryDataSummary>(
    json['summary'],
  );
  if (summary != null) {
    batteryDataEntity.summary = summary;
  }
  final BatteryDataRunningProtection? runningProtection = jsonConvert
      .convert<BatteryDataRunningProtection>(json['runningProtection']);
  if (runningProtection != null) {
    batteryDataEntity.runningProtection = runningProtection;
  }
  final BatteryDataEnergy? energy = jsonConvert.convert<BatteryDataEnergy>(
    json['energy'],
  );
  if (energy != null) {
    batteryDataEntity.energy = energy;
  }
  final BatteryDataTrend? trend = jsonConvert.convert<BatteryDataTrend>(
    json['trend'],
  );
  if (trend != null) {
    batteryDataEntity.trend = trend;
  }
  final BatteryDataExtrema? extrema = jsonConvert.convert<BatteryDataExtrema>(
    json['extrema'],
  );
  if (extrema != null) {
    batteryDataEntity.extrema = extrema;
  }
  final BatteryDataDiagnosis? diagnosis = jsonConvert
      .convert<BatteryDataDiagnosis>(json['diagnosis']);
  if (diagnosis != null) {
    batteryDataEntity.diagnosis = diagnosis;
  }
  final BatteryDataAlarmInfo? alarmInfo = jsonConvert
      .convert<BatteryDataAlarmInfo>(json['alarmInfo']);
  if (alarmInfo != null) {
    batteryDataEntity.alarmInfo = alarmInfo;
  }
  final BatteryDataSystemInfo? systemInfo = jsonConvert
      .convert<BatteryDataSystemInfo>(json['systemInfo']);
  if (systemInfo != null) {
    batteryDataEntity.systemInfo = systemInfo;
  }
  final List<BatteryDataClusters>? clusters =
      (json['clusters'] as List<dynamic>?)
          ?.map(
            (e) =>
                jsonConvert.convert<BatteryDataClusters>(e)
                    as BatteryDataClusters,
          )
          .toList();
  if (clusters != null) {
    batteryDataEntity.clusters = clusters;
  }
  return batteryDataEntity;
}

Map<String, dynamic> $BatteryDataEntityToJson(BatteryDataEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['scope'] = entity.scope;
  data['stackId'] = entity.stackId;
  data['clusterId'] = entity.clusterId;
  data['stackSn'] = entity.stackSn;
  data['clusterSn'] = entity.clusterSn;
  data['stackName'] = entity.stackName;
  data['clusterName'] = entity.clusterName;
  data['firmwareVersion'] = entity.firmwareVersion;
  data['sysMode'] = entity.sysMode;
  data['commStatus'] = entity.commStatus;
  data['clusterCount'] = entity.clusterCount;
  data['packCount'] = entity.packCount;
  data['alarmClusterCount'] = entity.alarmClusterCount;
  data['lastDataTime'] = entity.lastDataTime;
  data['timezone'] = entity.timezone;
  data['summary'] = entity.summary?.toJson();
  data['runningProtection'] = entity.runningProtection?.toJson();
  data['energy'] = entity.energy?.toJson();
  data['trend'] = entity.trend?.toJson();
  data['extrema'] = entity.extrema?.toJson();
  data['diagnosis'] = entity.diagnosis?.toJson();
  data['alarmInfo'] = entity.alarmInfo?.toJson();
  data['systemInfo'] = entity.systemInfo?.toJson();
  data['clusters'] = entity.clusters?.map((v) => v.toJson()).toList();
  return data;
}

extension BatteryDataEntityExtension on BatteryDataEntity {
  BatteryDataEntity copyWith({
    String? scope,
    int? stackId,
    int? clusterId,
    String? stackSn,
    String? clusterSn,
    String? stackName,
    String? clusterName,
    String? firmwareVersion,
    int? sysMode,
    String? commStatus,
    int? clusterCount,
    int? packCount,
    int? alarmClusterCount,
    String? lastDataTime,
    String? timezone,
    BatteryDataSummary? summary,
    BatteryDataRunningProtection? runningProtection,
    BatteryDataEnergy? energy,
    BatteryDataTrend? trend,
    BatteryDataExtrema? extrema,
    BatteryDataDiagnosis? diagnosis,
    BatteryDataAlarmInfo? alarmInfo,
    BatteryDataSystemInfo? systemInfo,
    List<BatteryDataClusters>? clusters,
  }) {
    return BatteryDataEntity()
      ..scope = scope ?? this.scope
      ..stackId = stackId ?? this.stackId
      ..clusterId = clusterId ?? this.clusterId
      ..stackSn = stackSn ?? this.stackSn
      ..clusterSn = clusterSn ?? this.clusterSn
      ..stackName = stackName ?? this.stackName
      ..clusterName = clusterName ?? this.clusterName
      ..firmwareVersion = firmwareVersion ?? this.firmwareVersion
      ..sysMode = sysMode ?? this.sysMode
      ..commStatus = commStatus ?? this.commStatus
      ..clusterCount = clusterCount ?? this.clusterCount
      ..packCount = packCount ?? this.packCount
      ..alarmClusterCount = alarmClusterCount ?? this.alarmClusterCount
      ..lastDataTime = lastDataTime ?? this.lastDataTime
      ..timezone = timezone ?? this.timezone
      ..summary = summary ?? this.summary
      ..runningProtection = runningProtection ?? this.runningProtection
      ..energy = energy ?? this.energy
      ..trend = trend ?? this.trend
      ..extrema = extrema ?? this.extrema
      ..diagnosis = diagnosis ?? this.diagnosis
      ..alarmInfo = alarmInfo ?? this.alarmInfo
      ..systemInfo = systemInfo ?? this.systemInfo
      ..clusters = clusters ?? this.clusters;
  }
}

BatteryDataSummary $BatteryDataSummaryFromJson(Map<String, dynamic> json) {
  final BatteryDataSummary batteryDataSummary = BatteryDataSummary();
  final String? soc = jsonConvert.convert<String>(json['soc']);
  if (soc != null) {
    batteryDataSummary.soc = soc;
  }
  final String? soh = jsonConvert.convert<String>(json['soh']);
  if (soh != null) {
    batteryDataSummary.soh = soh;
  }
  final String? totalVoltage = jsonConvert.convert<String>(
    json['totalVoltage'],
  );
  if (totalVoltage != null) {
    batteryDataSummary.totalVoltage = totalVoltage;
  }
  final String? totalCurrent = jsonConvert.convert<String>(
    json['totalCurrent'],
  );
  if (totalCurrent != null) {
    batteryDataSummary.totalCurrent = totalCurrent;
  }
  final String? maxTemperature = jsonConvert.convert<String>(
    json['maxTemperature'],
  );
  if (maxTemperature != null) {
    batteryDataSummary.maxTemperature = maxTemperature;
  }
  final String? maxVoltageDiff = jsonConvert.convert<String>(
    json['maxVoltageDiff'],
  );
  if (maxVoltageDiff != null) {
    batteryDataSummary.maxVoltageDiff = maxVoltageDiff;
  }
  return batteryDataSummary;
}

Map<String, dynamic> $BatteryDataSummaryToJson(BatteryDataSummary entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['soc'] = entity.soc;
  data['soh'] = entity.soh;
  data['totalVoltage'] = entity.totalVoltage;
  data['totalCurrent'] = entity.totalCurrent;
  data['maxTemperature'] = entity.maxTemperature;
  data['maxVoltageDiff'] = entity.maxVoltageDiff;
  return data;
}

extension BatteryDataSummaryExtension on BatteryDataSummary {
  BatteryDataSummary copyWith({
    String? soc,
    String? soh,
    String? totalVoltage,
    String? totalCurrent,
    String? maxTemperature,
    String? maxVoltageDiff,
  }) {
    return BatteryDataSummary()
      ..soc = soc ?? this.soc
      ..soh = soh ?? this.soh
      ..totalVoltage = totalVoltage ?? this.totalVoltage
      ..totalCurrent = totalCurrent ?? this.totalCurrent
      ..maxTemperature = maxTemperature ?? this.maxTemperature
      ..maxVoltageDiff = maxVoltageDiff ?? this.maxVoltageDiff;
  }
}

BatteryDataRunningProtection $BatteryDataRunningProtectionFromJson(
  Map<String, dynamic> json,
) {
  final BatteryDataRunningProtection batteryDataRunningProtection =
      BatteryDataRunningProtection();
  final String? runStatus = jsonConvert.convert<String>(json['runStatus']);
  if (runStatus != null) {
    batteryDataRunningProtection.runStatus = runStatus;
  }
  final String? chargeDischargePermission = jsonConvert.convert<String>(
    json['chargeDischargePermission'],
  );
  if (chargeDischargePermission != null) {
    batteryDataRunningProtection.chargeDischargePermission =
        chargeDischargePermission;
  }
  final String? maxChargeCurrent = jsonConvert.convert<String>(
    json['maxChargeCurrent'],
  );
  if (maxChargeCurrent != null) {
    batteryDataRunningProtection.maxChargeCurrent = maxChargeCurrent;
  }
  final String? maxDischargeCurrent = jsonConvert.convert<String>(
    json['maxDischargeCurrent'],
  );
  if (maxDischargeCurrent != null) {
    batteryDataRunningProtection.maxDischargeCurrent = maxDischargeCurrent;
  }
  final String? current1 = jsonConvert.convert<String>(json['current1']);
  if (current1 != null) {
    batteryDataRunningProtection.current1 = current1;
  }
  final String? current2 = jsonConvert.convert<String>(json['current2']);
  if (current2 != null) {
    batteryDataRunningProtection.current2 = current2;
  }
  final int? cycles = jsonConvert.convert<int>(json['cycles']);
  if (cycles != null) {
    batteryDataRunningProtection.cycles = cycles;
  }
  final int? heaterStatus = jsonConvert.convert<int>(json['heaterStatus']);
  if (heaterStatus != null) {
    batteryDataRunningProtection.heaterStatus = heaterStatus;
  }
  return batteryDataRunningProtection;
}

Map<String, dynamic> $BatteryDataRunningProtectionToJson(
  BatteryDataRunningProtection entity,
) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['runStatus'] = entity.runStatus;
  data['chargeDischargePermission'] = entity.chargeDischargePermission;
  data['maxChargeCurrent'] = entity.maxChargeCurrent;
  data['maxDischargeCurrent'] = entity.maxDischargeCurrent;
  data['current1'] = entity.current1;
  data['current2'] = entity.current2;
  data['cycles'] = entity.cycles;
  data['heaterStatus'] = entity.heaterStatus;
  return data;
}

extension BatteryDataRunningProtectionExtension
    on BatteryDataRunningProtection {
  BatteryDataRunningProtection copyWith({
    String? runStatus,
    String? chargeDischargePermission,
    String? maxChargeCurrent,
    String? maxDischargeCurrent,
    String? current1,
    String? current2,
    int? cycles,
    int? heaterStatus,
  }) {
    return BatteryDataRunningProtection()
      ..runStatus = runStatus ?? this.runStatus
      ..chargeDischargePermission =
          chargeDischargePermission ?? this.chargeDischargePermission
      ..maxChargeCurrent = maxChargeCurrent ?? this.maxChargeCurrent
      ..maxDischargeCurrent = maxDischargeCurrent ?? this.maxDischargeCurrent
      ..current1 = current1 ?? this.current1
      ..current2 = current2 ?? this.current2
      ..cycles = cycles ?? this.cycles
      ..heaterStatus = heaterStatus ?? this.heaterStatus;
  }
}

BatteryDataEnergy $BatteryDataEnergyFromJson(Map<String, dynamic> json) {
  final BatteryDataEnergy batteryDataEnergy = BatteryDataEnergy();
  final String? remainingKwh = jsonConvert.convert<String>(
    json['remainingKwh'],
  );
  if (remainingKwh != null) {
    batteryDataEnergy.remainingKwh = remainingKwh;
  }
  final String? canChargeKwh = jsonConvert.convert<String>(
    json['canChargeKwh'],
  );
  if (canChargeKwh != null) {
    batteryDataEnergy.canChargeKwh = canChargeKwh;
  }
  final String? canDischargeKwh = jsonConvert.convert<String>(
    json['canDischargeKwh'],
  );
  if (canDischargeKwh != null) {
    batteryDataEnergy.canDischargeKwh = canDischargeKwh;
  }
  final String? totalChargedKwh = jsonConvert.convert<String>(
    json['totalChargedKwh'],
  );
  if (totalChargedKwh != null) {
    batteryDataEnergy.totalChargedKwh = totalChargedKwh;
  }
  final String? totalDischargedKwh = jsonConvert.convert<String>(
    json['totalDischargedKwh'],
  );
  if (totalDischargedKwh != null) {
    batteryDataEnergy.totalDischargedKwh = totalDischargedKwh;
  }
  final String? maxTemperatureDiff = jsonConvert.convert<String>(
    json['maxTemperatureDiff'],
  );
  if (maxTemperatureDiff != null) {
    batteryDataEnergy.maxTemperatureDiff = maxTemperatureDiff;
  }
  return batteryDataEnergy;
}

Map<String, dynamic> $BatteryDataEnergyToJson(BatteryDataEnergy entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['remainingKwh'] = entity.remainingKwh;
  data['canChargeKwh'] = entity.canChargeKwh;
  data['canDischargeKwh'] = entity.canDischargeKwh;
  data['totalChargedKwh'] = entity.totalChargedKwh;
  data['totalDischargedKwh'] = entity.totalDischargedKwh;
  data['maxTemperatureDiff'] = entity.maxTemperatureDiff;
  return data;
}

extension BatteryDataEnergyExtension on BatteryDataEnergy {
  BatteryDataEnergy copyWith({
    String? remainingKwh,
    String? canChargeKwh,
    String? canDischargeKwh,
    String? totalChargedKwh,
    String? totalDischargedKwh,
    String? maxTemperatureDiff,
  }) {
    return BatteryDataEnergy()
      ..remainingKwh = remainingKwh ?? this.remainingKwh
      ..canChargeKwh = canChargeKwh ?? this.canChargeKwh
      ..canDischargeKwh = canDischargeKwh ?? this.canDischargeKwh
      ..totalChargedKwh = totalChargedKwh ?? this.totalChargedKwh
      ..totalDischargedKwh = totalDischargedKwh ?? this.totalDischargedKwh
      ..maxTemperatureDiff = maxTemperatureDiff ?? this.maxTemperatureDiff;
  }
}

BatteryDataTrend $BatteryDataTrendFromJson(Map<String, dynamic> json) {
  final BatteryDataTrend batteryDataTrend = BatteryDataTrend();
  final int? intervalMinutes = jsonConvert.convert<int>(
    json['intervalMinutes'],
  );
  if (intervalMinutes != null) {
    batteryDataTrend.intervalMinutes = intervalMinutes;
  }
  final int? expectedPoints = jsonConvert.convert<int>(json['expectedPoints']);
  if (expectedPoints != null) {
    batteryDataTrend.expectedPoints = expectedPoints;
  }
  final String? timezone = jsonConvert.convert<String>(json['timezone']);
  if (timezone != null) {
    batteryDataTrend.timezone = timezone;
  }
  final List<BatteryDataTrendPoints>? points =
      (json['points'] as List<dynamic>?)
          ?.map(
            (e) =>
                jsonConvert.convert<BatteryDataTrendPoints>(e)
                    as BatteryDataTrendPoints,
          )
          .toList();
  if (points != null) {
    batteryDataTrend.points = points;
  }
  return batteryDataTrend;
}

Map<String, dynamic> $BatteryDataTrendToJson(BatteryDataTrend entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['intervalMinutes'] = entity.intervalMinutes;
  data['expectedPoints'] = entity.expectedPoints;
  data['timezone'] = entity.timezone;
  data['points'] = entity.points?.map((v) => v.toJson()).toList();
  return data;
}

extension BatteryDataTrendExtension on BatteryDataTrend {
  BatteryDataTrend copyWith({
    int? intervalMinutes,
    int? expectedPoints,
    String? timezone,
    List<BatteryDataTrendPoints>? points,
  }) {
    return BatteryDataTrend()
      ..intervalMinutes = intervalMinutes ?? this.intervalMinutes
      ..expectedPoints = expectedPoints ?? this.expectedPoints
      ..timezone = timezone ?? this.timezone
      ..points = points ?? this.points;
  }
}

BatteryDataTrendPoints $BatteryDataTrendPointsFromJson(
  Map<String, dynamic> json,
) {
  final BatteryDataTrendPoints batteryDataTrendPoints =
      BatteryDataTrendPoints();
  final int? timestamp = jsonConvert.convert<int>(json['timestamp']);
  if (timestamp != null) {
    batteryDataTrendPoints.timestamp = timestamp;
  }
  final int? soc = jsonConvert.convert<int>(json['soc']);
  if (soc != null) {
    batteryDataTrendPoints.soc = soc;
  }
  final int? voltage = jsonConvert.convert<int>(json['voltage']);
  if (voltage != null) {
    batteryDataTrendPoints.voltage = voltage;
  }
  final int? current = jsonConvert.convert<int>(json['current']);
  if (current != null) {
    batteryDataTrendPoints.current = current;
  }
  return batteryDataTrendPoints;
}

Map<String, dynamic> $BatteryDataTrendPointsToJson(
  BatteryDataTrendPoints entity,
) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['timestamp'] = entity.timestamp;
  data['soc'] = entity.soc;
  data['voltage'] = entity.voltage;
  data['current'] = entity.current;
  return data;
}

extension BatteryDataTrendPointsExtension on BatteryDataTrendPoints {
  BatteryDataTrendPoints copyWith({
    int? timestamp,
    int? soc,
    int? voltage,
    int? current,
  }) {
    return BatteryDataTrendPoints()
      ..timestamp = timestamp ?? this.timestamp
      ..soc = soc ?? this.soc
      ..voltage = voltage ?? this.voltage
      ..current = current ?? this.current;
  }
}

BatteryDataExtrema $BatteryDataExtremaFromJson(Map<String, dynamic> json) {
  final BatteryDataExtrema batteryDataExtrema = BatteryDataExtrema();
  final BatteryDataExtremaMaxCellVoltage? maxCellVoltage = jsonConvert
      .convert<BatteryDataExtremaMaxCellVoltage>(json['maxCellVoltage']);
  if (maxCellVoltage != null) {
    batteryDataExtrema.maxCellVoltage = maxCellVoltage;
  }
  final BatteryDataExtremaMinCellVoltage? minCellVoltage = jsonConvert
      .convert<BatteryDataExtremaMinCellVoltage>(json['minCellVoltage']);
  if (minCellVoltage != null) {
    batteryDataExtrema.minCellVoltage = minCellVoltage;
  }
  final BatteryDataExtremaMaxTemperature? maxTemperature = jsonConvert
      .convert<BatteryDataExtremaMaxTemperature>(json['maxTemperature']);
  if (maxTemperature != null) {
    batteryDataExtrema.maxTemperature = maxTemperature;
  }
  final BatteryDataExtremaMinTemperature? minTemperature = jsonConvert
      .convert<BatteryDataExtremaMinTemperature>(json['minTemperature']);
  if (minTemperature != null) {
    batteryDataExtrema.minTemperature = minTemperature;
  }
  return batteryDataExtrema;
}

Map<String, dynamic> $BatteryDataExtremaToJson(BatteryDataExtrema entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['maxCellVoltage'] = entity.maxCellVoltage?.toJson();
  data['minCellVoltage'] = entity.minCellVoltage?.toJson();
  data['maxTemperature'] = entity.maxTemperature?.toJson();
  data['minTemperature'] = entity.minTemperature?.toJson();
  return data;
}

extension BatteryDataExtremaExtension on BatteryDataExtrema {
  BatteryDataExtrema copyWith({
    BatteryDataExtremaMaxCellVoltage? maxCellVoltage,
    BatteryDataExtremaMinCellVoltage? minCellVoltage,
    BatteryDataExtremaMaxTemperature? maxTemperature,
    BatteryDataExtremaMinTemperature? minTemperature,
  }) {
    return BatteryDataExtrema()
      ..maxCellVoltage = maxCellVoltage ?? this.maxCellVoltage
      ..minCellVoltage = minCellVoltage ?? this.minCellVoltage
      ..maxTemperature = maxTemperature ?? this.maxTemperature
      ..minTemperature = minTemperature ?? this.minTemperature;
  }
}

BatteryDataExtremaMaxCellVoltage $BatteryDataExtremaMaxCellVoltageFromJson(
  Map<String, dynamic> json,
) {
  final BatteryDataExtremaMaxCellVoltage batteryDataExtremaMaxCellVoltage =
      BatteryDataExtremaMaxCellVoltage();
  final String? value = jsonConvert.convert<String>(json['value']);
  if (value != null) {
    batteryDataExtremaMaxCellVoltage.value = value;
  }
  final int? clusterId = jsonConvert.convert<int>(json['clusterId']);
  if (clusterId != null) {
    batteryDataExtremaMaxCellVoltage.clusterId = clusterId;
  }
  final int? packNo = jsonConvert.convert<int>(json['packNo']);
  if (packNo != null) {
    batteryDataExtremaMaxCellVoltage.packNo = packNo;
  }
  final int? cellNo = jsonConvert.convert<int>(json['cellNo']);
  if (cellNo != null) {
    batteryDataExtremaMaxCellVoltage.cellNo = cellNo;
  }
  return batteryDataExtremaMaxCellVoltage;
}

Map<String, dynamic> $BatteryDataExtremaMaxCellVoltageToJson(
  BatteryDataExtremaMaxCellVoltage entity,
) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['value'] = entity.value;
  data['clusterId'] = entity.clusterId;
  data['packNo'] = entity.packNo;
  data['cellNo'] = entity.cellNo;
  return data;
}

extension BatteryDataExtremaMaxCellVoltageExtension
    on BatteryDataExtremaMaxCellVoltage {
  BatteryDataExtremaMaxCellVoltage copyWith({
    String? value,
    int? clusterId,
    int? packNo,
    int? cellNo,
  }) {
    return BatteryDataExtremaMaxCellVoltage()
      ..value = value ?? this.value
      ..clusterId = clusterId ?? this.clusterId
      ..packNo = packNo ?? this.packNo
      ..cellNo = cellNo ?? this.cellNo;
  }
}

BatteryDataExtremaMinCellVoltage $BatteryDataExtremaMinCellVoltageFromJson(
  Map<String, dynamic> json,
) {
  final BatteryDataExtremaMinCellVoltage batteryDataExtremaMinCellVoltage =
      BatteryDataExtremaMinCellVoltage();
  final String? value = jsonConvert.convert<String>(json['value']);
  if (value != null) {
    batteryDataExtremaMinCellVoltage.value = value;
  }
  final int? clusterId = jsonConvert.convert<int>(json['clusterId']);
  if (clusterId != null) {
    batteryDataExtremaMinCellVoltage.clusterId = clusterId;
  }
  final int? packNo = jsonConvert.convert<int>(json['packNo']);
  if (packNo != null) {
    batteryDataExtremaMinCellVoltage.packNo = packNo;
  }
  final int? cellNo = jsonConvert.convert<int>(json['cellNo']);
  if (cellNo != null) {
    batteryDataExtremaMinCellVoltage.cellNo = cellNo;
  }
  return batteryDataExtremaMinCellVoltage;
}

Map<String, dynamic> $BatteryDataExtremaMinCellVoltageToJson(
  BatteryDataExtremaMinCellVoltage entity,
) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['value'] = entity.value;
  data['clusterId'] = entity.clusterId;
  data['packNo'] = entity.packNo;
  data['cellNo'] = entity.cellNo;
  return data;
}

extension BatteryDataExtremaMinCellVoltageExtension
    on BatteryDataExtremaMinCellVoltage {
  BatteryDataExtremaMinCellVoltage copyWith({
    String? value,
    int? clusterId,
    int? packNo,
    int? cellNo,
  }) {
    return BatteryDataExtremaMinCellVoltage()
      ..value = value ?? this.value
      ..clusterId = clusterId ?? this.clusterId
      ..packNo = packNo ?? this.packNo
      ..cellNo = cellNo ?? this.cellNo;
  }
}

BatteryDataExtremaMaxTemperature $BatteryDataExtremaMaxTemperatureFromJson(
  Map<String, dynamic> json,
) {
  final BatteryDataExtremaMaxTemperature batteryDataExtremaMaxTemperature =
      BatteryDataExtremaMaxTemperature();
  final String? value = jsonConvert.convert<String>(json['value']);
  if (value != null) {
    batteryDataExtremaMaxTemperature.value = value;
  }
  final int? clusterId = jsonConvert.convert<int>(json['clusterId']);
  if (clusterId != null) {
    batteryDataExtremaMaxTemperature.clusterId = clusterId;
  }
  final int? packNo = jsonConvert.convert<int>(json['packNo']);
  if (packNo != null) {
    batteryDataExtremaMaxTemperature.packNo = packNo;
  }
  final int? probeNo = jsonConvert.convert<int>(json['probeNo']);
  if (probeNo != null) {
    batteryDataExtremaMaxTemperature.probeNo = probeNo;
  }
  return batteryDataExtremaMaxTemperature;
}

Map<String, dynamic> $BatteryDataExtremaMaxTemperatureToJson(
  BatteryDataExtremaMaxTemperature entity,
) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['value'] = entity.value;
  data['clusterId'] = entity.clusterId;
  data['packNo'] = entity.packNo;
  data['probeNo'] = entity.probeNo;
  return data;
}

extension BatteryDataExtremaMaxTemperatureExtension
    on BatteryDataExtremaMaxTemperature {
  BatteryDataExtremaMaxTemperature copyWith({
    String? value,
    int? clusterId,
    int? packNo,
    int? probeNo,
  }) {
    return BatteryDataExtremaMaxTemperature()
      ..value = value ?? this.value
      ..clusterId = clusterId ?? this.clusterId
      ..packNo = packNo ?? this.packNo
      ..probeNo = probeNo ?? this.probeNo;
  }
}

BatteryDataExtremaMinTemperature $BatteryDataExtremaMinTemperatureFromJson(
  Map<String, dynamic> json,
) {
  final BatteryDataExtremaMinTemperature batteryDataExtremaMinTemperature =
      BatteryDataExtremaMinTemperature();
  final String? value = jsonConvert.convert<String>(json['value']);
  if (value != null) {
    batteryDataExtremaMinTemperature.value = value;
  }
  final int? clusterId = jsonConvert.convert<int>(json['clusterId']);
  if (clusterId != null) {
    batteryDataExtremaMinTemperature.clusterId = clusterId;
  }
  final int? packNo = jsonConvert.convert<int>(json['packNo']);
  if (packNo != null) {
    batteryDataExtremaMinTemperature.packNo = packNo;
  }
  final int? probeNo = jsonConvert.convert<int>(json['probeNo']);
  if (probeNo != null) {
    batteryDataExtremaMinTemperature.probeNo = probeNo;
  }
  return batteryDataExtremaMinTemperature;
}

Map<String, dynamic> $BatteryDataExtremaMinTemperatureToJson(
  BatteryDataExtremaMinTemperature entity,
) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['value'] = entity.value;
  data['clusterId'] = entity.clusterId;
  data['packNo'] = entity.packNo;
  data['probeNo'] = entity.probeNo;
  return data;
}

extension BatteryDataExtremaMinTemperatureExtension
    on BatteryDataExtremaMinTemperature {
  BatteryDataExtremaMinTemperature copyWith({
    String? value,
    int? clusterId,
    int? packNo,
    int? probeNo,
  }) {
    return BatteryDataExtremaMinTemperature()
      ..value = value ?? this.value
      ..clusterId = clusterId ?? this.clusterId
      ..packNo = packNo ?? this.packNo
      ..probeNo = probeNo ?? this.probeNo;
  }
}

BatteryDataDiagnosis $BatteryDataDiagnosisFromJson(Map<String, dynamic> json) {
  final BatteryDataDiagnosis batteryDataDiagnosis = BatteryDataDiagnosis();
  final List<BatteryDataDiagnosisPacks>? packs =
      (json['packs'] as List<dynamic>?)
          ?.map(
            (e) =>
                jsonConvert.convert<BatteryDataDiagnosisPacks>(e)
                    as BatteryDataDiagnosisPacks,
          )
          .toList();
  if (packs != null) {
    batteryDataDiagnosis.packs = packs;
  }
  return batteryDataDiagnosis;
}

Map<String, dynamic> $BatteryDataDiagnosisToJson(BatteryDataDiagnosis entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['packs'] = entity.packs?.map((v) => v.toJson()).toList();
  return data;
}

extension BatteryDataDiagnosisExtension on BatteryDataDiagnosis {
  BatteryDataDiagnosis copyWith({List<BatteryDataDiagnosisPacks>? packs}) {
    return BatteryDataDiagnosis()..packs = packs ?? this.packs;
  }
}

BatteryDataDiagnosisPacks $BatteryDataDiagnosisPacksFromJson(
  Map<String, dynamic> json,
) {
  final BatteryDataDiagnosisPacks batteryDataDiagnosisPacks =
      BatteryDataDiagnosisPacks();
  final int? packNo = jsonConvert.convert<int>(json['packNo']);
  if (packNo != null) {
    batteryDataDiagnosisPacks.packNo = packNo;
  }
  final int? cellCount = jsonConvert.convert<int>(json['cellCount']);
  if (cellCount != null) {
    batteryDataDiagnosisPacks.cellCount = cellCount;
  }
  final int? cellTempCount = jsonConvert.convert<int>(json['cellTempCount']);
  if (cellTempCount != null) {
    batteryDataDiagnosisPacks.cellTempCount = cellTempCount;
  }
  final String? soh = jsonConvert.convert<String>(json['soh']);
  if (soh != null) {
    batteryDataDiagnosisPacks.soh = soh;
  }
  final String? environmentTemperature = jsonConvert.convert<String>(
    json['environmentTemperature'],
  );
  if (environmentTemperature != null) {
    batteryDataDiagnosisPacks.environmentTemperature = environmentTemperature;
  }
  final String? heaterTemperature = jsonConvert.convert<String>(
    json['heaterTemperature'],
  );
  if (heaterTemperature != null) {
    batteryDataDiagnosisPacks.heaterTemperature = heaterTemperature;
  }
  final int? balance = jsonConvert.convert<int>(json['balance']);
  if (balance != null) {
    batteryDataDiagnosisPacks.balance = balance;
  }
  final List<int>? balancingCells = (json['balancingCells'] as List<dynamic>?)
      ?.map((e) => jsonConvert.convert<int>(e) as int)
      .toList();
  if (balancingCells != null) {
    batteryDataDiagnosisPacks.balancingCells = balancingCells;
  }
  final List<BatteryDataDiagnosisPacksCellVoltages>? cellVoltages =
      (json['cellVoltages'] as List<dynamic>?)
          ?.map(
            (e) =>
                jsonConvert.convert<BatteryDataDiagnosisPacksCellVoltages>(e)
                    as BatteryDataDiagnosisPacksCellVoltages,
          )
          .toList();
  if (cellVoltages != null) {
    batteryDataDiagnosisPacks.cellVoltages = cellVoltages;
  }
  final List<BatteryDataDiagnosisPacksCellTemperatures>? cellTemperatures =
      (json['cellTemperatures'] as List<dynamic>?)
          ?.map(
            (e) =>
                jsonConvert.convert<BatteryDataDiagnosisPacksCellTemperatures>(
                  e,
                ) as BatteryDataDiagnosisPacksCellTemperatures,
          )
          .toList();
  if (cellTemperatures != null) {
    batteryDataDiagnosisPacks.cellTemperatures = cellTemperatures;
  }
  final List<BatteryDataDiagnosisPacksMosTemperatures>? mosTemperatures =
      (json['mosTemperatures'] as List<dynamic>?)
          ?.map(
            (e) =>
                jsonConvert.convert<BatteryDataDiagnosisPacksMosTemperatures>(e)
                    as BatteryDataDiagnosisPacksMosTemperatures,
          )
          .toList();
  if (mosTemperatures != null) {
    batteryDataDiagnosisPacks.mosTemperatures = mosTemperatures;
  }
  return batteryDataDiagnosisPacks;
}

Map<String, dynamic> $BatteryDataDiagnosisPacksToJson(
  BatteryDataDiagnosisPacks entity,
) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['packNo'] = entity.packNo;
  data['cellCount'] = entity.cellCount;
  data['cellTempCount'] = entity.cellTempCount;
  data['soh'] = entity.soh;
  data['environmentTemperature'] = entity.environmentTemperature;
  data['heaterTemperature'] = entity.heaterTemperature;
  data['balance'] = entity.balance;
  data['balancingCells'] = entity.balancingCells;
  data['cellVoltages'] = entity.cellVoltages?.map((v) => v.toJson()).toList();
  data['cellTemperatures'] = entity.cellTemperatures
      ?.map((v) => v.toJson())
      .toList();
  data['mosTemperatures'] = entity.mosTemperatures
      ?.map((v) => v.toJson())
      .toList();
  return data;
}

extension BatteryDataDiagnosisPacksExtension on BatteryDataDiagnosisPacks {
  BatteryDataDiagnosisPacks copyWith({
    int? packNo,
    int? cellCount,
    int? cellTempCount,
    String? soh,
    String? environmentTemperature,
    String? heaterTemperature,
    int? balance,
    List<int>? balancingCells,
    List<BatteryDataDiagnosisPacksCellVoltages>? cellVoltages,
    List<BatteryDataDiagnosisPacksCellTemperatures>? cellTemperatures,
    List<BatteryDataDiagnosisPacksMosTemperatures>? mosTemperatures,
  }) {
    return BatteryDataDiagnosisPacks()
      ..packNo = packNo ?? this.packNo
      ..cellCount = cellCount ?? this.cellCount
      ..cellTempCount = cellTempCount ?? this.cellTempCount
      ..soh = soh ?? this.soh
      ..environmentTemperature =
          environmentTemperature ?? this.environmentTemperature
      ..heaterTemperature = heaterTemperature ?? this.heaterTemperature
      ..balance = balance ?? this.balance
      ..balancingCells = balancingCells ?? this.balancingCells
      ..cellVoltages = cellVoltages ?? this.cellVoltages
      ..cellTemperatures = cellTemperatures ?? this.cellTemperatures
      ..mosTemperatures = mosTemperatures ?? this.mosTemperatures;
  }
}

BatteryDataDiagnosisPacksCellVoltages
$BatteryDataDiagnosisPacksCellVoltagesFromJson(Map<String, dynamic> json) {
  final BatteryDataDiagnosisPacksCellVoltages
  batteryDataDiagnosisPacksCellVoltages =
      BatteryDataDiagnosisPacksCellVoltages();
  final int? cellNo = jsonConvert.convert<int>(json['cellNo']);
  if (cellNo != null) {
    batteryDataDiagnosisPacksCellVoltages.cellNo = cellNo;
  }
  final int? voltageMv = jsonConvert.convert<int>(json['voltageMv']);
  if (voltageMv != null) {
    batteryDataDiagnosisPacksCellVoltages.voltageMv = voltageMv;
  }
  final int? voltageV = jsonConvert.convert<int>(json['voltageV']);
  if (voltageV != null) {
    batteryDataDiagnosisPacksCellVoltages.voltageV = voltageV;
  }
  final bool? isMax = jsonConvert.convert<bool>(json['isMax']);
  if (isMax != null) {
    batteryDataDiagnosisPacksCellVoltages.isMax = isMax;
  }
  final bool? isMin = jsonConvert.convert<bool>(json['isMin']);
  if (isMin != null) {
    batteryDataDiagnosisPacksCellVoltages.isMin = isMin;
  }
  final bool? isBalancing = jsonConvert.convert<bool>(json['isBalancing']);
  if (isBalancing != null) {
    batteryDataDiagnosisPacksCellVoltages.isBalancing = isBalancing;
  }
  return batteryDataDiagnosisPacksCellVoltages;
}

Map<String, dynamic> $BatteryDataDiagnosisPacksCellVoltagesToJson(
  BatteryDataDiagnosisPacksCellVoltages entity,
) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['cellNo'] = entity.cellNo;
  data['voltageMv'] = entity.voltageMv;
  data['voltageV'] = entity.voltageV;
  data['isMax'] = entity.isMax;
  data['isMin'] = entity.isMin;
  data['isBalancing'] = entity.isBalancing;
  return data;
}

extension BatteryDataDiagnosisPacksCellVoltagesExtension
    on BatteryDataDiagnosisPacksCellVoltages {
  BatteryDataDiagnosisPacksCellVoltages copyWith({
    int? cellNo,
    int? voltageMv,
    int? voltageV,
    bool? isMax,
    bool? isMin,
    bool? isBalancing,
  }) {
    return BatteryDataDiagnosisPacksCellVoltages()
      ..cellNo = cellNo ?? this.cellNo
      ..voltageMv = voltageMv ?? this.voltageMv
      ..voltageV = voltageV ?? this.voltageV
      ..isMax = isMax ?? this.isMax
      ..isMin = isMin ?? this.isMin
      ..isBalancing = isBalancing ?? this.isBalancing;
  }
}

BatteryDataDiagnosisPacksCellTemperatures
$BatteryDataDiagnosisPacksCellTemperaturesFromJson(Map<String, dynamic> json) {
  final BatteryDataDiagnosisPacksCellTemperatures
  batteryDataDiagnosisPacksCellTemperatures =
      BatteryDataDiagnosisPacksCellTemperatures();
  final int? probeNo = jsonConvert.convert<int>(json['probeNo']);
  if (probeNo != null) {
    batteryDataDiagnosisPacksCellTemperatures.probeNo = probeNo;
  }
  final int? tempRawDc = jsonConvert.convert<int>(json['tempRawDc']);
  if (tempRawDc != null) {
    batteryDataDiagnosisPacksCellTemperatures.tempRawDc = tempRawDc;
  }
  final int? tempC = jsonConvert.convert<int>(json['tempC']);
  if (tempC != null) {
    batteryDataDiagnosisPacksCellTemperatures.tempC = tempC;
  }
  final bool? isMax = jsonConvert.convert<bool>(json['isMax']);
  if (isMax != null) {
    batteryDataDiagnosisPacksCellTemperatures.isMax = isMax;
  }
  final bool? isMin = jsonConvert.convert<bool>(json['isMin']);
  if (isMin != null) {
    batteryDataDiagnosisPacksCellTemperatures.isMin = isMin;
  }
  return batteryDataDiagnosisPacksCellTemperatures;
}

Map<String, dynamic> $BatteryDataDiagnosisPacksCellTemperaturesToJson(
  BatteryDataDiagnosisPacksCellTemperatures entity,
) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['probeNo'] = entity.probeNo;
  data['tempRawDc'] = entity.tempRawDc;
  data['tempC'] = entity.tempC;
  data['isMax'] = entity.isMax;
  data['isMin'] = entity.isMin;
  return data;
}

extension BatteryDataDiagnosisPacksCellTemperaturesExtension
    on BatteryDataDiagnosisPacksCellTemperatures {
  BatteryDataDiagnosisPacksCellTemperatures copyWith({
    int? probeNo,
    int? tempRawDc,
    int? tempC,
    bool? isMax,
    bool? isMin,
  }) {
    return BatteryDataDiagnosisPacksCellTemperatures()
      ..probeNo = probeNo ?? this.probeNo
      ..tempRawDc = tempRawDc ?? this.tempRawDc
      ..tempC = tempC ?? this.tempC
      ..isMax = isMax ?? this.isMax
      ..isMin = isMin ?? this.isMin;
  }
}

BatteryDataDiagnosisPacksMosTemperatures
$BatteryDataDiagnosisPacksMosTemperaturesFromJson(Map<String, dynamic> json) {
  final BatteryDataDiagnosisPacksMosTemperatures
  batteryDataDiagnosisPacksMosTemperatures =
      BatteryDataDiagnosisPacksMosTemperatures();
  final int? no = jsonConvert.convert<int>(json['no']);
  if (no != null) {
    batteryDataDiagnosisPacksMosTemperatures.no = no;
  }
  final int? tempC = jsonConvert.convert<int>(json['tempC']);
  if (tempC != null) {
    batteryDataDiagnosisPacksMosTemperatures.tempC = tempC;
  }
  return batteryDataDiagnosisPacksMosTemperatures;
}

Map<String, dynamic> $BatteryDataDiagnosisPacksMosTemperaturesToJson(
  BatteryDataDiagnosisPacksMosTemperatures entity,
) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['no'] = entity.no;
  data['tempC'] = entity.tempC;
  return data;
}

extension BatteryDataDiagnosisPacksMosTemperaturesExtension
    on BatteryDataDiagnosisPacksMosTemperatures {
  BatteryDataDiagnosisPacksMosTemperatures copyWith({int? no, int? tempC}) {
    return BatteryDataDiagnosisPacksMosTemperatures()
      ..no = no ?? this.no
      ..tempC = tempC ?? this.tempC;
  }
}

BatteryDataAlarmInfo $BatteryDataAlarmInfoFromJson(Map<String, dynamic> json) {
  final BatteryDataAlarmInfo batteryDataAlarmInfo = BatteryDataAlarmInfo();
  final String? status = jsonConvert.convert<String>(json['status']);
  if (status != null) {
    batteryDataAlarmInfo.status = status;
  }
  final int? siteId = jsonConvert.convert<int>(json['siteId']);
  if (siteId != null) {
    batteryDataAlarmInfo.siteId = siteId;
  }
  final String? siteName = jsonConvert.convert<String>(json['siteName']);
  if (siteName != null) {
    batteryDataAlarmInfo.siteName = siteName;
  }
  final String? domainType = jsonConvert.convert<String>(json['domainType']);
  if (domainType != null) {
    batteryDataAlarmInfo.domainType = domainType;
  }
  final String? stackSn = jsonConvert.convert<String>(json['stackSn']);
  if (stackSn != null) {
    batteryDataAlarmInfo.stackSn = stackSn;
  }
  final String? stackName = jsonConvert.convert<String>(json['stackName']);
  if (stackName != null) {
    batteryDataAlarmInfo.stackName = stackName;
  }
  final String? clusterSn = jsonConvert.convert<String>(json['clusterSn']);
  if (clusterSn != null) {
    batteryDataAlarmInfo.clusterSn = clusterSn;
  }
  final String? clusterName = jsonConvert.convert<String>(json['clusterName']);
  if (clusterName != null) {
    batteryDataAlarmInfo.clusterName = clusterName;
  }
  final int? alarmLevel = jsonConvert.convert<int>(json['alarmLevel']);
  if (alarmLevel != null) {
    batteryDataAlarmInfo.alarmLevel = alarmLevel;
  }
  final int? packNo = jsonConvert.convert<int>(json['packNo']);
  if (packNo != null) {
    batteryDataAlarmInfo.packNo = packNo;
  }
  final int? cellNo = jsonConvert.convert<int>(json['cellNo']);
  if (cellNo != null) {
    batteryDataAlarmInfo.cellNo = cellNo;
  }
  return batteryDataAlarmInfo;
}

Map<String, dynamic> $BatteryDataAlarmInfoToJson(BatteryDataAlarmInfo entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['siteId'] = entity.siteId;
  data['siteName'] = entity.siteName;
  data['domainType'] = entity.domainType;
  data['stackSn'] = entity.stackSn;
  data['stackName'] = entity.stackName;
  data['clusterSn'] = entity.clusterSn;
  data['clusterName'] = entity.clusterName;
  data['alarmLevel'] = entity.alarmLevel;
  data['packNo'] = entity.packNo;
  data['cellNo'] = entity.cellNo;
  return data;
}

extension BatteryDataAlarmInfoExtension on BatteryDataAlarmInfo {
  BatteryDataAlarmInfo copyWith({
    String? status,
    int? siteId,
    String? siteName,
    String? domainType,
    String? stackSn,
    String? stackName,
    String? clusterSn,
    String? clusterName,
    int? alarmLevel,
    int? packNo,
    int? cellNo,
  }) {
    return BatteryDataAlarmInfo()
      ..status = status ?? this.status
      ..siteId = siteId ?? this.siteId
      ..siteName = siteName ?? this.siteName
      ..domainType = domainType ?? this.domainType
      ..stackSn = stackSn ?? this.stackSn
      ..stackName = stackName ?? this.stackName
      ..clusterSn = clusterSn ?? this.clusterSn
      ..clusterName = clusterName ?? this.clusterName
      ..alarmLevel = alarmLevel ?? this.alarmLevel
      ..packNo = packNo ?? this.packNo
      ..cellNo = cellNo ?? this.cellNo;
  }
}

BatteryDataSystemInfo $BatteryDataSystemInfoFromJson(
  Map<String, dynamic> json,
) {
  final BatteryDataSystemInfo batteryDataSystemInfo = BatteryDataSystemInfo();
  final String? stackSn = jsonConvert.convert<String>(json['stackSn']);
  if (stackSn != null) {
    batteryDataSystemInfo.stackSn = stackSn;
  }
  final String? clusterSn = jsonConvert.convert<String>(json['clusterSn']);
  if (clusterSn != null) {
    batteryDataSystemInfo.clusterSn = clusterSn;
  }
  final int? clusterNo = jsonConvert.convert<int>(json['clusterNo']);
  if (clusterNo != null) {
    batteryDataSystemInfo.clusterNo = clusterNo;
  }
  final String? softwareVersion = jsonConvert.convert<String>(
    json['softwareVersion'],
  );
  if (softwareVersion != null) {
    batteryDataSystemInfo.softwareVersion = softwareVersion;
  }
  final String? hardwareVersion = jsonConvert.convert<String>(
    json['hardwareVersion'],
  );
  if (hardwareVersion != null) {
    batteryDataSystemInfo.hardwareVersion = hardwareVersion;
  }
  final String? bootVersion = jsonConvert.convert<String>(json['bootVersion']);
  if (bootVersion != null) {
    batteryDataSystemInfo.bootVersion = bootVersion;
  }
  final int? designMah = jsonConvert.convert<int>(json['designMah']);
  if (designMah != null) {
    batteryDataSystemInfo.designMah = designMah;
  }
  final String? designCapacity = jsonConvert.convert<String>(
    json['designCapacity'],
  );
  if (designCapacity != null) {
    batteryDataSystemInfo.designCapacity = designCapacity;
  }
  final int? packCount = jsonConvert.convert<int>(json['packCount']);
  if (packCount != null) {
    batteryDataSystemInfo.packCount = packCount;
  }
  final int? packCellCount = jsonConvert.convert<int>(json['packCellCount']);
  if (packCellCount != null) {
    batteryDataSystemInfo.packCellCount = packCellCount;
  }
  final int? packTempCount = jsonConvert.convert<int>(json['packTempCount']);
  if (packTempCount != null) {
    batteryDataSystemInfo.packTempCount = packTempCount;
  }
  final int? sysMode = jsonConvert.convert<int>(json['sysMode']);
  if (sysMode != null) {
    batteryDataSystemInfo.sysMode = sysMode;
  }
  final int? accessMode = jsonConvert.convert<int>(json['accessMode']);
  if (accessMode != null) {
    batteryDataSystemInfo.accessMode = accessMode;
  }
  return batteryDataSystemInfo;
}

Map<String, dynamic> $BatteryDataSystemInfoToJson(
  BatteryDataSystemInfo entity,
) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['stackSn'] = entity.stackSn;
  data['clusterSn'] = entity.clusterSn;
  data['clusterNo'] = entity.clusterNo;
  data['softwareVersion'] = entity.softwareVersion;
  data['hardwareVersion'] = entity.hardwareVersion;
  data['bootVersion'] = entity.bootVersion;
  data['designMah'] = entity.designMah;
  data['designCapacity'] = entity.designCapacity;
  data['packCount'] = entity.packCount;
  data['packCellCount'] = entity.packCellCount;
  data['packTempCount'] = entity.packTempCount;
  data['sysMode'] = entity.sysMode;
  data['accessMode'] = entity.accessMode;
  return data;
}

extension BatteryDataSystemInfoExtension on BatteryDataSystemInfo {
  BatteryDataSystemInfo copyWith({
    String? stackSn,
    String? clusterSn,
    int? clusterNo,
    String? softwareVersion,
    String? hardwareVersion,
    String? bootVersion,
    int? designMah,
    String? designCapacity,
    int? packCount,
    int? packCellCount,
    int? packTempCount,
    int? sysMode,
    int? accessMode,
  }) {
    return BatteryDataSystemInfo()
      ..stackSn = stackSn ?? this.stackSn
      ..clusterSn = clusterSn ?? this.clusterSn
      ..clusterNo = clusterNo ?? this.clusterNo
      ..softwareVersion = softwareVersion ?? this.softwareVersion
      ..hardwareVersion = hardwareVersion ?? this.hardwareVersion
      ..bootVersion = bootVersion ?? this.bootVersion
      ..designMah = designMah ?? this.designMah
      ..designCapacity = designCapacity ?? this.designCapacity
      ..packCount = packCount ?? this.packCount
      ..packCellCount = packCellCount ?? this.packCellCount
      ..packTempCount = packTempCount ?? this.packTempCount
      ..sysMode = sysMode ?? this.sysMode
      ..accessMode = accessMode ?? this.accessMode;
  }
}

BatteryDataClusters $BatteryDataClustersFromJson(Map<String, dynamic> json) {
  final BatteryDataClusters batteryDataClusters = BatteryDataClusters();
  final int? clusterId = jsonConvert.convert<int>(json['clusterId']);
  if (clusterId != null) {
    batteryDataClusters.clusterId = clusterId;
  }
  final String? clusterSn = jsonConvert.convert<String>(json['clusterSn']);
  if (clusterSn != null) {
    batteryDataClusters.clusterSn = clusterSn;
  }
  final int? clusterNo = jsonConvert.convert<int>(json['clusterNo']);
  if (clusterNo != null) {
    batteryDataClusters.clusterNo = clusterNo;
  }
  final String? clusterName = jsonConvert.convert<String>(json['clusterName']);
  if (clusterName != null) {
    batteryDataClusters.clusterName = clusterName;
  }
  final int? packCount = jsonConvert.convert<int>(json['packCount']);
  if (packCount != null) {
    batteryDataClusters.packCount = packCount;
  }
  final String? commStatus = jsonConvert.convert<String>(json['commStatus']);
  if (commStatus != null) {
    batteryDataClusters.commStatus = commStatus;
  }
  final String? soc = jsonConvert.convert<String>(json['soc']);
  if (soc != null) {
    batteryDataClusters.soc = soc;
  }
  final String? soh = jsonConvert.convert<String>(json['soh']);
  if (soh != null) {
    batteryDataClusters.soh = soh;
  }
  final String? totalVoltage = jsonConvert.convert<String>(
    json['totalVoltage'],
  );
  if (totalVoltage != null) {
    batteryDataClusters.totalVoltage = totalVoltage;
  }
  final String? totalCurrent = jsonConvert.convert<String>(
    json['totalCurrent'],
  );
  if (totalCurrent != null) {
    batteryDataClusters.totalCurrent = totalCurrent;
  }
  final String? maxTemperature = jsonConvert.convert<String>(
    json['maxTemperature'],
  );
  if (maxTemperature != null) {
    batteryDataClusters.maxTemperature = maxTemperature;
  }
  final String? maxVoltageDiff = jsonConvert.convert<String>(
    json['maxVoltageDiff'],
  );
  if (maxVoltageDiff != null) {
    batteryDataClusters.maxVoltageDiff = maxVoltageDiff;
  }
  final String? lastDataTime = jsonConvert.convert<String>(
    json['lastDataTime'],
  );
  if (lastDataTime != null) {
    batteryDataClusters.lastDataTime = lastDataTime;
  }
  return batteryDataClusters;
}

Map<String, dynamic> $BatteryDataClustersToJson(BatteryDataClusters entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['clusterId'] = entity.clusterId;
  data['clusterSn'] = entity.clusterSn;
  data['clusterNo'] = entity.clusterNo;
  data['clusterName'] = entity.clusterName;
  data['packCount'] = entity.packCount;
  data['commStatus'] = entity.commStatus;
  data['soc'] = entity.soc;
  data['soh'] = entity.soh;
  data['totalVoltage'] = entity.totalVoltage;
  data['totalCurrent'] = entity.totalCurrent;
  data['maxTemperature'] = entity.maxTemperature;
  data['maxVoltageDiff'] = entity.maxVoltageDiff;
  data['lastDataTime'] = entity.lastDataTime;
  return data;
}

extension BatteryDataClustersExtension on BatteryDataClusters {
  BatteryDataClusters copyWith({
    int? clusterId,
    String? clusterSn,
    int? clusterNo,
    String? clusterName,
    int? packCount,
    String? commStatus,
    String? soc,
    String? soh,
    String? totalVoltage,
    String? totalCurrent,
    String? maxTemperature,
    String? maxVoltageDiff,
    String? lastDataTime,
  }) {
    return BatteryDataClusters()
      ..clusterId = clusterId ?? this.clusterId
      ..clusterSn = clusterSn ?? this.clusterSn
      ..clusterNo = clusterNo ?? this.clusterNo
      ..clusterName = clusterName ?? this.clusterName
      ..packCount = packCount ?? this.packCount
      ..commStatus = commStatus ?? this.commStatus
      ..soc = soc ?? this.soc
      ..soh = soh ?? this.soh
      ..totalVoltage = totalVoltage ?? this.totalVoltage
      ..totalCurrent = totalCurrent ?? this.totalCurrent
      ..maxTemperature = maxTemperature ?? this.maxTemperature
      ..maxVoltageDiff = maxVoltageDiff ?? this.maxVoltageDiff
      ..lastDataTime = lastDataTime ?? this.lastDataTime;
  }
}
