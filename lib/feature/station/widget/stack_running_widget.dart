import 'package:cesc01/core/helper/device_status.dart';
import 'package:cesc01/core/network/bean/site_over_view_data_entity.dart';
import 'package:cesc01/core/translations/lan_key.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class StackRunningWidget extends StatelessWidget {
  final SiteOverViewDataStackStatusDistribution? data;
  const StackRunningWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      width: double.maxFinite,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF102346).withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            margin: EdgeInsetsDirectional.only(bottom: 10),
            width: double.maxFinite,
            child: Text(
              LKey.pileOperationDistribution.tr,
              style: TextStyle(fontSize: 13, color: Color(0xFF6F7D92)),
            ),
          ),

          SizedBox(
            width: double.maxFinite,
            child: Wrap(
              runSpacing: 8,
              spacing: 15,
              children: [
                buildRunLabel(
                  color: "ONLINE".colorValue,
                  title: LKey.online.tr,
                  value: data?.showOnline ?? "-",
                ),

                buildRunLabel(
                  color: "ALARM".colorValue,
                  title: LKey.alarm.tr,
                  value: data?.showAlarm ?? "-",
                ),

                buildRunLabel(
                  color: "DELAYED".colorValue,
                  title: LKey.delayed.tr,
                  value: data?.showDelayed ?? "-",
                ),

                buildRunLabel(
                  color: "OFFLINE".colorValue,
                  title: LKey.offline.tr,
                  value: data?.showOffline ?? "-",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildRunLabel({
    required Color color,
    required String title,
    required String value,
  }) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        width: 6,
        height: 6,
        margin: EdgeInsetsDirectional.only(end: 5),
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      ),
      Container(
        margin: EdgeInsetsDirectional.only(end: 5),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Color(0xFF6F7D92),
          ),
        ),
      ),
      Text(
        value,
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w700,
          color: Colors.black,
        ),
      ),
    ],
  );
}
