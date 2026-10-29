import 'package:cesc01/core/helper/app_env.dart';
import 'package:cesc01/core/translations/lan_key.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class AppBarTitle extends StatelessWidget {
  const AppBarTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppInfo.appName,
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w700,
            color: Color(0xFF172033),
            letterSpacing: 0.2,
          ),
        ),
        SizedBox(height: 2),
        Text(
          LKey.brandingTitle.tr,
          style: TextStyle(fontSize: 10, color: Color(0xFF9DB0D2)),
        ),
      ],
    );
  }
}
