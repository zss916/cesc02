part of 'index.dart';

/// 设备配网
class ProvisionPage extends StatefulWidget {
  const ProvisionPage({super.key});

  @override
  State<ProvisionPage> createState() => _ProvisionPageState();
}

class _ProvisionPageState extends State<ProvisionPage> with AppStateMixin {
  int step = 0;

  ///系统蓝牙
  bool bluetoothOpened = false;

  @override
  void initState() {
    super.initState();
    BLEManager.instance.getSystemBLEState().then((isOn) {
      safeSetState(() => bluetoothOpened = isOn);
    });
    BLEManager.instance.onSystemBLEStateStream(
      onState: (bool isOn) {
        safeSetState(() => bluetoothOpened = isOn);
      },
    );
    WakelockPlus.enable();
  }

  @override
  void dispose() {
    WakelockPlus.disable();
    super.dispose();
    BLEManager.instance.cancelSystemBLEStateStream();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: GetBuilder<ProvisionLogic>(
        init: ProvisionLogic(),
        builder: (logic) {
          return Scaffold(
            backgroundColor: const Color(0xFFF2F5FB),
            appBar: buildAppBar(
              onBack: () {
                SmartBleLinkTools.instance.stopLinking();
                Get.back<void>();
              },
              onPressed: () {
                SmartBleLinkTools.instance.stopLinking();
                Get.back<void>();
              },
            ),
            body: Column(
              children: [
                StepIndicator(step: step),
                Expanded(
                  child: SingleChildScrollView(
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 20,
                    ),
                    child: GetBuilder<ProvisionLogic>(
                      init: ProvisionLogic(),
                      builder: (logic) {
                        //return BuildStepConfig(onNext: () {}, logic: logic);
                        /*return BuildStepConnect(
                          onNext: () {},
                          logic: logic,
                          bluetoothOpened: true,
                        );*/
                        //return BuildStepSite(logic: logic);
                        return buildBody(stepIndex: step, logic: logic);
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget buildBody({required int stepIndex, required ProvisionLogic logic}) {
    switch (stepIndex) {
      case 0:
        return BuildStepBluetooth(
          bluetoothOpened: bluetoothOpened,
          logic: logic,
          onTap: () {
            safeSetState(() => step = 1);
          },
        );
      case 1:
        return AppKeepAlivePage(
          BuildStepConnect(
            bluetoothOpened: bluetoothOpened,
            logic: logic,
            onNext: () {
              safeSetState(() => step = 2);
            },
          ),
        );
      case 2:
        return BuildStepConfig(
          logic: logic,
          onNext: () {
            safeSetState(() => step = 3);
          },
        );
      case 3:
        return BuildStepSite(logic: logic);
      default:
        return const SizedBox.shrink();
    }
  }
}
