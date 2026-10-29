import 'package:cesc01/core/helper/userData/recently_data.dart';
import 'package:cesc01/core/network/bean/realtime_entity.dart';
import 'package:cesc01/generated/json/base/json_convert_content.dart';

RecentlyData $RecentlyDataFromJson(Map<String, dynamic> json) {
  final RecentlyData recentlyData = RecentlyData();
  final String? siteId = jsonConvert.convert<String>(json['siteId']);
  if (siteId != null) {
    recentlyData.siteId = siteId;
  }
  final String? siteName = jsonConvert.convert<String>(json['siteName']);
  if (siteName != null) {
    recentlyData.siteName = siteName;
  }
  final String? countryRegion = jsonConvert.convert<String>(
    json['countryRegion'],
  );
  if (countryRegion != null) {
    recentlyData.countryRegion = countryRegion;
  }
  final String? commStatus = jsonConvert.convert<String>(json['commStatus']);
  if (commStatus != null) {
    recentlyData.commStatus = commStatus;
  }
  final RealtimePageListSoc? soc = jsonConvert.convert<RealtimePageListSoc>(
    json['soc'],
  );
  if (soc != null) {
    recentlyData.soc = soc;
  }
  return recentlyData;
}

Map<String, dynamic> $RecentlyDataToJson(RecentlyData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['siteId'] = entity.siteId;
  data['siteName'] = entity.siteName;
  data['countryRegion'] = entity.countryRegion;
  data['commStatus'] = entity.commStatus;
  data['soc'] = entity.soc?.toJson();
  return data;
}

extension RecentlyDataExtension on RecentlyData {
  RecentlyData copyWith({
    String? siteId,
    String? siteName,
    String? countryRegion,
    String? commStatus,
    RealtimePageListSoc? soc,
  }) {
    return RecentlyData()
      ..siteId = siteId ?? this.siteId
      ..siteName = siteName ?? this.siteName
      ..countryRegion = countryRegion ?? this.countryRegion
      ..commStatus = commStatus ?? this.commStatus
      ..soc = soc ?? this.soc;
  }
}
