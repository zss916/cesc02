import 'dart:convert';

import 'package:cesc01/generated/json/alarm_summary_entity.g.dart';
import 'package:cesc01/generated/json/base/json_field.dart';

export 'package:cesc01/generated/json/alarm_summary_entity.g.dart';

@JsonSerializable()
class AlarmSummaryEntity {
  int? siteCount;
  int? stackCount;
  int? alarmClusterCount;

  String get showSiteCount => '${siteCount ?? 0}';
  String get showStackCount => '${stackCount ?? 0}';
  String get showAlarmClusterCount => '${alarmClusterCount ?? 0}';

  AlarmSummaryEntity();

  factory AlarmSummaryEntity.fromJson(Map<String, dynamic> json) =>
      $AlarmSummaryEntityFromJson(json);

  Map<String, dynamic> toJson() => $AlarmSummaryEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
