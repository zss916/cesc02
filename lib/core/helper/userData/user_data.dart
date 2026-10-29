import 'dart:convert';

import 'package:cesc01/generated/json/base/json_field.dart';
import 'package:cesc01/generated/json/user_data.g.dart';

export 'package:cesc01/generated/json/login_entity.g.dart';

@JsonSerializable()
class UserData {
  String? token;
  String? tokenHeader;
  int? userId;
  String? username;
  String? displayName;
  String? personnelType;
  String? dataScopeType;
  List<String>? roles;
  List<String>? permissions;

  UserData();

  factory UserData.fromJson(Map<String, dynamic> json) =>
      $UserDataFromJson(json);

  Map<String, dynamic> toJson() => $UserDataToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
