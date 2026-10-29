import 'package:cesc01/core/translations/lan_key.dart';
import 'package:cesc01/routes/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

void showLogoutConfirmDialog({required VoidCallback onLogout}) {
  Get.dialog(
    LogoutConfirmDialog(onLogout: onLogout),
    routeSettings: RouteSettings(name: ARoute.logoutDialog),
  );
}

class LogoutConfirmDialog extends StatelessWidget {
  final VoidCallback onLogout;

  const LogoutConfirmDialog({super.key, required this.onLogout});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 32),
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: const [
            BoxShadow(
              color: Color(0x33172033),
              blurRadius: 32,
              offset: Offset(0, 16),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // 顶部红色警示图标
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: const Color(0x1AE75252),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.logout_rounded,
                  color: Color(0xFFE75252),
                  size: 26,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                LKey.logoutTipTitle.tr,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF172033),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                LKey.logoutTipContent.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  color: Color(0xFF6F7D92),
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 22),
              Row(
                children: [
                  // 取消
                  Expanded(
                    child: SizedBox(
                      height: 44,
                      child: OutlinedButton(
                        onPressed: () => Get.back<void>(),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Color(0xFFE3E9F2)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          LKey.cancel.tr,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF5B6B85),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // 确认退出
                  Expanded(
                    child: SizedBox(
                      height: 44,
                      child: ElevatedButton(
                        onPressed: () {
                          Get.back<void>();
                          onLogout.call();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFE75252),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          LKey.confirm.tr,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
