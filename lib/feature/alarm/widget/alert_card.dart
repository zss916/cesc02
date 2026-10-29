import 'package:cesc01/core/helper/device_status.dart';
import 'package:cesc01/core/network/bean/alarm_detail_entity.dart';
import 'package:cesc01/core/translations/lan_key.dart';
import 'package:cesc01/routes/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class AlertCard extends StatelessWidget {
  final AlarmDetailEntity item;
  final bool? isHistory;
  const AlertCard({super.key, required this.item, this.isHistory});

  @override
  Widget build(BuildContext context) {
    return buildItem(item: item, isHistory: isHistory);
  }

  Widget buildItem({
    required AlarmDetailEntity item,
    required bool? isHistory,
  }) {
    final rawColor = item.showAlarmLevel.colorValue;
    final levelColor = rawColor == Colors.transparent
        ? const Color(0xFF5B6B85)
        : rawColor;
    final isRestored = isHistory == true;

    return Container(
      margin: const EdgeInsetsDirectional.symmetric(
        horizontal: 16,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.white, Color(0xFFFAFBFD)],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
          BoxShadow(
            color: levelColor.withValues(alpha: 0.06),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            if (item.stackSn != null) {
              PageTools.toAlarmDetail(
                siteId: item.siteId,
                stackSn: item.stackSn ?? "",
                status: isRestored
                    ? AlarmStatus.recovered.value
                    : AlarmStatus.active.value,
              );
            }
          },
          borderRadius: BorderRadius.circular(16),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // 左侧彩色 accent 条
                  Container(
                    width: 4,
                    decoration: BoxDecoration(
                      color: levelColor,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(2),
                        bottomLeft: Radius.circular(2),
                      ),
                    ),
                  ),
                  // 内容区
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(14, 14, 12, 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildHeader(levelColor, isRestored),
                          const SizedBox(height: 10),
                          _buildDivider(),
                          const SizedBox(height: 10),
                          _buildStackInfo(),
                          if (item.alarmClusterCount != null ||
                              item.showClusterNos.isNotEmpty) ...[
                            const SizedBox(height: 10),
                            _buildStatsRow(levelColor),
                          ],
                          const SizedBox(height: 10),
                          _buildFooter(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ─────────── 头部：站点 + 状态 ───────────

  Widget _buildHeader(Color levelColor, bool isRestored) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // 站点图标徽章
        Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: const Color(0xFF34C759).withValues(alpha: 0.10),
            borderRadius: BorderRadius.circular(9),
          ),
          child: const Icon(
            Icons.location_on_rounded,
            size: 17,
            color: Color(0xFF34C759),
          ),
        ),
        const SizedBox(width: 10),
        // 站点名称
        Expanded(
          child: Column(
            children: [
              SizedBox(
                width: double.maxFinite,
                child: Text(
                  item.showSiteName,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF172033),
                    height: 1.3,
                  ),
                ),
              ),
              SizedBox(
                width: double.maxFinite,
                child: Text(
                  item.showSiteCode,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF6B7785),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        if (item.alarmLevel != null)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: levelColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: levelColor.withValues(alpha: 0.25),
                width: 0.8,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 5,
                  height: 5,
                  decoration: BoxDecoration(
                    color: levelColor,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 5),
                Text(
                  item.showAlarmLevel.title,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: levelColor,
                    height: 1.2,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  // ─────────── 电池堆信息 ───────────

  Widget _buildStackInfo() {
    return Row(
      children: [
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: const Color(0xFFFF9F0A).withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(
            Icons.bolt_rounded,
            size: 16,
            color: Color(0xFFFF9F0A),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            children: [
              SizedBox(
                width: double.maxFinite,
                child: Text(
                  item.showStackName,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF2C3E50),
                  ),
                ),
              ),
              SizedBox(
                width: double.maxFinite,
                child: Wrap(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 7,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF2F4F7),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        item.showStackSn,
                        overflow: TextOverflow.ellipsis,
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
            ],
          ),
        ),
      ],
    );
  }

  // ─────────── 告警统计 + 簇编号 ───────────

  Widget _buildStatsRow(Color levelColor) {
    return Wrap(
      spacing: 8,
      runSpacing: 6,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        // 告警簇数量
        if (item.alarmClusterCount != null)
          Text(
            '${item.alarmClusterCount}${LKey.alarmCluster.tr}',
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: Color(0xFFE09A2D),
              height: 1.2,
            ),
          ),
        // 簇编号 chips
        if (item.showClusterNos.isNotEmpty)
          Wrap(
            spacing: 5,
            runSpacing: 4,
            children: item.showClusterNos.map((e) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0xFFEEF1F6),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  '${LKey.cluster.tr}$e',
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF6B7785),
                    height: 1.2,
                  ),
                ),
              );
            }).toList(),
          ),
      ],
    );
  }

  // ─────────── 底部：时间 + 箭头 ───────────

  Widget _buildFooter() {
    return Row(
      children: [
        Expanded(
          child: Text(
            '${LKey.timeOfOccurrence.tr}: ${item.timeDisplay}',
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 12,
              color: Colors.black.withValues(alpha: 0.45),
              fontWeight: FontWeight.w500,
              fontFamily: 'SF Mono',
              fontFamilyFallback: ['Roboto Mono', 'monospace'],
              letterSpacing: 0.2,
              height: 1.3,
            ),
          ),
        ),
        Icon(
          Icons.arrow_forward_ios_rounded,
          size: 14,
          color: Colors.black.withValues(alpha: 0.25),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 1,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFFEDF0F4),
            const Color(0xFFEDF0F4).withValues(alpha: 0.3),
            Colors.transparent,
          ],
        ),
      ),
    );
  }
}
