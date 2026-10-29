import 'package:cesc01/core/helper/app_loading.dart';
import 'package:cesc01/core/helper/device_status.dart';
import 'package:cesc01/core/helper/userData/user_helper.dart';
import 'package:cesc01/core/translations/lan_key.dart';
import 'package:cesc01/routes/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showNotificationDialog({Function? onNext}) {
  Get.dialog(
    NotificationDialog(onNext: onNext),
    barrierColor: Colors.black.withValues(alpha: 0.45),
    routeSettings: RouteSettings(name: ARoute.notifyDialog),
  );
}

class NotificationDialog extends StatefulWidget {
  final Function? onNext;
  const NotificationDialog({super.key, this.onNext});

  @override
  State<NotificationDialog> createState() => _NotificationDialogState();
}

class _NotificationDialogState extends State<NotificationDialog> {
  List<String> get _options => [
    LKey.seriousAlarm.tr,
    LKey.majorAlarmTitle.tr,
    LKey.firmwareUpgrade.tr,
  ];

  bool seriousAlarmCheck = true;
  bool majorAlarmCheck = true;
  bool firmwareUpgradeCheck = true;

  List<String> list = [];

  @override
  void initState() {
    super.initState();
    initData();
  }

  Future<void> initData() async {
    List<dynamic> filterList = UserHelper.instance.getNotifyFilter();
    if (mounted) {
      setState(() {
        seriousAlarmCheck = !filterList.any(
          (e) => e.toString() == MessageLevel.severe.value,
        );
        majorAlarmCheck = !filterList.any(
          (e) => e.toString() == MessageLevel.important.value,
        );
        firmwareUpgradeCheck = !filterList.any(
          (e) => e.toString() == MessageLevel.upgrade.value,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      insetPadding: const EdgeInsets.symmetric(horizontal: 32),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 12, 0),
            child: Row(
              children: [
                Text(
                  LKey.notification.tr,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1A1A1A),
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () => Get.back(),
                  child: const Icon(
                    Icons.close_rounded,
                    size: 20,
                    color: Color(0xFF8A8F99),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Column(
            children: [
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  setState(() {
                    seriousAlarmCheck = !seriousAlarmCheck;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 18,
                  ),
                  child: Row(
                    children: [
                      Text(
                        _options[0],
                        style: const TextStyle(
                          fontSize: 13,
                          color: Color(0xFF1A1A1A),
                        ),
                      ),
                      const Spacer(),
                      Icon(
                        seriousAlarmCheck
                            ? Icons.check_box
                            : Icons.check_box_outline_blank,
                        color: Colors.blue,
                      ),
                    ],
                  ),
                ),
              ),
              const Divider(height: 1, color: Color(0xFFF0F1F3)),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  setState(() {
                    majorAlarmCheck = !majorAlarmCheck;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 18,
                  ),
                  child: Row(
                    children: [
                      Text(
                        _options[1],
                        style: const TextStyle(
                          fontSize: 13,
                          color: Color(0xFF1A1A1A),
                        ),
                      ),
                      const Spacer(),
                      Icon(
                        majorAlarmCheck
                            ? Icons.check_box
                            : Icons.check_box_outline_blank,
                        color: Colors.blue,
                      ),
                    ],
                  ),
                ),
              ),
              const Divider(height: 1, color: Color(0xFFF0F1F3)),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  setState(() {
                    firmwareUpgradeCheck = !firmwareUpgradeCheck;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 18,
                  ),
                  child: Row(
                    children: [
                      Text(
                        _options[2],
                        style: const TextStyle(
                          fontSize: 13,
                          color: Color(0xFF1A1A1A),
                        ),
                      ),
                      const Spacer(),
                      Icon(
                        firmwareUpgradeCheck
                            ? Icons.check_box
                            : Icons.check_box_outline_blank,
                        color: Colors.blue,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),
          Container(
            decoration: const BoxDecoration(
              color: Color(0xFFF7F8FA),
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
            ),
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    if (!seriousAlarmCheck) {
                      list.add(MessageLevel.severe.value);
                    } else {
                      list.removeWhere((e) => e == MessageLevel.severe.value);
                    }

                    if (!majorAlarmCheck) {
                      list.add(MessageLevel.important.value);
                    } else {
                      list.removeWhere(
                        (e) => e == MessageLevel.important.value,
                      );
                    }

                    if (!firmwareUpgradeCheck) {
                      list.add(MessageLevel.upgrade.value);
                    } else {
                      list.removeWhere((e) => e == MessageLevel.upgrade.value);
                    }
                    UserHelper.instance.saveNotifyFilter(value: list).then((_) {
                      Get.back();
                      AppLoading.toastBottom(LKey.setSuccessful.tr);
                    });
                    widget.onNext?.call();
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2E6BFF),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      LKey.saveSetting.tr,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
