import 'package:cesc01/core/network/bean/version_data_entity.dart';
import 'package:cesc01/generated/json/base/json_convert_content.dart';

VersionDataEntity $VersionDataEntityFromJson(Map<String, dynamic> json) {
  final VersionDataEntity versionDataEntity = VersionDataEntity();
  final int? stackId = jsonConvert.convert<int>(json['stackId']);
  if (stackId != null) {
    versionDataEntity.stackId = stackId;
  }
  final String? stackSn = jsonConvert.convert<String>(json['stackSn']);
  if (stackSn != null) {
    versionDataEntity.stackSn = stackSn;
  }
  final String? stackName = jsonConvert.convert<String>(json['stackName']);
  if (stackName != null) {
    versionDataEntity.stackName = stackName;
  }
  final String? softwareVersion = jsonConvert.convert<String>(
    json['softwareVersion'],
  );
  if (softwareVersion != null) {
    versionDataEntity.softwareVersion = softwareVersion;
  }
  final String? hardwareVersion = jsonConvert.convert<String>(
    json['hardwareVersion'],
  );
  if (hardwareVersion != null) {
    versionDataEntity.hardwareVersion = hardwareVersion;
  }
  final String? bootVersion = jsonConvert.convert<String>(json['bootVersion']);
  if (bootVersion != null) {
    versionDataEntity.bootVersion = bootVersion;
  }
  final List<VersionDataClusters>? clusters =
      (json['clusters'] as List<dynamic>?)
          ?.map(
            (e) =>
                jsonConvert.convert<VersionDataClusters>(e)
                    as VersionDataClusters,
          )
          .toList();
  if (clusters != null) {
    versionDataEntity.clusters = clusters;
  }
  return versionDataEntity;
}

Map<String, dynamic> $VersionDataEntityToJson(VersionDataEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['stackId'] = entity.stackId;
  data['stackSn'] = entity.stackSn;
  data['stackName'] = entity.stackName;
  data['softwareVersion'] = entity.softwareVersion;
  data['hardwareVersion'] = entity.hardwareVersion;
  data['bootVersion'] = entity.bootVersion;
  data['clusters'] = entity.clusters?.map((v) => v.toJson()).toList();
  return data;
}

extension VersionDataEntityExtension on VersionDataEntity {
  VersionDataEntity copyWith({
    int? stackId,
    String? stackSn,
    String? stackName,
    String? softwareVersion,
    String? hardwareVersion,
    String? bootVersion,
    List<VersionDataClusters>? clusters,
  }) {
    return VersionDataEntity()
      ..stackId = stackId ?? this.stackId
      ..stackSn = stackSn ?? this.stackSn
      ..stackName = stackName ?? this.stackName
      ..softwareVersion = softwareVersion ?? this.softwareVersion
      ..hardwareVersion = hardwareVersion ?? this.hardwareVersion
      ..bootVersion = bootVersion ?? this.bootVersion
      ..clusters = clusters ?? this.clusters;
  }
}

VersionDataClusters $VersionDataClustersFromJson(Map<String, dynamic> json) {
  final VersionDataClusters versionDataClusters = VersionDataClusters();
  final int? clusterId = jsonConvert.convert<int>(json['clusterId']);
  if (clusterId != null) {
    versionDataClusters.clusterId = clusterId;
  }
  final int? clusterNo = jsonConvert.convert<int>(json['clusterNo']);
  if (clusterNo != null) {
    versionDataClusters.clusterNo = clusterNo;
  }
  final String? clusterSn = jsonConvert.convert<String>(json['clusterSn']);
  if (clusterSn != null) {
    versionDataClusters.clusterSn = clusterSn;
  }
  final String? clusterName = jsonConvert.convert<String>(json['clusterName']);
  if (clusterName != null) {
    versionDataClusters.clusterName = clusterName;
  }
  final int? packCount = jsonConvert.convert<int>(json['packCount']);
  if (packCount != null) {
    versionDataClusters.packCount = packCount;
  }
  final String? softwareVersion = jsonConvert.convert<String>(
    json['softwareVersion'],
  );
  if (softwareVersion != null) {
    versionDataClusters.softwareVersion = softwareVersion;
  }
  final String? hardwareVersion = jsonConvert.convert<String>(
    json['hardwareVersion'],
  );
  if (hardwareVersion != null) {
    versionDataClusters.hardwareVersion = hardwareVersion;
  }
  final String? bootVersion = jsonConvert.convert<String>(json['bootVersion']);
  if (bootVersion != null) {
    versionDataClusters.bootVersion = bootVersion;
  }
  return versionDataClusters;
}

Map<String, dynamic> $VersionDataClustersToJson(VersionDataClusters entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['clusterId'] = entity.clusterId;
  data['clusterNo'] = entity.clusterNo;
  data['clusterSn'] = entity.clusterSn;
  data['clusterName'] = entity.clusterName;
  data['packCount'] = entity.packCount;
  data['softwareVersion'] = entity.softwareVersion;
  data['hardwareVersion'] = entity.hardwareVersion;
  data['bootVersion'] = entity.bootVersion;
  return data;
}

extension VersionDataClustersExtension on VersionDataClusters {
  VersionDataClusters copyWith({
    int? clusterId,
    int? clusterNo,
    String? clusterSn,
    String? clusterName,
    int? packCount,
    String? softwareVersion,
    String? hardwareVersion,
    String? bootVersion,
  }) {
    return VersionDataClusters()
      ..clusterId = clusterId ?? this.clusterId
      ..clusterNo = clusterNo ?? this.clusterNo
      ..clusterSn = clusterSn ?? this.clusterSn
      ..clusterName = clusterName ?? this.clusterName
      ..packCount = packCount ?? this.packCount
      ..softwareVersion = softwareVersion ?? this.softwareVersion
      ..hardwareVersion = hardwareVersion ?? this.hardwareVersion
      ..bootVersion = bootVersion ?? this.bootVersion;
  }
}
