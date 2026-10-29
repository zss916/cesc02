import 'package:cesc01/core/network/bean/dashboard_entity.dart';
import 'package:cesc01/core/translations/lan_key.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class HomeOverviewWidget extends StatelessWidget {
  final DashboardSummary? data;
  const HomeOverviewWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      padding: EdgeInsetsDirectional.symmetric(horizontal: 16, vertical: 10),
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      childAspectRatio: 2.2,
      children: [
        buildOverViewItem(
          title: LKey.authorizedPowerStation.tr,
          value: data?.totalSiteCount ?? "-",
          subTitle: "",
        ),

        buildOverViewItem(
          title: LKey.batteryStack.tr,
          value: data?.showTotalStackCount ?? "-",
          subTitle: "",
        ),

        buildOverViewItem(
          title: LKey.batteryCluster.tr,
          value: data?.showTotalClusterCount ?? "-",
          subTitle: "",
        ),

        buildOverViewItem(
          title: LKey.currentAlarmCluster.tr,
          value: data?.alarmCount ?? "-",
          subTitle: "",
          color: (data?.alarmClusterCount ?? 0) == 0
              ? Color(0xFF172033)
              : Color(0xFFE75252),
        ),
      ],
    );
  }

  Widget buildOverViewItem({
    required String title,
    String? subTitle,
    required String value,
    Color? color,
  }) => Container(
    padding: EdgeInsetsDirectional.all(10),
    width: double.maxFinite,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 14, color: Color(0xFF6F7D92)),
        ),
        Divider(height: 5, color: Colors.transparent),
        FittedBox(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: color ?? Colors.black,
            ),
          ),
        ),
      ],
    ),
  );
}
