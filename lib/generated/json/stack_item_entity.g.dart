import 'package:cesc01/core/network/bean/stack_item_entity.dart';
import 'package:cesc01/generated/json/base/json_convert_content.dart';

StackItemEntity $StackItemEntityFromJson(Map<String, dynamic> json) {
  final StackItemEntity stackItemEntity = StackItemEntity();
  final int? stackId = jsonConvert.convert<int>(json['stackId']);
  if (stackId != null) {
    stackItemEntity.stackId = stackId;
  }
  final String? stackSn = jsonConvert.convert<String>(json['stackSn']);
  if (stackSn != null) {
    stackItemEntity.stackSn = stackSn;
  }
  final String? stackName = jsonConvert.convert<String>(json['stackName']);
  if (stackName != null) {
    stackItemEntity.stackName = stackName;
  }
  final String? label = jsonConvert.convert<String>(json['label']);
  if (label != null) {
    stackItemEntity.label = label;
  }
  final String? modelName = jsonConvert.convert<String>(json['modelName']);
  if (modelName != null) {
    stackItemEntity.modelName = modelName;
  }
  final String? firmwareVersion = jsonConvert.convert<String>(
    json['firmwareVersion'],
  );
  if (firmwareVersion != null) {
    stackItemEntity.firmwareVersion = firmwareVersion;
  }
  final int? clusterCount = jsonConvert.convert<int>(json['clusterCount']);
  if (clusterCount != null) {
    stackItemEntity.clusterCount = clusterCount;
  }
  final int? sysMode = jsonConvert.convert<int>(json['sysMode']);
  if (sysMode != null) {
    stackItemEntity.sysMode = sysMode;
  }
  final String? commStatus = jsonConvert.convert<String>(json['commStatus']);
  if (commStatus != null) {
    stackItemEntity.commStatus = commStatus;
  }
  final String? runStatus = jsonConvert.convert<String>(json['runStatus']);
  if (runStatus != null) {
    stackItemEntity.runStatus = runStatus;
  }
  final int? siteId = jsonConvert.convert<int>(json['siteId']);
  if (siteId != null) {
    stackItemEntity.siteId = siteId;
  }
  final bool? bound = jsonConvert.convert<bool>(json['bound']);
  if (bound != null) {
    stackItemEntity.bound = bound;
  }
  return stackItemEntity;
}

Map<String, dynamic> $StackItemEntityToJson(StackItemEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['stackId'] = entity.stackId;
  data['stackSn'] = entity.stackSn;
  data['stackName'] = entity.stackName;
  data['label'] = entity.label;
  data['modelName'] = entity.modelName;
  data['firmwareVersion'] = entity.firmwareVersion;
  data['clusterCount'] = entity.clusterCount;
  data['sysMode'] = entity.sysMode;
  data['commStatus'] = entity.commStatus;
  data['runStatus'] = entity.runStatus;
  data['siteId'] = entity.siteId;
  data['bound'] = entity.bound;
  return data;
}

extension StackItemEntityExtension on StackItemEntity {
  StackItemEntity copyWith({
    int? stackId,
    String? stackSn,
    String? stackName,
    String? label,
    String? modelName,
    String? firmwareVersion,
    int? clusterCount,
    int? sysMode,
    String? commStatus,
    String? runStatus,
    int? siteId,
    bool? bound,
  }) {
    return StackItemEntity()
      ..stackId = stackId ?? this.stackId
      ..stackSn = stackSn ?? this.stackSn
      ..stackName = stackName ?? this.stackName
      ..label = label ?? this.label
      ..modelName = modelName ?? this.modelName
      ..firmwareVersion = firmwareVersion ?? this.firmwareVersion
      ..clusterCount = clusterCount ?? this.clusterCount
      ..sysMode = sysMode ?? this.sysMode
      ..commStatus = commStatus ?? this.commStatus
      ..runStatus = runStatus ?? this.runStatus
      ..siteId = siteId ?? this.siteId
      ..bound = bound ?? this.bound;
  }
}
