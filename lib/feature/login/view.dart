part of 'index.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final accountCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  bool remember = false;
  bool loading = false;

  bool get _canSubmit =>
      accountCtrl.text.trim().isNotEmpty && passwordCtrl.text.isNotEmpty;

  @override
  void initState() {
    super.initState();
    UserHelper.instance.getAccount().then((account) {
      //debugPrint("UserHelper===>> account:$account");
      safeSetState(() {
        accountCtrl.text = account;
      });
    });
    UserHelper.instance.getPwd().then((psd) {
      //Bearer
      //eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJsb2dpblR5cGUiOiJsb2dpbiIsImxvZ2luSWQiOiJwbGF0Zm9ybTEiLCJyblN0ciI6InVxT3lJMmV6RENJQ0VCT0loVFo4YlNSM0I0VXozMFBDIiwidXNlcklkIjoxLCJ1c2VyTmFtZSI6InBsYXRmb3JtX2FkbWluIiwicG9ydGFsU2NvcGUiOiJQTEFURk9STSJ9.AGSuQ_jgvJrw7OlE0Dp9c7hljM3EpwQ64r7p7hKFSYw
      //debugPrint("UserHelper===>> psd:$psd");
      safeSetState(() {
        remember = psd.isNotEmpty;
        passwordCtrl.text = psd;
      });
    });
  }

  @override
  void dispose() {
    accountCtrl.dispose();
    passwordCtrl.dispose();
    super.dispose();
  }

  Future<void> _login(LoginLogic logic) async {
    if (!_canSubmit || loading) return;
    safeSetState(() => loading = true);
    await Future.delayed(const Duration(milliseconds: 1200));
    if (!mounted) return;
    logic.toLogin(
      account: accountCtrl.text,
      password: passwordCtrl.text,
      remember: remember,
      onComplete: () {
        safeSetState(() => loading = false);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: GetBuilder<LoginLogic>(
            init: LoginLogic(),
            builder: (logic) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Divider(height: 40, color: Colors.transparent),
                  Column(
                    children: [
                      Container(
                        width: 88,
                        height: 88,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(22),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x332C78F4),
                              blurRadius: 20,
                              offset: Offset(0, 8),
                            ),
                          ],
                          border: Border.all(
                            color: const Color(0x59FFFFFF),
                            width: 1,
                          ),
                        ),
                        child: Assets.icon.icLauncher.image(
                          width: 40,
                          height: 40,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        AppInfo.appName,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF172033),
                          letterSpacing: 0.3,
                        ),
                      ),
                    ],
                  ),
                  Divider(height: 36, color: Colors.transparent),
                  LoginInputField(
                    controller: accountCtrl,
                    hintText: LKey.accountHint.tr,
                    prefixIcon: Icons.person_outline_rounded,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    onChanged: (value) => safeSetState(() {}),
                  ),
                  Divider(height: 14, color: Colors.transparent),
                  LoginInputField(
                    controller: passwordCtrl,
                    hintText: LKey.passwordHint.tr,
                    prefixIcon: Icons.lock_outline_rounded,
                    isPassword: true,
                    textInputAction: TextInputAction.done,
                    onChanged: (value) => safeSetState(() {}),
                    onSubmitted: (_) => _login(logic),
                  ),
                  Divider(height: 10, color: Colors.transparent),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      InkWell(
                        onTap: () => safeSetState(() => remember = !remember),
                        child: Row(
                          children: [
                            Icon(
                              remember
                                  ? Icons.check_box
                                  : Icons.check_box_outline_blank,
                              color: remember ? Colors.blue : Colors.black,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              LKey.rememberPassword.tr,
                              style: const TextStyle(
                                fontSize: 13,
                                color: Color(0xFF6F7D92),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                    ],
                  ),
                  Divider(height: 28, color: Colors.transparent),
                  SizedBox(
                    width: double.maxFinite,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: (_canSubmit && !loading)
                          ? () {
                              _login(logic);
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF3978F6),
                        foregroundColor: Colors.white,
                        disabledBackgroundColor: const Color(0xFFAECBFA),
                        disabledForegroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: loading
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeCap: StrokeCap.round,
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : Text(
                              LKey.login.tr,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                    ),
                  ),
                  Divider(height: 18, color: Colors.transparent),
                  PolicyWidget(
                    onPrivacyTap: () {
                      PageTools.toWeb(
                        title: LKey.privacyPolicy.tr,
                        url: AppInfo.privacyPolicy,
                      );
                    },
                    onServiceTap: () {
                      PageTools.toWeb(
                        title: LKey.userAgreement.tr,
                        url: AppInfo.userPolicy,
                      );
                    },
                  ),
                  Divider(height: 24, color: Colors.transparent),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  void safeSetState(VoidCallback fn) {
    if (mounted) setState(fn);
  }
}
