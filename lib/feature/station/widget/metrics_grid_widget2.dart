import 'package:cesc01/core/network/bean/site_over_view_data_entity.dart';
import 'package:cesc01/core/translations/lan_key.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class MetricsGridWidget2 extends StatelessWidget {
  final SiteOverViewDataEntity data;
  const MetricsGridWidget2({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 1.8,
        children: [
          _MetricTile(
            label: LKey.batteryStack.tr,
            value: data.totalStackCountValue,
            subTitle: "",
          ),
          _MetricTile(
            label: LKey.batteryCluster.tr,
            value: data.showTotalClusterCount,
          ),
          _MetricTile(label: '子Pack', value: data.showTotalSubPackCount),
          _MetricTile(
            label: LKey.currentAlarmCluster.tr,
            value: data.showAlarmClusterCount,
            accent: (data.alarmClusterCount ?? 0) == 0
                ? Color(0xFF172033)
                : Color(0xFFE75252),
          ),
        ],
      ),
    );
  }
}

class _MetricTile extends StatelessWidget {
  final String label, value;
  final String? subTitle;
  final Color accent;
  const _MetricTile({
    required this.label,
    required this.value,
    this.subTitle,
    this.accent = const Color(0xFF172033),
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(width: 1, color: Color(0xFFF7F9FC)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 11, color: Color(0xFF6F7D92)),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: accent,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subTitle ?? "",
            style: const TextStyle(fontSize: 11, color: Color(0xFF6F7D92)),
          ),
        ],
      ),
    );
  }
}
