import 'package:cesc01/generated/json/base/json_convert_content.dart';
import 'package:cesc01/core/network/bean/battery_list_entity.dart';

BatteryListEntity $BatteryListEntityFromJson(Map<String, dynamic> json) {
  final BatteryListEntity batteryListEntity = BatteryListEntity();
  final int? total = jsonConvert.convert<int>(json['total']);
  if (total != null) {
    batteryListEntity.total = total;
  }
  final int? totalPage = jsonConvert.convert<int>(json['totalPage']);
  if (totalPage != null) {
    batteryListEntity.totalPage = totalPage;
  }
  final int? pageNum = jsonConvert.convert<int>(json['pageNum']);
  if (pageNum != null) {
    batteryListEntity.pageNum = pageNum;
  }
  final int? pageSize = jsonConvert.convert<int>(json['pageSize']);
  if (pageSize != null) {
    batteryListEntity.pageSize = pageSize;
  }
  final bool? hasNext = jsonConvert.convert<bool>(json['hasNext']);
  if (hasNext != null) {
    batteryListEntity.hasNext = hasNext;
  }
  final List<BatteryListList>? list = (json['list'] as List<dynamic>?)
      ?.map(
          (e) => jsonConvert.convert<BatteryListList>(e) as BatteryListList)
      .toList();
  if (list != null) {
    batteryListEntity.list = list;
  }
  return batteryListEntity;
}

Map<String, dynamic> $BatteryListEntityToJson(BatteryListEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['total'] = entity.total;
  data['totalPage'] = entity.totalPage;
  data['pageNum'] = entity.pageNum;
  data['pageSize'] = entity.pageSize;
  data['hasNext'] = entity.hasNext;
  data['list'] = entity.list?.map((v) => v.toJson()).toList();
  return data;
}

extension BatteryListEntityExtension on BatteryListEntity {
  BatteryListEntity copyWith({
    int? total,
    int? totalPage,
    int? pageNum,
    int? pageSize,
    bool? hasNext,
    List<BatteryListList>? list,
  }) {
    return BatteryListEntity()
      ..total = total ?? this.total
      ..totalPage = totalPage ?? this.totalPage
      ..pageNum = pageNum ?? this.pageNum
      ..pageSize = pageSize ?? this.pageSize
      ..hasNext = hasNext ?? this.hasNext
      ..list = list ?? this.list;
  }
}

BatteryListList $BatteryListListFromJson(Map<String, dynamic> json) {
  final BatteryListList batteryListList = BatteryListList();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    batteryListList.id = id;
  }
  final String? sn = jsonConvert.convert<String>(json['sn']);
  if (sn != null) {
    batteryListList.sn = sn;
  }
  final int? packIdx = jsonConvert.convert<int>(json['packIdx']);
  if (packIdx != null) {
    batteryListList.packIdx = packIdx;
  }
  final String? packName = jsonConvert.convert<String>(json['packName']);
  if (packName != null) {
    batteryListList.packName = packName;
  }
  final String? modelName = jsonConvert.convert<String>(json['modelName']);
  if (modelName != null) {
    batteryListList.modelName = modelName;
  }
  final String? siteId = jsonConvert.convert<String>(json['siteId']);
  if (siteId != null) {
    batteryListList.siteId = siteId;
  }
  final String? siteName = jsonConvert.convert<String>(json['siteName']);
  if (siteName != null) {
    batteryListList.siteName = siteName;
  }
  final String? runStatus = jsonConvert.convert<String>(json['runStatus']);
  if (runStatus != null) {
    batteryListList.runStatus = runStatus;
  }
  final String? commStatus = jsonConvert.convert<String>(json['commStatus']);
  if (commStatus != null) {
    batteryListList.commStatus = commStatus;
  }
  final double? soc = jsonConvert.convert<double>(json['soc']);
  if (soc != null) {
    batteryListList.soc = soc;
  }
  final double? soh = jsonConvert.convert<double>(json['soh']);
  if (soh != null) {
    batteryListList.soh = soh;
  }
  final String? firmwareVersion = jsonConvert.convert<String>(
      json['firmwareVersion']);
  if (firmwareVersion != null) {
    batteryListList.firmwareVersion = firmwareVersion;
  }
  final String? lastDataTime = jsonConvert.convert<String>(
      json['lastDataTime']);
  if (lastDataTime != null) {
    batteryListList.lastDataTime = lastDataTime;
  }
  final String? totalVoltage = jsonConvert.convert<String>(
      json['totalVoltage']);
  if (totalVoltage != null) {
    batteryListList.totalVoltage = totalVoltage;
  }
  final String? totalCurrent = jsonConvert.convert<String>(
      json['totalCurrent']);
  if (totalCurrent != null) {
    batteryListList.totalCurrent = totalCurrent;
  }
  final String? maxTemperature = jsonConvert.convert<String>(
      json['maxTemperature']);
  if (maxTemperature != null) {
    batteryListList.maxTemperature = maxTemperature;
  }
  final int? alarmCount = jsonConvert.convert<int>(json['alarmCount']);
  if (alarmCount != null) {
    batteryListList.alarmCount = alarmCount;
  }
  return batteryListList;
}

Map<String, dynamic> $BatteryListListToJson(BatteryListList entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['sn'] = entity.sn;
  data['packIdx'] = entity.packIdx;
  data['packName'] = entity.packName;
  data['modelName'] = entity.modelName;
  data['siteId'] = entity.siteId;
  data['siteName'] = entity.siteName;
  data['runStatus'] = entity.runStatus;
  data['commStatus'] = entity.commStatus;
  data['soc'] = entity.soc;
  data['soh'] = entity.soh;
  data['firmwareVersion'] = entity.firmwareVersion;
  data['lastDataTime'] = entity.lastDataTime;
  data['totalVoltage'] = entity.totalVoltage;
  data['totalCurrent'] = entity.totalCurrent;
  data['maxTemperature'] = entity.maxTemperature;
  data['alarmCount'] = entity.alarmCount;
  return data;
}

extension BatteryListListExtension on BatteryListList {
  BatteryListList copyWith({
    int? id,
    String? sn,
    int? packIdx,
    String? packName,
    String? modelName,
    String? siteId,
    String? siteName,
    String? runStatus,
    String? commStatus,
    double? soc,
    double? soh,
    String? firmwareVersion,
    String? lastDataTime,
    String? totalVoltage,
    String? totalCurrent,
    String? maxTemperature,
    int? alarmCount,
  }) {
    return BatteryListList()
      ..id = id ?? this.id
      ..sn = sn ?? this.sn
      ..packIdx = packIdx ?? this.packIdx
      ..packName = packName ?? this.packName
      ..modelName = modelName ?? this.modelName
      ..siteId = siteId ?? this.siteId
      ..siteName = siteName ?? this.siteName
      ..runStatus = runStatus ?? this.runStatus
      ..commStatus = commStatus ?? this.commStatus
      ..soc = soc ?? this.soc
      ..soh = soh ?? this.soh
      ..firmwareVersion = firmwareVersion ?? this.firmwareVersion
      ..lastDataTime = lastDataTime ?? this.lastDataTime
      ..totalVoltage = totalVoltage ?? this.totalVoltage
      ..totalCurrent = totalCurrent ?? this.totalCurrent
      ..maxTemperature = maxTemperature ?? this.maxTemperature
      ..alarmCount = alarmCount ?? this.alarmCount;
  }
}