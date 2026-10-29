import 'package:cesc01/core/network/bean/stack_and_cluster_entity.dart';
import 'package:cesc01/generated/json/base/json_convert_content.dart';

StackAndClusterEntity $StackAndClusterEntityFromJson(
  Map<String, dynamic> json,
) {
  final StackAndClusterEntity stackAndClusterEntity = StackAndClusterEntity();
  final String? scope = jsonConvert.convert<String>(json['scope']);
  if (scope != null) {
    stackAndClusterEntity.scope = scope;
  }
  final int? stackId = jsonConvert.convert<int>(json['stackId']);
  if (stackId != null) {
    stackAndClusterEntity.stackId = stackId;
  }
  final int? clusterId = jsonConvert.convert<int>(json['clusterId']);
  if (clusterId != null) {
    stackAndClusterEntity.clusterId = clusterId;
  }
  final String? stackSn = jsonConvert.convert<String>(json['stackSn']);
  if (stackSn != null) {
    stackAndClusterEntity.stackSn = stackSn;
  }
  final String? clusterSn = jsonConvert.convert<String>(json['clusterSn']);
  if (clusterSn != null) {
    stackAndClusterEntity.clusterSn = clusterSn;
  }
  final String? stackName = jsonConvert.convert<String>(json['stackName']);
  if (stackName != null) {
    stackAndClusterEntity.stackName = stackName;
  }
  final String? clusterName = jsonConvert.convert<String>(json['clusterName']);
  if (clusterName != null) {
    stackAndClusterEntity.clusterName = clusterName;
  }
  final String? firmwareVersion = jsonConvert.convert<String>(
    json['firmwareVersion'],
  );
  if (firmwareVersion != null) {
    stackAndClusterEntity.firmwareVersion = firmwareVersion;
  }
  final int? sysMode = jsonConvert.convert<int>(json['sysMode']);
  if (sysMode != null) {
    stackAndClusterEntity.sysMode = sysMode;
  }
  final String? commStatus = jsonConvert.convert<String>(json['commStatus']);
  if (commStatus != null) {
    stackAndClusterEntity.commStatus = commStatus;
  }
  final int? clusterCount = jsonConvert.convert<int>(json['clusterCount']);
  if (clusterCount != null) {
    stackAndClusterEntity.clusterCount = clusterCount;
  }
  final int? packCount = jsonConvert.convert<int>(json['packCount']);
  if (packCount != null) {
    stackAndClusterEntity.packCount = packCount;
  }
  final int? alarmClusterCount = jsonConvert.convert<int>(
    json['alarmClusterCount'],
  );
  if (alarmClusterCount != null) {
    stackAndClusterEntity.alarmClusterCount = alarmClusterCount;
  }
  final String? lastDataTime = jsonConvert.convert<String>(
    json['lastDataTime'],
  );
  if (lastDataTime != null) {
    stackAndClusterEntity.lastDataTime = lastDataTime;
  }
  final String? timezone = jsonConvert.convert<String>(json['timezone']);
  if (timezone != null) {
    stackAndClusterEntity.timezone = timezone;
  }
  final StackAndClusterSummary? summary = jsonConvert
      .convert<StackAndClusterSummary>(json['summary']);
  if (summary != null) {
    stackAndClusterEntity.summary = summary;
  }
  final StackAndClusterRunningProtection? runningProtection = jsonConvert
      .convert<StackAndClusterRunningProtection>(json['runningProtection']);
  if (runningProtection != null) {
    stackAndClusterEntity.runningProtection = runningProtection;
  }
  final StackAndClusterEnergy? energy = jsonConvert
      .convert<StackAndClusterEnergy>(json['energy']);
  if (energy != null) {
    stackAndClusterEntity.energy = energy;
  }
  final StackAndClusterTrend? trend = jsonConvert.convert<StackAndClusterTrend>(
    json['trend'],
  );
  if (trend != null) {
    stackAndClusterEntity.trend = trend;
  }
  final StackAndClusterExtrema? extrema = jsonConvert
      .convert<StackAndClusterExtrema>(json['extrema']);
  if (extrema != null) {
    stackAndClusterEntity.extrema = extrema;
  }
  final StackAndClusterDiagnosis? diagnosis = jsonConvert
      .convert<StackAndClusterDiagnosis>(json['diagnosis']);
  if (diagnosis != null) {
    stackAndClusterEntity.diagnosis = diagnosis;
  }
  final StackAndClusterAlarmInfo? alarmInfo = jsonConvert
      .convert<StackAndClusterAlarmInfo>(json['alarmInfo']);
  if (alarmInfo != null) {
    stackAndClusterEntity.alarmInfo = alarmInfo;
  }
  final StackAndClusterSystemInfo? systemInfo = jsonConvert
      .convert<StackAndClusterSystemInfo>(json['systemInfo']);
  if (systemInfo != null) {
    stackAndClusterEntity.systemInfo = systemInfo;
  }
  final List<StackAndClusterClusters>? clusters =
      (json['clusters'] as List<dynamic>?)
          ?.map(
            (e) =>
                jsonConvert.convert<StackAndClusterClusters>(e)
                    as StackAndClusterClusters,
          )
          .toList();
  if (clusters != null) {
    stackAndClusterEntity.clusters = clusters;
  }
  return stackAndClusterEntity;
}

Map<String, dynamic> $StackAndClusterEntityToJson(
  StackAndClusterEntity entity,
) {
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

extension StackAndClusterEntityExtension on StackAndClusterEntity {
  StackAndClusterEntity copyWith({
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
    StackAndClusterSummary? summary,
    StackAndClusterRunningProtection? runningProtection,
    StackAndClusterEnergy? energy,
    StackAndClusterTrend? trend,
    StackAndClusterExtrema? extrema,
    StackAndClusterDiagnosis? diagnosis,
    StackAndClusterAlarmInfo? alarmInfo,
    StackAndClusterSystemInfo? systemInfo,
    List<StackAndClusterClusters>? clusters,
  }) {
    return StackAndClusterEntity()
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

StackAndClusterSummary $StackAndClusterSummaryFromJson(
  Map<String, dynamic> json,
) {
  final StackAndClusterSummary stackAndClusterSummary =
      StackAndClusterSummary();
  final String? soc = jsonConvert.convert<String>(json['soc']);
  if (soc != null) {
    stackAndClusterSummary.soc = soc;
  }
  final String? soh = jsonConvert.convert<String>(json['soh']);
  if (soh != null) {
    stackAndClusterSummary.soh = soh;
  }
  final String? totalVoltage = jsonConvert.convert<String>(
    json['totalVoltage'],
  );
  if (totalVoltage != null) {
    stackAndClusterSummary.totalVoltage = totalVoltage;
  }
  final String? totalCurrent = jsonConvert.convert<String>(
    json['totalCurrent'],
  );
  if (totalCurrent != null) {
    stackAndClusterSummary.totalCurrent = totalCurrent;
  }
  final String? maxTemperature = jsonConvert.convert<String>(
    json['maxTemperature'],
  );
  if (maxTemperature != null) {
    stackAndClusterSummary.maxTemperature = maxTemperature;
  }
  final String? maxVoltageDiff = jsonConvert.convert<String>(
    json['maxVoltageDiff'],
  );
  if (maxVoltageDiff != null) {
    stackAndClusterSummary.maxVoltageDiff = maxVoltageDiff;
  }
  return stackAndClusterSummary;
}

Map<String, dynamic> $StackAndClusterSummaryToJson(
  StackAndClusterSummary entity,
) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['soc'] = entity.soc;
  data['soh'] = entity.soh;
  data['totalVoltage'] = entity.totalVoltage;
  data['totalCurrent'] = entity.totalCurrent;
  data['maxTemperature'] = entity.maxTemperature;
  data['maxVoltageDiff'] = entity.maxVoltageDiff;
  return data;
}

extension StackAndClusterSummaryExtension on StackAndClusterSummary {
  StackAndClusterSummary copyWith({
    String? soc,
    String? soh,
    String? totalVoltage,
    String? totalCurrent,
    String? maxTemperature,
    String? maxVoltageDiff,
  }) {
    return StackAndClusterSummary()
      ..soc = soc ?? this.soc
      ..soh = soh ?? this.soh
      ..totalVoltage = totalVoltage ?? this.totalVoltage
      ..totalCurrent = totalCurrent ?? this.totalCurrent
      ..maxTemperature = maxTemperature ?? this.maxTemperature
      ..maxVoltageDiff = maxVoltageDiff ?? this.maxVoltageDiff;
  }
}

StackAndClusterRunningProtection $StackAndClusterRunningProtectionFromJson(
  Map<String, dynamic> json,
) {
  final StackAndClusterRunningProtection stackAndClusterRunningProtection =
      StackAndClusterRunningProtection();
  final String? runStatus = jsonConvert.convert<String>(json['runStatus']);
  if (runStatus != null) {
    stackAndClusterRunningProtection.runStatus = runStatus;
  }
  final String? chargeDischargePermission = jsonConvert.convert<String>(
    json['chargeDischargePermission'],
  );
  if (chargeDischargePermission != null) {
    stackAndClusterRunningProtection.chargeDischargePermission =
        chargeDischargePermission;
  }
  final String? maxChargeCurrent = jsonConvert.convert<String>(
    json['maxChargeCurrent'],
  );
  if (maxChargeCurrent != null) {
    stackAndClusterRunningProtection.maxChargeCurrent = maxChargeCurrent;
  }
  final String? maxDischargeCurrent = jsonConvert.convert<String>(
    json['maxDischargeCurrent'],
  );
  if (maxDischargeCurrent != null) {
    stackAndClusterRunningProtection.maxDischargeCurrent = maxDischargeCurrent;
  }
  final String? current1 = jsonConvert.convert<String>(json['current1']);
  if (current1 != null) {
    stackAndClusterRunningProtection.current1 = current1;
  }
  final String? current2 = jsonConvert.convert<String>(json['current2']);
  if (current2 != null) {
    stackAndClusterRunningProtection.current2 = current2;
  }
  final int? cycles = jsonConvert.convert<int>(json['cycles']);
  if (cycles != null) {
    stackAndClusterRunningProtection.cycles = cycles;
  }
  final int? heaterStatus = jsonConvert.convert<int>(json['heaterStatus']);
  if (heaterStatus != null) {
    stackAndClusterRunningProtection.heaterStatus = heaterStatus;
  }
  return stackAndClusterRunningProtection;
}

Map<String, dynamic> $StackAndClusterRunningProtectionToJson(
  StackAndClusterRunningProtection entity,
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

extension StackAndClusterRunningProtectionExtension
    on StackAndClusterRunningProtection {
  StackAndClusterRunningProtection copyWith({
    String? runStatus,
    String? chargeDischargePermission,
    String? maxChargeCurrent,
    String? maxDischargeCurrent,
    String? current1,
    String? current2,
    int? cycles,
    int? heaterStatus,
  }) {
    return StackAndClusterRunningProtection()
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

StackAndClusterEnergy $StackAndClusterEnergyFromJson(
  Map<String, dynamic> json,
) {
  final StackAndClusterEnergy stackAndClusterEnergy = StackAndClusterEnergy();
  final String? remainingKwh = jsonConvert.convert<String>(
    json['remainingKwh'],
  );
  if (remainingKwh != null) {
    stackAndClusterEnergy.remainingKwh = remainingKwh;
  }
  final String? canChargeKwh = jsonConvert.convert<String>(
    json['canChargeKwh'],
  );
  if (canChargeKwh != null) {
    stackAndClusterEnergy.canChargeKwh = canChargeKwh;
  }
  final String? canDischargeKwh = jsonConvert.convert<String>(
    json['canDischargeKwh'],
  );
  if (canDischargeKwh != null) {
    stackAndClusterEnergy.canDischargeKwh = canDischargeKwh;
  }
  final String? totalChargedKwh = jsonConvert.convert<String>(
    json['totalChargedKwh'],
  );
  if (totalChargedKwh != null) {
    stackAndClusterEnergy.totalChargedKwh = totalChargedKwh;
  }
  final String? totalDischargedKwh = jsonConvert.convert<String>(
    json['totalDischargedKwh'],
  );
  if (totalDischargedKwh != null) {
    stackAndClusterEnergy.totalDischargedKwh = totalDischargedKwh;
  }
  final String? maxTemperatureDiff = jsonConvert.convert<String>(
    json['maxTemperatureDiff'],
  );
  if (maxTemperatureDiff != null) {
    stackAndClusterEnergy.maxTemperatureDiff = maxTemperatureDiff;
  }
  return stackAndClusterEnergy;
}

Map<String, dynamic> $StackAndClusterEnergyToJson(
  StackAndClusterEnergy entity,
) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['remainingKwh'] = entity.remainingKwh;
  data['canChargeKwh'] = entity.canChargeKwh;
  data['canDischargeKwh'] = entity.canDischargeKwh;
  data['totalChargedKwh'] = entity.totalChargedKwh;
  data['totalDischargedKwh'] = entity.totalDischargedKwh;
  data['maxTemperatureDiff'] = entity.maxTemperatureDiff;
  return data;
}

extension StackAndClusterEnergyExtension on StackAndClusterEnergy {
  StackAndClusterEnergy copyWith({
    String? remainingKwh,
    String? canChargeKwh,
    String? canDischargeKwh,
    String? totalChargedKwh,
    String? totalDischargedKwh,
    String? maxTemperatureDiff,
  }) {
    return StackAndClusterEnergy()
      ..remainingKwh = remainingKwh ?? this.remainingKwh
      ..canChargeKwh = canChargeKwh ?? this.canChargeKwh
      ..canDischargeKwh = canDischargeKwh ?? this.canDischargeKwh
      ..totalChargedKwh = totalChargedKwh ?? this.totalChargedKwh
      ..totalDischargedKwh = totalDischargedKwh ?? this.totalDischargedKwh
      ..maxTemperatureDiff = maxTemperatureDiff ?? this.maxTemperatureDiff;
  }
}

StackAndClusterTrend $StackAndClusterTrendFromJson(Map<String, dynamic> json) {
  final StackAndClusterTrend stackAndClusterTrend = StackAndClusterTrend();
  final int? intervalMinutes = jsonConvert.convert<int>(
    json['intervalMinutes'],
  );
  if (intervalMinutes != null) {
    stackAndClusterTrend.intervalMinutes = intervalMinutes;
  }
  final int? expectedPoints = jsonConvert.convert<int>(json['expectedPoints']);
  if (expectedPoints != null) {
    stackAndClusterTrend.expectedPoints = expectedPoints;
  }
  final String? timezone = jsonConvert.convert<String>(json['timezone']);
  if (timezone != null) {
    stackAndClusterTrend.timezone = timezone;
  }
  final List<StackAndClusterTrendPoints>? points =
      (json['points'] as List<dynamic>?)
          ?.map(
            (e) =>
                jsonConvert.convert<StackAndClusterTrendPoints>(e)
                    as StackAndClusterTrendPoints,
          )
          .toList();
  if (points != null) {
    stackAndClusterTrend.points = points;
  }
  return stackAndClusterTrend;
}

Map<String, dynamic> $StackAndClusterTrendToJson(StackAndClusterTrend entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['intervalMinutes'] = entity.intervalMinutes;
  data['expectedPoints'] = entity.expectedPoints;
  data['timezone'] = entity.timezone;
  data['points'] = entity.points?.map((v) => v.toJson()).toList();
  return data;
}

extension StackAndClusterTrendExtension on StackAndClusterTrend {
  StackAndClusterTrend copyWith({
    int? intervalMinutes,
    int? expectedPoints,
    String? timezone,
    List<StackAndClusterTrendPoints>? points,
  }) {
    return StackAndClusterTrend()
      ..intervalMinutes = intervalMinutes ?? this.intervalMinutes
      ..expectedPoints = expectedPoints ?? this.expectedPoints
      ..timezone = timezone ?? this.timezone
      ..points = points ?? this.points;
  }
}

StackAndClusterTrendPoints $StackAndClusterTrendPointsFromJson(
  Map<String, dynamic> json,
) {
  final StackAndClusterTrendPoints stackAndClusterTrendPoints =
      StackAndClusterTrendPoints();
  final int? timestamp = jsonConvert.convert<int>(json['timestamp']);
  if (timestamp != null) {
    stackAndClusterTrendPoints.timestamp = timestamp;
  }
  final double? soc = jsonConvert.convert<double>(json['soc']);
  if (soc != null) {
    stackAndClusterTrendPoints.soc = soc;
  }
  final double? voltage = jsonConvert.convert<double>(json['voltage']);
  if (voltage != null) {
    stackAndClusterTrendPoints.voltage = voltage;
  }
  final double? current = jsonConvert.convert<double>(json['current']);
  if (current != null) {
    stackAndClusterTrendPoints.current = current;
  }
  return stackAndClusterTrendPoints;
}

Map<String, dynamic> $StackAndClusterTrendPointsToJson(
  StackAndClusterTrendPoints entity,
) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['timestamp'] = entity.timestamp;
  data['soc'] = entity.soc;
  data['voltage'] = entity.voltage;
  data['current'] = entity.current;
  return data;
}

extension StackAndClusterTrendPointsExtension on StackAndClusterTrendPoints {
  StackAndClusterTrendPoints copyWith({
    int? timestamp,
    double? soc,
    double? voltage,
    double? current,
  }) {
    return StackAndClusterTrendPoints()
      ..timestamp = timestamp ?? this.timestamp
      ..soc = soc ?? this.soc
      ..voltage = voltage ?? this.voltage
      ..current = current ?? this.current;
  }
}

StackAndClusterExtrema $StackAndClusterExtremaFromJson(
  Map<String, dynamic> json,
) {
  final StackAndClusterExtrema stackAndClusterExtrema =
      StackAndClusterExtrema();
  final StackAndClusterExtremaMaxCellVoltage? maxCellVoltage = jsonConvert
      .convert<StackAndClusterExtremaMaxCellVoltage>(json['maxCellVoltage']);
  if (maxCellVoltage != null) {
    stackAndClusterExtrema.maxCellVoltage = maxCellVoltage;
  }
  final StackAndClusterExtremaMinCellVoltage? minCellVoltage = jsonConvert
      .convert<StackAndClusterExtremaMinCellVoltage>(json['minCellVoltage']);
  if (minCellVoltage != null) {
    stackAndClusterExtrema.minCellVoltage = minCellVoltage;
  }
  final StackAndClusterExtremaMaxTemperature? maxTemperature = jsonConvert
      .convert<StackAndClusterExtremaMaxTemperature>(json['maxTemperature']);
  if (maxTemperature != null) {
    stackAndClusterExtrema.maxTemperature = maxTemperature;
  }
  final StackAndClusterExtremaMinTemperature? minTemperature = jsonConvert
      .convert<StackAndClusterExtremaMinTemperature>(json['minTemperature']);
  if (minTemperature != null) {
    stackAndClusterExtrema.minTemperature = minTemperature;
  }
  return stackAndClusterExtrema;
}

Map<String, dynamic> $StackAndClusterExtremaToJson(
  StackAndClusterExtrema entity,
) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['maxCellVoltage'] = entity.maxCellVoltage?.toJson();
  data['minCellVoltage'] = entity.minCellVoltage?.toJson();
  data['maxTemperature'] = entity.maxTemperature?.toJson();
  data['minTemperature'] = entity.minTemperature?.toJson();
  return data;
}

extension StackAndClusterExtremaExtension on StackAndClusterExtrema {
  StackAndClusterExtrema copyWith({
    StackAndClusterExtremaMaxCellVoltage? maxCellVoltage,
    StackAndClusterExtremaMinCellVoltage? minCellVoltage,
    StackAndClusterExtremaMaxTemperature? maxTemperature,
    StackAndClusterExtremaMinTemperature? minTemperature,
  }) {
    return StackAndClusterExtrema()
      ..maxCellVoltage = maxCellVoltage ?? this.maxCellVoltage
      ..minCellVoltage = minCellVoltage ?? this.minCellVoltage
      ..maxTemperature = maxTemperature ?? this.maxTemperature
      ..minTemperature = minTemperature ?? this.minTemperature;
  }
}

StackAndClusterExtremaMaxCellVoltage
$StackAndClusterExtremaMaxCellVoltageFromJson(Map<String, dynamic> json) {
  final StackAndClusterExtremaMaxCellVoltage
  stackAndClusterExtremaMaxCellVoltage = StackAndClusterExtremaMaxCellVoltage();
  final String? value = jsonConvert.convert<String>(json['value']);
  if (value != null) {
    stackAndClusterExtremaMaxCellVoltage.value = value;
  }
  final int? clusterId = jsonConvert.convert<int>(json['clusterId']);
  if (clusterId != null) {
    stackAndClusterExtremaMaxCellVoltage.clusterId = clusterId;
  }
  final int? packNo = jsonConvert.convert<int>(json['packNo']);
  if (packNo != null) {
    stackAndClusterExtremaMaxCellVoltage.packNo = packNo;
  }
  final int? cellNo = jsonConvert.convert<int>(json['cellNo']);
  if (cellNo != null) {
    stackAndClusterExtremaMaxCellVoltage.cellNo = cellNo;
  }
  return stackAndClusterExtremaMaxCellVoltage;
}

Map<String, dynamic> $StackAndClusterExtremaMaxCellVoltageToJson(
  StackAndClusterExtremaMaxCellVoltage entity,
) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['value'] = entity.value;
  data['clusterId'] = entity.clusterId;
  data['packNo'] = entity.packNo;
  data['cellNo'] = entity.cellNo;
  return data;
}

extension StackAndClusterExtremaMaxCellVoltageExtension
    on StackAndClusterExtremaMaxCellVoltage {
  StackAndClusterExtremaMaxCellVoltage copyWith({
    String? value,
    int? clusterId,
    int? packNo,
    int? cellNo,
  }) {
    return StackAndClusterExtremaMaxCellVoltage()
      ..value = value ?? this.value
      ..clusterId = clusterId ?? this.clusterId
      ..packNo = packNo ?? this.packNo
      ..cellNo = cellNo ?? this.cellNo;
  }
}

StackAndClusterExtremaMinCellVoltage
$StackAndClusterExtremaMinCellVoltageFromJson(Map<String, dynamic> json) {
  final StackAndClusterExtremaMinCellVoltage
  stackAndClusterExtremaMinCellVoltage = StackAndClusterExtremaMinCellVoltage();
  final String? value = jsonConvert.convert<String>(json['value']);
  if (value != null) {
    stackAndClusterExtremaMinCellVoltage.value = value;
  }
  final int? clusterId = jsonConvert.convert<int>(json['clusterId']);
  if (clusterId != null) {
    stackAndClusterExtremaMinCellVoltage.clusterId = clusterId;
  }
  final int? packNo = jsonConvert.convert<int>(json['packNo']);
  if (packNo != null) {
    stackAndClusterExtremaMinCellVoltage.packNo = packNo;
  }
  final int? cellNo = jsonConvert.convert<int>(json['cellNo']);
  if (cellNo != null) {
    stackAndClusterExtremaMinCellVoltage.cellNo = cellNo;
  }
  return stackAndClusterExtremaMinCellVoltage;
}

Map<String, dynamic> $StackAndClusterExtremaMinCellVoltageToJson(
  StackAndClusterExtremaMinCellVoltage entity,
) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['value'] = entity.value;
  data['clusterId'] = entity.clusterId;
  data['packNo'] = entity.packNo;
  data['cellNo'] = entity.cellNo;
  return data;
}

extension StackAndClusterExtremaMinCellVoltageExtension
    on StackAndClusterExtremaMinCellVoltage {
  StackAndClusterExtremaMinCellVoltage copyWith({
    String? value,
    int? clusterId,
    int? packNo,
    int? cellNo,
  }) {
    return StackAndClusterExtremaMinCellVoltage()
      ..value = value ?? this.value
      ..clusterId = clusterId ?? this.clusterId
      ..packNo = packNo ?? this.packNo
      ..cellNo = cellNo ?? this.cellNo;
  }
}

StackAndClusterExtremaMaxTemperature
$StackAndClusterExtremaMaxTemperatureFromJson(Map<String, dynamic> json) {
  final StackAndClusterExtremaMaxTemperature
  stackAndClusterExtremaMaxTemperature = StackAndClusterExtremaMaxTemperature();
  final String? value = jsonConvert.convert<String>(json['value']);
  if (value != null) {
    stackAndClusterExtremaMaxTemperature.value = value;
  }
  final int? clusterId = jsonConvert.convert<int>(json['clusterId']);
  if (clusterId != null) {
    stackAndClusterExtremaMaxTemperature.clusterId = clusterId;
  }
  final int? packNo = jsonConvert.convert<int>(json['packNo']);
  if (packNo != null) {
    stackAndClusterExtremaMaxTemperature.packNo = packNo;
  }
  final int? probeNo = jsonConvert.convert<int>(json['probeNo']);
  if (probeNo != null) {
    stackAndClusterExtremaMaxTemperature.probeNo = probeNo;
  }
  return stackAndClusterExtremaMaxTemperature;
}

Map<String, dynamic> $StackAndClusterExtremaMaxTemperatureToJson(
  StackAndClusterExtremaMaxTemperature entity,
) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['value'] = entity.value;
  data['clusterId'] = entity.clusterId;
  data['packNo'] = entity.packNo;
  data['probeNo'] = entity.probeNo;
  return data;
}

extension StackAndClusterExtremaMaxTemperatureExtension
    on StackAndClusterExtremaMaxTemperature {
  StackAndClusterExtremaMaxTemperature copyWith({
    String? value,
    int? clusterId,
    int? packNo,
    int? probeNo,
  }) {
    return StackAndClusterExtremaMaxTemperature()
      ..value = value ?? this.value
      ..clusterId = clusterId ?? this.clusterId
      ..packNo = packNo ?? this.packNo
      ..probeNo = probeNo ?? this.probeNo;
  }
}

StackAndClusterExtremaMinTemperature
$StackAndClusterExtremaMinTemperatureFromJson(Map<String, dynamic> json) {
  final StackAndClusterExtremaMinTemperature
  stackAndClusterExtremaMinTemperature = StackAndClusterExtremaMinTemperature();
  final String? value = jsonConvert.convert<String>(json['value']);
  if (value != null) {
    stackAndClusterExtremaMinTemperature.value = value;
  }
  final int? clusterId = jsonConvert.convert<int>(json['clusterId']);
  if (clusterId != null) {
    stackAndClusterExtremaMinTemperature.clusterId = clusterId;
  }
  final int? packNo = jsonConvert.convert<int>(json['packNo']);
  if (packNo != null) {
    stackAndClusterExtremaMinTemperature.packNo = packNo;
  }
  final int? probeNo = jsonConvert.convert<int>(json['probeNo']);
  if (probeNo != null) {
    stackAndClusterExtremaMinTemperature.probeNo = probeNo;
  }
  return stackAndClusterExtremaMinTemperature;
}

Map<String, dynamic> $StackAndClusterExtremaMinTemperatureToJson(
  StackAndClusterExtremaMinTemperature entity,
) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['value'] = entity.value;
  data['clusterId'] = entity.clusterId;
  data['packNo'] = entity.packNo;
  data['probeNo'] = entity.probeNo;
  return data;
}

extension StackAndClusterExtremaMinTemperatureExtension
    on StackAndClusterExtremaMinTemperature {
  StackAndClusterExtremaMinTemperature copyWith({
    String? value,
    int? clusterId,
    int? packNo,
    int? probeNo,
  }) {
    return StackAndClusterExtremaMinTemperature()
      ..value = value ?? this.value
      ..clusterId = clusterId ?? this.clusterId
      ..packNo = packNo ?? this.packNo
      ..probeNo = probeNo ?? this.probeNo;
  }
}

StackAndClusterDiagnosis $StackAndClusterDiagnosisFromJson(
  Map<String, dynamic> json,
) {
  final StackAndClusterDiagnosis stackAndClusterDiagnosis =
      StackAndClusterDiagnosis();
  final List<StackAndClusterDiagnosisPacks>? packs =
      (json['packs'] as List<dynamic>?)
          ?.map(
            (e) =>
                jsonConvert.convert<StackAndClusterDiagnosisPacks>(e)
                    as StackAndClusterDiagnosisPacks,
          )
          .toList();
  if (packs != null) {
    stackAndClusterDiagnosis.packs = packs;
  }
  return stackAndClusterDiagnosis;
}

Map<String, dynamic> $StackAndClusterDiagnosisToJson(
  StackAndClusterDiagnosis entity,
) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['packs'] = entity.packs?.map((v) => v.toJson()).toList();
  return data;
}

extension StackAndClusterDiagnosisExtension on StackAndClusterDiagnosis {
  StackAndClusterDiagnosis copyWith({
    List<StackAndClusterDiagnosisPacks>? packs,
  }) {
    return StackAndClusterDiagnosis()..packs = packs ?? this.packs;
  }
}

StackAndClusterDiagnosisPacks $StackAndClusterDiagnosisPacksFromJson(
  Map<String, dynamic> json,
) {
  final StackAndClusterDiagnosisPacks stackAndClusterDiagnosisPacks =
      StackAndClusterDiagnosisPacks();
  final String? packNo = jsonConvert.convert<String>(json['packNo']);
  if (packNo != null) {
    stackAndClusterDiagnosisPacks.packNo = packNo;
  }
  final int? cellCount = jsonConvert.convert<int>(json['cellCount']);
  if (cellCount != null) {
    stackAndClusterDiagnosisPacks.cellCount = cellCount;
  }
  final int? cellTempCount = jsonConvert.convert<int>(json['cellTempCount']);
  if (cellTempCount != null) {
    stackAndClusterDiagnosisPacks.cellTempCount = cellTempCount;
  }
  final String? soh = jsonConvert.convert<String>(json['soh']);
  if (soh != null) {
    stackAndClusterDiagnosisPacks.soh = soh;
  }
  final String? environmentTemperature = jsonConvert.convert<String>(
    json['environmentTemperature'],
  );
  if (environmentTemperature != null) {
    stackAndClusterDiagnosisPacks.environmentTemperature =
        environmentTemperature;
  }
  final String? heaterTemperature = jsonConvert.convert<String>(
    json['heaterTemperature'],
  );
  if (heaterTemperature != null) {
    stackAndClusterDiagnosisPacks.heaterTemperature = heaterTemperature;
  }
  final int? balance = jsonConvert.convert<int>(json['balance']);
  if (balance != null) {
    stackAndClusterDiagnosisPacks.balance = balance;
  }
  final List<int>? balancingCells = (json['balancingCells'] as List<dynamic>?)
      ?.map((e) => jsonConvert.convert<int>(e) as int)
      .toList();
  if (balancingCells != null) {
    stackAndClusterDiagnosisPacks.balancingCells = balancingCells;
  }
  final List<StackAndClusterDiagnosisPacksCellVoltages>? cellVoltages =
      (json['cellVoltages'] as List<dynamic>?)
          ?.map(
            (e) =>
                jsonConvert.convert<StackAndClusterDiagnosisPacksCellVoltages>(
                  e,
                ) as StackAndClusterDiagnosisPacksCellVoltages,
          )
          .toList();
  if (cellVoltages != null) {
    stackAndClusterDiagnosisPacks.cellVoltages = cellVoltages;
  }
  final List<StackAndClusterDiagnosisPacksCellTemperatures>? cellTemperatures =
      (json['cellTemperatures'] as List<dynamic>?)
          ?.map(
            (e) =>
                jsonConvert
                        .convert<StackAndClusterDiagnosisPacksCellTemperatures>(
                          e,
                        )
                    as StackAndClusterDiagnosisPacksCellTemperatures,
          )
          .toList();
  if (cellTemperatures != null) {
    stackAndClusterDiagnosisPacks.cellTemperatures = cellTemperatures;
  }
  final List<StackAndClusterDiagnosisPacksMosTemperatures>?
  mosTemperatures = (json['mosTemperatures'] as List<dynamic>?)
      ?.map(
        (e) =>
            jsonConvert.convert<StackAndClusterDiagnosisPacksMosTemperatures>(e)
                as StackAndClusterDiagnosisPacksMosTemperatures,
      )
      .toList();
  if (mosTemperatures != null) {
    stackAndClusterDiagnosisPacks.mosTemperatures = mosTemperatures;
  }
  return stackAndClusterDiagnosisPacks;
}

Map<String, dynamic> $StackAndClusterDiagnosisPacksToJson(
  StackAndClusterDiagnosisPacks entity,
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

extension StackAndClusterDiagnosisPacksExtension
    on StackAndClusterDiagnosisPacks {
  StackAndClusterDiagnosisPacks copyWith({
    String? packNo,
    int? cellCount,
    int? cellTempCount,
    String? soh,
    String? environmentTemperature,
    String? heaterTemperature,
    int? balance,
    List<int>? balancingCells,
    List<StackAndClusterDiagnosisPacksCellVoltages>? cellVoltages,
    List<StackAndClusterDiagnosisPacksCellTemperatures>? cellTemperatures,
    List<StackAndClusterDiagnosisPacksMosTemperatures>? mosTemperatures,
  }) {
    return StackAndClusterDiagnosisPacks()
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

StackAndClusterDiagnosisPacksCellVoltages
$StackAndClusterDiagnosisPacksCellVoltagesFromJson(Map<String, dynamic> json) {
  final StackAndClusterDiagnosisPacksCellVoltages
  stackAndClusterDiagnosisPacksCellVoltages =
      StackAndClusterDiagnosisPacksCellVoltages();
  final String? cellNo = jsonConvert.convert<String>(json['cellNo']);
  if (cellNo != null) {
    stackAndClusterDiagnosisPacksCellVoltages.cellNo = cellNo;
  }
  final num? voltageMv = jsonConvert.convert<num>(json['voltageMv']);
  if (voltageMv != null) {
    stackAndClusterDiagnosisPacksCellVoltages.voltageMv = voltageMv;
  }
  final num? voltageV = jsonConvert.convert<num>(json['voltageV']);
  if (voltageV != null) {
    stackAndClusterDiagnosisPacksCellVoltages.voltageV = voltageV;
  }
  final bool? isMax = jsonConvert.convert<bool>(json['isMax']);
  if (isMax != null) {
    stackAndClusterDiagnosisPacksCellVoltages.isMax = isMax;
  }
  final bool? isMin = jsonConvert.convert<bool>(json['isMin']);
  if (isMin != null) {
    stackAndClusterDiagnosisPacksCellVoltages.isMin = isMin;
  }
  final bool? isBalancing = jsonConvert.convert<bool>(json['isBalancing']);
  if (isBalancing != null) {
    stackAndClusterDiagnosisPacksCellVoltages.isBalancing = isBalancing;
  }
  return stackAndClusterDiagnosisPacksCellVoltages;
}

Map<String, dynamic> $StackAndClusterDiagnosisPacksCellVoltagesToJson(
  StackAndClusterDiagnosisPacksCellVoltages entity,
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

extension StackAndClusterDiagnosisPacksCellVoltagesExtension
    on StackAndClusterDiagnosisPacksCellVoltages {
  StackAndClusterDiagnosisPacksCellVoltages copyWith({
    String? cellNo,
    num? voltageMv,
    num? voltageV,
    bool? isMax,
    bool? isMin,
    bool? isBalancing,
  }) {
    return StackAndClusterDiagnosisPacksCellVoltages()
      ..cellNo = cellNo ?? this.cellNo
      ..voltageMv = voltageMv ?? this.voltageMv
      ..voltageV = voltageV ?? this.voltageV
      ..isMax = isMax ?? this.isMax
      ..isMin = isMin ?? this.isMin
      ..isBalancing = isBalancing ?? this.isBalancing;
  }
}

StackAndClusterDiagnosisPacksCellTemperatures
$StackAndClusterDiagnosisPacksCellTemperaturesFromJson(
  Map<String, dynamic> json,
) {
  final StackAndClusterDiagnosisPacksCellTemperatures
  stackAndClusterDiagnosisPacksCellTemperatures =
      StackAndClusterDiagnosisPacksCellTemperatures();
  final int? probeNo = jsonConvert.convert<int>(json['probeNo']);
  if (probeNo != null) {
    stackAndClusterDiagnosisPacksCellTemperatures.probeNo = probeNo;
  }
  final int? tempRawDc = jsonConvert.convert<int>(json['tempRawDc']);
  if (tempRawDc != null) {
    stackAndClusterDiagnosisPacksCellTemperatures.tempRawDc = tempRawDc;
  }
  final int? tempC = jsonConvert.convert<int>(json['tempC']);
  if (tempC != null) {
    stackAndClusterDiagnosisPacksCellTemperatures.tempC = tempC;
  }
  final bool? isMax = jsonConvert.convert<bool>(json['isMax']);
  if (isMax != null) {
    stackAndClusterDiagnosisPacksCellTemperatures.isMax = isMax;
  }
  final bool? isMin = jsonConvert.convert<bool>(json['isMin']);
  if (isMin != null) {
    stackAndClusterDiagnosisPacksCellTemperatures.isMin = isMin;
  }
  return stackAndClusterDiagnosisPacksCellTemperatures;
}

Map<String, dynamic> $StackAndClusterDiagnosisPacksCellTemperaturesToJson(
  StackAndClusterDiagnosisPacksCellTemperatures entity,
) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['probeNo'] = entity.probeNo;
  data['tempRawDc'] = entity.tempRawDc;
  data['tempC'] = entity.tempC;
  data['isMax'] = entity.isMax;
  data['isMin'] = entity.isMin;
  return data;
}

extension StackAndClusterDiagnosisPacksCellTemperaturesExtension
    on StackAndClusterDiagnosisPacksCellTemperatures {
  StackAndClusterDiagnosisPacksCellTemperatures copyWith({
    int? probeNo,
    int? tempRawDc,
    int? tempC,
    bool? isMax,
    bool? isMin,
  }) {
    return StackAndClusterDiagnosisPacksCellTemperatures()
      ..probeNo = probeNo ?? this.probeNo
      ..tempRawDc = tempRawDc ?? this.tempRawDc
      ..tempC = tempC ?? this.tempC
      ..isMax = isMax ?? this.isMax
      ..isMin = isMin ?? this.isMin;
  }
}

StackAndClusterDiagnosisPacksMosTemperatures
$StackAndClusterDiagnosisPacksMosTemperaturesFromJson(
  Map<String, dynamic> json,
) {
  final StackAndClusterDiagnosisPacksMosTemperatures
  stackAndClusterDiagnosisPacksMosTemperatures =
      StackAndClusterDiagnosisPacksMosTemperatures();
  final int? no = jsonConvert.convert<int>(json['no']);
  if (no != null) {
    stackAndClusterDiagnosisPacksMosTemperatures.no = no;
  }
  final int? tempC = jsonConvert.convert<int>(json['tempC']);
  if (tempC != null) {
    stackAndClusterDiagnosisPacksMosTemperatures.tempC = tempC;
  }
  return stackAndClusterDiagnosisPacksMosTemperatures;
}

Map<String, dynamic> $StackAndClusterDiagnosisPacksMosTemperaturesToJson(
  StackAndClusterDiagnosisPacksMosTemperatures entity,
) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['no'] = entity.no;
  data['tempC'] = entity.tempC;
  return data;
}

extension StackAndClusterDiagnosisPacksMosTemperaturesExtension
    on StackAndClusterDiagnosisPacksMosTemperatures {
  StackAndClusterDiagnosisPacksMosTemperatures copyWith({int? no, int? tempC}) {
    return StackAndClusterDiagnosisPacksMosTemperatures()
      ..no = no ?? this.no
      ..tempC = tempC ?? this.tempC;
  }
}

StackAndClusterAlarmInfo $StackAndClusterAlarmInfoFromJson(
  Map<String, dynamic> json,
) {
  final StackAndClusterAlarmInfo stackAndClusterAlarmInfo =
      StackAndClusterAlarmInfo();
  final String? status = jsonConvert.convert<String>(json['status']);
  if (status != null) {
    stackAndClusterAlarmInfo.status = status;
  }
  final int? siteId = jsonConvert.convert<int>(json['siteId']);
  if (siteId != null) {
    stackAndClusterAlarmInfo.siteId = siteId;
  }
  final String? siteName = jsonConvert.convert<String>(json['siteName']);
  if (siteName != null) {
    stackAndClusterAlarmInfo.siteName = siteName;
  }
  final String? domainType = jsonConvert.convert<String>(json['domainType']);
  if (domainType != null) {
    stackAndClusterAlarmInfo.domainType = domainType;
  }
  final String? stackSn = jsonConvert.convert<String>(json['stackSn']);
  if (stackSn != null) {
    stackAndClusterAlarmInfo.stackSn = stackSn;
  }
  final String? stackName = jsonConvert.convert<String>(json['stackName']);
  if (stackName != null) {
    stackAndClusterAlarmInfo.stackName = stackName;
  }
  final String? clusterSn = jsonConvert.convert<String>(json['clusterSn']);
  if (clusterSn != null) {
    stackAndClusterAlarmInfo.clusterSn = clusterSn;
  }
  final String? clusterName = jsonConvert.convert<String>(json['clusterName']);
  if (clusterName != null) {
    stackAndClusterAlarmInfo.clusterName = clusterName;
  }
  final int? alarmLevel = jsonConvert.convert<int>(json['alarmLevel']);
  if (alarmLevel != null) {
    stackAndClusterAlarmInfo.alarmLevel = alarmLevel;
  }
  final int? packNo = jsonConvert.convert<int>(json['packNo']);
  if (packNo != null) {
    stackAndClusterAlarmInfo.packNo = packNo;
  }
  final int? cellNo = jsonConvert.convert<int>(json['cellNo']);
  if (cellNo != null) {
    stackAndClusterAlarmInfo.cellNo = cellNo;
  }
  return stackAndClusterAlarmInfo;
}

Map<String, dynamic> $StackAndClusterAlarmInfoToJson(
  StackAndClusterAlarmInfo entity,
) {
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

extension StackAndClusterAlarmInfoExtension on StackAndClusterAlarmInfo {
  StackAndClusterAlarmInfo copyWith({
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
    return StackAndClusterAlarmInfo()
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

StackAndClusterSystemInfo $StackAndClusterSystemInfoFromJson(
  Map<String, dynamic> json,
) {
  final StackAndClusterSystemInfo stackAndClusterSystemInfo =
      StackAndClusterSystemInfo();
  final String? stackSn = jsonConvert.convert<String>(json['stackSn']);
  if (stackSn != null) {
    stackAndClusterSystemInfo.stackSn = stackSn;
  }
  final String? clusterSn = jsonConvert.convert<String>(json['clusterSn']);
  if (clusterSn != null) {
    stackAndClusterSystemInfo.clusterSn = clusterSn;
  }
  final String? clusterNo = jsonConvert.convert<String>(json['clusterNo']);
  if (clusterNo != null) {
    stackAndClusterSystemInfo.clusterNo = clusterNo;
  }
  final String? softwareVersion = jsonConvert.convert<String>(
    json['softwareVersion'],
  );
  if (softwareVersion != null) {
    stackAndClusterSystemInfo.softwareVersion = softwareVersion;
  }
  final String? hardwareVersion = jsonConvert.convert<String>(
    json['hardwareVersion'],
  );
  if (hardwareVersion != null) {
    stackAndClusterSystemInfo.hardwareVersion = hardwareVersion;
  }
  final String? bootVersion = jsonConvert.convert<String>(json['bootVersion']);
  if (bootVersion != null) {
    stackAndClusterSystemInfo.bootVersion = bootVersion;
  }
  final int? designMah = jsonConvert.convert<int>(json['designMah']);
  if (designMah != null) {
    stackAndClusterSystemInfo.designMah = designMah;
  }
  final String? designCapacity = jsonConvert.convert<String>(
    json['designCapacity'],
  );
  if (designCapacity != null) {
    stackAndClusterSystemInfo.designCapacity = designCapacity;
  }
  final int? packCount = jsonConvert.convert<int>(json['packCount']);
  if (packCount != null) {
    stackAndClusterSystemInfo.packCount = packCount;
  }
  final int? packCellCount = jsonConvert.convert<int>(json['packCellCount']);
  if (packCellCount != null) {
    stackAndClusterSystemInfo.packCellCount = packCellCount;
  }
  final int? packTempCount = jsonConvert.convert<int>(json['packTempCount']);
  if (packTempCount != null) {
    stackAndClusterSystemInfo.packTempCount = packTempCount;
  }
  final int? sysMode = jsonConvert.convert<int>(json['sysMode']);
  if (sysMode != null) {
    stackAndClusterSystemInfo.sysMode = sysMode;
  }
  final int? accessMode = jsonConvert.convert<int>(json['accessMode']);
  if (accessMode != null) {
    stackAndClusterSystemInfo.accessMode = accessMode;
  }
  return stackAndClusterSystemInfo;
}

Map<String, dynamic> $StackAndClusterSystemInfoToJson(
  StackAndClusterSystemInfo entity,
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

extension StackAndClusterSystemInfoExtension on StackAndClusterSystemInfo {
  StackAndClusterSystemInfo copyWith({
    String? stackSn,
    String? clusterSn,
    String? clusterNo,
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
    return StackAndClusterSystemInfo()
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

StackAndClusterClusters $StackAndClusterClustersFromJson(
  Map<String, dynamic> json,
) {
  final StackAndClusterClusters stackAndClusterClusters =
      StackAndClusterClusters();
  final int? clusterId = jsonConvert.convert<int>(json['clusterId']);
  if (clusterId != null) {
    stackAndClusterClusters.clusterId = clusterId;
  }
  final String? clusterSn = jsonConvert.convert<String>(json['clusterSn']);
  if (clusterSn != null) {
    stackAndClusterClusters.clusterSn = clusterSn;
  }
  final int? clusterNo = jsonConvert.convert<int>(json['clusterNo']);
  if (clusterNo != null) {
    stackAndClusterClusters.clusterNo = clusterNo;
  }
  final String? clusterName = jsonConvert.convert<String>(json['clusterName']);
  if (clusterName != null) {
    stackAndClusterClusters.clusterName = clusterName;
  }
  final int? packCount = jsonConvert.convert<int>(json['packCount']);
  if (packCount != null) {
    stackAndClusterClusters.packCount = packCount;
  }
  final String? commStatus = jsonConvert.convert<String>(json['commStatus']);
  if (commStatus != null) {
    stackAndClusterClusters.commStatus = commStatus;
  }
  final String? soc = jsonConvert.convert<String>(json['soc']);
  if (soc != null) {
    stackAndClusterClusters.soc = soc;
  }
  final String? soh = jsonConvert.convert<String>(json['soh']);
  if (soh != null) {
    stackAndClusterClusters.soh = soh;
  }
  final String? totalVoltage = jsonConvert.convert<String>(
    json['totalVoltage'],
  );
  if (totalVoltage != null) {
    stackAndClusterClusters.totalVoltage = totalVoltage;
  }
  final String? totalCurrent = jsonConvert.convert<String>(
    json['totalCurrent'],
  );
  if (totalCurrent != null) {
    stackAndClusterClusters.totalCurrent = totalCurrent;
  }
  final String? maxTemperature = jsonConvert.convert<String>(
    json['maxTemperature'],
  );
  if (maxTemperature != null) {
    stackAndClusterClusters.maxTemperature = maxTemperature;
  }
  final String? maxVoltageDiff = jsonConvert.convert<String>(
    json['maxVoltageDiff'],
  );
  if (maxVoltageDiff != null) {
    stackAndClusterClusters.maxVoltageDiff = maxVoltageDiff;
  }
  final String? lastDataTime = jsonConvert.convert<String>(
    json['lastDataTime'],
  );
  if (lastDataTime != null) {
    stackAndClusterClusters.lastDataTime = lastDataTime;
  }
  return stackAndClusterClusters;
}

Map<String, dynamic> $StackAndClusterClustersToJson(
  StackAndClusterClusters entity,
) {
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

extension StackAndClusterClustersExtension on StackAndClusterClusters {
  StackAndClusterClusters copyWith({
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
    return StackAndClusterClusters()
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
