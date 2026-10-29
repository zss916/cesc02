import 'package:cesc01/core/network/bean/site_entity.dart';
import 'package:cesc01/generated/json/base/json_convert_content.dart';

SiteEntity $SiteEntityFromJson(Map<String, dynamic> json) {
  final SiteEntity siteEntity = SiteEntity();
  final String? siteId = jsonConvert.convert<String>(json['siteId']);
  if (siteId != null) {
    siteEntity.siteId = siteId;
  }
  final String? siteCode = jsonConvert.convert<String>(json['siteCode']);
  if (siteCode != null) {
    siteEntity.siteCode = siteCode;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    siteEntity.name = name;
  }
  final String? countryRegion = jsonConvert.convert<String>(
    json['countryRegion'],
  );
  if (countryRegion != null) {
    siteEntity.countryRegion = countryRegion;
  }
  final String? detailAddress = jsonConvert.convert<String>(
    json['detailAddress'],
  );
  if (detailAddress != null) {
    siteEntity.detailAddress = detailAddress;
  }
  final String? timezone = jsonConvert.convert<String>(json['timezone']);
  if (timezone != null) {
    siteEntity.timezone = timezone;
  }
  final String? batteryCountText = jsonConvert.convert<String>(
    json['batteryCountText'],
  );
  if (batteryCountText != null) {
    siteEntity.batteryCountText = batteryCountText;
  }
  final int? onlineBatteryCount = jsonConvert.convert<int>(
    json['onlineBatteryCount'],
  );
  if (onlineBatteryCount != null) {
    siteEntity.onlineBatteryCount = onlineBatteryCount;
  }
  final int? totalBatteryCount = jsonConvert.convert<int>(
    json['totalBatteryCount'],
  );
  if (totalBatteryCount != null) {
    siteEntity.totalBatteryCount = totalBatteryCount;
  }
  final String? runtimeStatus = jsonConvert.convert<String>(
    json['runtimeStatus'],
  );
  if (runtimeStatus != null) {
    siteEntity.runtimeStatus = runtimeStatus;
  }
  final String? updateTime = jsonConvert.convert<String>(json['updateTime']);
  if (updateTime != null) {
    siteEntity.updateTime = updateTime;
  }
  return siteEntity;
}

Map<String, dynamic> $SiteEntityToJson(SiteEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['siteId'] = entity.siteId;
  data['siteCode'] = entity.siteCode;
  data['name'] = entity.name;
  data['countryRegion'] = entity.countryRegion;
  data['detailAddress'] = entity.detailAddress;
  data['timezone'] = entity.timezone;
  data['batteryCountText'] = entity.batteryCountText;
  data['onlineBatteryCount'] = entity.onlineBatteryCount;
  data['totalBatteryCount'] = entity.totalBatteryCount;
  data['runtimeStatus'] = entity.runtimeStatus;
  data['updateTime'] = entity.updateTime;
  return data;
}

extension SiteEntityExtension on SiteEntity {
  SiteEntity copyWith({
    String? siteId,
    String? siteCode,
    String? name,
    String? countryRegion,
    String? detailAddress,
    String? timezone,
    String? batteryCountText,
    int? onlineBatteryCount,
    int? totalBatteryCount,
    String? runtimeStatus,
    String? updateTime,
  }) {
    return SiteEntity()
      ..siteId = siteId ?? this.siteId
      ..siteCode = siteCode ?? this.siteCode
      ..name = name ?? this.name
      ..countryRegion = countryRegion ?? this.countryRegion
      ..detailAddress = detailAddress ?? this.detailAddress
      ..timezone = timezone ?? this.timezone
      ..batteryCountText = batteryCountText ?? this.batteryCountText
      ..onlineBatteryCount = onlineBatteryCount ?? this.onlineBatteryCount
      ..totalBatteryCount = totalBatteryCount ?? this.totalBatteryCount
      ..runtimeStatus = runtimeStatus ?? this.runtimeStatus
      ..updateTime = updateTime ?? this.updateTime;
  }
}
