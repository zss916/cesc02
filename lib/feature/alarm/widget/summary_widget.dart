import 'package:cesc01/core/network/bean/alarm_summary_entity.dart';
import 'package:cesc01/core/translations/lan_key.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class SummaryWidget extends StatelessWidget {
  final AlarmSummaryEntity? summary;
  const SummaryWidget({super.key, this.summary});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsetsDirectional.symmetric(horizontal: 20),
      padding: EdgeInsetsDirectional.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      width: double.maxFinite,
      child: Column(
        children: [
          SizedBox(
            width: double.maxFinite,
            child: Text(
              LKey.currentFiltering.tr,
              style: TextStyle(color: Color(0xFF6F7D92)),
            ),
          ),
          Divider(height: 10, color: Colors.transparent),
          SizedBox(
            width: double.maxFinite,
            child: Wrap(
              spacing: 10,
              runSpacing: 5,
              children: [
                if (summary?.siteCount != null)
                  Text(
                    "${summary?.showSiteCount}${LKey.station.tr}",
                    style: TextStyle(color: Colors.black),
                  ),

                if (summary?.stackCount != null)
                  Text(
                    "${summary?.showStackCount}${LKey.batteryStack.tr}",
                    style: TextStyle(color: Colors.black),
                  ),

                if (summary?.alarmClusterCount != null)
                  Text(
                    "${summary?.showAlarmClusterCount}${LKey.alarmCluster.tr}",
                    style: TextStyle(color: Colors.black),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
