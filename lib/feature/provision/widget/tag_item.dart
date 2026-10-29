import 'package:flutter/material.dart';

/// Tab 项
class TabItem extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;
  const TabItem({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 38,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected ? Color(0xFF3978F6) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          boxShadow: selected
              ? [
                  BoxShadow(
                    color: const Color(0xFF102346).withValues(alpha: 0.06),
                    blurRadius: 4,
                  ),
                ]
              : null,
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13.5,
            fontWeight: FontWeight.w600,
            color: selected ? Colors.white : const Color(0xFF6F7D92),
          ),
        ),
      ),
    );
  }
}
