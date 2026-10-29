import 'package:cesc01/core/translations/lan_key.dart';
import 'package:cesc01/routes/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showBluetoothOffDialog() {
  if (Get.isDialogOpen == true &&
      (Get.containName(ARoute.systemBleTipDialog))) {
    return;
  }
  Get.dialog(
    BluetoothOffDialog(),
    routeSettings: const RouteSettings(name: ARoute.systemBleTipDialog),
  );
}

class BluetoothOffDialog extends StatelessWidget {
  const BluetoothOffDialog({super.key});

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
                          LKey.bluetoothNotTurnedOn.tr,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Center(
                        child: Text(
                          LKey.systemBluetoothTip.tr,
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
                              LKey.iKnow.tr,
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
