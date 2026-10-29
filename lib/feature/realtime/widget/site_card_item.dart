import 'package:cesc01/core/event/app_event_bus.dart';
import 'package:cesc01/core/helper/device_status.dart';
import 'package:cesc01/core/helper/userData/user_helper.dart';
import 'package:cesc01/core/network/bean/realtime_entity.dart';
import 'package:cesc01/core/translations/lan_key.dart';
import 'package:cesc01/feature/station/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SiteCard extends StatelessWidget {
  final RealtimePageList item;
  const SiteCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
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
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: () {
            UserHelper.instance
                .setRecentlyViewed(
                  siteId: item.siteId ?? "",
                  siteName: item.siteName,
                  commStatus: item.commStatus,
                  countryRegion: item.countryRegion,
                )
                .whenComplete(() {
                  ///todo
                  AppEventBus.eventBus.fire(MainPageEvent(select: 2));
                  Get.find<StationLogic>().siteId = item.siteId ?? "";
                  Get.find<StationLogic>().refreshStation(loading: true);
                });
          },
          child: Container(
            width: double.maxFinite,
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.showSiteName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF172033),
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            item.showSiteAddress,
                            style: const TextStyle(
                              fontSize: 11,
                              color: Color(0xFF6F7D92),
                            ),
                          ),
                        ],
                      ),
                    ),

                    if (item.runtimeStatusVisibility)
                      SiteStatusTag(runtimeStatus: item.showRuntimeStatus),
                  ],
                ),
                Divider(height: 14, color: Colors.transparent),

                IntrinsicHeight(
                  child: Row(
                    children: [
                      Expanded(
                        child: MetricTile(
                          value: item.packRate,
                          label: LKey.devicesCount.tr,
                        ),
                      ),

                      Container(
                        margin: EdgeInsetsDirectional.symmetric(horizontal: 2),
                        width: 1,
                        height: 36,
                        color: const Color(0xFFEEF1F7),
                      ),

                      Expanded(
                        child: MetricTile(
                          value: item.showSocRange,
                          label: "SOC",
                        ),
                      ),

                      Container(
                        margin: EdgeInsetsDirectional.symmetric(horizontal: 2),
                        width: 1,
                        height: 36,
                        color: const Color(0xFFEEF1F7),
                      ),

                      Expanded(
                        child: MetricTile(
                          value: item.showMaxTemp,
                          label: LKey.tempRange.tr,
                        ),
                      ),
                    ],
                  ),
                ),

                Divider(height: 12, color: Colors.transparent),

                Divider(height: 0.5, color: const Color(0xFFEEF1F7)),

                Divider(height: 8, color: Colors.transparent),

                Row(
                  children: [
                    Expanded(
                      child: Text(
                        item.showLastDataTime,
                        style: const TextStyle(
                          fontSize: 11,
                          color: Color(0xFFA8B4C8),
                        ),
                      ),
                    ),
                    VerticalDivider(width: 5, color: Colors.transparent),
                    AlarmTip(count: item.alarmCount),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

///状态标签
class SiteStatusTag extends StatelessWidget {
  final String runtimeStatus;
  const SiteStatusTag({super.key, required this.runtimeStatus});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
      decoration: BoxDecoration(
        color: runtimeStatus.colorValue.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: runtimeStatus.colorValue,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 5),
          Text(
            runtimeStatus.title,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: runtimeStatus.colorValue,
            ),
          ),
        ],
      ),
    );
  }
}

///内容
class MetricTile extends StatelessWidget {
  final String value;
  final String label;
  const MetricTile({super.key, required this.value, required this.label});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        Divider(height: 4, color: Colors.transparent),
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 11, color: Color(0xFF6F7D92)),
        ),
      ],
    );
  }
}

///告警提示
class AlarmTip extends StatelessWidget {
  final int count;
  const AlarmTip({super.key, required this.count});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          count > 0
              ? Icons.error_outline_rounded
              : Icons.check_circle_outline_rounded,
          color: count > 0 ? const Color(0xFFE75252) : const Color(0xFF11A879),
          size: 14,
        ),
        VerticalDivider(width: 2, color: Colors.transparent),
        Text(
          ///告警统计文案
          count == 0
              ? LKey.emptyAlarmTip.tr
              : LKey.countAlarmTip.trArgs(["$count"]),
          style: TextStyle(fontSize: 11, color: const Color(0xFF6F7D92)),
        ),
      ],
    );
  }
}
