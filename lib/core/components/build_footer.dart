import 'package:cesc01/core/translations/lan_key.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:pull_to_refresh_simple/pull_to_refresh_simple.dart';

class BuildFooter extends StatelessWidget {
  const BuildFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return ClassicFooter(
      idleText: LKey.idleLoadingText.tr,
      canLoadingText: LKey.canLoadingText.tr,
      loadingText: LKey.loadingText.tr,
      noDataText: LKey.noMoreText.tr,
      failedText: LKey.loadFailedText.tr,
    );
  }
}
