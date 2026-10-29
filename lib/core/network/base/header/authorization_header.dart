import 'package:cesc01/core/helper/userData/user_helper.dart';

class AuthorizationHeader {
  static String getAuthorization() => UserHelper.instance.token;
}
