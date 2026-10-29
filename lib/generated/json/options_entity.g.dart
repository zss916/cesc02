import 'package:cesc01/core/network/bean/options_entity.dart';
import 'package:cesc01/generated/json/base/json_convert_content.dart';

OptionsEntity $OptionsEntityFromJson(Map<String, dynamic> json) {
  final OptionsEntity optionsEntity = OptionsEntity();
  final int? siteId = jsonConvert.convert<int>(json['siteId']);
  if (siteId != null) {
    optionsEntity.siteId = siteId;
  }
  final String? siteCode = jsonConvert.convert<String>(json['siteCode']);
  if (siteCode != null) {
    optionsEntity.siteCode = siteCode;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    optionsEntity.name = name;
  }
  final String? label = jsonConvert.convert<String>(json['label']);
  if (label != null) {
    optionsEntity.label = label;
  }
  final List<OptionsStacks>? stacks = (json['stacks'] as List<dynamic>?)
      ?.map((e) => jsonConvert.convert<OptionsStacks>(e) as OptionsStacks)
      .toList();
  if (stacks != null) {
    optionsEntity.stacks = stacks;
  }
  return optionsEntity;
}

Map<String, dynamic> $OptionsEntityToJson(OptionsEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['siteId'] = entity.siteId;
  data['siteCode'] = entity.siteCode;
  data['name'] = entity.name;
  data['label'] = entity.label;
  data['stacks'] = entity.stacks?.map((v) => v.toJson()).toList();
  return data;
}

extension OptionsEntityExtension on OptionsEntity {
  OptionsEntity copyWith({
    int? siteId,
    String? siteCode,
    String? name,
    String? label,
    List<OptionsStacks>? stacks,
  }) {
    return OptionsEntity()
      ..siteId = siteId ?? this.siteId
      ..siteCode = siteCode ?? this.siteCode
      ..name = name ?? this.name
      ..label = label ?? this.label
      ..stacks = stacks ?? this.stacks;
  }
}

OptionsStacks $OptionsStacksFromJson(Map<String, dynamic> json) {
  final OptionsStacks optionsStacks = OptionsStacks();
  final String? stackId = jsonConvert.convert<String>(json['stackId']);
  if (stackId != null) {
    optionsStacks.stackId = stackId;
  }
  final String? stackSn = jsonConvert.convert<String>(json['stackSn']);
  if (stackSn != null) {
    optionsStacks.stackSn = stackSn;
  }
  final String? stackName = jsonConvert.convert<String>(json['stackName']);
  if (stackName != null) {
    optionsStacks.stackName = stackName;
  }
  final String? label = jsonConvert.convert<String>(json['label']);
  if (label != null) {
    optionsStacks.label = label;
  }
  final String? modelName = jsonConvert.convert<String>(json['modelName']);
  if (modelName != null) {
    optionsStacks.modelName = modelName;
  }
  final String? commStatus = jsonConvert.convert<String>(json['commStatus']);
  if (commStatus != null) {
    optionsStacks.commStatus = commStatus;
  }
  final List<OptionsStacksClusters>? clusters =
      (json['clusters'] as List<dynamic>?)
          ?.map(
            (e) =>
                jsonConvert.convert<OptionsStacksClusters>(e)
                    as OptionsStacksClusters,
          )
          .toList();
  if (clusters != null) {
    optionsStacks.clusters = clusters;
  }
  return optionsStacks;
}

Map<String, dynamic> $OptionsStacksToJson(OptionsStacks entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['stackId'] = entity.stackId;
  data['stackSn'] = entity.stackSn;
  data['stackName'] = entity.stackName;
  data['label'] = entity.label;
  data['modelName'] = entity.modelName;
  data['commStatus'] = entity.commStatus;
  data['clusters'] = entity.clusters?.map((v) => v.toJson()).toList();
  return data;
}

extension OptionsStacksExtension on OptionsStacks {
  OptionsStacks copyWith({
    String? stackId,
    String? stackSn,
    String? stackName,
    String? label,
    String? modelName,
    String? commStatus,
    List<OptionsStacksClusters>? clusters,
  }) {
    return OptionsStacks()
      ..stackId = stackId ?? this.stackId
      ..stackSn = stackSn ?? this.stackSn
      ..stackName = stackName ?? this.stackName
      ..label = label ?? this.label
      ..modelName = modelName ?? this.modelName
      ..commStatus = commStatus ?? this.commStatus
      ..clusters = clusters ?? this.clusters;
  }
}

OptionsStacksClusters $OptionsStacksClustersFromJson(
  Map<String, dynamic> json,
) {
  final OptionsStacksClusters optionsStacksClusters = OptionsStacksClusters();
  final String? clusterId = jsonConvert.convert<String>(json['clusterId']);
  if (clusterId != null) {
    optionsStacksClusters.clusterId = clusterId;
  }
  final int? clusterNo = jsonConvert.convert<int>(json['clusterNo']);
  if (clusterNo != null) {
    optionsStacksClusters.clusterNo = clusterNo;
  }
  final String? clusterSn = jsonConvert.convert<String>(json['clusterSn']);
  if (clusterSn != null) {
    optionsStacksClusters.clusterSn = clusterSn;
  }
  final String? clusterName = jsonConvert.convert<String>(json['clusterName']);
  if (clusterName != null) {
    optionsStacksClusters.clusterName = clusterName;
  }
  final int? packCount = jsonConvert.convert<int>(json['packCount']);
  if (packCount != null) {
    optionsStacksClusters.packCount = packCount;
  }
  final String? commStatus = jsonConvert.convert<String>(json['commStatus']);
  if (commStatus != null) {
    optionsStacksClusters.commStatus = commStatus;
  }
  return optionsStacksClusters;
}

Map<String, dynamic> $OptionsStacksClustersToJson(
  OptionsStacksClusters entity,
) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['clusterId'] = entity.clusterId;
  data['clusterNo'] = entity.clusterNo;
  data['clusterSn'] = entity.clusterSn;
  data['clusterName'] = entity.clusterName;
  data['packCount'] = entity.packCount;
  data['commStatus'] = entity.commStatus;
  return data;
}

extension OptionsStacksClustersExtension on OptionsStacksClusters {
  OptionsStacksClusters copyWith({
    String? clusterId,
    int? clusterNo,
    String? clusterSn,
    String? clusterName,
    int? packCount,
    String? commStatus,
  }) {
    return OptionsStacksClusters()
      ..clusterId = clusterId ?? this.clusterId
      ..clusterNo = clusterNo ?? this.clusterNo
      ..clusterSn = clusterSn ?? this.clusterSn
      ..clusterName = clusterName ?? this.clusterName
      ..packCount = packCount ?? this.packCount
      ..commStatus = commStatus ?? this.commStatus;
  }
}
