import 'package:cesc01/core/network/bean/stack_and_cluster_entity.dart';
import 'package:cesc01/core/translations/lan_key.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class StackMetricsGrid extends StatelessWidget {
  final StackAndClusterSummary data;
  const StackMetricsGrid({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Color(0xFFECEFF3), width: 1),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1B2A4A).withValues(alpha: 0.05),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
          BoxShadow(
            color: const Color(0xFF1B2A4A).withValues(alpha: 0.03),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      width: double.maxFinite,
      child: Column(
        children: [
          Container(
            margin: EdgeInsetsDirectional.only(bottom: 10),
            width: double.maxFinite,
            child: Row(
              children: [
                Container(
                  width: 3,
                  height: 15,
                  decoration: BoxDecoration(
                    color: Color(0xFF3D7BEA),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    LKey.keyMetrics.tr,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1F3A56),
                      height: 1.2,
                      letterSpacing: 0.2,
                    ),
                  ),
                ),
              ],
            ),
          ),
          GridView.count(
            padding: EdgeInsetsDirectional.zero,
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 12,
            crossAxisSpacing: 16,
            childAspectRatio: 2.4,
            children: [
              buildGridItem(title: 'SOC', value: data.showSoc),
              buildGridItem(title: "SOH", value: data.showSoh),
              buildGridItem(
                title: LKey.totalVoltage.tr,
                value: data.showTotalVoltage,
              ),
              buildGridItem(
                title: LKey.totalCurrent.tr,
                value: data.showTotalCurrent,
              ),
              buildGridItem(
                title: LKey.maxTemp.tr,
                value: data.showMaxTemperature,
              ),
              buildGridItem(
                title: LKey.maxVoltageDiff.tr,
                value: data.showMaxVoltageDiff,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildGridItem({required String title, required String value}) =>
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.grey.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 11, color: Color(0xFF6F7D92)),
            ),
            Divider(height: 3, color: Colors.transparent),
            FittedBox(
              child: Text(
                value,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      );
}
