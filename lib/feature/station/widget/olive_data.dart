import 'package:cesc01/core/network/bean/site_over_view_data_entity.dart';
import 'package:cesc01/core/translations/lan_key.dart';
import 'package:cesc01/feature/station/widget/battery_stack_list.dart';
import 'package:cesc01/feature/station/widget/metrics_grid_widget2.dart';
import 'package:cesc01/feature/station/widget/stack_running_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class OliveData extends StatelessWidget {
  final SiteOverViewDataEntity data;
  final Function(SiteOverViewDataStacks) onTap;
  const OliveData({super.key, required this.data, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: Column(
        children: [
          MetricsGridWidget2(data: data),
          Divider(height: 18, color: Colors.transparent),
          StackRunningWidget(data: data.stackStatusDistribution),
          Container(
            margin: EdgeInsetsDirectional.only(top: 16, bottom: 8),
            padding: EdgeInsetsDirectional.symmetric(horizontal: 16),
            width: double.maxFinite,
            child: Text(
              LKey.allBatteryStacks.tr,
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          BatteryStackList(
            list: data.showStacks,
            onTap: (item) {
              onTap.call(item);
            },
          ),
          Divider(height: 18, color: Colors.transparent),
        ],
      ),
    );
  }
}
