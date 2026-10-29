import 'package:cesc01/core/helper/device_status.dart';
import 'package:cesc01/core/network/bean/site_over_view_data_entity.dart';
import 'package:cesc01/core/translations/lan_key.dart';
import 'package:cesc01/feature/station/widget/build_version_widget.dart';
import 'package:cesc01/feature/station/widget/item_metrics_grid_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class BatteryStackCard extends StatelessWidget {
  final SiteOverViewDataStacks item;
  final Function(SiteOverViewDataStacks) onTap;
  const BatteryStackCard({super.key, required this.item, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A102346),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: Container(
          margin: const EdgeInsets.fromLTRB(16, 16, 16, 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 顶部：图标 + 名称 + 状态
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 38,
                    height: 38,
                    margin: EdgeInsetsDirectional.only(end: 10),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEAF1FF),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.battery_full_rounded,
                      color: Color(0xFF3978F6),
                      size: 20,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.showStackName,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF172033),
                          ),
                        ),
                        Divider(height: 3, color: Colors.transparent),
                        Text(
                          item.showStackSn,
                          style: const TextStyle(
                            fontSize: 10,
                            color: Color(0xFF6F7D92),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsetsDirectional.only(start: 8),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: item.showCommStatus.colorValue.withValues(
                        alpha: 0.2,
                      ),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(
                            color: item.showCommStatus.colorValue,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          item.showCommStatus.title,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: item.showCommStatus.colorValue,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Divider(height: 4, color: Colors.transparent),
              BuildVersionWidget(
                firmwareVersion: item.showFirmwareVersion,
                stackId: item.stackId,
              ),
              Divider(height: 2, color: Colors.transparent),
              Row(
                children: [
                  if (item.sysMode != null)
                    Text(
                      item.showSysMode.modeTitle,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color(0xFF6F7D92),
                      ),
                    ),
                  Spacer(),
                  Text(
                    item.showEndTitle,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Color(0xFF6F7D92),
                    ),
                  ),
                ],
              ),
              Divider(height: 12, color: Colors.transparent),
              // 6 指标网格
              ItemMetricsGridWidget(
                socValue: item.showSoc,
                sohValue: item.showSoh,
                totalVoltageValue: item.showTotalVoltage,
                totalCurrentValue: item.showTotalCurrent,
                maxTempValue: item.showMaxTemperature,
                maxVoltageDiff: item.showMaxVoltageDiff,
              ),
              Divider(height: 10, color: Colors.transparent),
              const Divider(height: 1, thickness: 1, color: Color(0xFFF0F2F7)),
              // 底部：最后数据 + 查看详情
              InkWell(
                borderRadius: BorderRadius.circular(4),
                onTap: () {
                  onTap.call(item);
                },
                child: Container(
                  padding: EdgeInsetsDirectional.only(top: 10, bottom: 10),
                  width: double.maxFinite,
                  child: Row(
                    children: [
                      Text(
                        item.showLastDataTime,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFFA8B4C8),
                        ),
                      ),
                      const Spacer(),
                      Text(
                        LKey.viewDetails.tr,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF3978F6),
                        ),
                      ),
                      const SizedBox(width: 2),
                      const Icon(
                        Icons.chevron_right_rounded,
                        color: Color(0xFF3978F6),
                        size: 18,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
