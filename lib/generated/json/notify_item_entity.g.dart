import 'package:cesc01/core/network/bean/notify_item_entity.dart';
import 'package:cesc01/generated/json/base/json_convert_content.dart';

NotifyItemEntity $NotifyItemEntityFromJson(Map<String, dynamic> json) {
  final NotifyItemEntity notifyItemEntity = NotifyItemEntity();
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    notifyItemEntity.id = id;
  }
  final String? type = jsonConvert.convert<String>(json['type']);
  if (type != null) {
    notifyItemEntity.type = type;
  }
  final String? level = jsonConvert.convert<String>(json['level']);
  if (level != null) {
    notifyItemEntity.level = level;
  }
  final String? levelLabel = jsonConvert.convert<String>(json['levelLabel']);
  if (levelLabel != null) {
    notifyItemEntity.levelLabel = levelLabel;
  }
  final int? alarmLevel = jsonConvert.convert<int>(json['alarmLevel']);
  if (alarmLevel != null) {
    notifyItemEntity.alarmLevel = alarmLevel;
  }
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    notifyItemEntity.title = title;
  }
  final String? time = jsonConvert.convert<String>(json['time']);
  if (time != null) {
    notifyItemEntity.time = time;
  }
  final int? timestamp = jsonConvert.convert<int>(json['timestamp']);
  if (timestamp != null) {
    notifyItemEntity.timestamp = timestamp;
  }
  final String? siteId = jsonConvert.convert<String>(json['siteId']);
  if (siteId != null) {
    notifyItemEntity.siteId = siteId;
  }
  final String? siteName = jsonConvert.convert<String>(json['siteName']);
  if (siteName != null) {
    notifyItemEntity.siteName = siteName;
  }
  final String? stackSn = jsonConvert.convert<String>(json['stackSn']);
  if (stackSn != null) {
    notifyItemEntity.stackSn = stackSn;
  }
  final String? stackName = jsonConvert.convert<String>(json['stackName']);
  if (stackName != null) {
    notifyItemEntity.stackName = stackName;
  }
  final int? alarmId = jsonConvert.convert<int>(json['alarmId']);
  if (alarmId != null) {
    notifyItemEntity.alarmId = alarmId;
  }
  final int? taskId = jsonConvert.convert<int>(json['taskId']);
  if (taskId != null) {
    notifyItemEntity.taskId = taskId;
  }
  final String? taskNo = jsonConvert.convert<String>(json['taskNo']);
  if (taskNo != null) {
    notifyItemEntity.taskNo = taskNo;
  }
  final String? upgradeType = jsonConvert.convert<String>(json['upgradeType']);
  if (upgradeType != null) {
    notifyItemEntity.upgradeType = upgradeType;
  }
  final String? versionDisplay = jsonConvert.convert<String>(
    json['versionDisplay'],
  );
  if (versionDisplay != null) {
    notifyItemEntity.versionDisplay = versionDisplay;
  }
  return notifyItemEntity;
}

Map<String, dynamic> $NotifyItemEntityToJson(NotifyItemEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['type'] = entity.type;
  data['level'] = entity.level;
  data['levelLabel'] = entity.levelLabel;
  data['alarmLevel'] = entity.alarmLevel;
  data['title'] = entity.title;
  data['time'] = entity.time;
  data['timestamp'] = entity.timestamp;
  data['siteId'] = entity.siteId;
  data['siteName'] = entity.siteName;
  data['stackSn'] = entity.stackSn;
  data['stackName'] = entity.stackName;
  data['alarmId'] = entity.alarmId;
  data['taskId'] = entity.taskId;
  data['taskNo'] = entity.taskNo;
  data['upgradeType'] = entity.upgradeType;
  data['versionDisplay'] = entity.versionDisplay;
  return data;
}

extension NotifyItemEntityExtension on NotifyItemEntity {
  NotifyItemEntity copyWith({
    String? id,
    String? type,
    String? level,
    String? levelLabel,
    int? alarmLevel,
    String? title,
    String? time,
    int? timestamp,
    String? siteId,
    String? siteName,
    String? stackSn,
    String? stackName,
    int? alarmId,
    int? taskId,
    String? taskNo,
    String? upgradeType,
    String? versionDisplay,
  }) {
    return NotifyItemEntity()
      ..id = id ?? this.id
      ..type = type ?? this.type
      ..level = level ?? this.level
      ..levelLabel = levelLabel ?? this.levelLabel
      ..alarmLevel = alarmLevel ?? this.alarmLevel
      ..title = title ?? this.title
      ..time = time ?? this.time
      ..timestamp = timestamp ?? this.timestamp
      ..siteId = siteId ?? this.siteId
      ..siteName = siteName ?? this.siteName
      ..stackSn = stackSn ?? this.stackSn
      ..stackName = stackName ?? this.stackName
      ..alarmId = alarmId ?? this.alarmId
      ..taskId = taskId ?? this.taskId
      ..taskNo = taskNo ?? this.taskNo
      ..upgradeType = upgradeType ?? this.upgradeType
      ..versionDisplay = versionDisplay ?? this.versionDisplay;
  }
}
