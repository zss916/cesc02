import 'dart:convert';

import 'package:cesc01/generated/json/base/json_field.dart';
import 'package:cesc01/generated/json/battery_list_entity.g.dart';

export 'package:cesc01/generated/json/battery_list_entity.g.dart';

@JsonSerializable()
class BatteryListEntity {
  int? total;
  int? totalPage;
  int? pageNum;
  int? pageSize;
  bool? hasNext;
  List<BatteryListList>? list;

  BatteryListEntity();

  factory BatteryListEntity.fromJson(Map<String, dynamic> json) =>
      $BatteryListEntityFromJson(json);

  Map<String, dynamic> toJson() => $BatteryListEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class BatteryListList {
  int? id;
  String? sn;
  int? packIdx;
  String? packName;
  String? modelName;
  String? siteId;
  String? siteName;
  String? runStatus;
  String? commStatus;
  double? soc;
  double? soh;
  String? firmwareVersion;
  String? lastDataTime;
  String? totalVoltage;
  String? totalCurrent;
  String? maxTemperature;
  int? alarmCount;

  String get showRuntimeStatus => runStatus ?? "-";

  String get showCommStatus => commStatus ?? "-";

  String get showSoh => soh == null ? "-" : "${soh ?? 0}%";

  String get showSoc => soc == null ? "-" : "${soc ?? 0}%";

  String get showAlarmCount => alarmCount == null ? "-" : "${alarmCount ?? 0}";

  String get showSocAndSoh => '$showSoc / $showSoh';

  String get showFirmwareVersion => firmwareVersion ?? "-";

  String get showLastDataTime => lastDataTime ?? "-";

  String get showPackName => packName ?? "-";

  String get showSN => sn ?? "-";

  String get showMaxTempe => maxTemperature ?? "-";

  String get showTotalCurrent => totalCurrent ?? "-";

  String get showTotalVoltage => totalVoltage ?? "-";

  BatteryListList();

  factory BatteryListList.fromJson(Map<String, dynamic> json) =>
      $BatteryListListFromJson(json);

  Map<String, dynamic> toJson() => $BatteryListListToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
