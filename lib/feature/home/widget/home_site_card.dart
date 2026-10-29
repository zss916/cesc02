import 'package:cesc01/core/event/app_event_bus.dart';
import 'package:cesc01/core/helper/device_status.dart';
import 'package:cesc01/core/network/bean/dashboard_entity.dart';
import 'package:cesc01/core/translations/lan_key.dart';
import 'package:cesc01/feature/station/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeSiteCardList extends StatelessWidget {
  final List<DashboardAttentionSites> data;
  const HomeSiteCardList({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionTitle(title: LKey.siteList.tr, trailing: ""),
        if (data.isEmpty) buildEmpty() else buildList(),
      ],
    );
  }

  Widget buildEmpty() {
    return Container(
      width: double.maxFinite,
      height: Get.width * 2 / 3,
      alignment: AlignmentDirectional.center,
      margin: EdgeInsetsDirectional.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF102346).withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Text(LKey.emptyTip.tr, style: TextStyle(color: Colors.black)),
    );
  }

  Widget buildList() {
    return ListView.separated(
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsetsDirectional.only(
        start: 16,
        end: 16,
        top: 0,
        bottom: 30,
      ),
      shrinkWrap: true,
      itemCount: data.length,
      separatorBuilder: (BuildContext context, int index) =>
          Divider(height: 14, color: Colors.transparent),
      itemBuilder: (BuildContext context, int i) => HomeSiteItem(item: data[i]),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title, trailing;
  const SectionTitle({super.key, required this.title, required this.trailing});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(start: 16, end: 16, bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: Color(0xFF172033),
            ),
          ),
          Text(
            trailing,
            style: const TextStyle(fontSize: 12, color: Color(0xFF6F7D92)),
          ),
        ],
      ),
    );
  }
}

class HomeSiteItem extends StatelessWidget {
  final DashboardAttentionSites item;

  const HomeSiteItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF102346).withValues(alpha: 0.04),
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
            if (item.siteId != null) {
              AppEventBus.eventBus.fire(MainPageEvent(select: 2));
              Get.find<StationLogic>().siteId = item.siteId ?? "";
              Get.find<StationLogic>().refreshStation(loading: true);
            }
          },
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(14)),
            margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.showSiteName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF172033),
                        ),
                      ),
                      Divider(height: 5, color: Colors.transparent),
                      Text(
                        item.showSubTitle,
                        style: TextStyle(
                          fontSize: 11,
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
                const Icon(
                  Icons.chevron_right_rounded,
                  color: Color(0xFFC2CCDB),
                  size: 22,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
