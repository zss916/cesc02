import 'dart:convert';

import 'package:cesc01/generated/json/base/json_field.dart';
import 'package:cesc01/generated/json/stack_item_entity.g.dart';

export 'package:cesc01/generated/json/stack_item_entity.g.dart';

@JsonSerializable()
class StackItemEntity {
  int? stackId;
  String? stackSn;
  String? stackName;
  String? label;
  String? modelName;
  String? firmwareVersion;
  int? clusterCount;
  int? sysMode;
  String? commStatus;
  String? runStatus;
  int? siteId;
  bool? bound;

  String get showStackName => stackName ?? "-";

  StackItemEntity();

  factory StackItemEntity.fromJson(Map<String, dynamic> json) =>
      $StackItemEntityFromJson(json);

  Map<String, dynamic> toJson() => $StackItemEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
