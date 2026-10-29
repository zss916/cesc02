import 'package:cesc01/core/helper/device_status.dart';
import 'package:cesc01/core/network/bean/stack_alarm_detail_entity.dart';
import 'package:cesc01/core/translations/lan_key.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

/// 电池簇告警卡片
///
/// 展示一个电池簇下所有告警：可展开/收起的簇头（名称 + 编号 + 条数徽章）
/// + 告警明细行（圆点 + 告警名称 + 发生时间）。
/// 该组件本身不带卡片外框，作为 [_AlarmDetailPanel] 内的一个区块使用。
class BatteryClusterAlarmCard extends StatefulWidget {
  const BatteryClusterAlarmCard({super.key, required this.alarms});

  /// 同一簇下的所有告警条目
  final List<StackAlarmDetailClusters> alarms;

  @override
  State<BatteryClusterAlarmCard> createState() =>
      _BatteryClusterAlarmCardState();
}

class _BatteryClusterAlarmCardState extends State<BatteryClusterAlarmCard> {
  bool _expanded = true;

  StackAlarmDetailClusters get _first => widget.alarms.first;

  int get _count => _first.alarmCount ?? widget.alarms.length;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildClusterHeader(),
        AnimatedSize(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOut,
          child: _expanded
              ? _buildAlarmRows()
              : const SizedBox(width: double.infinity),
        ),
      ],
    );
  }

  // ─────────── 簇头 ───────────

  Widget _buildClusterHeader() {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => setState(() => _expanded = !_expanded),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            // 展开/收起箭头
            AnimatedRotation(
              duration: const Duration(milliseconds: 200),
              turns: _expanded ? 0.25 : 0,
              child: const Icon(
                Icons.play_arrow_rounded,
                size: 16,
                color: Color(0xFF8C9AA8),
              ),
            ),
            const SizedBox(width: 8),
            // 簇名称
            Text(
              _first.showClusterName,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: Color(0xFF2C3E50),
                height: 1.2,
              ),
            ),
            const SizedBox(width: 8),
            // 簇 SN
            Flexible(
              child: Text(
                _first.showClusterSn,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 11,
                  color: Color(0xFF8C9AA8),
                  fontWeight: FontWeight.w500,
                  fontFamily: 'SF Mono',
                  fontFamilyFallback: ['Roboto Mono', 'monospace'],
                  letterSpacing: 0.4,
                  height: 1.3,
                ),
              ),
            ),
            const SizedBox(width: 8),
            // 条数徽章
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF4E0),
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: const Color(0xFFE09A2D).withValues(alpha: 0.25),
                  width: 0.8,
                ),
              ),
              child: Text(
                LKey.itemUnit.trArgs(["$_count"]),
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFFE09A2D),
                  height: 1.3,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ─────────── 告警明细行 ───────────

  Widget _buildAlarmRows() {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: widget.alarms.length,
      separatorBuilder: (_, i) => Divider(
        height: 1,
        thickness: 1,
        color: Color(0xFFF2F4F7),
        indent: 16,
        endIndent: 16,
      ),
      itemBuilder: (_, i) => _AlarmRow(alarm: widget.alarms[i]),
    );
  }
}

class _AlarmRow extends StatelessWidget {
  const _AlarmRow({required this.alarm});

  final StackAlarmDetailClusters alarm;

  Color get _dotColor {
    final c = alarm.showAlarmLevel.colorValue;
    return c == Colors.transparent ? const Color(0xFFEF8F32) : c;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
      child: Column(
        spacing: 8,
        children: [
          Row(
            children: [
              // 与簇头箭头对齐的缩进
              const SizedBox(width: 24),
              // 告警等级圆点
              Container(
                width: 7,
                height: 7,
                decoration: BoxDecoration(
                  color: _dotColor,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: _dotColor.withValues(alpha: 0.30),
                      blurRadius: 4,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 5),
              // 告警名称
              Expanded(
                child: Text(
                  alarm.showAlarmName,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF2C3E50),
                    height: 1.3,
                  ),
                ),
              ),
              const SizedBox(width: 5),
              // 告警等级徽章
              Container(
                constraints: BoxConstraints(minWidth: 46),
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: _dotColor.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      alarm.showAlarmLevel.title,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: _dotColor,
                        height: 1.2,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          // 发生时间
          Container(
            margin: EdgeInsetsDirectional.only(start: 24),
            width: double.maxFinite,
            child: Row(
              children: [
                Text(
                  '${LKey.timeOfOccurrence.tr}: ${alarm.showOccurredAt}',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF8C9AA8),
                  ),
                ),
              ],
            ),
          ),

          //alarm.showStatus
          // 恢复时间
          if (alarm.recoveredAt != null)
            Container(
              margin: EdgeInsetsDirectional.only(start: 24),
              width: double.maxFinite,
              child: Row(
                children: [
                  Text(
                    '${LKey.recoveryTime.tr}: ${alarm.showRecoveredAt}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF8C9AA8),
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
