import 'package:cesc01/core/network/bean/cluster_item_entity.dart';
import 'package:cesc01/generated/json/base/json_convert_content.dart';

ClusterItemEntity $ClusterItemEntityFromJson(Map<String, dynamic> json) {
  final ClusterItemEntity clusterItemEntity = ClusterItemEntity();
  final int? clusterNo = jsonConvert.convert<int>(json['clusterNo']);
  if (clusterNo != null) {
    clusterItemEntity.clusterNo = clusterNo;
  }
  final String? clusterSn = jsonConvert.convert<String>(json['clusterSn']);
  if (clusterSn != null) {
    clusterItemEntity.clusterSn = clusterSn;
  }
  final String? clusterName = jsonConvert.convert<String>(json['clusterName']);
  if (clusterName != null) {
    clusterItemEntity.clusterName = clusterName;
  }
  final String? domainType = jsonConvert.convert<String>(json['domainType']);
  if (domainType != null) {
    clusterItemEntity.domainType = domainType;
  }
  final int? alarmLevel = jsonConvert.convert<int>(json['alarmLevel']);
  if (alarmLevel != null) {
    clusterItemEntity.alarmLevel = alarmLevel;
  }
  final String? alarmName = jsonConvert.convert<String>(json['alarmName']);
  if (alarmName != null) {
    clusterItemEntity.alarmName = alarmName;
  }
  final String? status = jsonConvert.convert<String>(json['status']);
  if (status != null) {
    clusterItemEntity.status = status;
  }
  final String? occurredAt = jsonConvert.convert<String>(json['occurredAt']);
  if (occurredAt != null) {
    clusterItemEntity.occurredAt = occurredAt;
  }
  final String? recoveredAt = jsonConvert.convert<String>(json['recoveredAt']);
  if (recoveredAt != null) {
    clusterItemEntity.recoveredAt = recoveredAt;
  }
  final int? packNo = jsonConvert.convert<int>(json['packNo']);
  if (packNo != null) {
    clusterItemEntity.packNo = packNo;
  }
  final int? cellNo = jsonConvert.convert<int>(json['cellNo']);
  if (cellNo != null) {
    clusterItemEntity.cellNo = cellNo;
  }
  return clusterItemEntity;
}

Map<String, dynamic> $ClusterItemEntityToJson(ClusterItemEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['clusterNo'] = entity.clusterNo;
  data['clusterSn'] = entity.clusterSn;
  data['clusterName'] = entity.clusterName;
  data['domainType'] = entity.domainType;
  data['alarmLevel'] = entity.alarmLevel;
  data['alarmName'] = entity.alarmName;
  data['status'] = entity.status;
  data['occurredAt'] = entity.occurredAt;
  data['recoveredAt'] = entity.recoveredAt;
  data['packNo'] = entity.packNo;
  data['cellNo'] = entity.cellNo;
  return data;
}

extension ClusterItemEntityExtension on ClusterItemEntity {
  ClusterItemEntity copyWith({
    int? clusterNo,
    String? clusterSn,
    String? clusterName,
    String? domainType,
    int? alarmLevel,
    String? alarmName,
    String? status,
    String? occurredAt,
    String? recoveredAt,
    int? packNo,
    int? cellNo,
  }) {
    return ClusterItemEntity()
      ..clusterNo = clusterNo ?? this.clusterNo
      ..clusterSn = clusterSn ?? this.clusterSn
      ..clusterName = clusterName ?? this.clusterName
      ..domainType = domainType ?? this.domainType
      ..alarmLevel = alarmLevel ?? this.alarmLevel
      ..alarmName = alarmName ?? this.alarmName
      ..status = status ?? this.status
      ..occurredAt = occurredAt ?? this.occurredAt
      ..recoveredAt = recoveredAt ?? this.recoveredAt
      ..packNo = packNo ?? this.packNo
      ..cellNo = cellNo ?? this.cellNo;
  }
}
