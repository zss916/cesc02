import 'dart:convert';

import 'package:cesc01/generated/json/base/json_field.dart';
import 'package:cesc01/generated/json/version_data_entity.g.dart';

export 'package:cesc01/generated/json/version_data_entity.g.dart';

@JsonSerializable()
class VersionDataEntity {
  int? stackId;
  String? stackSn;
  String? stackName;
  String? softwareVersion;
  String? hardwareVersion;
  String? bootVersion;
  List<VersionDataClusters>? clusters;

  String get showStackName => stackName ?? '-';

  String get showStackSn => stackSn ?? '-';

  String get showSoftwareVersion => softwareVersion ?? '--';

  String get showHardwareVersion => hardwareVersion ?? '--';

  String get showBootVersion => bootVersion ?? '--';

  List<VersionDataClusters> get showClusterList => clusters ?? [];

  VersionDataEntity();

  factory VersionDataEntity.fromJson(Map<String, dynamic> json) =>
      $VersionDataEntityFromJson(json);

  Map<String, dynamic> toJson() => $VersionDataEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class VersionDataClusters {
  int? clusterId;
  int? clusterNo;
  String? clusterSn;
  String? clusterName;
  int? packCount;
  String? softwareVersion;
  String? hardwareVersion;
  String? bootVersion;

  String get showClusterName => clusterName ?? '-';

  String get showClusterSn => clusterSn ?? '-';

  String get showSoftwareVersion => softwareVersion ?? '-';

  String get showHardwareVersion => hardwareVersion ?? '-';

  String get showBootVersion => bootVersion ?? '-';

  String get showClusterNo => clusterNo == null ? '-' : '${clusterNo ?? 0}';

  int get showPackCount => packCount ?? 0;

  VersionDataClusters();

  factory VersionDataClusters.fromJson(Map<String, dynamic> json) =>
      $VersionDataClustersFromJson(json);

  Map<String, dynamic> toJson() => $VersionDataClustersToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
