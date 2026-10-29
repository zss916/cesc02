import 'package:cesc01/core/helper/app_loading.dart';
import 'package:cesc01/core/network/base/interceptor/net_status.dart';
import 'package:cesc01/core/network/bean/auth_entity.dart';
import 'package:cesc01/core/network/bean/login_entity.dart';
import 'package:cesc01/core/network/http.dart';
import 'package:cesc01/core/network/path.dart';
import 'package:cesc01/core/translations/lan_key.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

///admin
abstract class AdminAPI {
  ///登录
  static Future<(bool, LoginEntity)> login({
    required String username,
    required String password,
  }) async {
    try {
      var result = await Http.instance.post(
        ApiPath.postLogin,
        data: {"username": username, "password": password},
      );

      if (result["code"] == NetStatus.ok) {
        return (true, LoginEntity.fromJson(result["data"]));
      } else {
        AppLoading.toastBottom(result["message"]);
        return (false, LoginEntity());
      }
    } catch (error) {
      AppLoading.toastBottom(LKey.loginFailed.tr);
      return (false, LoginEntity());
    }
  }

  ///登出
  static Future<bool> logout() async {
    try {
      var result = await Http.instance.post(ApiPath.postLogout);
      if (result["code"] == NetStatus.ok) {
        return true;
      } else {
        AppLoading.toast(result["message"]);
        return false;
      }
    } catch (error) {
      AppLoading.toast(LKey.logoutFailed.tr);
      return false;
    }
  }

  ///获取用户信息
  static Future<(bool, AuthEntity)> getUserInfo() async {
    try {
      var result = await Http.instance.get(ApiPath.getUserInfo);
      if (result["code"] == NetStatus.ok) {
        return (true, AuthEntity.fromJson(result["data"]));
      } else {
        AppLoading.toast(result["message"]);
        return (false, AuthEntity());
      }
    } catch (error) {
      AppLoading.toast(LKey.loadFailedText.tr);
      return (false, AuthEntity());
    }
  }
}
