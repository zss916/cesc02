import 'package:cesc01/core/translations/lan_key.dart';
import 'package:cesc01/routes/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showOrgDialog({required String value}) => showInfoDialog(
  title: LKey.organization.tr,
  heading: value,
  subtitle: LKey.organizationTitle.trArgs([value]),
);

void showInfoDialog({
  required String title,
  required String heading,
  required String subtitle,
}) {
  Get.dialog(
    _InfoDialog(title: title, heading: heading, subtitle: subtitle),
    barrierColor: Colors.black.withValues(alpha: 0.45),
    routeSettings: RouteSettings(name: ARoute.orgDialog),
  );
}

class _InfoDialog extends StatelessWidget {
  final String title, heading, subtitle;
  const _InfoDialog({
    required this.title,
    required this.heading,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      insetPadding: const EdgeInsets.symmetric(horizontal: 32),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 12, 0),
            child: Row(
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1A1A1A),
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () => Get.back(),
                  child: const Icon(
                    Icons.close_rounded,
                    size: 20,
                    color: Color(0xFF8A8F99),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 28),
          Center(
            child: Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: const Color(0xFFE8F0FF),
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Icon(
                Icons.apartment_rounded,
                size: 28,
                color: Color(0xFF2E6BFF),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Center(
            child: Text(
              heading,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1A1A1A),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF8A8F99),
                height: 1.5,
              ),
            ),
          ),
          const SizedBox(height: 24),
          Container(
            decoration: const BoxDecoration(
              color: Color(0xFFF7F8FA),
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
            ),
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () => Get.back(),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xFFE3E5E8)),
                    ),
                    child: Text(
                      LKey.iKnow.tr,
                      style: TextStyle(fontSize: 13, color: Color(0xFF4A5160)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
