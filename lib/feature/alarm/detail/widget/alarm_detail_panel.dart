import 'package:cesc01/core/network/bean/stack_alarm_detail_entity.dart';
import 'package:cesc01/core/translations/lan_key.dart';
import 'package:cesc01/feature/alarm/detail/widget/battery_cluster_alarm_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class AlarmDetailPanel extends StatelessWidget {
  final List<StackAlarmDetailClusters> data;
  final String timezone;

  const AlarmDetailPanel({
    super.key,
    required this.data,
    required this.timezone,
  });

  @override
  Widget build(BuildContext context) {
    final groups = _groupClusters(data);
    return groups.isEmpty
        ? const SizedBox.shrink()
        : Container(
            width: double.maxFinite,
            margin: const EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFECEFF3), width: 1),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 16,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildSectionTitle(),
                const Divider(
                  height: 1,
                  thickness: 1,
                  color: Color(0xFFEDF0F4),
                  indent: 16,
                  endIndent: 16,
                ),
                ListView.separated(
                  padding: EdgeInsetsDirectional.only(
                    start: 0,
                    end: 0,
                    top: 0,
                    bottom: 4,
                  ),
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: groups.length,
                  shrinkWrap: true,
                  separatorBuilder: (_, i) => Divider(
                    height: 1,
                    thickness: 1,
                    color: Color(0xFFEDF0F4),
                    indent: 16,
                    endIndent: 16,
                  ),
                  itemBuilder: (_, i) =>
                      BatteryClusterAlarmCard(alarms: groups[i]),
                ),
              ],
            ),
          );
  }

  // 区块标题：彩色竖条 + 「告警明细」
  Widget _buildSectionTitle() {
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 14),
      child: Row(
        children: [
          Container(
            width: 3,
            height: 14,
            margin: EdgeInsetsDirectional.only(end: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFE09A2D),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Text(
            LKey.alarmListDetails.tr,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: Color(0xFF2C3E50),
              height: 1.2,
            ),
          ),
          Spacer(),
          Text(
            timezone,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w400,
              color: Color(0xFF8C9AA8),
            ),
          ),
        ],
      ),
    );
  }

  /// 按 clusterNo 将告警分组
  List<List<StackAlarmDetailClusters>> _groupClusters(
    List<StackAlarmDetailClusters> clusters,
  ) {
    final grouped = <int, List<StackAlarmDetailClusters>>{};
    for (final c in clusters) {
      grouped.putIfAbsent(c.clusterNo ?? -1, () => []).add(c);
    }
    return grouped.values.toList();
  }
}
