part of 'index.dart';

class LoginLogic extends BaseNetConnectLogic {
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  @override
  void onReady() {
    super.onReady();
  }

  Future<void> toLogin({
    required bool remember,
    required String? account,
    required String? password,
    Function? onComplete,
  }) async {
    loadData(
      onIntercept: () {
        onComplete?.call();
      },
      onFetch: () {
        fetchLoginApi(
          remember: remember,
          account: account,
          password: password,
          onComplete: onComplete,
        );
      },
    );
  }

  Future<void> fetchLoginApi({
    required bool remember,
    required String? account,
    required String? password,
    Function? onComplete,
  }) async {
    LogUtil.print("toLogin", "account:$account,password:$password");

    if ((account ?? "").trim().isEmpty) {
      AppLoading.toastBottom(LKey.accountHint.tr);
      onComplete?.call();
      return;
    }

    if ((password ?? "").trim().isEmpty) {
      AppLoading.toastBottom(LKey.passwordHint.tr);
      onComplete?.call();
      return;
    }

    final (
      bool isSuccessful,
      LoginEntity value,
    ) = await AdminAPI.login(username: account ?? "", password: password ?? "")
        .whenComplete(() {
          onComplete?.call();
        });

    if (isSuccessful) {
      await UserHelper.instance.setToken(
        tokenHead: value.getTokenHeader,
        token: value.getToken,
      );
      await UserHelper.instance.setAccount(account: (account ?? ""));
      if (remember) {
        UserHelper.instance.setPwd(pwd: password ?? "");
      } else {
        UserHelper.instance.removePwd();
      }
      PageTools.toMain();
    }
  }
}
