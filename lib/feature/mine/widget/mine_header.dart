import 'package:cesc01/feature/mine/widget/avatar_widget.dart';
import 'package:flutter/material.dart';

class MineHeader extends StatelessWidget {
  final String name;
  final String? intro;
  final String? title;
  final Function onTap;
  const MineHeader({
    super.key,
    this.intro,
    required this.name,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF102346).withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          AvatarWidget(
            onTap: () {
              onTap.call();
            },
          ),
          const SizedBox(height: 12),
          Text(
            name,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Color(0xFF172033),
            ),
          ),
          const SizedBox(height: 3),
          if ((intro ?? "").isNotEmpty)
            Text(
              intro ?? "",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, color: Color(0xFF6F7D92)),
            ),
          const SizedBox(height: 12),
          if ((title ?? '').isNotEmpty)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
              decoration: BoxDecoration(
                color: const Color(0xFFEAF1FF),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                title ?? "",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF3978F6),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
