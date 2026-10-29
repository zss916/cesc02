import 'dart:convert';

import 'package:cesc01/generated/json/base/json_field.dart';
import 'package:cesc01/generated/json/site_entity.g.dart';

export 'package:cesc01/generated/json/site_entity.g.dart';

@JsonSerializable()
class SiteEntity {
  String? siteId;
  String? siteCode;
  String? name;
  String? countryRegion;
  String? detailAddress;
  String? timezone;
  String? batteryCountText;
  int? onlineBatteryCount;
  int? totalBatteryCount;
  String? runtimeStatus;
  String? updateTime;

  SiteEntity();

  factory SiteEntity.fromJson(Map<String, dynamic> json) =>
      $SiteEntityFromJson(json);

  Map<String, dynamic> toJson() => $SiteEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
