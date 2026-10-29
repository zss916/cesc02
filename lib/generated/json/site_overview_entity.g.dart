import 'package:cesc01/generated/json/base/json_convert_content.dart';
import 'package:cesc01/core/network/bean/site_overview_entity.dart';

SiteOverviewEntity $SiteOverviewEntityFromJson(Map<String, dynamic> json) {
  final SiteOverviewEntity siteOverviewEntity = SiteOverviewEntity();
  final String? siteId = jsonConvert.convert<String>(json['siteId']);
  if (siteId != null) {
    siteOverviewEntity.siteId = siteId;
  }
  final String? siteName = jsonConvert.convert<String>(json['siteName']);
  if (siteName != null) {
    siteOverviewEntity.siteName = siteName;
  }
  final String? countryRegion = jsonConvert.convert<String>(
      json['countryRegion']);
  if (countryRegion != null) {
    siteOverviewEntity.countryRegion = countryRegion;
  }
  final String? address = jsonConvert.convert<String>(json['address']);
  if (address != null) {
    siteOverviewEntity.address = address;
  }
  final String? runStatus = jsonConvert.convert<String>(json['runStatus']);
  if (runStatus != null) {
    siteOverviewEntity.runStatus = runStatus;
  }
  final String? commStatus = jsonConvert.convert<String>(json['commStatus']);
  if (commStatus != null) {
    siteOverviewEntity.commStatus = commStatus;
  }
  final String? siteCode = jsonConvert.convert<String>(json['siteCode']);
  if (siteCode != null) {
    siteOverviewEntity.siteCode = siteCode;
  }
  final String? timezone = jsonConvert.convert<String>(json['timezone']);
  if (timezone != null) {
    siteOverviewEntity.timezone = timezone;
  }
  final String? siteType = jsonConvert.convert<String>(json['siteType']);
  if (siteType != null) {
    siteOverviewEntity.siteType = siteType;
  }
  final String? updateTime = jsonConvert.convert<String>(json['updateTime']);
  if (updateTime != null) {
    siteOverviewEntity.updateTime = updateTime;
  }
  final int? onlinePackCount = jsonConvert.convert<int>(
      json['onlinePackCount']);
  if (onlinePackCount != null) {
    siteOverviewEntity.onlinePackCount = onlinePackCount;
  }
  final int? totalPackCount = jsonConvert.convert<int>(json['totalPackCount']);
  if (totalPackCount != null) {
    siteOverviewEntity.totalPackCount = totalPackCount;
  }
  final double? soc = jsonConvert.convert<double>(json['soc']);
  if (soc != null) {
    siteOverviewEntity.soc = soc;
  }
  final String? socRange = jsonConvert.convert<String>(json['socRange']);
  if (socRange != null) {
    siteOverviewEntity.socRange = socRange;
  }
  final String? sohRange = jsonConvert.convert<String>(json['sohRange']);
  if (sohRange != null) {
    siteOverviewEntity.sohRange = sohRange;
  }
  final int? alarmCount = jsonConvert.convert<int>(json['alarmCount']);
  if (alarmCount != null) {
    siteOverviewEntity.alarmCount = alarmCount;
  }
  final String? totalVoltageRange = jsonConvert.convert<String>(
      json['totalVoltageRange']);
  if (totalVoltageRange != null) {
    siteOverviewEntity.totalVoltageRange = totalVoltageRange;
  }
  final String? totalCurrentRange = jsonConvert.convert<String>(
      json['totalCurrentRange']);
  if (totalCurrentRange != null) {
    siteOverviewEntity.totalCurrentRange = totalCurrentRange;
  }
  final String? maxTemperatureRange = jsonConvert.convert<String>(
      json['maxTemperatureRange']);
  if (maxTemperatureRange != null) {
    siteOverviewEntity.maxTemperatureRange = maxTemperatureRange;
  }
  final String? remainingCapacity = jsonConvert.convert<String>(
      json['remainingCapacity']);
  if (remainingCapacity != null) {
    siteOverviewEntity.remainingCapacity = remainingCapacity;
  }
  final String? cycles = jsonConvert.convert<String>(json['cycles']);
  if (cycles != null) {
    siteOverviewEntity.cycles = cycles;
  }
  final String? maxChargeCurrent = jsonConvert.convert<String>(
      json['maxChargeCurrent']);
  if (maxChargeCurrent != null) {
    siteOverviewEntity.maxChargeCurrent = maxChargeCurrent;
  }
  final String? maxDischargeCurrent = jsonConvert.convert<String>(
      json['maxDischargeCurrent']);
  if (maxDischargeCurrent != null) {
    siteOverviewEntity.maxDischargeCurrent = maxDischargeCurrent;
  }
  final String? canChargeCapacity = jsonConvert.convert<String>(
      json['canChargeCapacity']);
  if (canChargeCapacity != null) {
    siteOverviewEntity.canChargeCapacity = canChargeCapacity;
  }
  final String? canDischargeCapacity = jsonConvert.convert<String>(
      json['canDischargeCapacity']);
  if (canDischargeCapacity != null) {
    siteOverviewEntity.canDischargeCapacity = canDischargeCapacity;
  }
  final String? maintenanceCycles = jsonConvert.convert<String>(
      json['maintenanceCycles']);
  if (maintenanceCycles != null) {
    siteOverviewEntity.maintenanceCycles = maintenanceCycles;
  }
  final String? dataTime = jsonConvert.convert<String>(json['dataTime']);
  if (dataTime != null) {
    siteOverviewEntity.dataTime = dataTime;
  }
  final List<
      SiteOverviewTrendPoints>? trendPoints = (json['trendPoints'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<SiteOverviewTrendPoints>(
          e) as SiteOverviewTrendPoints).toList();
  if (trendPoints != null) {
    siteOverviewEntity.trendPoints = trendPoints;
  }
  final List<
      SiteOverviewCharge>? chargeDischargeTrendPoints = (json['chargeDischargeTrendPoints'] as List<
      dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<SiteOverviewCharge>(e) as SiteOverviewCharge)
      .toList();
  if (chargeDischargeTrendPoints != null) {
    siteOverviewEntity.chargeDischargeTrendPoints = chargeDischargeTrendPoints;
  }
  return siteOverviewEntity;
}

Map<String, dynamic> $SiteOverviewEntityToJson(SiteOverviewEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['siteId'] = entity.siteId;
  data['siteName'] = entity.siteName;
  data['countryRegion'] = entity.countryRegion;
  data['address'] = entity.address;
  data['runStatus'] = entity.runStatus;
  data['commStatus'] = entity.commStatus;
  data['siteCode'] = entity.siteCode;
  data['timezone'] = entity.timezone;
  data['siteType'] = entity.siteType;
  data['updateTime'] = entity.updateTime;
  data['onlinePackCount'] = entity.onlinePackCount;
  data['totalPackCount'] = entity.totalPackCount;
  data['soc'] = entity.soc;
  data['socRange'] = entity.socRange;
  data['sohRange'] = entity.sohRange;
  data['alarmCount'] = entity.alarmCount;
  data['totalVoltageRange'] = entity.totalVoltageRange;
  data['totalCurrentRange'] = entity.totalCurrentRange;
  data['maxTemperatureRange'] = entity.maxTemperatureRange;
  data['remainingCapacity'] = entity.remainingCapacity;
  data['cycles'] = entity.cycles;
  data['maxChargeCurrent'] = entity.maxChargeCurrent;
  data['maxDischargeCurrent'] = entity.maxDischargeCurrent;
  data['canChargeCapacity'] = entity.canChargeCapacity;
  data['canDischargeCapacity'] = entity.canDischargeCapacity;
  data['maintenanceCycles'] = entity.maintenanceCycles;
  data['dataTime'] = entity.dataTime;
  data['trendPoints'] = entity.trendPoints?.map((v) => v.toJson()).toList();
  data['chargeDischargeTrendPoints'] =
      entity.chargeDischargeTrendPoints?.map((v) => v.toJson()).toList();
  return data;
}

extension SiteOverviewEntityExtension on SiteOverviewEntity {
  SiteOverviewEntity copyWith({
    String? siteId,
    String? siteName,
    String? countryRegion,
    String? address,
    String? runStatus,
    String? commStatus,
    String? siteCode,
    String? timezone,
    String? siteType,
    String? updateTime,
    int? onlinePackCount,
    int? totalPackCount,
    double? soc,
    String? socRange,
    String? sohRange,
    int? alarmCount,
    String? totalVoltageRange,
    String? totalCurrentRange,
    String? maxTemperatureRange,
    String? remainingCapacity,
    String? cycles,
    String? maxChargeCurrent,
    String? maxDischargeCurrent,
    String? canChargeCapacity,
    String? canDischargeCapacity,
    String? maintenanceCycles,
    String? dataTime,
    List<SiteOverviewTrendPoints>? trendPoints,
    List<SiteOverviewCharge>? chargeDischargeTrendPoints,
  }) {
    return SiteOverviewEntity()
      ..siteId = siteId ?? this.siteId
      ..siteName = siteName ?? this.siteName
      ..countryRegion = countryRegion ?? this.countryRegion
      ..address = address ?? this.address
      ..runStatus = runStatus ?? this.runStatus
      ..commStatus = commStatus ?? this.commStatus
      ..siteCode = siteCode ?? this.siteCode
      ..timezone = timezone ?? this.timezone
      ..siteType = siteType ?? this.siteType
      ..updateTime = updateTime ?? this.updateTime
      ..onlinePackCount = onlinePackCount ?? this.onlinePackCount
      ..totalPackCount = totalPackCount ?? this.totalPackCount
      ..soc = soc ?? this.soc
      ..socRange = socRange ?? this.socRange
      ..sohRange = sohRange ?? this.sohRange
      ..alarmCount = alarmCount ?? this.alarmCount
      ..totalVoltageRange = totalVoltageRange ?? this.totalVoltageRange
      ..totalCurrentRange = totalCurrentRange ?? this.totalCurrentRange
      ..maxTemperatureRange = maxTemperatureRange ?? this.maxTemperatureRange
      ..remainingCapacity = remainingCapacity ?? this.remainingCapacity
      ..cycles = cycles ?? this.cycles
      ..maxChargeCurrent = maxChargeCurrent ?? this.maxChargeCurrent
      ..maxDischargeCurrent = maxDischargeCurrent ?? this.maxDischargeCurrent
      ..canChargeCapacity = canChargeCapacity ?? this.canChargeCapacity
      ..canDischargeCapacity = canDischargeCapacity ?? this.canDischargeCapacity
      ..maintenanceCycles = maintenanceCycles ?? this.maintenanceCycles
      ..dataTime = dataTime ?? this.dataTime
      ..trendPoints = trendPoints ?? this.trendPoints
      ..chargeDischargeTrendPoints = chargeDischargeTrendPoints ??
          this.chargeDischargeTrendPoints;
  }
}

SiteOverviewTrendPoints $SiteOverviewTrendPointsFromJson(
    Map<String, dynamic> json) {
  final SiteOverviewTrendPoints siteOverviewTrendPoints = SiteOverviewTrendPoints();
  final int? timestamp = jsonConvert.convert<int>(json['timestamp']);
  if (timestamp != null) {
    siteOverviewTrendPoints.timestamp = timestamp;
  }
  final String? timeLabel = jsonConvert.convert<String>(json['timeLabel']);
  if (timeLabel != null) {
    siteOverviewTrendPoints.timeLabel = timeLabel;
  }
  final double? soc = jsonConvert.convert<double>(json['soc']);
  if (soc != null) {
    siteOverviewTrendPoints.soc = soc;
  }
  final double? socMin = jsonConvert.convert<double>(json['socMin']);
  if (socMin != null) {
    siteOverviewTrendPoints.socMin = socMin;
  }
  final double? socMax = jsonConvert.convert<double>(json['socMax']);
  if (socMax != null) {
    siteOverviewTrendPoints.socMax = socMax;
  }
  final double? current = jsonConvert.convert<double>(json['current']);
  if (current != null) {
    siteOverviewTrendPoints.current = current;
  }
  final double? temperature = jsonConvert.convert<double>(json['temperature']);
  if (temperature != null) {
    siteOverviewTrendPoints.temperature = temperature;
  }
  final double? voltage = jsonConvert.convert<double>(json['voltage']);
  if (voltage != null) {
    siteOverviewTrendPoints.voltage = voltage;
  }
  return siteOverviewTrendPoints;
}

Map<String, dynamic> $SiteOverviewTrendPointsToJson(
    SiteOverviewTrendPoints entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['timestamp'] = entity.timestamp;
  data['timeLabel'] = entity.timeLabel;
  data['soc'] = entity.soc;
  data['socMin'] = entity.socMin;
  data['socMax'] = entity.socMax;
  data['current'] = entity.current;
  data['temperature'] = entity.temperature;
  data['voltage'] = entity.voltage;
  return data;
}

extension SiteOverviewTrendPointsExtension on SiteOverviewTrendPoints {
  SiteOverviewTrendPoints copyWith({
    int? timestamp,
    String? timeLabel,
    double? soc,
    double? socMin,
    double? socMax,
    double? current,
    double? temperature,
    double? voltage,
  }) {
    return SiteOverviewTrendPoints()
      ..timestamp = timestamp ?? this.timestamp
      ..timeLabel = timeLabel ?? this.timeLabel
      ..soc = soc ?? this.soc
      ..socMin = socMin ?? this.socMin
      ..socMax = socMax ?? this.socMax
      ..current = current ?? this.current
      ..temperature = temperature ?? this.temperature
      ..voltage = voltage ?? this.voltage;
  }
}

SiteOverviewCharge $SiteOverviewChargeFromJson(Map<String, dynamic> json) {
  final SiteOverviewCharge siteOverviewCharge = SiteOverviewCharge();
  final String? date = jsonConvert.convert<String>(json['date']);
  if (date != null) {
    siteOverviewCharge.date = date;
  }
  final String? triggerTime = jsonConvert.convert<String>(json['triggerTime']);
  if (triggerTime != null) {
    siteOverviewCharge.triggerTime = triggerTime;
  }
  final int? endTimestamp = jsonConvert.convert<int>(json['endTimestamp']);
  if (endTimestamp != null) {
    siteOverviewCharge.endTimestamp = endTimestamp;
  }
  final int? timestamp = jsonConvert.convert<int>(json['timestamp']);
  if (timestamp != null) {
    siteOverviewCharge.timestamp = timestamp;
  }
  final double? chargeAh = jsonConvert.convert<double>(json['chargeAh']);
  if (chargeAh != null) {
    siteOverviewCharge.chargeAh = chargeAh;
  }
  final double? dischargeAh = jsonConvert.convert<double>(json['dischargeAh']);
  if (dischargeAh != null) {
    siteOverviewCharge.dischargeAh = dischargeAh;
  }
  final String? unit = jsonConvert.convert<String>(json['unit']);
  if (unit != null) {
    siteOverviewCharge.unit = unit;
  }
  return siteOverviewCharge;
}

Map<String, dynamic> $SiteOverviewChargeToJson(SiteOverviewCharge entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['date'] = entity.date;
  data['triggerTime'] = entity.triggerTime;
  data['endTimestamp'] = entity.endTimestamp;
  data['timestamp'] = entity.timestamp;
  data['chargeAh'] = entity.chargeAh;
  data['dischargeAh'] = entity.dischargeAh;
  data['unit'] = entity.unit;
  return data;
}

extension SiteOverviewChargeExtension on SiteOverviewCharge {
  SiteOverviewCharge copyWith({
    String? date,
    String? triggerTime,
    int? endTimestamp,
    int? timestamp,
    double? chargeAh,
    double? dischargeAh,
    String? unit,
  }) {
    return SiteOverviewCharge()
      ..date = date ?? this.date
      ..triggerTime = triggerTime ?? this.triggerTime
      ..endTimestamp = endTimestamp ?? this.endTimestamp
      ..timestamp = timestamp ?? this.timestamp
      ..chargeAh = chargeAh ?? this.chargeAh
      ..dischargeAh = dischargeAh ?? this.dischargeAh
      ..unit = unit ?? this.unit;
  }
}