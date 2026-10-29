import 'dart:convert';

import 'package:cesc01/core/translations/lan_key.dart';
import 'package:cesc01/generated/json/base/json_field.dart';
import 'package:cesc01/generated/json/notify_item_entity.g.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

export 'package:cesc01/generated/json/notify_item_entity.g.dart';

@JsonSerializable()
class NotifyItemEntity {
  String? id;
  String? type;
  String? level;
  String? levelLabel;
  int? alarmLevel;
  String? title;
  String? time;
  int? timestamp;
  String? siteId;
  String? siteName;
  String? stackSn;
  String? stackName;
  int? alarmId;
  int? taskId;
  String? taskNo;
  String? upgradeType;
  String? versionDisplay;

  int get showAlarmLevel => alarmLevel ?? -1;

  ///站点名称
  String get showSiteName => siteName ?? '-';

  int get showTimestamp => timestamp ?? 0;

  String get showTime => time ?? '-';

  String get showTitle => title ?? '-';

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

  NotifyItemEntity();

  factory NotifyItemEntity.fromJson(Map<String, dynamic> json) =>
      $NotifyItemEntityFromJson(json);

  Map<String, dynamic> toJson() => $NotifyItemEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
