import 'package:cesc01/core/translations/lan_key.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class ItemMetricsGridWidget extends StatelessWidget {
  final String socValue;
  final String sohValue;
  final String totalVoltageValue;
  final String totalCurrentValue;
  final String maxTempValue;
  final String maxVoltageDiff;

  const ItemMetricsGridWidget({
    super.key,
    required this.socValue,
    required this.sohValue,
    required this.totalVoltageValue,
    required this.totalCurrentValue,
    required this.maxTempValue,
    required this.maxVoltageDiff,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 12,
      crossAxisSpacing: 16,
      childAspectRatio: 2.4,
      children: [
        buildGridItem(title: 'SOC', value: socValue),
        buildGridItem(title: "SOH", value: sohValue),
        buildGridItem(title: LKey.totalVoltage.tr, value: totalVoltageValue),
        buildGridItem(title: LKey.totalCurrent.tr, value: totalCurrentValue),
        buildGridItem(title: LKey.maxTemp.tr, value: maxTempValue),
        buildGridItem(title: LKey.maxVoltageDiff.tr, value: maxVoltageDiff),
      ],
    );
  }

  Widget buildGridItem({required String title, required String value}) =>
      Container(
        padding: EdgeInsetsDirectional.all(10),
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
            Text(
              value,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ],
        ),
      );
}
