import 'dart:convert';

import 'package:cesc01/generated/json/base/json_field.dart';
import 'package:cesc01/generated/json/login_entity.g.dart';

export 'package:cesc01/generated/json/login_entity.g.dart';

@JsonSerializable()
class LoginEntity {
  String? token;
  String? tokenHeader;
  String? userId;
  String? username;
  String? displayName;
  String? personnelType;
  String? dataScopeType;
  String? organizationName;
  List<String>? roles;
  List<String>? permissions;

  String get getTokenHeader => tokenHeader ?? "";
  String get getToken => token ?? "";

  LoginEntity();

  factory LoginEntity.fromJson(Map<String, dynamic> json) =>
      $LoginEntityFromJson(json);

  Map<String, dynamic> toJson() => $LoginEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
