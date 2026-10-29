import 'package:cesc01/core/helper/device_status.dart';
import 'package:cesc01/core/translations/lan_key.dart';
import 'package:cesc01/feature/provision/helper/state_mixin.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class RealtimeFilterWidget extends StatefulWidget {
  final Function(String?) onFilter;
  const RealtimeFilterWidget({super.key, required this.onFilter});

  @override
  State<RealtimeFilterWidget> createState() => _RealtimeFilterWidgetState();
}

class _RealtimeFilterWidgetState extends State<RealtimeFilterWidget>
    with AppStateMixin {
  int _chipIndex = 0;

  List<String> get chips => [
    LKey.all.tr,
    LKey.online.tr,
    LKey.alarm.tr,
    LKey.delayed.tr,
    LKey.offline.tr,
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsetsDirectional.only(start: 16, end: 16, bottom: 18),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: List.generate(chips.length, (i) {
          final active = i == _chipIndex;
          return GestureDetector(
            onTap: () {
              safeSetState(() => _chipIndex = i);
              widget.onFilter.call(i.filterStatus);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
              decoration: BoxDecoration(
                color: active ? const Color(0xFF3978F6) : Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                chips[i],
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: active ? Colors.white : const Color(0xFF5B6B85),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
