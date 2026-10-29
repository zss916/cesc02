import 'package:cesc01/core/translations/lan_key.dart';
import 'package:cesc01/feature/provision/widget/tag.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

// 设备卡片
class DeviceBlueCard extends StatelessWidget {
  final bool connected;
  final String sn;
  final bool? checked;
  const DeviceBlueCard({
    super.key,
    required this.connected,
    required this.sn,
    this.checked,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        //border: Border.all(color: Colors.blue),
        border: Border.all(
          width: 1,
          color: (checked == true) ? Colors.blue : const Color(0xFFE3E9F2),
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
            child: Icon(Icons.battery_full_rounded, color: Color(0xFF3978F6)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              sn,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: (checked == true) ? Colors.blue : Color(0xFF172033),
              ),
            ),
          ),
          Tag(
            text: connected ? LKey.connected.tr : LKey.toBeConnected.tr,
            ok: connected,
          ),
        ],
      ),
    );
  }
}
