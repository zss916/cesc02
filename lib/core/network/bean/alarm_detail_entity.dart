import 'dart:convert';

import 'package:cesc01/core/network/bean/cluster_item_entity.dart';
import 'package:cesc01/core/translations/lan_key.dart';
import 'package:cesc01/generated/json/alarm_detail_entity.g.dart';
import 'package:cesc01/generated/json/base/json_field.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

export 'package:cesc01/generated/json/alarm_detail_entity.g.dart';

@JsonSerializable()
class AlarmDetailEntity {
  String? siteId;
  String? siteName;
  String? siteCode;
  String? timezone;
  String? stackSn;
  String? stackName;
  int? alarmClusterCount;
  int? alarmLevel;
  String? latestOccurredAt;
  List<int>? clusterNos;
  List<ClusterItemEntity>? clusters;

  List<int> get showClusterNos => (clusterNos ?? []);

  List<ClusterItemEntity> get showClusters => (clusters ?? []);

  String get showTimezone => timezone ?? '-';

  ///站点名称
  String get showSiteName => siteName ?? '-';

  String get showSiteCode => siteCode ?? '-';

  ///SN
  String get showStackSn => stackSn ?? '-';

  ///堆名称
  String get showStackName => stackName ?? '-';

  ///发生时间
  String get timeDisplay => latestOccurredAt ?? '-';

  ///告警等级
  int get showAlarmLevel => alarmLevel ?? -1;

  String formatDuration(int seconds) {
    if (seconds <= 0) return '';

    final days = seconds ~/ 86400;
    final hours = (seconds % 86400) ~/ 3600;
    final minutes = (seconds % 3600) ~/ 60;
    final secs = seconds % 60;

    final parts = <String>[];

    if (days > 0) parts.add('$days${LKey.day.tr}');
    if (hours > 0) parts.add('$hours${LKey.hour.tr}');
    if (minutes > 0) parts.add('$minutes${LKey.minute.tr}');
    if (secs > 0) parts.add('$secs${LKey.second.tr}');

    return parts.join();
  }

  AlarmDetailEntity();

  factory AlarmDetailEntity.fromJson(Map<String, dynamic> json) =>
      $AlarmDetailEntityFromJson(json);

  Map<String, dynamic> toJson() => $AlarmDetailEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
