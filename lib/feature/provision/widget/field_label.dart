import 'package:flutter/material.dart';

/// 字段标签
class FieldLabel extends StatelessWidget {
  final String text;
  final AlignmentGeometry? alignment;
  const FieldLabel(this.text, {super.key, this.alignment});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment ?? AlignmentDirectional.centerStart,
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 12.5,
          fontWeight: FontWeight.w500,
          color: Color(0xFF5B6B85),
        ),
      ),
    );
  }
}
