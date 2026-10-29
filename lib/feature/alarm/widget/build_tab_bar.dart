import 'package:cesc01/core/translations/lan_key.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class BuildTabBar extends StatelessWidget {
  const BuildTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsetsDirectional.only(start: 16, end: 16, bottom: 5),
      height: 44,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TabBar(
        // 两个 Tab 平分
        isScrollable: false,

        // 去掉底部 Divider
        dividerColor: Colors.transparent,

        // 去掉默认 indicator
        indicator: BoxDecoration(
          color: Color(0xFF3978F6),
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 3,
              offset: const Offset(0, 1),
            ),
          ],
        ),

        // indicator 左右留一点间距
        indicatorPadding: EdgeInsets.zero,

        // 文字颜色
        labelColor: Colors.white,
        unselectedLabelColor: const Color(0xFF6B7280),

        // 文字大小
        labelStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
        unselectedLabelStyle: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
        ),

        // Tab 内边距
        labelPadding: EdgeInsets.zero,

        // 点击没有水波纹
        splashFactory: NoSplash.splashFactory,
        overlayColor: const WidgetStatePropertyAll(Colors.transparent),

        tabs: [
          Tab(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text.rich(
                  TextSpan(
                    text: LKey.realAlarm.tr,
                    children: [
                      TextSpan(text: '', style: const TextStyle(fontSize: 13)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Tab(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text.rich(
                  TextSpan(
                    text: LKey.historyAlarm.tr,
                    children: [
                      TextSpan(text: '', style: const TextStyle(fontSize: 13)),
                    ],
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
