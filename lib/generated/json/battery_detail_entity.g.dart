import 'package:cesc01/core/network/bean/battery_detail_entity.dart';
import 'package:cesc01/generated/json/base/json_convert_content.dart';

BatteryDetailEntity $BatteryDetailEntityFromJson(Map<String, dynamic> json) {
  final BatteryDetailEntity batteryDetailEntity = BatteryDetailEntity();
  final int? packId = jsonConvert.convert<int>(json['packId']);
  if (packId != null) {
    batteryDetailEntity.packId = packId;
  }
  final String? packName = jsonConvert.convert<String>(json['packName']);
  if (packName != null) {
    batteryDetailEntity.packName = packName;
  }
  final String? modelName = jsonConvert.convert<String>(json['modelName']);
  if (modelName != null) {
    batteryDetailEntity.modelName = modelName;
  }
  final String? sn = jsonConvert.convert<String>(json['sn']);
  if (sn != null) {
    batteryDetailEntity.sn = sn;
  }
  final String? runStatus = jsonConvert.convert<String>(json['runStatus']);
  if (runStatus != null) {
    batteryDetailEntity.runStatus = runStatus;
  }
  final String? commStatus = jsonConvert.convert<String>(json['commStatus']);
  if (commStatus != null) {
    batteryDetailEntity.commStatus = commStatus;
  }
  final String? statusDesc = jsonConvert.convert<String>(json['statusDesc']);
  if (statusDesc != null) {
    batteryDetailEntity.statusDesc = statusDesc;
  }
  final String? reportTime = jsonConvert.convert<String>(json['reportTime']);
  if (reportTime != null) {
    batteryDetailEntity.reportTime = reportTime;
  }
  final String? dataValidDesc = jsonConvert.convert<String>(
    json['dataValidDesc'],
  );
  if (dataValidDesc != null) {
    batteryDetailEntity.dataValidDesc = dataValidDesc;
  }
  final BatteryDetailKeyMetrics? keyMetrics = jsonConvert
      .convert<BatteryDetailKeyMetrics>(json['keyMetrics']);
  if (keyMetrics != null) {
    batteryDetailEntity.keyMetrics = keyMetrics;
  }
  final BatteryDetailAdvancedDiagnosis? advancedDiagnosis = jsonConvert
      .convert<BatteryDetailAdvancedDiagnosis>(json['advancedDiagnosis']);
  if (advancedDiagnosis != null) {
    batteryDetailEntity.advancedDiagnosis = advancedDiagnosis;
  }
  final BatteryDetailSystemInfo? systemInfo = jsonConvert
      .convert<BatteryDetailSystemInfo>(json['systemInfo']);
  if (systemInfo != null) {
    batteryDetailEntity.systemInfo = systemInfo;
  }
  return batteryDetailEntity;
}

Map<String, dynamic> $BatteryDetailEntityToJson(BatteryDetailEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['packId'] = entity.packId;
  data['packName'] = entity.packName;
  data['modelName'] = entity.modelName;
  data['sn'] = entity.sn;
  data['runStatus'] = entity.runStatus;
  data['commStatus'] = entity.commStatus;
  data['statusDesc'] = entity.statusDesc;
  data['reportTime'] = entity.reportTime;
  data['dataValidDesc'] = entity.dataValidDesc;
  data['keyMetrics'] = entity.keyMetrics?.toJson();
  data['advancedDiagnosis'] = entity.advancedDiagnosis?.toJson();
  data['systemInfo'] = entity.systemInfo?.toJson();
  return data;
}

extension BatteryDetailEntityExtension on BatteryDetailEntity {
  BatteryDetailEntity copyWith({
    int? packId,
    String? packName,
    String? modelName,
    String? sn,
    String? runStatus,
    String? commStatus,
    String? statusDesc,
    String? reportTime,
    String? dataValidDesc,
    BatteryDetailKeyMetrics? keyMetrics,
    BatteryDetailAdvancedDiagnosis? advancedDiagnosis,
    BatteryDetailSystemInfo? systemInfo,
  }) {
    return BatteryDetailEntity()
      ..packId = packId ?? this.packId
      ..packName = packName ?? this.packName
      ..modelName = modelName ?? this.modelName
      ..sn = sn ?? this.sn
      ..runStatus = runStatus ?? this.runStatus
      ..commStatus = commStatus ?? this.commStatus
      ..statusDesc = statusDesc ?? this.statusDesc
      ..reportTime = reportTime ?? this.reportTime
      ..dataValidDesc = dataValidDesc ?? this.dataValidDesc
      ..keyMetrics = keyMetrics ?? this.keyMetrics
      ..advancedDiagnosis = advancedDiagnosis ?? this.advancedDiagnosis
      ..systemInfo = systemInfo ?? this.systemInfo;
  }
}

BatteryDetailKeyMetrics $BatteryDetailKeyMetricsFromJson(
  Map<String, dynamic> json,
) {
  final BatteryDetailKeyMetrics batteryDetailKeyMetrics =
      BatteryDetailKeyMetrics();
  final BatteryDetailKeyMetricsCore? core = jsonConvert
      .convert<BatteryDetailKeyMetricsCore>(json['core']);
  if (core != null) {
    batteryDetailKeyMetrics.core = core;
  }
  final BatteryDetailKeyMetricsExtrema? extrema = jsonConvert
      .convert<BatteryDetailKeyMetricsExtrema>(json['extrema']);
  if (extrema != null) {
    batteryDetailKeyMetrics.extrema = extrema;
  }
  final BatteryDetailKeyMetricsCapacity? capacity = jsonConvert
      .convert<BatteryDetailKeyMetricsCapacity>(json['capacity']);
  if (capacity != null) {
    batteryDetailKeyMetrics.capacity = capacity;
  }
  return batteryDetailKeyMetrics;
}

Map<String, dynamic> $BatteryDetailKeyMetricsToJson(
  BatteryDetailKeyMetrics entity,
) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['core'] = entity.core?.toJson();
  data['extrema'] = entity.extrema?.toJson();
  data['capacity'] = entity.capacity?.toJson();
  return data;
}

extension BatteryDetailKeyMetricsExtension on BatteryDetailKeyMetrics {
  BatteryDetailKeyMetrics copyWith({
    BatteryDetailKeyMetricsCore? core,
    BatteryDetailKeyMetricsExtrema? extrema,
    BatteryDetailKeyMetricsCapacity? capacity,
  }) {
    return BatteryDetailKeyMetrics()
      ..core = core ?? this.core
      ..extrema = extrema ?? this.extrema
      ..capacity = capacity ?? this.capacity;
  }
}

BatteryDetailKeyMetricsCore $BatteryDetailKeyMetricsCoreFromJson(
  Map<String, dynamic> json,
) {
  final BatteryDetailKeyMetricsCore batteryDetailKeyMetricsCore =
      BatteryDetailKeyMetricsCore();
  final String? runStatus = jsonConvert.convert<String>(json['runStatus']);
  if (runStatus != null) {
    batteryDetailKeyMetricsCore.runStatus = runStatus;
  }
  final String? soc = jsonConvert.convert<String>(json['soc']);
  if (soc != null) {
    batteryDetailKeyMetricsCore.soc = soc;
  }
  final String? soh = jsonConvert.convert<String>(json['soh']);
  if (soh != null) {
    batteryDetailKeyMetricsCore.soh = soh;
  }
  final String? totalVoltage = jsonConvert.convert<String>(
    json['totalVoltage'],
  );
  if (totalVoltage != null) {
    batteryDetailKeyMetricsCore.totalVoltage = totalVoltage;
  }
  final String? totalCurrent = jsonConvert.convert<String>(
    json['totalCurrent'],
  );
  if (totalCurrent != null) {
    batteryDetailKeyMetricsCore.totalCurrent = totalCurrent;
  }
  final String? remainingCapacity = jsonConvert.convert<String>(
    json['remainingCapacity'],
  );
  if (remainingCapacity != null) {
    batteryDetailKeyMetricsCore.remainingCapacity = remainingCapacity;
  }
  final String? maxTemperature = jsonConvert.convert<String>(
    json['maxTemperature'],
  );
  if (maxTemperature != null) {
    batteryDetailKeyMetricsCore.maxTemperature = maxTemperature;
  }
  final String? maxVoltageDiff = jsonConvert.convert<String>(
    json['maxVoltageDiff'],
  );
  if (maxVoltageDiff != null) {
    batteryDetailKeyMetricsCore.maxVoltageDiff = maxVoltageDiff;
  }
  final String? chargeDischargePermission = jsonConvert.convert<String>(
    json['chargeDischargePermission'],
  );
  if (chargeDischargePermission != null) {
    batteryDetailKeyMetricsCore.chargeDischargePermission =
        chargeDischargePermission;
  }
  final String? maxChargeCurrent = jsonConvert.convert<String>(
    json['maxChargeCurrent'],
  );
  if (maxChargeCurrent != null) {
    batteryDetailKeyMetricsCore.maxChargeCurrent = maxChargeCurrent;
  }
  final String? maxDischargeCurrent = jsonConvert.convert<String>(
    json['maxDischargeCurrent'],
  );
  if (maxDischargeCurrent != null) {
    batteryDetailKeyMetricsCore.maxDischargeCurrent = maxDischargeCurrent;
  }
  final int? alarmCount = jsonConvert.convert<int>(json['alarmCount']);
  if (alarmCount != null) {
    batteryDetailKeyMetricsCore.alarmCount = alarmCount;
  }
  final String? alarmCountDesc = jsonConvert.convert<String>(
    json['alarmCountDesc'],
  );
  if (alarmCountDesc != null) {
    batteryDetailKeyMetricsCore.alarmCountDesc = alarmCountDesc;
  }
  return batteryDetailKeyMetricsCore;
}

Map<String, dynamic> $BatteryDetailKeyMetricsCoreToJson(
  BatteryDetailKeyMetricsCore entity,
) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['runStatus'] = entity.runStatus;
  data['soc'] = entity.soc;
  data['soh'] = entity.soh;
  data['totalVoltage'] = entity.totalVoltage;
  data['totalCurrent'] = entity.totalCurrent;
  data['remainingCapacity'] = entity.remainingCapacity;
  data['maxTemperature'] = entity.maxTemperature;
  data['maxVoltageDiff'] = entity.maxVoltageDiff;
  data['chargeDischargePermission'] = entity.chargeDischargePermission;
  data['maxChargeCurrent'] = entity.maxChargeCurrent;
  data['maxDischargeCurrent'] = entity.maxDischargeCurrent;
  data['alarmCount'] = entity.alarmCount;
  data['alarmCountDesc'] = entity.alarmCountDesc;
  return data;
}

extension BatteryDetailKeyMetricsCoreExtension on BatteryDetailKeyMetricsCore {
  BatteryDetailKeyMetricsCore copyWith({
    String? runStatus,
    String? soc,
    String? soh,
    String? totalVoltage,
    String? totalCurrent,
    String? remainingCapacity,
    String? maxTemperature,
    String? maxVoltageDiff,
    String? chargeDischargePermission,
    String? maxChargeCurrent,
    String? maxDischargeCurrent,
    int? alarmCount,
    String? alarmCountDesc,
  }) {
    return BatteryDetailKeyMetricsCore()
      ..runStatus = runStatus ?? this.runStatus
      ..soc = soc ?? this.soc
      ..soh = soh ?? this.soh
      ..totalVoltage = totalVoltage ?? this.totalVoltage
      ..totalCurrent = totalCurrent ?? this.totalCurrent
      ..remainingCapacity = remainingCapacity ?? this.remainingCapacity
      ..maxTemperature = maxTemperature ?? this.maxTemperature
      ..maxVoltageDiff = maxVoltageDiff ?? this.maxVoltageDiff
      ..chargeDischargePermission =
          chargeDischargePermission ?? this.chargeDischargePermission
      ..maxChargeCurrent = maxChargeCurrent ?? this.maxChargeCurrent
      ..maxDischargeCurrent = maxDischargeCurrent ?? this.maxDischargeCurrent
      ..alarmCount = alarmCount ?? this.alarmCount
      ..alarmCountDesc = alarmCountDesc ?? this.alarmCountDesc;
  }
}

BatteryDetailKeyMetricsExtrema $BatteryDetailKeyMetricsExtremaFromJson(
  Map<String, dynamic> json,
) {
  final BatteryDetailKeyMetricsExtrema batteryDetailKeyMetricsExtrema =
      BatteryDetailKeyMetricsExtrema();
  final String? maxCellVoltage = jsonConvert.convert<String>(
    json['maxCellVoltage'],
  );
  if (maxCellVoltage != null) {
    batteryDetailKeyMetricsExtrema.maxCellVoltage = maxCellVoltage;
  }
  final String? maxCellVoltagePosition = jsonConvert.convert<String>(
    json['maxCellVoltagePosition'],
  );
  if (maxCellVoltagePosition != null) {
    batteryDetailKeyMetricsExtrema.maxCellVoltagePosition =
        maxCellVoltagePosition;
  }
  final String? minCellVoltage = jsonConvert.convert<String>(
    json['minCellVoltage'],
  );
  if (minCellVoltage != null) {
    batteryDetailKeyMetricsExtrema.minCellVoltage = minCellVoltage;
  }
  final String? minCellVoltagePosition = jsonConvert.convert<String>(
    json['minCellVoltagePosition'],
  );
  if (minCellVoltagePosition != null) {
    batteryDetailKeyMetricsExtrema.minCellVoltagePosition =
        minCellVoltagePosition;
  }
  final String? maxTempExtrema = jsonConvert.convert<String>(
    json['maxTempExtrema'],
  );
  if (maxTempExtrema != null) {
    batteryDetailKeyMetricsExtrema.maxTempExtrema = maxTempExtrema;
  }
  final String? maxTempPosition = jsonConvert.convert<String>(
    json['maxTempPosition'],
  );
  if (maxTempPosition != null) {
    batteryDetailKeyMetricsExtrema.maxTempPosition = maxTempPosition;
  }
  final String? minTempExtrema = jsonConvert.convert<String>(
    json['minTempExtrema'],
  );
  if (minTempExtrema != null) {
    batteryDetailKeyMetricsExtrema.minTempExtrema = minTempExtrema;
  }
  final String? minTempPosition = jsonConvert.convert<String>(
    json['minTempPosition'],
  );
  if (minTempPosition != null) {
    batteryDetailKeyMetricsExtrema.minTempPosition = minTempPosition;
  }
  final String? maxTempDiff = jsonConvert.convert<String>(json['maxTempDiff']);
  if (maxTempDiff != null) {
    batteryDetailKeyMetricsExtrema.maxTempDiff = maxTempDiff;
  }
  final String? maxTempDiffPosition = jsonConvert.convert<String>(
    json['maxTempDiffPosition'],
  );
  if (maxTempDiffPosition != null) {
    batteryDetailKeyMetricsExtrema.maxTempDiffPosition = maxTempDiffPosition;
  }
  return batteryDetailKeyMetricsExtrema;
}

Map<String, dynamic> $BatteryDetailKeyMetricsExtremaToJson(
  BatteryDetailKeyMetricsExtrema entity,
) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['maxCellVoltage'] = entity.maxCellVoltage;
  data['maxCellVoltagePosition'] = entity.maxCellVoltagePosition;
  data['minCellVoltage'] = entity.minCellVoltage;
  data['minCellVoltagePosition'] = entity.minCellVoltagePosition;
  data['maxTempExtrema'] = entity.maxTempExtrema;
  data['maxTempPosition'] = entity.maxTempPosition;
  data['minTempExtrema'] = entity.minTempExtrema;
  data['minTempPosition'] = entity.minTempPosition;
  data['maxTempDiff'] = entity.maxTempDiff;
  data['maxTempDiffPosition'] = entity.maxTempDiffPosition;
  return data;
}

extension BatteryDetailKeyMetricsExtremaExtension
    on BatteryDetailKeyMetricsExtrema {
  BatteryDetailKeyMetricsExtrema copyWith({
    String? maxCellVoltage,
    String? maxCellVoltagePosition,
    String? minCellVoltage,
    String? minCellVoltagePosition,
    String? maxTempExtrema,
    String? maxTempPosition,
    String? minTempExtrema,
    String? minTempPosition,
    String? maxTempDiff,
    String? maxTempDiffPosition,
  }) {
    return BatteryDetailKeyMetricsExtrema()
      ..maxCellVoltage = maxCellVoltage ?? this.maxCellVoltage
      ..maxCellVoltagePosition =
          maxCellVoltagePosition ?? this.maxCellVoltagePosition
      ..minCellVoltage = minCellVoltage ?? this.minCellVoltage
      ..minCellVoltagePosition =
          minCellVoltagePosition ?? this.minCellVoltagePosition
      ..maxTempExtrema = maxTempExtrema ?? this.maxTempExtrema
      ..maxTempPosition = maxTempPosition ?? this.maxTempPosition
      ..minTempExtrema = minTempExtrema ?? this.minTempExtrema
      ..minTempPosition = minTempPosition ?? this.minTempPosition
      ..maxTempDiff = maxTempDiff ?? this.maxTempDiff
      ..maxTempDiffPosition = maxTempDiffPosition ?? this.maxTempDiffPosition;
  }
}

BatteryDetailKeyMetricsCapacity $BatteryDetailKeyMetricsCapacityFromJson(
  Map<String, dynamic> json,
) {
  final BatteryDetailKeyMetricsCapacity batteryDetailKeyMetricsCapacity =
      BatteryDetailKeyMetricsCapacity();
  final String? canChargeCapacity = jsonConvert.convert<String>(
    json['canChargeCapacity'],
  );
  if (canChargeCapacity != null) {
    batteryDetailKeyMetricsCapacity.canChargeCapacity = canChargeCapacity;
  }
  final String? canDischargeCapacity = jsonConvert.convert<String>(
    json['canDischargeCapacity'],
  );
  if (canDischargeCapacity != null) {
    batteryDetailKeyMetricsCapacity.canDischargeCapacity = canDischargeCapacity;
  }
  final String? totalChargedEnergy = jsonConvert.convert<String>(
    json['totalChargedEnergy'],
  );
  if (totalChargedEnergy != null) {
    batteryDetailKeyMetricsCapacity.totalChargedEnergy = totalChargedEnergy;
  }
  final String? totalDischargedEnergy = jsonConvert.convert<String>(
    json['totalDischargedEnergy'],
  );
  if (totalDischargedEnergy != null) {
    batteryDetailKeyMetricsCapacity.totalDischargedEnergy =
        totalDischargedEnergy;
  }
  final String? cycles = jsonConvert.convert<String>(json['cycles']);
  if (cycles != null) {
    batteryDetailKeyMetricsCapacity.cycles = cycles;
  }
  final String? heaterStatusDesc = jsonConvert.convert<String>(
    json['heaterStatusDesc'],
  );
  if (heaterStatusDesc != null) {
    batteryDetailKeyMetricsCapacity.heaterStatusDesc = heaterStatusDesc;
  }
  final String? balanceStatusDesc = jsonConvert.convert<String>(
    json['balanceStatusDesc'],
  );
  if (balanceStatusDesc != null) {
    batteryDetailKeyMetricsCapacity.balanceStatusDesc = balanceStatusDesc;
  }
  final List<BatteryDetailKeyMetricsCapacityBalancingPacks>? balancingPacks =
      (json['balancingPacks'] as List<dynamic>?)
          ?.map(
            (e) =>
                jsonConvert
                        .convert<BatteryDetailKeyMetricsCapacityBalancingPacks>(
                          e,
                        )
                    as BatteryDetailKeyMetricsCapacityBalancingPacks,
          )
          .toList();
  if (balancingPacks != null) {
    batteryDetailKeyMetricsCapacity.balancingPacks = balancingPacks;
  }
  final String? environmentTemperature = jsonConvert.convert<String>(
    json['environmentTemperature'],
  );
  if (environmentTemperature != null) {
    batteryDetailKeyMetricsCapacity.environmentTemperature =
        environmentTemperature;
  }
  return batteryDetailKeyMetricsCapacity;
}

Map<String, dynamic> $BatteryDetailKeyMetricsCapacityToJson(
  BatteryDetailKeyMetricsCapacity entity,
) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['canChargeCapacity'] = entity.canChargeCapacity;
  data['canDischargeCapacity'] = entity.canDischargeCapacity;
  data['totalChargedEnergy'] = entity.totalChargedEnergy;
  data['totalDischargedEnergy'] = entity.totalDischargedEnergy;
  data['cycles'] = entity.cycles;
  data['heaterStatusDesc'] = entity.heaterStatusDesc;
  data['balanceStatusDesc'] = entity.balanceStatusDesc;
  data['balancingPacks'] = entity.balancingPacks
      ?.map((v) => v.toJson())
      .toList();
  data['environmentTemperature'] = entity.environmentTemperature;
  return data;
}

extension BatteryDetailKeyMetricsCapacityExtension
    on BatteryDetailKeyMetricsCapacity {
  BatteryDetailKeyMetricsCapacity copyWith({
    String? canChargeCapacity,
    String? canDischargeCapacity,
    String? totalChargedEnergy,
    String? totalDischargedEnergy,
    String? cycles,
    String? heaterStatusDesc,
    String? balanceStatusDesc,
    List<BatteryDetailKeyMetricsCapacityBalancingPacks>? balancingPacks,
    String? environmentTemperature,
  }) {
    return BatteryDetailKeyMetricsCapacity()
      ..canChargeCapacity = canChargeCapacity ?? this.canChargeCapacity
      ..canDischargeCapacity = canDischargeCapacity ?? this.canDischargeCapacity
      ..totalChargedEnergy = totalChargedEnergy ?? this.totalChargedEnergy
      ..totalDischargedEnergy =
          totalDischargedEnergy ?? this.totalDischargedEnergy
      ..cycles = cycles ?? this.cycles
      ..heaterStatusDesc = heaterStatusDesc ?? this.heaterStatusDesc
      ..balanceStatusDesc = balanceStatusDesc ?? this.balanceStatusDesc
      ..balancingPacks = balancingPacks ?? this.balancingPacks
      ..environmentTemperature =
          environmentTemperature ?? this.environmentTemperature;
  }
}

BatteryDetailKeyMetricsCapacityBalancingPacks
$BatteryDetailKeyMetricsCapacityBalancingPacksFromJson(
  Map<String, dynamic> json,
) {
  final BatteryDetailKeyMetricsCapacityBalancingPacks
  batteryDetailKeyMetricsCapacityBalancingPacks =
      BatteryDetailKeyMetricsCapacityBalancingPacks();
  final int? packIdx = jsonConvert.convert<int>(json['packIdx']);
  if (packIdx != null) {
    batteryDetailKeyMetricsCapacityBalancingPacks.packIdx = packIdx;
  }
  final String? packLabel = jsonConvert.convert<String>(json['packLabel']);
  if (packLabel != null) {
    batteryDetailKeyMetricsCapacityBalancingPacks.packLabel = packLabel;
  }
  final List<int>? cells = (json['cells'] as List<dynamic>?)
      ?.map((e) => jsonConvert.convert<int>(e) as int)
      .toList();
  if (cells != null) {
    batteryDetailKeyMetricsCapacityBalancingPacks.cells = cells;
  }
  return batteryDetailKeyMetricsCapacityBalancingPacks;
}

Map<String, dynamic> $BatteryDetailKeyMetricsCapacityBalancingPacksToJson(
  BatteryDetailKeyMetricsCapacityBalancingPacks entity,
) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['packIdx'] = entity.packIdx;
  data['packLabel'] = entity.packLabel;
  data['cells'] = entity.cells;
  return data;
}

extension BatteryDetailKeyMetricsCapacityBalancingPacksExtension
    on BatteryDetailKeyMetricsCapacityBalancingPacks {
  BatteryDetailKeyMetricsCapacityBalancingPacks copyWith({
    int? packIdx,
    String? packLabel,
    List<int>? cells,
  }) {
    return BatteryDetailKeyMetricsCapacityBalancingPacks()
      ..packIdx = packIdx ?? this.packIdx
      ..packLabel = packLabel ?? this.packLabel
      ..cells = cells ?? this.cells;
  }
}

BatteryDetailAdvancedDiagnosis $BatteryDetailAdvancedDiagnosisFromJson(
  Map<String, dynamic> json,
) {
  final BatteryDetailAdvancedDiagnosis batteryDetailAdvancedDiagnosis =
      BatteryDetailAdvancedDiagnosis();
  final String? current1 = jsonConvert.convert<String>(json['current1']);
  if (current1 != null) {
    batteryDetailAdvancedDiagnosis.current1 = current1;
  }
  final String? current2 = jsonConvert.convert<String>(json['current2']);
  if (current2 != null) {
    batteryDetailAdvancedDiagnosis.current2 = current2;
  }
  final String? mosMaxTemperature = jsonConvert.convert<String>(
    json['mosMaxTemperature'],
  );
  if (mosMaxTemperature != null) {
    batteryDetailAdvancedDiagnosis.mosMaxTemperature = mosMaxTemperature;
  }
  final String? heaterTemperature = jsonConvert.convert<String>(
    json['heaterTemperature'],
  );
  if (heaterTemperature != null) {
    batteryDetailAdvancedDiagnosis.heaterTemperature = heaterTemperature;
  }
  final int? packCount = jsonConvert.convert<int>(json['packCount']);
  if (packCount != null) {
    batteryDetailAdvancedDiagnosis.packCount = packCount;
  }
  final List<BatteryDetailAdvancedDiagnosisPacks>? packs =
      (json['packs'] as List<dynamic>?)
          ?.map(
            (e) =>
                jsonConvert.convert<BatteryDetailAdvancedDiagnosisPacks>(e)
                    as BatteryDetailAdvancedDiagnosisPacks,
          )
          .toList();
  if (packs != null) {
    batteryDetailAdvancedDiagnosis.packs = packs;
  }
  return batteryDetailAdvancedDiagnosis;
}

Map<String, dynamic> $BatteryDetailAdvancedDiagnosisToJson(
  BatteryDetailAdvancedDiagnosis entity,
) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['current1'] = entity.current1;
  data['current2'] = entity.current2;
  data['mosMaxTemperature'] = entity.mosMaxTemperature;
  data['heaterTemperature'] = entity.heaterTemperature;
  data['packCount'] = entity.packCount;
  data['packs'] = entity.packs?.map((v) => v.toJson()).toList();
  return data;
}

extension BatteryDetailAdvancedDiagnosisExtension
    on BatteryDetailAdvancedDiagnosis {
  BatteryDetailAdvancedDiagnosis copyWith({
    String? current1,
    String? current2,
    String? mosMaxTemperature,
    String? heaterTemperature,
    int? packCount,
    List<BatteryDetailAdvancedDiagnosisPacks>? packs,
  }) {
    return BatteryDetailAdvancedDiagnosis()
      ..current1 = current1 ?? this.current1
      ..current2 = current2 ?? this.current2
      ..mosMaxTemperature = mosMaxTemperature ?? this.mosMaxTemperature
      ..heaterTemperature = heaterTemperature ?? this.heaterTemperature
      ..packCount = packCount ?? this.packCount
      ..packs = packs ?? this.packs;
  }
}

BatteryDetailAdvancedDiagnosisPacks
$BatteryDetailAdvancedDiagnosisPacksFromJson(Map<String, dynamic> json) {
  final BatteryDetailAdvancedDiagnosisPacks
  batteryDetailAdvancedDiagnosisPacks = BatteryDetailAdvancedDiagnosisPacks();
  final int? packIdx = jsonConvert.convert<int>(json['packIdx']);
  if (packIdx != null) {
    batteryDetailAdvancedDiagnosisPacks.packIdx = packIdx;
  }
  final String? packLabel = jsonConvert.convert<String>(json['packLabel']);
  if (packLabel != null) {
    batteryDetailAdvancedDiagnosisPacks.packLabel = packLabel;
  }
  final String? cellPositionPrefix = jsonConvert.convert<String>(
    json['cellPositionPrefix'],
  );
  if (cellPositionPrefix != null) {
    batteryDetailAdvancedDiagnosisPacks.cellPositionPrefix = cellPositionPrefix;
  }
  final String? cellCountDesc = jsonConvert.convert<String>(
    json['cellCountDesc'],
  );
  if (cellCountDesc != null) {
    batteryDetailAdvancedDiagnosisPacks.cellCountDesc = cellCountDesc;
  }
  final String? cellTempCountDesc = jsonConvert.convert<String>(
    json['cellTempCountDesc'],
  );
  if (cellTempCountDesc != null) {
    batteryDetailAdvancedDiagnosisPacks.cellTempCountDesc = cellTempCountDesc;
  }
  final int? cellCount = jsonConvert.convert<int>(json['cellCount']);
  if (cellCount != null) {
    batteryDetailAdvancedDiagnosisPacks.cellCount = cellCount;
  }
  final int? cellTempCount = jsonConvert.convert<int>(json['cellTempCount']);
  if (cellTempCount != null) {
    batteryDetailAdvancedDiagnosisPacks.cellTempCount = cellTempCount;
  }
  final String? packDesignCapacity = jsonConvert.convert<String>(
    json['packDesignCapacity'],
  );
  if (packDesignCapacity != null) {
    batteryDetailAdvancedDiagnosisPacks.packDesignCapacity = packDesignCapacity;
  }
  final List<BatteryDetailAdvancedDiagnosisPacksCellVoltages>?
  cellVoltages = (json['cellVoltages'] as List<dynamic>?)
      ?.map(
        (e) =>
            jsonConvert
                    .convert<BatteryDetailAdvancedDiagnosisPacksCellVoltages>(e)
                as BatteryDetailAdvancedDiagnosisPacksCellVoltages,
      )
      .toList();
  if (cellVoltages != null) {
    batteryDetailAdvancedDiagnosisPacks.cellVoltages = cellVoltages;
  }
  final List<BatteryDetailAdvancedDiagnosisPacksCellTemperatures>?
  cellTemperatures = (json['cellTemperatures'] as List<dynamic>?)
      ?.map(
        (e) =>
            jsonConvert.convert<
                  BatteryDetailAdvancedDiagnosisPacksCellTemperatures
                >(e)
                as BatteryDetailAdvancedDiagnosisPacksCellTemperatures,
      )
      .toList();
  if (cellTemperatures != null) {
    batteryDetailAdvancedDiagnosisPacks.cellTemperatures = cellTemperatures;
  }
  final List<BatteryDetailAdvancedDiagnosisPacksMosTemperatures>?
  mosTemperatures = (json['mosTemperatures'] as List<dynamic>?)
      ?.map(
        (e) =>
            jsonConvert.convert<
                  BatteryDetailAdvancedDiagnosisPacksMosTemperatures
                >(e)
                as BatteryDetailAdvancedDiagnosisPacksMosTemperatures,
      )
      .toList();
  if (mosTemperatures != null) {
    batteryDetailAdvancedDiagnosisPacks.mosTemperatures = mosTemperatures;
  }
  return batteryDetailAdvancedDiagnosisPacks;
}

Map<String, dynamic> $BatteryDetailAdvancedDiagnosisPacksToJson(
  BatteryDetailAdvancedDiagnosisPacks entity,
) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['packIdx'] = entity.packIdx;
  data['packLabel'] = entity.packLabel;
  data['cellPositionPrefix'] = entity.cellPositionPrefix;
  data['cellCountDesc'] = entity.cellCountDesc;
  data['cellTempCountDesc'] = entity.cellTempCountDesc;
  data['cellCount'] = entity.cellCount;
  data['cellTempCount'] = entity.cellTempCount;
  data['packDesignCapacity'] = entity.packDesignCapacity;
  data['cellVoltages'] = entity.cellVoltages?.map((v) => v.toJson()).toList();
  data['cellTemperatures'] = entity.cellTemperatures
      ?.map((v) => v.toJson())
      .toList();
  data['mosTemperatures'] = entity.mosTemperatures
      ?.map((v) => v.toJson())
      .toList();
  return data;
}

extension BatteryDetailAdvancedDiagnosisPacksExtension
    on BatteryDetailAdvancedDiagnosisPacks {
  BatteryDetailAdvancedDiagnosisPacks copyWith({
    int? packIdx,
    String? packLabel,
    String? cellPositionPrefix,
    String? cellCountDesc,
    String? cellTempCountDesc,
    int? cellCount,
    int? cellTempCount,
    String? packDesignCapacity,
    List<BatteryDetailAdvancedDiagnosisPacksCellVoltages>? cellVoltages,
    List<BatteryDetailAdvancedDiagnosisPacksCellTemperatures>? cellTemperatures,
    List<BatteryDetailAdvancedDiagnosisPacksMosTemperatures>? mosTemperatures,
  }) {
    return BatteryDetailAdvancedDiagnosisPacks()
      ..packIdx = packIdx ?? this.packIdx
      ..packLabel = packLabel ?? this.packLabel
      ..cellPositionPrefix = cellPositionPrefix ?? this.cellPositionPrefix
      ..cellCountDesc = cellCountDesc ?? this.cellCountDesc
      ..cellTempCountDesc = cellTempCountDesc ?? this.cellTempCountDesc
      ..cellCount = cellCount ?? this.cellCount
      ..cellTempCount = cellTempCount ?? this.cellTempCount
      ..packDesignCapacity = packDesignCapacity ?? this.packDesignCapacity
      ..cellVoltages = cellVoltages ?? this.cellVoltages
      ..cellTemperatures = cellTemperatures ?? this.cellTemperatures
      ..mosTemperatures = mosTemperatures ?? this.mosTemperatures;
  }
}

BatteryDetailAdvancedDiagnosisPacksCellVoltages
$BatteryDetailAdvancedDiagnosisPacksCellVoltagesFromJson(
  Map<String, dynamic> json,
) {
  final BatteryDetailAdvancedDiagnosisPacksCellVoltages
  batteryDetailAdvancedDiagnosisPacksCellVoltages =
      BatteryDetailAdvancedDiagnosisPacksCellVoltages();
  final int? cellNo = jsonConvert.convert<int>(json['cellNo']);
  if (cellNo != null) {
    batteryDetailAdvancedDiagnosisPacksCellVoltages.cellNo = cellNo;
  }
  final String? positionLabel = jsonConvert.convert<String>(
    json['positionLabel'],
  );
  if (positionLabel != null) {
    batteryDetailAdvancedDiagnosisPacksCellVoltages.positionLabel =
        positionLabel;
  }
  final double? voltageMv = jsonConvert.convert<double>(json['voltageMv']);
  if (voltageMv != null) {
    batteryDetailAdvancedDiagnosisPacksCellVoltages.voltageMv = voltageMv;
  }
  final double? voltageV = jsonConvert.convert<double>(json['voltageV']);
  if (voltageV != null) {
    batteryDetailAdvancedDiagnosisPacksCellVoltages.voltageV = voltageV;
  }
  final bool? isMax = jsonConvert.convert<bool>(json['isMax']);
  if (isMax != null) {
    batteryDetailAdvancedDiagnosisPacksCellVoltages.isMax = isMax;
  }
  final bool? isMin = jsonConvert.convert<bool>(json['isMin']);
  if (isMin != null) {
    batteryDetailAdvancedDiagnosisPacksCellVoltages.isMin = isMin;
  }
  final bool? isBalancing = jsonConvert.convert<bool>(json['isBalancing']);
  if (isBalancing != null) {
    batteryDetailAdvancedDiagnosisPacksCellVoltages.isBalancing = isBalancing;
  }
  return batteryDetailAdvancedDiagnosisPacksCellVoltages;
}

Map<String, dynamic> $BatteryDetailAdvancedDiagnosisPacksCellVoltagesToJson(
  BatteryDetailAdvancedDiagnosisPacksCellVoltages entity,
) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['cellNo'] = entity.cellNo;
  data['positionLabel'] = entity.positionLabel;
  data['voltageMv'] = entity.voltageMv;
  data['voltageV'] = entity.voltageV;
  data['isMax'] = entity.isMax;
  data['isMin'] = entity.isMin;
  data['isBalancing'] = entity.isBalancing;
  return data;
}

extension BatteryDetailAdvancedDiagnosisPacksCellVoltagesExtension
    on BatteryDetailAdvancedDiagnosisPacksCellVoltages {
  BatteryDetailAdvancedDiagnosisPacksCellVoltages copyWith({
    int? cellNo,
    String? positionLabel,
    double? voltageMv,
    double? voltageV,
    bool? isMax,
    bool? isMin,
    bool? isBalancing,
  }) {
    return BatteryDetailAdvancedDiagnosisPacksCellVoltages()
      ..cellNo = cellNo ?? this.cellNo
      ..positionLabel = positionLabel ?? this.positionLabel
      ..voltageMv = voltageMv ?? this.voltageMv
      ..voltageV = voltageV ?? this.voltageV
      ..isMax = isMax ?? this.isMax
      ..isMin = isMin ?? this.isMin
      ..isBalancing = isBalancing ?? this.isBalancing;
  }
}

BatteryDetailAdvancedDiagnosisPacksCellTemperatures
$BatteryDetailAdvancedDiagnosisPacksCellTemperaturesFromJson(
  Map<String, dynamic> json,
) {
  final BatteryDetailAdvancedDiagnosisPacksCellTemperatures
  batteryDetailAdvancedDiagnosisPacksCellTemperatures =
      BatteryDetailAdvancedDiagnosisPacksCellTemperatures();
  final int? probeNo = jsonConvert.convert<int>(json['probeNo']);
  if (probeNo != null) {
    batteryDetailAdvancedDiagnosisPacksCellTemperatures.probeNo = probeNo;
  }
  final String? positionLabel = jsonConvert.convert<String>(
    json['positionLabel'],
  );
  if (positionLabel != null) {
    batteryDetailAdvancedDiagnosisPacksCellTemperatures.positionLabel =
        positionLabel;
  }
  final int? tempRawDc = jsonConvert.convert<int>(json['tempRawDc']);
  if (tempRawDc != null) {
    batteryDetailAdvancedDiagnosisPacksCellTemperatures.tempRawDc = tempRawDc;
  }
  final double? tempC = jsonConvert.convert<double>(json['tempC']);
  if (tempC != null) {
    batteryDetailAdvancedDiagnosisPacksCellTemperatures.tempC = tempC;
  }
  final bool? isMax = jsonConvert.convert<bool>(json['isMax']);
  if (isMax != null) {
    batteryDetailAdvancedDiagnosisPacksCellTemperatures.isMax = isMax;
  }
  final bool? isMin = jsonConvert.convert<bool>(json['isMin']);
  if (isMin != null) {
    batteryDetailAdvancedDiagnosisPacksCellTemperatures.isMin = isMin;
  }
  return batteryDetailAdvancedDiagnosisPacksCellTemperatures;
}

Map<String, dynamic> $BatteryDetailAdvancedDiagnosisPacksCellTemperaturesToJson(
  BatteryDetailAdvancedDiagnosisPacksCellTemperatures entity,
) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['probeNo'] = entity.probeNo;
  data['positionLabel'] = entity.positionLabel;
  data['tempRawDc'] = entity.tempRawDc;
  data['tempC'] = entity.tempC;
  data['isMax'] = entity.isMax;
  data['isMin'] = entity.isMin;
  return data;
}

extension BatteryDetailAdvancedDiagnosisPacksCellTemperaturesExtension
    on BatteryDetailAdvancedDiagnosisPacksCellTemperatures {
  BatteryDetailAdvancedDiagnosisPacksCellTemperatures copyWith({
    int? probeNo,
    String? positionLabel,
    int? tempRawDc,
    double? tempC,
    bool? isMax,
    bool? isMin,
  }) {
    return BatteryDetailAdvancedDiagnosisPacksCellTemperatures()
      ..probeNo = probeNo ?? this.probeNo
      ..positionLabel = positionLabel ?? this.positionLabel
      ..tempRawDc = tempRawDc ?? this.tempRawDc
      ..tempC = tempC ?? this.tempC
      ..isMax = isMax ?? this.isMax
      ..isMin = isMin ?? this.isMin;
  }
}

BatteryDetailAdvancedDiagnosisPacksMosTemperatures
$BatteryDetailAdvancedDiagnosisPacksMosTemperaturesFromJson(
  Map<String, dynamic> json,
) {
  final BatteryDetailAdvancedDiagnosisPacksMosTemperatures
  batteryDetailAdvancedDiagnosisPacksMosTemperatures =
      BatteryDetailAdvancedDiagnosisPacksMosTemperatures();
  final int? no = jsonConvert.convert<int>(json['no']);
  if (no != null) {
    batteryDetailAdvancedDiagnosisPacksMosTemperatures.no = no;
  }
  final String? positionLabel = jsonConvert.convert<String>(
    json['positionLabel'],
  );
  if (positionLabel != null) {
    batteryDetailAdvancedDiagnosisPacksMosTemperatures.positionLabel =
        positionLabel;
  }
  final double? tempC = jsonConvert.convert<double>(json['tempC']);
  if (tempC != null) {
    batteryDetailAdvancedDiagnosisPacksMosTemperatures.tempC = tempC;
  }
  return batteryDetailAdvancedDiagnosisPacksMosTemperatures;
}

Map<String, dynamic> $BatteryDetailAdvancedDiagnosisPacksMosTemperaturesToJson(
  BatteryDetailAdvancedDiagnosisPacksMosTemperatures entity,
) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['no'] = entity.no;
  data['positionLabel'] = entity.positionLabel;
  data['tempC'] = entity.tempC;
  return data;
}

extension BatteryDetailAdvancedDiagnosisPacksMosTemperaturesExtension
    on BatteryDetailAdvancedDiagnosisPacksMosTemperatures {
  BatteryDetailAdvancedDiagnosisPacksMosTemperatures copyWith({
    int? no,
    String? positionLabel,
    double? tempC,
  }) {
    return BatteryDetailAdvancedDiagnosisPacksMosTemperatures()
      ..no = no ?? this.no
      ..positionLabel = positionLabel ?? this.positionLabel
      ..tempC = tempC ?? this.tempC;
  }
}

BatteryDetailSystemInfo $BatteryDetailSystemInfoFromJson(
  Map<String, dynamic> json,
) {
  final BatteryDetailSystemInfo batteryDetailSystemInfo =
      BatteryDetailSystemInfo();
  final String? bmsFirmware = jsonConvert.convert<String>(json['bmsFirmware']);
  if (bmsFirmware != null) {
    batteryDetailSystemInfo.bmsFirmware = bmsFirmware;
  }
  final String? softwareVersion = jsonConvert.convert<String>(
    json['softwareVersion'],
  );
  if (softwareVersion != null) {
    batteryDetailSystemInfo.softwareVersion = softwareVersion;
  }
  final String? hardwareVersion = jsonConvert.convert<String>(
    json['hardwareVersion'],
  );
  if (hardwareVersion != null) {
    batteryDetailSystemInfo.hardwareVersion = hardwareVersion;
  }
  final String? bootVersion = jsonConvert.convert<String>(json['bootVersion']);
  if (bootVersion != null) {
    batteryDetailSystemInfo.bootVersion = bootVersion;
  }
  final String? designCapacity = jsonConvert.convert<String>(
    json['designCapacity'],
  );
  if (designCapacity != null) {
    batteryDetailSystemInfo.designCapacity = designCapacity;
  }
  final int? packCount = jsonConvert.convert<int>(json['packCount']);
  if (packCount != null) {
    batteryDetailSystemInfo.packCount = packCount;
  }
  final int? cellCount = jsonConvert.convert<int>(json['cellCount']);
  if (cellCount != null) {
    batteryDetailSystemInfo.cellCount = cellCount;
  }
  final int? cellTempCount = jsonConvert.convert<int>(json['cellTempCount']);
  if (cellTempCount != null) {
    batteryDetailSystemInfo.cellTempCount = cellTempCount;
  }
  final String? deviceSn = jsonConvert.convert<String>(json['deviceSn']);
  if (deviceSn != null) {
    batteryDetailSystemInfo.deviceSn = deviceSn;
  }
  final String? deviceModel = jsonConvert.convert<String>(json['deviceModel']);
  if (deviceModel != null) {
    batteryDetailSystemInfo.deviceModel = deviceModel;
  }
  final String? platformReceiveTime = jsonConvert.convert<String>(
    json['platformReceiveTime'],
  );
  if (platformReceiveTime != null) {
    batteryDetailSystemInfo.platformReceiveTime = platformReceiveTime;
  }
  final String? dataValidDesc = jsonConvert.convert<String>(
    json['dataValidDesc'],
  );
  if (dataValidDesc != null) {
    batteryDetailSystemInfo.dataValidDesc = dataValidDesc;
  }
  return batteryDetailSystemInfo;
}

Map<String, dynamic> $BatteryDetailSystemInfoToJson(
  BatteryDetailSystemInfo entity,
) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['bmsFirmware'] = entity.bmsFirmware;
  data['softwareVersion'] = entity.softwareVersion;
  data['hardwareVersion'] = entity.hardwareVersion;
  data['bootVersion'] = entity.bootVersion;
  data['designCapacity'] = entity.designCapacity;
  data['packCount'] = entity.packCount;
  data['cellCount'] = entity.cellCount;
  data['cellTempCount'] = entity.cellTempCount;
  data['deviceSn'] = entity.deviceSn;
  data['deviceModel'] = entity.deviceModel;
  data['platformReceiveTime'] = entity.platformReceiveTime;
  data['dataValidDesc'] = entity.dataValidDesc;
  return data;
}

extension BatteryDetailSystemInfoExtension on BatteryDetailSystemInfo {
  BatteryDetailSystemInfo copyWith({
    String? bmsFirmware,
    String? softwareVersion,
    String? hardwareVersion,
    String? bootVersion,
    String? designCapacity,
    int? packCount,
    int? cellCount,
    int? cellTempCount,
    String? deviceSn,
    String? deviceModel,
    String? platformReceiveTime,
    String? dataValidDesc,
  }) {
    return BatteryDetailSystemInfo()
      ..bmsFirmware = bmsFirmware ?? this.bmsFirmware
      ..softwareVersion = softwareVersion ?? this.softwareVersion
      ..hardwareVersion = hardwareVersion ?? this.hardwareVersion
      ..bootVersion = bootVersion ?? this.bootVersion
      ..designCapacity = designCapacity ?? this.designCapacity
      ..packCount = packCount ?? this.packCount
      ..cellCount = cellCount ?? this.cellCount
      ..cellTempCount = cellTempCount ?? this.cellTempCount
      ..deviceSn = deviceSn ?? this.deviceSn
      ..deviceModel = deviceModel ?? this.deviceModel
      ..platformReceiveTime = platformReceiveTime ?? this.platformReceiveTime
      ..dataValidDesc = dataValidDesc ?? this.dataValidDesc;
  }
}
