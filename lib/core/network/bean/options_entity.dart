import 'dart:convert';

import 'package:cesc01/generated/json/base/json_field.dart';
import 'package:cesc01/generated/json/options_entity.g.dart';

export 'package:cesc01/generated/json/options_entity.g.dart';

@JsonSerializable()
class OptionsEntity {
  int? siteId;
  String? siteCode;
  String? name;
  String? label;
  List<OptionsStacks>? stacks;

  List<OptionsStacks> get showStacks => stacks ?? [];

  OptionsEntity();

  factory OptionsEntity.fromJson(Map<String, dynamic> json) =>
      $OptionsEntityFromJson(json);

  Map<String, dynamic> toJson() => $OptionsEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class OptionsStacks {
  String? stackId;
  String? stackSn;
  String? stackName;
  String? label;
  String? modelName;
  String? commStatus;
  List<OptionsStacksClusters>? clusters;

  String get showCommStatus => (commStatus ?? '-');

  String get showStackSn => stackSn ?? '-';

  String get showStackName => stackName ?? '-';

  int get clusterCount => (clusters ?? []).length;

  OptionsStacks();

  factory OptionsStacks.fromJson(Map<String, dynamic> json) =>
      $OptionsStacksFromJson(json);

  Map<String, dynamic> toJson() => $OptionsStacksToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class OptionsStacksClusters {
  String? clusterId;
  int? clusterNo;
  String? clusterSn;
  String? clusterName;
  int? packCount;
  String? commStatus;

  String get showCommStatus => (commStatus ?? '-');

  String get showClusterName => clusterName ?? '-';

  String get showClusterSn => clusterSn ?? '-';

  int get showPackCount => packCount ?? 0;

  OptionsStacksClusters();

  factory OptionsStacksClusters.fromJson(Map<String, dynamic> json) =>
      $OptionsStacksClustersFromJson(json);

  Map<String, dynamic> toJson() => $OptionsStacksClustersToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
