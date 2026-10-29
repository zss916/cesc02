import 'package:cesc01/core/network/bean/stack_and_cluster_entity.dart';
import 'package:cesc01/core/translations/lan_key.dart';
import 'package:cesc01/feature/station/widget/battery_stack_detail_card.dart';
import 'package:cesc01/feature/station/widget/build_version_widget.dart';
import 'package:cesc01/feature/station/widget/chart/battery_trend_chart_card.dart';
import 'package:cesc01/feature/station/widget/stack_electricity.dart';
import 'package:cesc01/feature/station/widget/stack_metrics_grid.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class StackDataView extends StatelessWidget {
  final StackAndClusterEntity data;
  final String stackId;
  const StackDataView({super.key, required this.data, required this.stackId});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(height: 10, color: Colors.transparent),
        Container(
          width: double.maxFinite,
          margin: EdgeInsetsDirectional.symmetric(horizontal: 16),
          alignment: AlignmentDirectional.centerStart,
          child: Text(
            "${LKey.platformReception.tr} ${data.showLastDataTime}",
            style: const TextStyle(fontSize: 11, color: Color(0xFF6F7D92)),
          ),
        ),
        Divider(height: 10, color: Colors.transparent),
        if (stackId.isNotEmpty)
          Container(
            width: double.maxFinite,
            margin: EdgeInsetsDirectional.symmetric(horizontal: 16),
            alignment: AlignmentDirectional.centerStart,
            child: BuildVersionWidget(
              firmwareVersion: data.showFirmwareVersion,
              stackId: stackId,
            ),
          ),
        Divider(height: 10, color: Colors.transparent),
        Container(
          padding: EdgeInsetsDirectional.only(start: 16, end: 16),
          child: StackMetricsGrid(data: data.summary!),
        ),
        Divider(height: 14, color: Colors.transparent),
        BatteryTrendChartCard(trend: data.trend!),
        Divider(height: 14, color: Colors.transparent),
        StackElectricity(
          energy: data.energy!,
          runningProtection: data.runningProtection!,
        ),
        Divider(height: 14, color: Colors.transparent),
        BatteryStackDetailCard(
          clusterCount: data.showClusterCount,
          extrema: data.extrema!,
          systemInfo: data.systemInfo!,
        ),
        Divider(height: 36, color: Colors.transparent),
      ],
    );
  }
}
