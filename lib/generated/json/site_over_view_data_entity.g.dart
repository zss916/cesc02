import 'package:cesc01/core/network/bean/site_over_view_data_entity.dart';
import 'package:cesc01/generated/json/base/json_convert_content.dart';

SiteOverViewDataEntity $SiteOverViewDataEntityFromJson(
  Map<String, dynamic> json,
) {
  final SiteOverViewDataEntity siteOverViewDataEntity =
      SiteOverViewDataEntity();
  final int? siteId = jsonConvert.convert<int>(json['siteId']);
  if (siteId != null) {
    siteOverViewDataEntity.siteId = siteId;
  }
  final String? siteName = jsonConvert.convert<String>(json['siteName']);
  if (siteName != null) {
    siteOverViewDataEntity.siteName = siteName;
  }
  final String? countryRegion = jsonConvert.convert<String>(
    json['countryRegion'],
  );
  if (countryRegion != null) {
    siteOverViewDataEntity.countryRegion = countryRegion;
  }
  final String? address = jsonConvert.convert<String>(json['address']);
  if (address != null) {
    siteOverViewDataEntity.address = address;
  }
  final String? commStatus = jsonConvert.convert<String>(json['commStatus']);
  if (commStatus != null) {
    siteOverViewDataEntity.commStatus = commStatus;
  }
  final String? runStatus = jsonConvert.convert<String>(json['runStatus']);
  if (runStatus != null) {
    siteOverViewDataEntity.runStatus = runStatus;
  }
  final int? totalStackCount = jsonConvert.convert<int>(
    json['totalStackCount'],
  );
  if (totalStackCount != null) {
    siteOverViewDataEntity.totalStackCount = totalStackCount;
  }
  final int? onlineStackCount = jsonConvert.convert<int>(
    json['onlineStackCount'],
  );
  if (onlineStackCount != null) {
    siteOverViewDataEntity.onlineStackCount = onlineStackCount;
  }
  final int? totalClusterCount = jsonConvert.convert<int>(
    json['totalClusterCount'],
  );
  if (totalClusterCount != null) {
    siteOverViewDataEntity.totalClusterCount = totalClusterCount;
  }
  final int? totalSubPackCount = jsonConvert.convert<int>(
    json['totalSubPackCount'],
  );
  if (totalSubPackCount != null) {
    siteOverViewDataEntity.totalSubPackCount = totalSubPackCount;
  }
  final int? alarmClusterCount = jsonConvert.convert<int>(
    json['alarmClusterCount'],
  );
  if (alarmClusterCount != null) {
    siteOverViewDataEntity.alarmClusterCount = alarmClusterCount;
  }
  final int? alarmStackCount = jsonConvert.convert<int>(
    json['alarmStackCount'],
  );
  if (alarmStackCount != null) {
    siteOverViewDataEntity.alarmStackCount = alarmStackCount;
  }
  final SiteOverViewDataStackStatusDistribution? stackStatusDistribution =
      jsonConvert.convert<SiteOverViewDataStackStatusDistribution>(
        json['stackStatusDistribution'],
      );
  if (stackStatusDistribution != null) {
    siteOverViewDataEntity.stackStatusDistribution = stackStatusDistribution;
  }
  final List<SiteOverViewDataStacks>? stacks =
      (json['stacks'] as List<dynamic>?)
          ?.map(
            (e) =>
                jsonConvert.convert<SiteOverViewDataStacks>(e)
                    as SiteOverViewDataStacks,
          )
          .toList();
  if (stacks != null) {
    siteOverViewDataEntity.stacks = stacks;
  }
  return siteOverViewDataEntity;
}

Map<String, dynamic> $SiteOverViewDataEntityToJson(
  SiteOverViewDataEntity entity,
) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['siteId'] = entity.siteId;
  data['siteName'] = entity.siteName;
  data['countryRegion'] = entity.countryRegion;
  data['address'] = entity.address;
  data['commStatus'] = entity.commStatus;
  data['runStatus'] = entity.runStatus;
  data['totalStackCount'] = entity.totalStackCount;
  data['onlineStackCount'] = entity.onlineStackCount;
  data['totalClusterCount'] = entity.totalClusterCount;
  data['totalSubPackCount'] = entity.totalSubPackCount;
  data['alarmClusterCount'] = entity.alarmClusterCount;
  data['alarmStackCount'] = entity.alarmStackCount;
  data['stackStatusDistribution'] = entity.stackStatusDistribution?.toJson();
  data['stacks'] = entity.stacks?.map((v) => v.toJson()).toList();
  return data;
}

extension SiteOverViewDataEntityExtension on SiteOverViewDataEntity {
  SiteOverViewDataEntity copyWith({
    int? siteId,
    String? siteName,
    String? countryRegion,
    String? address,
    String? commStatus,
    String? runStatus,
    int? totalStackCount,
    int? onlineStackCount,
    int? totalClusterCount,
    int? totalSubPackCount,
    int? alarmClusterCount,
    int? alarmStackCount,
    SiteOverViewDataStackStatusDistribution? stackStatusDistribution,
    List<SiteOverViewDataStacks>? stacks,
  }) {
    return SiteOverViewDataEntity()
      ..siteId = siteId ?? this.siteId
      ..siteName = siteName ?? this.siteName
      ..countryRegion = countryRegion ?? this.countryRegion
      ..address = address ?? this.address
      ..commStatus = commStatus ?? this.commStatus
      ..runStatus = runStatus ?? this.runStatus
      ..totalStackCount = totalStackCount ?? this.totalStackCount
      ..onlineStackCount = onlineStackCount ?? this.onlineStackCount
      ..totalClusterCount = totalClusterCount ?? this.totalClusterCount
      ..totalSubPackCount = totalSubPackCount ?? this.totalSubPackCount
      ..alarmClusterCount = alarmClusterCount ?? this.alarmClusterCount
      ..alarmStackCount = alarmStackCount ?? this.alarmStackCount
      ..stackStatusDistribution =
          stackStatusDistribution ?? this.stackStatusDistribution
      ..stacks = stacks ?? this.stacks;
  }
}

SiteOverViewDataStackStatusDistribution
$SiteOverViewDataStackStatusDistributionFromJson(Map<String, dynamic> json) {
  final SiteOverViewDataStackStatusDistribution
  siteOverViewDataStackStatusDistribution =
      SiteOverViewDataStackStatusDistribution();
  final int? online = jsonConvert.convert<int>(json['online']);
  if (online != null) {
    siteOverViewDataStackStatusDistribution.online = online;
  }
  final int? alarm = jsonConvert.convert<int>(json['alarm']);
  if (alarm != null) {
    siteOverViewDataStackStatusDistribution.alarm = alarm;
  }
  final int? delayed = jsonConvert.convert<int>(json['delayed']);
  if (delayed != null) {
    siteOverViewDataStackStatusDistribution.delayed = delayed;
  }
  final int? offline = jsonConvert.convert<int>(json['offline']);
  if (offline != null) {
    siteOverViewDataStackStatusDistribution.offline = offline;
  }
  return siteOverViewDataStackStatusDistribution;
}

Map<String, dynamic> $SiteOverViewDataStackStatusDistributionToJson(
  SiteOverViewDataStackStatusDistribution entity,
) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['online'] = entity.online;
  data['alarm'] = entity.alarm;
  data['delayed'] = entity.delayed;
  data['offline'] = entity.offline;
  return data;
}

extension SiteOverViewDataStackStatusDistributionExtension
    on SiteOverViewDataStackStatusDistribution {
  SiteOverViewDataStackStatusDistribution copyWith({
    int? online,
    int? alarm,
    int? delayed,
    int? offline,
  }) {
    return SiteOverViewDataStackStatusDistribution()
      ..online = online ?? this.online
      ..alarm = alarm ?? this.alarm
      ..delayed = delayed ?? this.delayed
      ..offline = offline ?? this.offline;
  }
}

SiteOverViewDataStacks $SiteOverViewDataStacksFromJson(
  Map<String, dynamic> json,
) {
  final SiteOverViewDataStacks siteOverViewDataStacks =
      SiteOverViewDataStacks();
  final String? stackId = jsonConvert.convert<String>(json['stackId']);
  if (stackId != null) {
    siteOverViewDataStacks.stackId = stackId;
  }
  final String? stackName = jsonConvert.convert<String>(json['stackName']);
  if (stackName != null) {
    siteOverViewDataStacks.stackName = stackName;
  }
  final String? stackSn = jsonConvert.convert<String>(json['stackSn']);
  if (stackSn != null) {
    siteOverViewDataStacks.stackSn = stackSn;
  }
  final String? firmwareVersion = jsonConvert.convert<String>(
    json['firmwareVersion'],
  );
  if (firmwareVersion != null) {
    siteOverViewDataStacks.firmwareVersion = firmwareVersion;
  }
  final int? sysMode = jsonConvert.convert<int>(json['sysMode']);
  if (sysMode != null) {
    siteOverViewDataStacks.sysMode = sysMode;
  }
  final int? clusterCount = jsonConvert.convert<int>(json['clusterCount']);
  if (clusterCount != null) {
    siteOverViewDataStacks.clusterCount = clusterCount;
  }
  final int? packCount = jsonConvert.convert<int>(json['packCount']);
  if (packCount != null) {
    siteOverViewDataStacks.packCount = packCount;
  }
  final String? commStatus = jsonConvert.convert<String>(json['commStatus']);
  if (commStatus != null) {
    siteOverViewDataStacks.commStatus = commStatus;
  }
  final String? runStatus = jsonConvert.convert<String>(json['runStatus']);
  if (runStatus != null) {
    siteOverViewDataStacks.runStatus = runStatus;
  }
  final int? alarmClusterCount = jsonConvert.convert<int>(
    json['alarmClusterCount'],
  );
  if (alarmClusterCount != null) {
    siteOverViewDataStacks.alarmClusterCount = alarmClusterCount;
  }
  final String? soc = jsonConvert.convert<String>(json['soc']);
  if (soc != null) {
    siteOverViewDataStacks.soc = soc;
  }
  final String? soh = jsonConvert.convert<String>(json['soh']);
  if (soh != null) {
    siteOverViewDataStacks.soh = soh;
  }
  final String? totalVoltage = jsonConvert.convert<String>(
    json['totalVoltage'],
  );
  if (totalVoltage != null) {
    siteOverViewDataStacks.totalVoltage = totalVoltage;
  }
  final String? totalCurrent = jsonConvert.convert<String>(
    json['totalCurrent'],
  );
  if (totalCurrent != null) {
    siteOverViewDataStacks.totalCurrent = totalCurrent;
  }
  final String? maxTemperature = jsonConvert.convert<String>(
    json['maxTemperature'],
  );
  if (maxTemperature != null) {
    siteOverViewDataStacks.maxTemperature = maxTemperature;
  }
  final String? maxVoltageDiff = jsonConvert.convert<String>(
    json['maxVoltageDiff'],
  );
  if (maxVoltageDiff != null) {
    siteOverViewDataStacks.maxVoltageDiff = maxVoltageDiff;
  }
  final String? lastDataTime = jsonConvert.convert<String>(
    json['lastDataTime'],
  );
  if (lastDataTime != null) {
    siteOverViewDataStacks.lastDataTime = lastDataTime;
  }
  return siteOverViewDataStacks;
}

Map<String, dynamic> $SiteOverViewDataStacksToJson(
  SiteOverViewDataStacks entity,
) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['stackId'] = entity.stackId;
  data['stackName'] = entity.stackName;
  data['stackSn'] = entity.stackSn;
  data['firmwareVersion'] = entity.firmwareVersion;
  data['sysMode'] = entity.sysMode;
  data['clusterCount'] = entity.clusterCount;
  data['packCount'] = entity.packCount;
  data['commStatus'] = entity.commStatus;
  data['runStatus'] = entity.runStatus;
  data['alarmClusterCount'] = entity.alarmClusterCount;
  data['soc'] = entity.soc;
  data['soh'] = entity.soh;
  data['totalVoltage'] = entity.totalVoltage;
  data['totalCurrent'] = entity.totalCurrent;
  data['maxTemperature'] = entity.maxTemperature;
  data['maxVoltageDiff'] = entity.maxVoltageDiff;
  data['lastDataTime'] = entity.lastDataTime;
  return data;
}

extension SiteOverViewDataStacksExtension on SiteOverViewDataStacks {
  SiteOverViewDataStacks copyWith({
    String? stackId,
    String? stackName,
    String? stackSn,
    String? firmwareVersion,
    int? sysMode,
    int? clusterCount,
    int? packCount,
    String? commStatus,
    String? runStatus,
    int? alarmClusterCount,
    String? soc,
    String? soh,
    String? totalVoltage,
    String? totalCurrent,
    String? maxTemperature,
    String? maxVoltageDiff,
    String? lastDataTime,
  }) {
    return SiteOverViewDataStacks()
      ..stackId = stackId ?? this.stackId
      ..stackName = stackName ?? this.stackName
      ..stackSn = stackSn ?? this.stackSn
      ..firmwareVersion = firmwareVersion ?? this.firmwareVersion
      ..sysMode = sysMode ?? this.sysMode
      ..clusterCount = clusterCount ?? this.clusterCount
      ..packCount = packCount ?? this.packCount
      ..commStatus = commStatus ?? this.commStatus
      ..runStatus = runStatus ?? this.runStatus
      ..alarmClusterCount = alarmClusterCount ?? this.alarmClusterCount
      ..soc = soc ?? this.soc
      ..soh = soh ?? this.soh
      ..totalVoltage = totalVoltage ?? this.totalVoltage
      ..totalCurrent = totalCurrent ?? this.totalCurrent
      ..maxTemperature = maxTemperature ?? this.maxTemperature
      ..maxVoltageDiff = maxVoltageDiff ?? this.maxVoltageDiff
      ..lastDataTime = lastDataTime ?? this.lastDataTime;
  }
}
