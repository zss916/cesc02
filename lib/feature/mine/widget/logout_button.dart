import 'package:cesc01/core/translations/lan_key.dart';
import 'package:cesc01/feature/mine/dialog/logout_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LogoutButton extends StatelessWidget {
  final VoidCallback onLogout;
  const LogoutButton({super.key, required this.onLogout});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: OutlinedButton(
        onPressed: () {
          showLogoutConfirmDialog(onLogout: onLogout);
        },
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Color(0xFFE75252)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          LKey.logout.tr,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Color(0xFFE75252),
          ),
        ),
      ),
    );
  }
}
