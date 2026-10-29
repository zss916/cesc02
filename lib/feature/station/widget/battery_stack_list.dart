import 'package:cesc01/core/network/bean/site_over_view_data_entity.dart';
import 'package:cesc01/core/translations/lan_key.dart';
import 'package:cesc01/feature/station/widget/battery_stack_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BatteryStackList extends StatelessWidget {
  final List<SiteOverViewDataStacks> list;
  final Function(SiteOverViewDataStacks) onTap;
  const BatteryStackList({super.key, required this.list, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return list.isEmpty
        ? buildEmpty()
        : ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsetsDirectional.only(
              start: 16,
              end: 16,
              top: 0,
              bottom: 30,
            ),
            shrinkWrap: true,
            itemCount: list.length,
            separatorBuilder: (_, i) =>
                Divider(height: 14, color: Colors.transparent),
            itemBuilder: (_, i) => BatteryStackCard(
              item: list[i],
              onTap: (item) {
                onTap.call(item);
              },
            ),
          );
  }

  Widget buildEmpty() {
    return Container(
      width: double.maxFinite,
      height: Get.width,
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
}
