import 'package:cesc01/core/helper/userData/recently_data.dart';
import 'package:cesc01/core/network/bean/auth_entity.dart';
import 'package:cesc01/core/system/util/storage/secure_storage.dart';
import 'package:cesc01/core/system/util/storage/storage_util.dart';

class UserHelper {
  static final UserHelper _instance = UserHelper._internal();
  static UserHelper get instance => UserHelper();
  factory UserHelper() => _instance;
  UserHelper._internal();

  final String accountKey = "coreAccountKey";
  final String passwordKey = "corePasswordKey";
  final String loginKey = "coreLoginKey";
  final String tokenKey = "coreTokenKey";
  final String userDataKey = "coreUserDataKey";
  final String checkListKey = "coreCheckListKey";
  final String recentlyViewedKey = "recentlyViewedKey";

  ///通知
  List<dynamic> getNotifyFilter() => StorageUtil.getListObject(checkListKey);

  ///保存过滤通知类型
  Future<void> saveNotifyFilter({required List<String> value}) async {
    await StorageUtil.setListObject(checkListKey, value);
  }

  bool get isOpenNotify => getNotifyFilter().length != 3;

  ///保存用户信息
  Future<void> setUserData({required dynamic data}) async {
    await StorageUtil.setObject(userDataKey, data);
  }

  ///获取用户信息
  Future<AuthEntity?> getUserData() async {
    final value = StorageUtil.getObject(userDataKey);
    try {
      return AuthEntity.fromJson(value);
    } catch (e) {
      return null;
    }
  }

  ///保存用token
  Future<void> setToken({
    required String tokenHead,
    required String token,
  }) async {
    await StorageUtil.setString(tokenKey, '$tokenHead $token');
  }

  ///请求头token
  String get token => StorageUtil.getString(tokenKey);

  ///删除token
  Future<void> removeToken() async {
    await StorageUtil.delete(tokenKey);
  }

  ///保存账号
  Future<void> setAccount({required String account}) async {
    await SecureStorage.to.save(accountKey, account);
  }

  ///保存密码
  void setPwd({required String pwd}) => SecureStorage.to.save(passwordKey, pwd);

  ///获取账号
  Future<String> getAccount() async {
    String? account = await SecureStorage.to.get(accountKey);
    return account ?? "";
  }

  ///获取密码
  Future<String> getPwd() async {
    String? pwd = await SecureStorage.to.get(passwordKey);
    return pwd ?? "";
  }

  ///删除账号
  void removeAccount() => SecureStorage.to.remove(accountKey);

  ///删除密码
  void removePwd() => SecureStorage.to.remove(passwordKey);

  ///是否登录
  bool get isLoginIn => isHasToken;

  ///是否有用户信息
  bool get isHasToken => token.isNotEmpty;

  ///注销本地数据
  Future<void> logOff() async {
    await removeToken();
    //removeAccount();
    //removePwd();
  }

  ///保存最近查看
  Future<void> setRecentlyViewed({
    String? siteId,
    String? siteName,
    String? countryRegion,
    String? commStatus,
  }) async {
    RecentlyData value = RecentlyData()
      ..siteId = siteId
      ..siteName = siteName
      ..countryRegion = countryRegion
      ..commStatus = commStatus;
    AuthEntity? auth = await getUserData();
    await StorageUtil.setObject(
      "$recentlyViewedKey${auth?.userId}",
      value.toJson(),
    );
  }

  Future<RecentlyData?> getRecentlyViewed() async {
    AuthEntity? auth = await getUserData();
    Map<String, dynamic> value = StorageUtil.getObject(
      "$recentlyViewedKey${auth?.userId}",
    );
    try {
      return RecentlyData.fromJson(value);
    } catch (e) {
      return null;
    }
  }
}
