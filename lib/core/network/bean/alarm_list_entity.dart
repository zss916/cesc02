import 'dart:convert';

import 'package:cesc01/core/network/bean/alarm_detail_entity.dart';
import 'package:cesc01/generated/json/alarm_list_entity.g.dart';
import 'package:cesc01/generated/json/base/json_field.dart';

export 'package:cesc01/generated/json/alarm_list_entity.g.dart';

@JsonSerializable()
class AlarmListEntity {
  int? total;
  int? totalPage;
  int? pageNum;
  int? pageSize;
  bool? hasNext;
  List<AlarmDetailEntity>? list;

  AlarmListEntity();

  factory AlarmListEntity.fromJson(Map<String, dynamic> json) =>
      $AlarmListEntityFromJson(json);

  Map<String, dynamic> toJson() => $AlarmListEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

/*@JsonSerializable()
class AlarmListList {
  int? id;
  String? alarmNo;
  String? alarmName;
  String? category;
  int? alarmLevel;
  int? bitIndex;
  String? status;
  int? siteId;
  String? siteName;
  int? clusterId;
  String? packName;
  String? sn;
  String? occurredAt;
  String? recoveredAt;
  int? durationSeconds;
  String? description;


  String get showDes => description ?? '--';

  String get showSiteName => siteName ?? '-';

  ///发生时间
  String get timeDisplay => occurredAt ?? '-';

  int get showAlarmLevel => alarmLevel ?? -1;

  String get showAlarmName => alarmName ?? '-';

  AlarmListList();

  factory AlarmListList.fromJson(Map<String, dynamic> json) =>
      $AlarmListListFromJson(json);

  Map<String, dynamic> toJson() => $AlarmListListToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}*/
