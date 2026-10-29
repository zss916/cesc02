import 'package:flutter/material.dart';

/// 主按钮
class PrimaryBtn extends StatelessWidget {
  final String label;
  final bool loading;
  final VoidCallback? onTap;
  const PrimaryBtn({
    super.key,
    required this.label,
    this.loading = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF3978F6),
          foregroundColor: Colors.white,
          disabledBackgroundColor: const Color(0xFFAECBFA),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: loading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  strokeCap: StrokeCap.round,
                  color: Colors.white,
                ),
              )
            : Text(
                label,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
      ),
    );
  }
}
