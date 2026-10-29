import 'package:flutter/material.dart';

/// 步进圆点
class StepCircle extends StatelessWidget {
  final int index;
  final bool done, active;
  const StepCircle({
    super.key,
    required this.index,
    required this.done,
    required this.active,
  });

  @override
  Widget build(BuildContext context) {
    final bg = done
        ? const Color(0xFF34C759)
        : (active ? const Color(0xFF3978F6) : const Color(0xFFE3E9F2));
    final fg = done || active ? Colors.white : const Color(0xFFA8B4C8);
    return Container(
      width: 26,
      height: 26,
      decoration: BoxDecoration(color: bg, shape: BoxShape.circle),
      alignment: Alignment.center,
      child: done
          ? const Icon(Icons.check_rounded, size: 16, color: Colors.white)
          : Text(
              '$index',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: fg,
              ),
            ),
    );
  }
}
