import 'package:cesc01/feature/provision/widget/tag.dart';
import 'package:flutter/material.dart';

// 设备卡片
class SelectDeviceBlueCard extends StatelessWidget {
  final bool selected;
  final bool connected;
  const SelectDeviceBlueCard({
    super.key,
    required this.connected,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: selected ? Colors.blue : const Color(0xFFE3E9F2),
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF102346).withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFFE8F0FE),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.battery_full_rounded,
              color: Color(0xFF3978F6),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Battery-New01',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF172033),
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  'BP26NEW00001 · PowerNest B',
                  style: TextStyle(
                    fontSize: 12,
                    color: const Color(0xFF6F7D92),
                  ),
                ),
              ],
            ),
          ),
          Tag(text: connected ? '已连接' : '待连接', ok: connected),
        ],
      ),
    );
  }
}
