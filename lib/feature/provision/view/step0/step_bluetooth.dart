part of 'index.dart';

// ---------- Step 1: 打开蓝牙 ----------
class BuildStepBluetooth extends StatefulWidget {
  final Function() onTap;
  final ProvisionLogic logic;
  final bool bluetoothOpened;
  const BuildStepBluetooth({
    super.key,
    required this.logic,
    required this.onTap,
    required this.bluetoothOpened,
  });

  @override
  State<BuildStepBluetooth> createState() => _BuildStepBluetoothState();
}

class _BuildStepBluetoothState extends State<BuildStepBluetooth>
    with AppStateMixin {
  bool loading = false;
  String keyword = '';
  final snCtr = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    snCtr.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StepShell(
      icon: Icons.bluetooth_rounded,
      iconColor: widget.bluetoothOpened ? const Color(0xFF3978F6) : Colors.grey,
      iconBg: const Color(0xFFE8F0FE),
      title: LKey.openBlue.tr,
      desc: '',
      children: [
        InputSn(snCtr: snCtr, onNext: (value) => keyword = value),
        StatusRow(
          label: LKey.blueStatus.tr,
          value: widget.bluetoothOpened ? LKey.opened.tr : LKey.unopened.tr,
          ok: widget.bluetoothOpened,
          onTap: () {
            ///点击开启
            unawaited(BLEManager.instance.enableBLE());
          },
        ),
        Divider(height: 24, color: Colors.transparent),
        PrimaryBtn(
          label: widget.bluetoothOpened
              ? LKey.next.tr
              : LKey.openBlueAndDiscoverDevice.tr,
          loading: loading,
          onTap: () async {
            keyword = snCtr.text.toString();
            FocusManager.instance.primaryFocus?.unfocus();
            if (keyword.isEmpty) {
              AppLoading.toastBottom(LKey.snHint.tr);
              return;
            }
            safeSetState(() => loading = true);
            await Future.delayed(const Duration(seconds: 1));
            safeSetState(() => loading = false);
            if (widget.bluetoothOpened) {
              bool isAllGranted = await PermissionTools.checkBLEAllPermission();
              if (isAllGranted) {
                BLEManager.instance.keyword = keyword;
                BLEManager.instance.toScan();
                widget.onTap.call();
              } else {
                ///打开BLE权限
                showBLETipDialog(
                  onSubmit: () {
                    BLEManager.instance.keyword = keyword;
                    BLEManager.instance.toScan();
                    widget.onTap.call();
                  },
                );
              }
            } else {
              ///点击开启BLE
              unawaited(BLEManager.instance.enableBLE());
            }
          },
        ),
      ],
    );
  }
}
