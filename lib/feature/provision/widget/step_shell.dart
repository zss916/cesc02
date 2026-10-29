import 'package:flutter/material.dart';

/// 步骤内容外壳（图标 + 标题 + 描述 + children）
class StepShell extends StatelessWidget {
  final IconData icon;
  final Color iconColor, iconBg;
  final String title, desc;
  final List<Widget> children;
  final TextStyle? descTextStyle;
  const StepShell({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.iconBg,
    required this.title,
    required this.desc,
    this.descTextStyle,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            color: iconBg,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Icon(icon, size: 38, color: iconColor),
        ),
        const SizedBox(height: 18),
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: Color(0xFF172033),
          ),
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            desc,
            textAlign: TextAlign.center,
            style:
                descTextStyle ??
                const TextStyle(
                  fontSize: 12.5,
                  color: Color(0xFF6F7D92),
                  height: 1.5,
                ),
          ),
        ),
        ...children,
      ],
    );
  }
}
