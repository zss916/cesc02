import 'package:cesc01/core/translations/lan_key.dart';
import 'package:cesc01/feature/provision/helper/state_mixin.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class FilterStatusWidget extends StatefulWidget {
  final Function(int?) onFilter;
  const FilterStatusWidget({super.key, required this.onFilter});

  @override
  State<FilterStatusWidget> createState() => _FilterStatusWidgetState();
}

class _FilterStatusWidgetState extends State<FilterStatusWidget>
    with AppStateMixin {
  int _filterChip = 0;

  List<String> get _filters => [
    LKey.all.tr,
    LKey.serious.tr,
    LKey.important.tr,
    LKey.general.tr,
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: List.generate(_filters.length, (i) {
          final active = i == _filterChip;
          return GestureDetector(
            onTap: () {
              safeSetState(() => _filterChip = i);
              widget.onFilter((_filterChip == 0) ? null : _filterChip);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
              decoration: BoxDecoration(
                color: active ? const Color(0xFF3978F6) : Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                _filters[i],
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
