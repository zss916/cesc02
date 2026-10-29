import 'package:cesc01/core/network/bean/alarm_detail_entity.dart';
import 'package:cesc01/core/network/bean/cluster_item_entity.dart';
import 'package:cesc01/generated/json/base/json_convert_content.dart';

AlarmDetailEntity $AlarmDetailEntityFromJson(Map<String, dynamic> json) {
  final AlarmDetailEntity alarmDetailEntity = AlarmDetailEntity();
  final String? siteId = jsonConvert.convert<String>(json['siteId']);
  if (siteId != null) {
    alarmDetailEntity.siteId = siteId;
  }
  final String? siteName = jsonConvert.convert<String>(json['siteName']);
  if (siteName != null) {
    alarmDetailEntity.siteName = siteName;
  }
  final String? siteCode = jsonConvert.convert<String>(json['siteCode']);
  if (siteCode != null) {
    alarmDetailEntity.siteCode = siteCode;
  }
  final String? timezone = jsonConvert.convert<String>(json['timezone']);
  if (timezone != null) {
    alarmDetailEntity.timezone = timezone;
  }
  final String? stackSn = jsonConvert.convert<String>(json['stackSn']);
  if (stackSn != null) {
    alarmDetailEntity.stackSn = stackSn;
  }
  final String? stackName = jsonConvert.convert<String>(json['stackName']);
  if (stackName != null) {
    alarmDetailEntity.stackName = stackName;
  }
  final int? alarmClusterCount = jsonConvert.convert<int>(
    json['alarmClusterCount'],
  );
  if (alarmClusterCount != null) {
    alarmDetailEntity.alarmClusterCount = alarmClusterCount;
  }
  final int? alarmLevel = jsonConvert.convert<int>(json['alarmLevel']);
  if (alarmLevel != null) {
    alarmDetailEntity.alarmLevel = alarmLevel;
  }
  final String? latestOccurredAt = jsonConvert.convert<String>(
    json['latestOccurredAt'],
  );
  if (latestOccurredAt != null) {
    alarmDetailEntity.latestOccurredAt = latestOccurredAt;
  }
  final List<int>? clusterNos = (json['clusterNos'] as List<dynamic>?)
      ?.map((e) => jsonConvert.convert<int>(e) as int)
      .toList();
  if (clusterNos != null) {
    alarmDetailEntity.clusterNos = clusterNos;
  }
  final List<ClusterItemEntity>? clusters = (json['clusters'] as List<dynamic>?)
      ?.map(
        (e) => jsonConvert.convert<ClusterItemEntity>(e) as ClusterItemEntity,
      )
      .toList();
  if (clusters != null) {
    alarmDetailEntity.clusters = clusters;
  }
  return alarmDetailEntity;
}

Map<String, dynamic> $AlarmDetailEntityToJson(AlarmDetailEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['siteId'] = entity.siteId;
  data['siteName'] = entity.siteName;
  data['siteCode'] = entity.siteCode;
  data['timezone'] = entity.timezone;
  data['stackSn'] = entity.stackSn;
  data['stackName'] = entity.stackName;
  data['alarmClusterCount'] = entity.alarmClusterCount;
  data['alarmLevel'] = entity.alarmLevel;
  data['latestOccurredAt'] = entity.latestOccurredAt;
  data['clusterNos'] = entity.clusterNos;
  data['clusters'] = entity.clusters?.map((v) => v.toJson()).toList();
  return data;
}

extension AlarmDetailEntityExtension on AlarmDetailEntity {
  AlarmDetailEntity copyWith({
    String? siteId,
    String? siteName,
    String? siteCode,
    String? timezone,
    String? stackSn,
    String? stackName,
    int? alarmClusterCount,
    int? alarmLevel,
    String? latestOccurredAt,
    List<int>? clusterNos,
    List<ClusterItemEntity>? clusters,
  }) {
    return AlarmDetailEntity()
      ..siteId = siteId ?? this.siteId
      ..siteName = siteName ?? this.siteName
      ..siteCode = siteCode ?? this.siteCode
      ..timezone = timezone ?? this.timezone
      ..stackSn = stackSn ?? this.stackSn
      ..stackName = stackName ?? this.stackName
      ..alarmClusterCount = alarmClusterCount ?? this.alarmClusterCount
      ..alarmLevel = alarmLevel ?? this.alarmLevel
      ..latestOccurredAt = latestOccurredAt ?? this.latestOccurredAt
      ..clusterNos = clusterNos ?? this.clusterNos
      ..clusters = clusters ?? this.clusters;
  }
}
