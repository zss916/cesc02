import 'package:cesc01/generated/json/base/json_convert_content.dart';
import 'package:cesc01/core/network/bean/alarm_summary_entity.dart';

AlarmSummaryEntity $AlarmSummaryEntityFromJson(Map<String, dynamic> json) {
  final AlarmSummaryEntity alarmSummaryEntity = AlarmSummaryEntity();
  final int? siteCount = jsonConvert.convert<int>(json['siteCount']);
  if (siteCount != null) {
    alarmSummaryEntity.siteCount = siteCount;
  }
  final int? stackCount = jsonConvert.convert<int>(json['stackCount']);
  if (stackCount != null) {
    alarmSummaryEntity.stackCount = stackCount;
  }
  final int? alarmClusterCount = jsonConvert.convert<int>(
      json['alarmClusterCount']);
  if (alarmClusterCount != null) {
    alarmSummaryEntity.alarmClusterCount = alarmClusterCount;
  }
  return alarmSummaryEntity;
}

Map<String, dynamic> $AlarmSummaryEntityToJson(AlarmSummaryEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['siteCount'] = entity.siteCount;
  data['stackCount'] = entity.stackCount;
  data['alarmClusterCount'] = entity.alarmClusterCount;
  return data;
}

extension AlarmSummaryEntityExtension on AlarmSummaryEntity {
  AlarmSummaryEntity copyWith({
    int? siteCount,
    int? stackCount,
    int? alarmClusterCount,
  }) {
    return AlarmSummaryEntity()
      ..siteCount = siteCount ?? this.siteCount
      ..stackCount = stackCount ?? this.stackCount
      ..alarmClusterCount = alarmClusterCount ?? this.alarmClusterCount;
  }
}