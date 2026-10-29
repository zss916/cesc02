import 'package:cesc01/core/helper/userData/user_data.dart';
import 'package:cesc01/generated/json/base/json_convert_content.dart';

UserData $UserDataFromJson(Map<String, dynamic> json) {
  final UserData userData = UserData();
  final String? token = jsonConvert.convert<String>(json['token']);
  if (token != null) {
    userData.token = token;
  }
  final String? tokenHeader = jsonConvert.convert<String>(json['tokenHeader']);
  if (tokenHeader != null) {
    userData.tokenHeader = tokenHeader;
  }
  final int? userId = jsonConvert.convert<int>(json['userId']);
  if (userId != null) {
    userData.userId = userId;
  }
  final String? username = jsonConvert.convert<String>(json['username']);
  if (username != null) {
    userData.username = username;
  }
  final String? displayName = jsonConvert.convert<String>(json['displayName']);
  if (displayName != null) {
    userData.displayName = displayName;
  }
  final String? personnelType = jsonConvert.convert<String>(
    json['personnelType'],
  );
  if (personnelType != null) {
    userData.personnelType = personnelType;
  }
  final String? dataScopeType = jsonConvert.convert<String>(
    json['dataScopeType'],
  );
  if (dataScopeType != null) {
    userData.dataScopeType = dataScopeType;
  }
  final List<String>? roles = (json['roles'] as List<dynamic>?)
      ?.map((e) => jsonConvert.convert<String>(e) as String)
      .toList();
  if (roles != null) {
    userData.roles = roles;
  }
  final List<String>? permissions = (json['permissions'] as List<dynamic>?)
      ?.map((e) => jsonConvert.convert<String>(e) as String)
      .toList();
  if (permissions != null) {
    userData.permissions = permissions;
  }
  return userData;
}

Map<String, dynamic> $UserDataToJson(UserData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['token'] = entity.token;
  data['tokenHeader'] = entity.tokenHeader;
  data['userId'] = entity.userId;
  data['username'] = entity.username;
  data['displayName'] = entity.displayName;
  data['personnelType'] = entity.personnelType;
  data['dataScopeType'] = entity.dataScopeType;
  data['roles'] = entity.roles;
  data['permissions'] = entity.permissions;
  return data;
}

extension UserDataExtension on UserData {
  UserData copyWith({
    String? token,
    String? tokenHeader,
    int? userId,
    String? username,
    String? displayName,
    String? personnelType,
    String? dataScopeType,
    List<String>? roles,
    List<String>? permissions,
  }) {
    return UserData()
      ..token = token ?? this.token
      ..tokenHeader = tokenHeader ?? this.tokenHeader
      ..userId = userId ?? this.userId
      ..username = username ?? this.username
      ..displayName = displayName ?? this.displayName
      ..personnelType = personnelType ?? this.personnelType
      ..dataScopeType = dataScopeType ?? this.dataScopeType
      ..roles = roles ?? this.roles
      ..permissions = permissions ?? this.permissions;
  }
}
