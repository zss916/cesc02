import 'package:flutter/material.dart';

/// 状态行（标签 + 右侧状态点+文字）
class StatusRow extends StatelessWidget {
  final String label, value;
  final bool ok, doing;
  final Function? onTap;
  const StatusRow({
    super.key,
    required this.label,
    required this.value,
    this.onTap,
    this.ok = false,
    this.doing = false,
  });

  @override
  Widget build(BuildContext context) {
    final dotColor = ok
        ? const Color(0xFF34C759)
        : (doing ? const Color(0xFF3978F6) : const Color(0xFFE75252));
    final textColor = ok
        ? const Color(0xFF34C759)
        : (doing ? const Color(0xFF3978F6) : const Color(0xFFE75252));
    return GestureDetector(
      onTap: () {
        onTap?.call();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFE3E9F2)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(fontSize: 13, color: Color(0xFF6F7D92)),
            ),
            Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: dotColor,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: textColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
