import 'package:cesc01/core/components/app_bar_title_widget.dart';
import 'package:cesc01/core/translations/lan_key.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ---------- 顶部导航 ----------
PreferredSizeWidget buildAppBar({
  required Function onPressed,
  required Function onBack,
}) {
  return AppBar(
    backgroundColor: Colors.white,
    elevation: 0,
    scrolledUnderElevation: 0,
    leading: IconButton(
      onPressed: () {
        onPressed.call();
      },
      icon: const Icon(
        Icons.arrow_back_ios_new_rounded,
        size: 20,
        color: Color(0xFF172033),
      ),
    ),
    actions: [
      if (false)
        IconButton(
          onPressed: () {
            onBack.call();
          },
          icon: const Icon(
            Icons.close_rounded,
            size: 22,
            color: Color(0xFF6F7D92),
          ),
        ),
    ],
    title: AppBarTitleWidget(title: LKey.deviceSetting.tr),
    centerTitle: true,
  );
}
