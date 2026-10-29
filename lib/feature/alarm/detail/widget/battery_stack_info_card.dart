import 'package:cesc01/core/event/app_event_bus.dart';
import 'package:cesc01/core/translations/lan_key.dart';
import 'package:cesc01/feature/alarm/detail/index.dart';
import 'package:cesc01/feature/station/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

/// 电池堆信息卡片
///
/// 展示「所属站点 → 电池堆」的层级关系，包含名称与编号，底部附告警统计摘要。
class BatteryStackInfoCard extends StatelessWidget {
  final String siteName;
  final String siteCode;
  final String stackName;
  final String stackSn;
  final int alarmClusterCount;
  final int alarmCount;
  final String? siteId;

  const BatteryStackInfoCard({
    super.key,
    required this.siteId,
    required this.siteName,
    required this.siteCode,
    required this.stackName,
    required this.stackSn,
    this.alarmClusterCount = 0,
    this.alarmCount = 0,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      width: double.maxFinite,
      margin: const EdgeInsetsDirectional.symmetric(
        horizontal: 15,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.white, Color(0xFFF7F9FC)],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
          BoxShadow(
            color: colorScheme.primary.withValues(alpha: 0.06),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Column(
          children: [
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  ///todo 去单站详情
                  if (siteId != null) {
                    Get.back();
                    if (Get.find<StackAlarmDetailLogic>().isMessage == true) {
                      Get.back();
                    }
                    AppEventBus.eventBus.fire(MainPageEvent(select: 2));
                    Get.find<StationLogic>().siteId = siteId ?? "";
                    Get.find<StationLogic>().refreshStation(loading: true);
                  }
                },
                child: _InfoRow(
                  icon: Icons.location_on_outlined,
                  iconColor: const Color(0xFF34C759),
                  iconBg: const Color(0xFF34C759).withValues(alpha: 0.10),
                  label: LKey.affiliatedSite.tr,
                  value: siteName,
                  code: siteCode,
                  isLast: false,
                  isArrow: true,
                ),
              ),
            ),
            const Divider(
              height: 1,
              thickness: 1,
              color: Color(0xFFEDF0F4),
              indent: 16,
              endIndent: 16,
            ),
            _InfoRow(
              icon: Icons.bolt_rounded,
              iconColor: const Color(0xFFFF9F0A),
              iconBg: const Color(0xFFFF9F0A).withValues(alpha: 0.12),
              label: LKey.batteryStack.tr,
              value: stackName,
              code: stackSn,
              isLast: false,
            ),
            const Divider(
              height: 1,
              thickness: 1,
              color: Color(0xFFEDF0F4),
              indent: 16,
              endIndent: 16,
            ),
            // 告警统计摘要
            Container(
              width: double.maxFinite,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    const Color(0xFFFFF9EE),
                    const Color(0xFFFFF4E0).withValues(alpha: 0.6),
                  ],
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE09A2D).withValues(alpha: 0.14),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.warning_amber_rounded,
                      size: 17,
                      color: Color(0xFFE09A2D),
                    ),
                  ),
                  const SizedBox(width: 10),
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF8C5A00),
                        letterSpacing: 0.2,
                        height: 1.3,
                      ),
                      children: [
                        TextSpan(text: '$alarmClusterCount'),
                        TextSpan(
                          text: ' ${LKey.alarmCluster.tr}',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        const TextSpan(
                          text: ' · ',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        TextSpan(text: '$alarmCount'),
                        TextSpan(
                          text: ' ${LKey.alarm.tr}',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.icon,
    required this.iconColor,
    required this.iconBg,
    required this.label,
    required this.value,
    required this.code,
    required this.isLast,
    this.isArrow,
  });

  final IconData icon;
  final Color iconColor;
  final Color iconBg;
  final String label;
  final String value;
  final String code;
  final bool isLast;
  final bool? isArrow;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.fromLTRB(16, 16, 16, isLast ? 16 : 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 20, color: iconColor),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF8C9AA8),
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.2,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Color(0xFF2C3E50),
                    fontWeight: FontWeight.w500,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF2F4F7),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    code,
                    style: const TextStyle(
                      fontSize: 11,
                      color: Color(0xFF6B7785),
                      fontWeight: FontWeight.w500,
                      fontFamily: 'SF Mono',
                      fontFamilyFallback: ['Roboto Mono', 'monospace'],
                      letterSpacing: 0.4,
                      height: 1.3,
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (isArrow == true)
            Icon(
              Icons.arrow_forward_ios_outlined,
              size: 20,
              color: Colors.black.withValues(alpha: 0.4),
            ),
        ],
      ),
    );
  }
}
