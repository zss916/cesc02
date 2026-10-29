import 'package:cesc01/core/network/bean/stack_alarm_detail_entity.dart';
import 'package:cesc01/generated/json/base/json_convert_content.dart';

StackAlarmDetailEntity $StackAlarmDetailEntityFromJson(
  Map<String, dynamic> json,
) {
  final StackAlarmDetailEntity stackAlarmDetailEntity =
      StackAlarmDetailEntity();
  final String? siteId = jsonConvert.convert<String>(json['siteId']);
  if (siteId != null) {
    stackAlarmDetailEntity.siteId = siteId;
  }
  final String? siteName = jsonConvert.convert<String>(json['siteName']);
  if (siteName != null) {
    stackAlarmDetailEntity.siteName = siteName;
  }
  final String? siteCode = jsonConvert.convert<String>(json['siteCode']);
  if (siteCode != null) {
    stackAlarmDetailEntity.siteCode = siteCode;
  }
  final String? stackSn = jsonConvert.convert<String>(json['stackSn']);
  if (stackSn != null) {
    stackAlarmDetailEntity.stackSn = stackSn;
  }
  final String? timezone = jsonConvert.convert<String>(json['timezone']);
  if (timezone != null) {
    stackAlarmDetailEntity.timezone = timezone;
  }
  final String? stackName = jsonConvert.convert<String>(json['stackName']);
  if (stackName != null) {
    stackAlarmDetailEntity.stackName = stackName;
  }
  final int? alarmClusterCount = jsonConvert.convert<int>(
    json['alarmClusterCount'],
  );
  if (alarmClusterCount != null) {
    stackAlarmDetailEntity.alarmClusterCount = alarmClusterCount;
  }
  final int? alarmCount = jsonConvert.convert<int>(json['alarmCount']);
  if (alarmCount != null) {
    stackAlarmDetailEntity.alarmCount = alarmCount;
  }
  final List<StackAlarmDetailClusters>? clusters =
      (json['clusters'] as List<dynamic>?)
          ?.map(
            (e) =>
                jsonConvert.convert<StackAlarmDetailClusters>(e)
                    as StackAlarmDetailClusters,
          )
          .toList();
  if (clusters != null) {
    stackAlarmDetailEntity.clusters = clusters;
  }
  final List<int>? clusterNos = (json['clusterNos'] as List<dynamic>?)
      ?.map((e) => jsonConvert.convert<int>(e) as int)
      .toList();
  if (clusterNos != null) {
    stackAlarmDetailEntity.clusterNos = clusterNos;
  }
  final int? alarmLevel = jsonConvert.convert<int>(json['alarmLevel']);
  if (alarmLevel != null) {
    stackAlarmDetailEntity.alarmLevel = alarmLevel;
  }
  final String? latestOccurredAt = jsonConvert.convert<String>(
    json['latestOccurredAt'],
  );
  if (latestOccurredAt != null) {
    stackAlarmDetailEntity.latestOccurredAt = latestOccurredAt;
  }
  return stackAlarmDetailEntity;
}

Map<String, dynamic> $StackAlarmDetailEntityToJson(
  StackAlarmDetailEntity entity,
) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['siteId'] = entity.siteId;
  data['siteName'] = entity.siteName;
  data['siteCode'] = entity.siteCode;
  data['stackSn'] = entity.stackSn;
  data['timezone'] = entity.timezone;
  data['stackName'] = entity.stackName;
  data['alarmClusterCount'] = entity.alarmClusterCount;
  data['alarmCount'] = entity.alarmCount;
  data['clusters'] = entity.clusters?.map((v) => v.toJson()).toList();
  data['clusterNos'] = entity.clusterNos;
  data['alarmLevel'] = entity.alarmLevel;
  data['latestOccurredAt'] = entity.latestOccurredAt;
  return data;
}

extension StackAlarmDetailEntityExtension on StackAlarmDetailEntity {
  StackAlarmDetailEntity copyWith({
    String? siteId,
    String? siteName,
    String? siteCode,
    String? stackSn,
    String? timezone,
    String? stackName,
    int? alarmClusterCount,
    int? alarmCount,
    List<StackAlarmDetailClusters>? clusters,
    List<int>? clusterNos,
    int? alarmLevel,
    String? latestOccurredAt,
  }) {
    return StackAlarmDetailEntity()
      ..siteId = siteId ?? this.siteId
      ..siteName = siteName ?? this.siteName
      ..siteCode = siteCode ?? this.siteCode
      ..stackSn = stackSn ?? this.stackSn
      ..timezone = timezone ?? this.timezone
      ..stackName = stackName ?? this.stackName
      ..alarmClusterCount = alarmClusterCount ?? this.alarmClusterCount
      ..alarmCount = alarmCount ?? this.alarmCount
      ..clusters = clusters ?? this.clusters
      ..clusterNos = clusterNos ?? this.clusterNos
      ..alarmLevel = alarmLevel ?? this.alarmLevel
      ..latestOccurredAt = latestOccurredAt ?? this.latestOccurredAt;
  }
}

StackAlarmDetailClusters $StackAlarmDetailClustersFromJson(
  Map<String, dynamic> json,
) {
  final StackAlarmDetailClusters stackAlarmDetailClusters =
      StackAlarmDetailClusters();
  final int? clusterNo = jsonConvert.convert<int>(json['clusterNo']);
  if (clusterNo != null) {
    stackAlarmDetailClusters.clusterNo = clusterNo;
  }
  final String? clusterSn = jsonConvert.convert<String>(json['clusterSn']);
  if (clusterSn != null) {
    stackAlarmDetailClusters.clusterSn = clusterSn;
  }
  final String? clusterName = jsonConvert.convert<String>(json['clusterName']);
  if (clusterName != null) {
    stackAlarmDetailClusters.clusterName = clusterName;
  }
  final String? domainType = jsonConvert.convert<String>(json['domainType']);
  if (domainType != null) {
    stackAlarmDetailClusters.domainType = domainType;
  }
  final int? alarmCount = jsonConvert.convert<int>(json['alarmCount']);
  if (alarmCount != null) {
    stackAlarmDetailClusters.alarmCount = alarmCount;
  }
  final int? alarmLevel = jsonConvert.convert<int>(json['alarmLevel']);
  if (alarmLevel != null) {
    stackAlarmDetailClusters.alarmLevel = alarmLevel;
  }
  final String? alarmName = jsonConvert.convert<String>(json['alarmName']);
  if (alarmName != null) {
    stackAlarmDetailClusters.alarmName = alarmName;
  }
  final String? status = jsonConvert.convert<String>(json['status']);
  if (status != null) {
    stackAlarmDetailClusters.status = status;
  }
  final String? occurredAt = jsonConvert.convert<String>(json['occurredAt']);
  if (occurredAt != null) {
    stackAlarmDetailClusters.occurredAt = occurredAt;
  }
  final String? recoveredAt = jsonConvert.convert<String>(json['recoveredAt']);
  if (recoveredAt != null) {
    stackAlarmDetailClusters.recoveredAt = recoveredAt;
  }
  final int? packNo = jsonConvert.convert<int>(json['packNo']);
  if (packNo != null) {
    stackAlarmDetailClusters.packNo = packNo;
  }
  final int? cellNo = jsonConvert.convert<int>(json['cellNo']);
  if (cellNo != null) {
    stackAlarmDetailClusters.cellNo = cellNo;
  }
  return stackAlarmDetailClusters;
}

Map<String, dynamic> $StackAlarmDetailClustersToJson(
  StackAlarmDetailClusters entity,
) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['clusterNo'] = entity.clusterNo;
  data['clusterSn'] = entity.clusterSn;
  data['clusterName'] = entity.clusterName;
  data['domainType'] = entity.domainType;
  data['alarmCount'] = entity.alarmCount;
  data['alarmLevel'] = entity.alarmLevel;
  data['alarmName'] = entity.alarmName;
  data['status'] = entity.status;
  data['occurredAt'] = entity.occurredAt;
  data['recoveredAt'] = entity.recoveredAt;
  data['packNo'] = entity.packNo;
  data['cellNo'] = entity.cellNo;
  return data;
}

extension StackAlarmDetailClustersExtension on StackAlarmDetailClusters {
  StackAlarmDetailClusters copyWith({
    int? clusterNo,
    String? clusterSn,
    String? clusterName,
    String? domainType,
    int? alarmCount,
    int? alarmLevel,
    String? alarmName,
    String? status,
    String? occurredAt,
    String? recoveredAt,
    int? packNo,
    int? cellNo,
  }) {
    return StackAlarmDetailClusters()
      ..clusterNo = clusterNo ?? this.clusterNo
      ..clusterSn = clusterSn ?? this.clusterSn
      ..clusterName = clusterName ?? this.clusterName
      ..domainType = domainType ?? this.domainType
      ..alarmCount = alarmCount ?? this.alarmCount
      ..alarmLevel = alarmLevel ?? this.alarmLevel
      ..alarmName = alarmName ?? this.alarmName
      ..status = status ?? this.status
      ..occurredAt = occurredAt ?? this.occurredAt
      ..recoveredAt = recoveredAt ?? this.recoveredAt
      ..packNo = packNo ?? this.packNo
      ..cellNo = cellNo ?? this.cellNo;
  }
}
