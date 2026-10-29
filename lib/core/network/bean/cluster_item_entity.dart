import 'dart:convert';

import 'package:cesc01/generated/json/base/json_field.dart';
import 'package:cesc01/generated/json/cluster_item_entity.g.dart';

export 'package:cesc01/generated/json/cluster_item_entity.g.dart';

@JsonSerializable()
class ClusterItemEntity {
  int? clusterNo;
  String? clusterSn;
  String? clusterName;
  String? domainType;
  int? alarmLevel;
  String? alarmName;
  String? status;
  String? occurredAt;
  String? recoveredAt;
  int? packNo;
  int? cellNo;

  String get showClusterName => clusterName ?? "-";

  String get showClusterSn => clusterSn ?? "-";

  int get showAlarmLevel => alarmLevel ?? -1;

  ClusterItemEntity();

  factory ClusterItemEntity.fromJson(Map<String, dynamic> json) =>
      $ClusterItemEntityFromJson(json);

  Map<String, dynamic> toJson() => $ClusterItemEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
