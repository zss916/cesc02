import 'package:cesc01/core/network/bean/site_item_entity.dart';
import 'package:cesc01/core/network/bean/stack_item_entity.dart';
import 'package:cesc01/generated/json/base/json_convert_content.dart';

SiteItemEntity $SiteItemEntityFromJson(Map<String, dynamic> json) {
  final SiteItemEntity siteItemEntity = SiteItemEntity();
  final String? siteId = jsonConvert.convert<String>(json['siteId']);
  if (siteId != null) {
    siteItemEntity.siteId = siteId;
  }
  final String? siteCode = jsonConvert.convert<String>(json['siteCode']);
  if (siteCode != null) {
    siteItemEntity.siteCode = siteCode;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    siteItemEntity.name = name;
  }
  final String? label = jsonConvert.convert<String>(json['label']);
  if (label != null) {
    siteItemEntity.label = label;
  }
  final List<StackItemEntity>? stacks = (json['stacks'] as List<dynamic>?)
      ?.map((e) => jsonConvert.convert<StackItemEntity>(e) as StackItemEntity)
      .toList();
  if (stacks != null) {
    siteItemEntity.stacks = stacks;
  }
  return siteItemEntity;
}

Map<String, dynamic> $SiteItemEntityToJson(SiteItemEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['siteId'] = entity.siteId;
  data['siteCode'] = entity.siteCode;
  data['name'] = entity.name;
  data['label'] = entity.label;
  data['stacks'] = entity.stacks?.map((v) => v.toJson()).toList();
  return data;
}

extension SiteItemEntityExtension on SiteItemEntity {
  SiteItemEntity copyWith({
    String? siteId,
    String? siteCode,
    String? name,
    String? label,
    List<StackItemEntity>? stacks,
  }) {
    return SiteItemEntity()
      ..siteId = siteId ?? this.siteId
      ..siteCode = siteCode ?? this.siteCode
      ..name = name ?? this.name
      ..label = label ?? this.label
      ..stacks = stacks ?? this.stacks;
  }
}
