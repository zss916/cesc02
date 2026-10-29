part of 'index.dart';

// ---------- Step 2: 连接设备 ----------
class BuildStepConnect extends StatefulWidget {
  final Function onNext;
  final ProvisionLogic logic;
  final bool bluetoothOpened;
  const BuildStepConnect({
    super.key,
    required this.onNext,
    required this.logic,
    required this.bluetoothOpened,
  });

  @override
  State<BuildStepConnect> createState() => _BuildStepConnectState();
}

class _BuildStepConnectState extends State<BuildStepConnect>
    with AppStateMixin {
  ///扫描中
  bool scanning = true;
  List<BMSItem> snList = [];
  int? checkedIndex;

  @override
  void dispose() {
    super.dispose();
    scanning = false;
    BLEManager.instance.stopScan();
    BLEManager.instance.cancelScanResults();
    BLEManager.instance.cancelScanStateListen();
  }

  @override
  void initState() {
    super.initState();
    onMessageReceived();
    onScanStateListen();
  }

  @override
  Widget build(BuildContext context) {
    return (snList.isNotEmpty)
        ? StepShell(
            icon: Icons.bluetooth_connected_rounded,
            iconColor: widget.bluetoothOpened
                ? const Color(0xFF3978F6)
                : Colors.grey,
            iconBg: const Color(0xFFE8F0FE),
            title: (snList.length >= 2)
                ? LKey.selectConnectDevice.tr
                : LKey.connectDevice.tr,
            desc: '',
            children: [connectDevice()],
          )
        : StepShell(
            icon: Icons.bluetooth_connected_rounded,
            iconColor: widget.bluetoothOpened
                ? const Color(0xFF3978F6)
                : Colors.grey,
            iconBg: const Color(0xFFE8F0FE),
            title: LKey.discoverDevice.tr,
            desc: "",
            //desc: '如果多次扫描不出设备情况:\n1.请重启设备\n2.杀掉App的进程，再重新打开',
            children: [if (scanning) loading else resetDiscoverDevice()],
          );
  }

  Widget connectDevice() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (snList.length == 1)
          DeviceBlueCard(sn: snList.first.sn, connected: false)
        else
          ///多个设备
          buildSNList(snList),
        Divider(height: 22, color: Colors.transparent),
        PrimaryBtn(
          label: LKey.next.tr,
          loading: false,
          onTap: () async {
            showFilterBLEPermissionDialog(
              onSubmit: () {
                BLEManager.instance.stopScan();
                if ((widget.logic.sn ?? "").isEmpty) {
                  AppLoading.toast(LKey.selectDeviceTip.tr);
                  return;
                }
                if ((widget.logic.sn ?? "").isNotEmpty) {
                  safeSetState(() => scanning = false);
                  widget.onNext.call();
                }
              },
            );
          },
        ),
        Divider(height: 30, color: Colors.transparent),
      ],
    );
  }

  Widget buildSNList(List<BMSItem> snList) => SizedBox(
    width: double.maxFinite,
    height: 220,
    child: Scrollbar(
      thumbVisibility: true,
      radius: Radius.circular(10),
      child: ListView.separated(
        padding: EdgeInsetsDirectional.only(
          start: 0,
          end: 0,
          top: 0,
          bottom: 50,
        ),
        shrinkWrap: true,
        itemCount: snList.length,
        separatorBuilder: (_, i) =>
            Divider(height: 5, color: Colors.transparent),
        itemBuilder: (_, i) => GestureDetector(
          onTap: () {
            safeSetState(() {
              checkedIndex = i;
              // snList[i].checked = !snList[i].checked;
              if (snList.isNotEmpty) {
                widget.logic.sn = snList[i].sn;
              }
            });
          },
          child: DeviceBlueCard(
            sn: snList[i].sn,
            connected: false,
            checked: checkedIndex == i,
            // checked: snList[i].checked,
          ),
        ),
      ),
    ),
  );

  ///重新发现设备
  Widget resetDiscoverDevice() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 60),
        PrimaryBtn(
          label: LKey.scanDevice.tr,
          loading: false,
          onTap: () {
            showFilterBLEPermissionDialog(
              onSubmit: () {
                snList.clear();
                BLEManager.instance.toScan();
                safeSetState(() {
                  scanning = true;
                });
              },
            );
          },
        ),
      ],
    );
  }

  ///监听消息
  void onMessageReceived() {
    snList.clear();
    BLEManager.instance.onScanResults(
      onDeviceFound: (Map<String, dynamic> data) {
        List<BMSItem> bmsList = data.entries
            .toList()
            .map((e) => BMSItem(sn: e.key, checked: e.value == true))
            .toList();

        if (bmsList.isNotEmpty) {
          safeSetState(() {
            scanning = false;
            snList.addAll(bmsList);
          });
          if (snList.length == 1) {
            widget.logic.sn = bmsList.first.sn;
          }
        } else {
          safeSetState(() {
            scanning = true;
            snList.clear();
          });
        }
      },
    );
  }

  ///监听扫描状态
  void onScanStateListen() {
    BLEManager.instance.onScanStateListen(
      onStopScan: () {
        safeSetState(() {
          scanning = false;
        });
      },
    );
  }
}
