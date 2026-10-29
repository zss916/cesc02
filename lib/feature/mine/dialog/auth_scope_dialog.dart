import 'package:cesc01/core/translations/lan_key.dart';
import 'package:cesc01/routes/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showAuthScopeDialog({required String value}) {
  Get.dialog(
    AuthScopeDialog(value: value),
    barrierColor: Colors.black.withValues(alpha: 0.45),
    routeSettings: RouteSettings(name: ARoute.authScopeDialog),
  );
}

class AuthScopeDialog extends StatelessWidget {
  final String value;
  const AuthScopeDialog({super.key, required this.value});

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
                  LKey.authorization.tr,
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
          const SizedBox(height: 28),
          Center(
            child: Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: const Color(0xFFFEF1E1),
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Icon(
                Icons.admin_panel_settings_rounded,
                size: 28,
                color: Color(0xFFEF8F32),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Center(
            child: Text(
              LKey.siteCountContent.trArgs([value]),
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1A1A1A),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              LKey.authSiteContent.trArgs([value]),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: Color(0xFF8A8F99),
                height: 1.5,
              ),
            ),
          ),
          const SizedBox(height: 24),
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
                  onTap: () => Get.back(),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xFFE3E5E8)),
                    ),
                    child: Text(
                      LKey.iKnow.tr,
                      style: TextStyle(fontSize: 13, color: Color(0xFF4A5160)),
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
