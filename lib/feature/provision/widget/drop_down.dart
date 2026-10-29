import 'package:cesc01/core/translations/lan_key.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

/// 下拉选择（原型用，点击切换）
class Dropdown extends StatefulWidget {
  final String value;
  final List<String> items;
  final ValueChanged<(String, int)>? onChanged;
  const Dropdown({
    super.key,
    required this.value,
    required this.items,
    this.onChanged,
  });

  @override
  State<Dropdown> createState() => _DropdownState();
}

class _DropdownState extends State<Dropdown> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => setState(() => expanded = !expanded),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFD),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFE3E9F2)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    widget.value.isEmpty ? LKey.pleaseChoose.tr : widget.value,
                    style: TextStyle(
                      fontSize: 14,
                      color: widget.value.isEmpty
                          ? Color(0xFFA8B4C8)
                          : Color(0xFF172033),
                    ),
                  ),
                ),
                Icon(
                  expanded
                      ? Icons.keyboard_arrow_up_rounded
                      : Icons.keyboard_arrow_down_rounded,
                  size: 20,
                  color: const Color(0xFFA8B4C8),
                ),
              ],
            ),
          ),
        ),
        if (expanded)
          Container(
            margin: const EdgeInsets.only(top: 4),
            padding: EdgeInsetsDirectional.only(top: 5, bottom: 0, end: 0.5),
            constraints: BoxConstraints(maxHeight: 150),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFE3E9F2)),
            ),
            child: Scrollbar(
              thumbVisibility: true,
              thickness: 5,
              radius: const Radius.circular(10),
              child: ListView.separated(
                padding: EdgeInsetsDirectional.zero,
                itemCount: widget.items.length,
                separatorBuilder: (_, int index) =>
                    Divider(color: Colors.transparent, height: 0),
                itemBuilder: (_, int index) {
                  String e = widget.items[index];
                  return InkWell(
                    onTap: () {
                      widget.onChanged?.call((e, index));
                      setState(() => expanded = false);
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: e == widget.value
                            ? const Color(0xFFE8F0FE)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        e,
                        style: TextStyle(
                          fontSize: 14,
                          color: e == widget.value
                              ? const Color(0xFF3978F6)
                              : const Color(0xFF172033),
                          fontWeight: e == widget.value
                              ? FontWeight.w600
                              : FontWeight.w400,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
      ],
    );
  }
}
