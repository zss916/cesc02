import 'dart:convert';

import 'package:cesc01/generated/json/base/json_field.dart';
import 'package:cesc01/generated/json/stack_alarm_detail_entity.g.dart';

export 'package:cesc01/generated/json/stack_alarm_detail_entity.g.dart';

@JsonSerializable()
class StackAlarmDetailEntity {
  String? siteId;
  String? siteName;
  String? siteCode;
  String? stackSn;
  String? timezone;
  String? stackName;
  int? alarmClusterCount;
  int? alarmCount;
  List<StackAlarmDetailClusters>? clusters;
  List<int>? clusterNos;
  int? alarmLevel;
  String? latestOccurredAt;

  String get showTimezone => timezone ?? '-';

  String get showSiteName => siteName ?? '-';

  String get showSiteCode => siteCode ?? '-';

  String get showStackName => stackName ?? '-';

  String get showStackSn => stackSn ?? '-';

  List<StackAlarmDetailClusters> get showClusters => clusters ?? [];

  StackAlarmDetailEntity();

  factory StackAlarmDetailEntity.fromJson(Map<String, dynamic> json) =>
      $StackAlarmDetailEntityFromJson(json);

  Map<String, dynamic> toJson() => $StackAlarmDetailEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class StackAlarmDetailClusters {
  int? clusterNo;
  String? clusterSn;
  String? clusterName;
  String? domainType;
  int? alarmCount;
  int? alarmLevel;
  String? alarmName;
  String? status;
  String? occurredAt;
  String? recoveredAt;
  int? packNo;
  int? cellNo;

  String get showStatus => status ?? "-";

  int get showAlarmLevel => alarmLevel ?? -1;

  String get showClusterNo => clusterNo == null ? "" : "$clusterNo";

  String get showClusterName => clusterName ?? "-";

  String get showClusterSn => clusterSn ?? "-";

  String get showAlarmName => alarmName ?? "-";

  String get showOccurredAt => occurredAt ?? "-";

  String get showRecoveredAt => recoveredAt ?? "-";

  StackAlarmDetailClusters();

  factory StackAlarmDetailClusters.fromJson(Map<String, dynamic> json) =>
      $StackAlarmDetailClustersFromJson(json);

  Map<String, dynamic> toJson() => $StackAlarmDetailClustersToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
