part of 'index.dart';

// ---------- Step 3: 配网初始化 ----------
class BuildStepConfig extends StatefulWidget {
  final Function onNext;
  final ProvisionLogic logic;
  const BuildStepConfig({super.key, required this.onNext, required this.logic});

  @override
  State<BuildStepConfig> createState() => _BuildStepConfigState();
}

class _BuildStepConfigState extends State<BuildStepConfig>
    with StateSheetCtrl, AppStateMixin {
  final wifiNameCtr = TextEditingController();
  final wifiPwdCtr = TextEditingController();
  bool initializing = false;
  bool initialized = false;
  bool obscureText = true;

  @override
  void initState() {
    super.initState();
    initData();
    onMessageReceived();
  }

  @override
  void dispose() {
    SmartBleLinkTools.instance.cancelEvent();
    SmartBleLinkTools.instance.stopLinking();
    wifiNameCtr.dispose();
    wifiPwdCtr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StepShell(
      icon: Icons.wifi_rounded,
      iconColor: const Color(0xFF34C759),
      iconBg: const Color(0xFFE7F8EE),
      title: LKey.setWifi.tr,
      desc: LKey.wifiType.tr,
      descTextStyle: TextStyle(fontSize: 11, color: Colors.red, height: 1.5),
      children: [
        FieldLabel(LKey.wifiName.tr),
        TextField(
          controller: wifiNameCtr,
          style: const TextStyle(fontSize: 14, color: Color(0xFF172033)),
          cursorColor: const Color(0xFF3978F6),
          decoration: inputDecoration(hint: LKey.enterWiFiName.tr),
          onTapOutside: (_) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          onSubmitted: (_) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
        ),
        Divider(height: 14, color: Colors.transparent),
        FieldLabel(LKey.wifiPassword.tr),
        TextField(
          controller: wifiPwdCtr,
          obscureText: obscureText,
          style: const TextStyle(fontSize: 14, color: Color(0xFF172033)),
          cursorColor: const Color(0xFF3978F6),
          decoration: inputPsdDecoration(
            hint: LKey.enterWiFiPassword.tr,
            suffixIcon: GestureDetector(
              onTap: () {
                safeSetState(() => obscureText = !obscureText);
              },
              child: Icon(
                obscureText ? Icons.visibility_off : Icons.visibility,
              ),
            ),
          ),
          onTapOutside: (_) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          onSubmitted: (_) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
        ),
        Divider(height: 14, color: Colors.transparent),
        StatusRow(
          label: LKey.initialStatus.tr,
          value: initialized
              ? LKey.completed.tr
              : (initializing ? LKey.progressing.tr : LKey.toBeStarted.tr),
          ok: initialized,
          doing: initializing,
        ),
        Divider(height: 20, color: Colors.transparent),
        PrimaryBtn(
          label: initialized ? LKey.completedAndNet.tr : LKey.setNetInitial.tr,
          loading: initializing,
          onTap: initialized
              ? () {
                  widget.onNext.call();
                }
              : () async {
                  showFilterBLEPermissionDialog(
                    onSubmit: () {
                      safeSetState(() => initializing = true);
                      toConnectWifi();
                    },
                  );
                },
        ),
      ],
    );
  }

  ///连接wifi
  void toConnectWifi() {
    String wifiName = wifiNameCtr.text;
    if (wifiName.isEmpty) {
      AppLoading.toast(LKey.enterWiFiName.tr);
      safeSetState(() {
        initializing = false;
        initialized = false;
      });
      return;
    }
    String password = wifiPwdCtr.text;
    if (password.isEmpty) {
      AppLoading.toast(LKey.enterWiFiPassword.tr);
      safeSetState(() {
        initializing = false;
        initialized = false;
      });
      return;
    }

    SmartBleLinkTools.instance.startLinking(
      ssid: wifiName,
      password: password,
      bleName: widget.logic.sn ?? "",
      onError: () {
        safeSetState(() {
          initializing = false;
          initialized = false;
        });
      },
    );
  }

  Future<void> initData() async {
    await SmartBleLinkTools.instance.isBleEnabled();
    String? ssid = await SmartBleLinkTools.instance.getSsid();
    safeSetState(() {
      wifiNameCtr.text = ssid ?? "";
    });
  }

  void onMessageReceived() {
    SmartBleLinkTools.instance.onEventListen(
      onSSIDEvent: (value) {
        safeSetState(() {
          wifiNameCtr.text = value ?? "";
        });
      },
      onTimeOutEvent: () {
        toShowTimeOut();
        safeSetState(() {
          initializing = false;
          initialized = false;
        });
      },
      onLinkedEvent: () {
        toShowSuccess();
        safeSetState(() {
          initializing = false;
          initialized = true;
        });
      },
      onErrorEvent: (value) {
        toShowError(error: value);
        safeSetState(() {
          initializing = false;
          initialized = false;
        });
      },
      onFinishEvent: () {
        safeSetState(() {
          initializing = false;
          //initialized = true;
        });
      },
    );
  }
}
