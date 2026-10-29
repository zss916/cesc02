import 'package:cesc01/core/helper/device_status.dart';
import 'package:cesc01/core/network/bean/site_over_view_data_entity.dart';
import 'package:flutter/material.dart';

class SingleSiteInfoItem extends StatelessWidget {
  final SiteOverViewDataEntity data;
  const SingleSiteInfoItem({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              data.showSiteName,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Color(0xFF172033),
              ),
            ),
            Divider(height: 4, color: Colors.transparent),
            Text(
              data.showSubTitle,
              style: TextStyle(fontSize: 11, color: Color(0xFF6F7D92)),
            ),
            Divider(height: 10, color: Colors.transparent),
            Wrap(
              spacing: 8,
              runSpacing: 4,
              children: [
                buildCommStatus(status: data.showCommStatus),
                if (data.onlineStackCount != null) buildBatteryStack(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBatteryStack() => Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    child: Text(
      data.showBatteryStackTitle,
      style: TextStyle(fontSize: 12, color: Color(0xFF6F7D92)),
    ),
  );

  Widget buildCommStatus({required String status}) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(
      color: status.colorValue.withValues(alpha: 0.2),
      borderRadius: BorderRadius.circular(6),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 6,
          height: 6,
          margin: EdgeInsetsDirectional.only(end: 5),
          decoration: BoxDecoration(
            color: status.colorValue,
            shape: BoxShape.circle,
          ),
        ),
        Text(
          status.title,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: status.colorValue,
          ),
        ),
      ],
    ),
  );
}
