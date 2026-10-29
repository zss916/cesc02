import 'package:cesc01/core/network/bean/login_entity.dart';
import 'package:cesc01/generated/json/base/json_convert_content.dart';

LoginEntity $LoginEntityFromJson(Map<String, dynamic> json) {
  final LoginEntity loginEntity = LoginEntity();
  final String? token = jsonConvert.convert<String>(json['token']);
  if (token != null) {
    loginEntity.token = token;
  }
  final String? tokenHeader = jsonConvert.convert<String>(json['tokenHeader']);
  if (tokenHeader != null) {
    loginEntity.tokenHeader = tokenHeader;
  }
  final String? userId = jsonConvert.convert<String>(json['userId']);
  if (userId != null) {
    loginEntity.userId = userId;
  }
  final String? username = jsonConvert.convert<String>(json['username']);
  if (username != null) {
    loginEntity.username = username;
  }
  final String? displayName = jsonConvert.convert<String>(json['displayName']);
  if (displayName != null) {
    loginEntity.displayName = displayName;
  }
  final String? personnelType = jsonConvert.convert<String>(
    json['personnelType'],
  );
  if (personnelType != null) {
    loginEntity.personnelType = personnelType;
  }
  final String? dataScopeType = jsonConvert.convert<String>(
    json['dataScopeType'],
  );
  if (dataScopeType != null) {
    loginEntity.dataScopeType = dataScopeType;
  }
  final String? organizationName = jsonConvert.convert<String>(
    json['organizationName'],
  );
  if (organizationName != null) {
    loginEntity.organizationName = organizationName;
  }
  final List<String>? roles = (json['roles'] as List<dynamic>?)
      ?.map((e) => jsonConvert.convert<String>(e) as String)
      .toList();
  if (roles != null) {
    loginEntity.roles = roles;
  }
  final List<String>? permissions = (json['permissions'] as List<dynamic>?)
      ?.map((e) => jsonConvert.convert<String>(e) as String)
      .toList();
  if (permissions != null) {
    loginEntity.permissions = permissions;
  }
  return loginEntity;
}

Map<String, dynamic> $LoginEntityToJson(LoginEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['token'] = entity.token;
  data['tokenHeader'] = entity.tokenHeader;
  data['userId'] = entity.userId;
  data['username'] = entity.username;
  data['displayName'] = entity.displayName;
  data['personnelType'] = entity.personnelType;
  data['dataScopeType'] = entity.dataScopeType;
  data['organizationName'] = entity.organizationName;
  data['roles'] = entity.roles;
  data['permissions'] = entity.permissions;
  return data;
}

extension LoginEntityExtension on LoginEntity {
  LoginEntity copyWith({
    String? token,
    String? tokenHeader,
    String? userId,
    String? username,
    String? displayName,
    String? personnelType,
    String? dataScopeType,
    String? organizationName,
    List<String>? roles,
    List<String>? permissions,
  }) {
    return LoginEntity()
      ..token = token ?? this.token
      ..tokenHeader = tokenHeader ?? this.tokenHeader
      ..userId = userId ?? this.userId
      ..username = username ?? this.username
      ..displayName = displayName ?? this.displayName
      ..personnelType = personnelType ?? this.personnelType
      ..dataScopeType = dataScopeType ?? this.dataScopeType
      ..organizationName = organizationName ?? this.organizationName
      ..roles = roles ?? this.roles
      ..permissions = permissions ?? this.permissions;
  }
}
