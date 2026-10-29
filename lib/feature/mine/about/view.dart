import 'package:cesc01/core/components/app_bar_title_widget.dart';
import 'package:cesc01/core/system/app_colors.dart';
import 'package:cesc01/core/translations/lan_key.dart';
import 'package:cesc01/feature/mine/about/widget/agreement_card.dart';
import 'package:cesc01/feature/mine/about/widget/app_branding.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: appBarColor,
        backgroundColor: appBarColor,
        centerTitle: true,
        title: AppBarTitleWidget(title: LKey.aboutApp.tr),
      ),
      backgroundColor: appPageColor,
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          const SizedBox(height: 28),
          AppBranding(),
          const SizedBox(height: 20),
          AgreementCard(),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
