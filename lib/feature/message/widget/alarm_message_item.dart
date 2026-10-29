import 'package:cesc01/core/helper/device_status.dart';
import 'package:cesc01/core/network/bean/notify_item_entity.dart';
import 'package:cesc01/routes/index.dart';
import 'package:flutter/material.dart';

class AlarmMessageItem extends StatelessWidget {
  final NotifyItemEntity item;
  const AlarmMessageItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        if (item.stackSn != null) {
          PageTools.toAlarmDetail(
            siteId: item.siteId,
            stackSn: item.stackSn ?? "",
            isMessage: true,
          );
        }
      },
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: item.showAlarmLevel.colorValue.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                item.showAlarmLevel.title,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: item.showAlarmLevel.colorValue,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.showTitle,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1A1A1A),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "${item.showSiteName} · ${item.showTime}",
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF8A8F99),
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right_rounded,
              size: 18,
              color: Color(0xFFC0C4CC),
            ),
          ],
        ),
      ),
    );
  }
}
