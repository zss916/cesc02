import 'package:cesc01/core/helper/app_env.dart';
import 'package:cesc01/core/translations/lan_key.dart';
import 'package:cesc01/generated/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class AppBranding extends StatelessWidget {
  const AppBranding({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 88,
          height: 88,
          decoration: BoxDecoration(
            /*gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF62D5BD), Color(0xFF2C78F4)],
            ),*/
            color: Colors.white,
            borderRadius: BorderRadius.circular(22),
            boxShadow: const [
              BoxShadow(
                color: Color(0x332C78F4),
                blurRadius: 20,
                offset: Offset(0, 8),
              ),
            ],
            border: Border.all(color: const Color(0x59FFFFFF), width: 1),
          ),
          child: Assets.icon.icLauncher.image(width: 40, height: 40),
        ),
        const SizedBox(height: 16),
        Text(
          AppInfo.appName,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w800,
            color: Color(0xFF172033),
            letterSpacing: 0.3,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          LKey.brandingTitle.tr,
          style: TextStyle(fontSize: 13, color: Color(0xFF6F7D92)),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: const Color(0xFFEAF1FF),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            AppInfo.appVersion,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: Color(0xFF3978F6),
            ),
          ),
        ),
      ],
    );
  }
}
