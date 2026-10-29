part of 'index.dart';

class MineLogic extends BaseNetConnectLogic {
  AuthEntity? auth;
  String get name => auth?.showDisplayName ?? "Admin";
  String get userType => auth?.personnelType?.type ?? "--";
  String get organization => auth?.organizationName ?? "--";
  String get authSiteCount =>
      (auth?.siteCount == null) ? '-' : '${auth?.siteCount ?? 0}';
  bool? isOpenNotify;

  @override
  void onInit() {
    super.onInit();
    initCacheData();
  }

  @override
  void onClose() {
    super.onClose();
  }

  @override
  void onReady() {
    super.onReady();
    loadData(
      onFetch: () {
        fetchDataApi();
      },
    );
  }

  void initCacheData() async {
    isOpenNotify = UserHelper.instance.isOpenNotify;
    auth = await UserHelper.instance.getUserData();
    update();
  }

  Future<void> toLogout() async {
    loadData(
      onFetch: () {
        fetchLogoutApi();
      },
    );
  }

  void toOrganization(String value) {
    showOrgDialog(value: value);
  }

  void toAuth(String value) {
    showAuthScopeDialog(value: value);
  }

  void toNotify() {
    // PageTools.toNotify();
    showNotificationDialog(
      onNext: () {
        isOpenNotify = UserHelper.instance.isOpenNotify;
        update();
      },
    );
  }

  void toVersion() {
    PageTools.toAbout();
  }

  Future<void> fetchDataApi() async {
    final (bool isSuccessful, AuthEntity authResult) =
        await AdminAPI.getUserInfo();
    if (isSuccessful) {
      UserHelper.instance.setUserData(data: authResult);
      auth = authResult;
      update();
    }
  }

  Future<void> fetchLogoutApi() async {
    bool isSuccessful = await AdminAPI.logout();
    if (isSuccessful) {
      await UserHelper.instance.logOff();
      PageTools.toLogout();
    }
  }
}
