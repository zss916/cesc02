import 'dart:convert';

import 'package:cesc01/core/network/bean/realtime_entity.dart';
import 'package:cesc01/generated/json/base/json_field.dart';
import 'package:cesc01/generated/json/recently_data.g.dart';

@JsonSerializable()
class RecentlyData {
  String? siteId;
  String? siteName;
  String? countryRegion;
  String? commStatus;
  RealtimePageListSoc? soc;

  ///站点名称
  String get showSiteName => siteName ?? '-';

  ///站点地址详情
  String get showSiteAddress => countryRegion ?? '- · -';

  ///运行状态
  String get showCommStatus => commStatus ?? '-';

  ///是否隐藏
  bool get commStatusVisibility => commStatus != null;

  ///soc
  String get showSocRange => soc?.display ?? "-";

  RecentlyData();

  factory RecentlyData.fromJson(Map<String, dynamic> json) =>
      $RecentlyDataFromJson(json);

  Map<String, dynamic> toJson() => $RecentlyDataToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
