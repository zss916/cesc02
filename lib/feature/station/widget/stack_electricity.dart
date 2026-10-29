import 'package:cesc01/core/helper/device_status.dart';
import 'package:cesc01/core/network/bean/stack_and_cluster_entity.dart';
import 'package:cesc01/core/translations/lan_key.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class StackElectricity extends StatelessWidget {
  final StackAndClusterEnergy energy;
  final StackAndClusterRunningProtection runningProtection;
  const StackElectricity({
    super.key,
    required this.energy,
    required this.runningProtection,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      margin: EdgeInsetsDirectional.symmetric(horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LKey.electricityAndChargeDischarge.tr,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: Color(0xFF172033),
            ),
          ),
          Divider(height: 14, color: Colors.transparent),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 12,
            crossAxisSpacing: 14,
            childAspectRatio: 2.6,
            children: [
              buildGridItem2(
                title: LKey.remainingEnergy.tr,
                value: energy.showRemainingKwh,
              ),
              buildGridItem2(
                title: LKey.chargeableEnergy.tr,
                value: energy.showCanChargeKwh,
              ),
              buildGridItem2(
                title: LKey.dischargeableEnergy.tr,
                value: energy.showCanDischargeKwh,
              ),
              buildGridItem2(
                title: LKey.totalChargedEnergy.tr,
                value: energy.showTotalChargedKwh,
              ),
              buildGridItem2(
                title: LKey.totalDischargedEnergy.tr,
                value: energy.showTotalDischargedKwh,
              ),
              buildGridItem2(
                title: LKey.maxAllowedChargeCurrent.tr,
                value: runningProtection.showMaxChargeCurrent,
              ),
              buildGridItem2(
                title: LKey.maxAllowedDischargeCurrent.tr,
                value: runningProtection.showMaxDischargeCurrent,
              ),
              buildGridItem2(
                title: LKey.bmsRunningStatus.tr,
                value: runningProtection.showRunStatus.runningTitle,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildGridItem2({required String title, required String value}) =>
      Column(
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
      );
}
