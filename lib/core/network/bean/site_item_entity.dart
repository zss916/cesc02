import 'dart:convert';

import 'package:cesc01/core/network/bean/stack_item_entity.dart';
import 'package:cesc01/generated/json/base/json_field.dart';
import 'package:cesc01/generated/json/site_item_entity.g.dart';

export 'package:cesc01/generated/json/site_item_entity.g.dart';

@JsonSerializable()
class SiteItemEntity {
  String? siteId;
  String? siteCode;
  String? name;
  String? label;
  List<StackItemEntity>? stacks;

  String get showSiteName => name ?? '-';

  String get showSiteCode => siteCode ?? '-';

  List<StackItemEntity> get showStacks => stacks ?? [];

  /*List<StackItemEntity> get showStacks => [
    StackItemEntity()
      ..stackName = "1"
      ..stackSn = "123",
    StackItemEntity()
      ..stackName = "2"
      ..stackSn = "234",
  ];*/

  SiteItemEntity();

  factory SiteItemEntity.fromJson(Map<String, dynamic> json) =>
      $SiteItemEntityFromJson(json);

  Map<String, dynamic> toJson() => $SiteItemEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
