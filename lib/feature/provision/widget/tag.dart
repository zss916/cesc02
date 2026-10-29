import 'package:flutter/material.dart';

/// 状态标签（待连接/已连接）
class Tag extends StatelessWidget {
  final String text;
  final bool ok;
  const Tag({super.key, required this.text, this.ok = false});

  @override
  Widget build(BuildContext context) {
    final bg = ok ? const Color(0xFFE7F8EE) : const Color(0xFFFFF1E6);
    final fg = ok ? const Color(0xFF34C759) : const Color(0xFFEF8F32);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 11.5,
          fontWeight: FontWeight.w600,
          color: fg,
        ),
      ),
    );
  }
}
