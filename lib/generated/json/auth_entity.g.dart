import 'package:cesc01/core/network/bean/auth_entity.dart';
import 'package:cesc01/generated/json/base/json_convert_content.dart';

AuthEntity $AuthEntityFromJson(Map<String, dynamic> json) {
  final AuthEntity authEntity = AuthEntity();
  final String? token = jsonConvert.convert<String>(json['token']);
  if (token != null) {
    authEntity.token = token;
  }
  final String? tokenHeader = jsonConvert.convert<String>(json['tokenHeader']);
  if (tokenHeader != null) {
    authEntity.tokenHeader = tokenHeader;
  }
  final String? userId = jsonConvert.convert<String>(json['userId']);
  if (userId != null) {
    authEntity.userId = userId;
  }
  final String? username = jsonConvert.convert<String>(json['username']);
  if (username != null) {
    authEntity.username = username;
  }
  final String? nickname = jsonConvert.convert<String>(json['nickname']);
  if (nickname != null) {
    authEntity.nickname = nickname;
  }
  final String? userPhone = jsonConvert.convert<String>(json['userPhone']);
  if (userPhone != null) {
    authEntity.userPhone = userPhone;
  }
  final String? email = jsonConvert.convert<String>(json['email']);
  if (email != null) {
    authEntity.email = email;
  }
  final String? organizationName = jsonConvert.convert<String>(
    json['organizationName'],
  );
  if (organizationName != null) {
    authEntity.organizationName = organizationName;
  }
  final String? personnelType = jsonConvert.convert<String>(
    json['personnelType'],
  );
  if (personnelType != null) {
    authEntity.personnelType = personnelType;
  }
  final String? dataScopeType = jsonConvert.convert<String>(
    json['dataScopeType'],
  );
  if (dataScopeType != null) {
    authEntity.dataScopeType = dataScopeType;
  }
  final List<String>? roles = (json['roles'] as List<dynamic>?)
      ?.map((e) => jsonConvert.convert<String>(e) as String)
      .toList();
  if (roles != null) {
    authEntity.roles = roles;
  }
  final List<String>? permissions = (json['permissions'] as List<dynamic>?)
      ?.map((e) => jsonConvert.convert<String>(e) as String)
      .toList();
  if (permissions != null) {
    authEntity.permissions = permissions;
  }
  final List<String>? assignedSiteIds =
      (json['assignedSiteIds'] as List<dynamic>?)
          ?.map((e) => jsonConvert.convert<String>(e) as String)
          .toList();
  if (assignedSiteIds != null) {
    authEntity.assignedSiteIds = assignedSiteIds;
  }
  final int? siteCount = jsonConvert.convert<int>(json['siteCount']);
  if (siteCount != null) {
    authEntity.siteCount = siteCount;
  }
  return authEntity;
}

Map<String, dynamic> $AuthEntityToJson(AuthEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['token'] = entity.token;
  data['tokenHeader'] = entity.tokenHeader;
  data['userId'] = entity.userId;
  data['username'] = entity.username;
  data['nickname'] = entity.nickname;
  data['userPhone'] = entity.userPhone;
  data['email'] = entity.email;
  data['organizationName'] = entity.organizationName;
  data['personnelType'] = entity.personnelType;
  data['dataScopeType'] = entity.dataScopeType;
  data['roles'] = entity.roles;
  data['permissions'] = entity.permissions;
  data['assignedSiteIds'] = entity.assignedSiteIds;
  data['siteCount'] = entity.siteCount;
  return data;
}

extension AuthEntityExtension on AuthEntity {
  AuthEntity copyWith({
    String? token,
    String? tokenHeader,
    String? userId,
    String? username,
    String? nickname,
    String? userPhone,
    String? email,
    String? organizationName,
    String? personnelType,
    String? dataScopeType,
    List<String>? roles,
    List<String>? permissions,
    List<String>? assignedSiteIds,
    int? siteCount,
  }) {
    return AuthEntity()
      ..token = token ?? this.token
      ..tokenHeader = tokenHeader ?? this.tokenHeader
      ..userId = userId ?? this.userId
      ..username = username ?? this.username
      ..nickname = nickname ?? this.nickname
      ..userPhone = userPhone ?? this.userPhone
      ..email = email ?? this.email
      ..organizationName = organizationName ?? this.organizationName
      ..personnelType = personnelType ?? this.personnelType
      ..dataScopeType = dataScopeType ?? this.dataScopeType
      ..roles = roles ?? this.roles
      ..permissions = permissions ?? this.permissions
      ..assignedSiteIds = assignedSiteIds ?? this.assignedSiteIds
      ..siteCount = siteCount ?? this.siteCount;
  }
}
