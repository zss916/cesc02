import 'package:cesc01/core/permission/ble_manager.dart';
import 'package:cesc01/core/permission/permission_tools.dart';
import 'package:cesc01/core/translations/lan_key.dart';
import 'package:cesc01/feature/provision/helper/smart_ble_link_tools.dart';
import 'package:cesc01/routes/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> showFilterBLEPermissionDialog({
  required Function() onSubmit,
}) async {
  bool isAllGranted = await PermissionTools.checkBLEAllPermission();
  bool isRequest = await SmartBleLinkTools.instance.requestPermissions();
  if (isAllGranted && isRequest) {
    onSubmit.call();
  } else {
    if (Get.isDialogOpen == true &&
        (Get.containName(ARoute.blePermissionTipDialog))) {
      debugPrint("权限弹窗已经打开");
      return;
    }
    String content = await getContent();
    Get.dialog(
      BluePermissionTipDialog(content: content, onSubmit: onSubmit),
      routeSettings: const RouteSettings(name: ARoute.blePermissionTipDialog),
    );
  }
}

Future<void> showBLETipDialog({required Function() onSubmit}) async {
  if (Get.isDialogOpen == true &&
      (Get.containName(ARoute.blePermissionTipDialog))) {
    debugPrint("权限弹窗已经打开");
    return;
  }
  String content = await getContent();
  Get.dialog(
    BluePermissionTipDialog(content: content, onSubmit: onSubmit),
    routeSettings: const RouteSettings(name: ARoute.blePermissionTipDialog),
  );
}

class BluePermissionTipDialog extends StatelessWidget {
  final String content;
  final Function() onSubmit;

  const BluePermissionTipDialog({
    super.key,
    required this.content,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Container(
          width: double.maxFinite,
          margin: EdgeInsetsDirectional.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: Color(0xFF1F1F1F),
            borderRadius: BorderRadius.circular(16),
          ),
          child: IntrinsicHeight(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        child: Text(
                          LKey.applyPermission.tr,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Center(
                        child: Text(
                          content,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(color: Color(0xFF2F2F2F), width: 1),
                    ),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => Get.back(),
                          child: Container(
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(16),
                              ),
                            ),
                            child: Text(
                              LKey.cancel.tr,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () async {
                            Get.back();
                            bool isOpen =
                                await PermissionTools.openBlueAllPermission();

                            if (isOpen) {
                              toHand(
                                onNext: () {
                                  onSubmit.call();
                                },
                              );
                            } else {
                              toHand(
                                onNext: () {
                                  BLEManager.instance.toOpenAppSetting();
                                },
                              );
                            }
                          },
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border(
                                left: BorderSide(
                                  color: Color(0xFF2F2F2F),
                                  width: 1,
                                ),
                              ),
                              borderRadius: const BorderRadius.only(
                                bottomRight: Radius.circular(16),
                              ),
                            ),
                            child: Text(
                              LKey.confirm.tr,
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

///获取文案
Future<String> getContent() async {
  bool isCheckLocationService = await PermissionTools.checkLocationService();
  bool isCheckSystemBluetooth = await PermissionTools.checkSystemBluetooth();
  bool isLocationGranted = await PermissionTools.isGrantedLocation();
  bool isBluetoothScan = await PermissionTools.isGrantedBluetoothScan();
  return LKey.bluetoothPermissionTip
      .trArgs([
        isCheckSystemBluetooth ? "" : LKey.systemBlue.tr,
        isCheckLocationService ? "" : LKey.locationService.tr,
        isLocationGranted ? "" : LKey.locationPermission.tr.tr,
        isBluetoothScan ? "" : LKey.bluetoothNeedPermission.tr,
      ])
      .trim()
      .replaceAll(" ", "、")
      .trim();
}

Future<void> toHand({Function? onNext}) async {
  bool isCheckLocationService = await PermissionTools.checkLocationService();
  if (!isCheckLocationService) {
    ///打开定位服务
    BLEManager.instance.openLocationSettings();
    return;
  }

  bool isCheckSystemBluetooth = await PermissionTools.checkSystemBluetooth();
  if (!isCheckSystemBluetooth) {
    ///系统蓝牙
    BLEManager.instance.enableBLE();
    return;
  }
  onNext?.call();
}
