import 'package:cesc01/core/network/bean/alarm_detail_entity.dart';
import 'package:cesc01/core/network/bean/alarm_list_entity.dart';
import 'package:cesc01/generated/json/base/json_convert_content.dart';

AlarmListEntity $AlarmListEntityFromJson(Map<String, dynamic> json) {
  final AlarmListEntity alarmListEntity = AlarmListEntity();
  final int? total = jsonConvert.convert<int>(json['total']);
  if (total != null) {
    alarmListEntity.total = total;
  }
  final int? totalPage = jsonConvert.convert<int>(json['totalPage']);
  if (totalPage != null) {
    alarmListEntity.totalPage = totalPage;
  }
  final int? pageNum = jsonConvert.convert<int>(json['pageNum']);
  if (pageNum != null) {
    alarmListEntity.pageNum = pageNum;
  }
  final int? pageSize = jsonConvert.convert<int>(json['pageSize']);
  if (pageSize != null) {
    alarmListEntity.pageSize = pageSize;
  }
  final bool? hasNext = jsonConvert.convert<bool>(json['hasNext']);
  if (hasNext != null) {
    alarmListEntity.hasNext = hasNext;
  }
  final List<AlarmDetailEntity>? list = (json['list'] as List<dynamic>?)
      ?.map(
        (e) => jsonConvert.convert<AlarmDetailEntity>(e) as AlarmDetailEntity,
      )
      .toList();
  if (list != null) {
    alarmListEntity.list = list;
  }
  return alarmListEntity;
}

Map<String, dynamic> $AlarmListEntityToJson(AlarmListEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['total'] = entity.total;
  data['totalPage'] = entity.totalPage;
  data['pageNum'] = entity.pageNum;
  data['pageSize'] = entity.pageSize;
  data['hasNext'] = entity.hasNext;
  data['list'] = entity.list?.map((v) => v.toJson()).toList();
  return data;
}

extension AlarmListEntityExtension on AlarmListEntity {
  AlarmListEntity copyWith({
    int? total,
    int? totalPage,
    int? pageNum,
    int? pageSize,
    bool? hasNext,
    List<AlarmDetailEntity>? list,
  }) {
    return AlarmListEntity()
      ..total = total ?? this.total
      ..totalPage = totalPage ?? this.totalPage
      ..pageNum = pageNum ?? this.pageNum
      ..pageSize = pageSize ?? this.pageSize
      ..hasNext = hasNext ?? this.hasNext
      ..list = list ?? this.list;
  }
}
