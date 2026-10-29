import 'package:flutter/material.dart';

/// 描边按钮
class OutlineBtn extends StatelessWidget {
  final String label;
  final bool loading;
  final VoidCallback? onTap;
  const OutlineBtn({
    super.key,
    required this.label,
    this.loading = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 44,
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Color(0xFFE3E9F2)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: loading
            ? const SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  strokeCap: StrokeCap.round,
                  color: Color(0xFF3978F6),
                ),
              )
            : Text(
                label,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF3978F6),
                ),
              ),
      ),
    );
  }
}
