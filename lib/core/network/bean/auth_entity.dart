import 'dart:convert';

import 'package:cesc01/generated/json/auth_entity.g.dart';
import 'package:cesc01/generated/json/base/json_field.dart';

export 'package:cesc01/generated/json/auth_entity.g.dart';

@JsonSerializable()
class AuthEntity {
  String? token;
  String? tokenHeader;
  String? userId;
  String? username;
  String? nickname;
  String? userPhone;
  String? email;
  String? organizationName;
  String? personnelType;
  //ALL
  String? dataScopeType;
  List<String>? roles;
  List<String>? permissions;
  List<String>? assignedSiteIds;
  int? siteCount;

  String get showDisplayName => nickname ?? 'Admin';

  AuthEntity();

  factory AuthEntity.fromJson(Map<String, dynamic> json) =>
      $AuthEntityFromJson(json);

  Map<String, dynamic> toJson() => $AuthEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
