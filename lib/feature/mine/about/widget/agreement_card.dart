import 'package:cesc01/core/helper/app_env.dart';
import 'package:cesc01/core/translations/lan_key.dart';
import 'package:cesc01/routes/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class AgreementCard extends StatelessWidget {
  const AgreementCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A102346),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          _agreementRow(
            icon: Icons.description_rounded,
            iconColor: const Color(0xFF3978F6),
            iconBg: const Color(0xFFEAF1FF),
            title: LKey.userAgreement.tr,
            url: AppInfo.userPolicy,
          ),
          const Divider(
            height: 1,
            thickness: 1,
            indent: 54,
            color: Color(0xFFF0F2F7),
          ),
          _agreementRow(
            icon: Icons.description_rounded,
            iconColor: const Color(0xFF11A879),
            iconBg: const Color(0xFFE3F6EE),
            title: LKey.privacyPolicy.tr,
            url: AppInfo.privacyPolicy,
          ),
        ],
      ),
    );
  }

  Widget _agreementRow({
    required IconData icon,
    required Color iconColor,
    required Color iconBg,
    required String title,
    required String url,
  }) {
    return InkWell(
      onTap: () => _openUrl(title, url),
      borderRadius: BorderRadius.circular(14),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: iconBg,
                borderRadius: BorderRadius.circular(9),
              ),
              child: Icon(icon, color: iconColor, size: 18),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF172033),
                ),
              ),
            ),
            const Icon(
              Icons.chevron_right_rounded,
              color: Color(0xFFC2CCDB),
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _openUrl(String title, String url) async {
    PageTools.toWeb(title: title, url: url);
    // final uri = Uri.parse(url);
    /*if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      Get.snackbar(
        '提示', '无法打开链接',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFF172033),
        colorText: Colors.white,
        margin: const EdgeInsets.all(16),
        borderRadius: 10,
      );
    }*/
  }
}
