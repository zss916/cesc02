import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';
import 'package:cesc01/core/translations/lan_tools.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

extension RateExtension on double {
  String get formatted {
    if (isNaN || isInfinite) return '0';

    final value = this * 100;
    final truncated = (value * 100).truncateToDouble() / 100;

    return truncated.toString().replaceFirst(RegExp(r'\.0$'), '');
  }
  // String get formatted => '${this * 100}'.replaceFirst(RegExp(r'\.0$'), "");
}

///目前根据手机语言判断
extension CheckLancode on GetInterface {
  bool get isZh => Get.locale?.languageCode == "zh";

  bool get isEn => Get.locale?.languageCode == "en";

  bool get isZH => LanTools.isZh();
}

class ScanTool {
  static Future<String> toScan({BuildContext? context}) async {
    final capture = await showAiBarcodeScanner(
      context!,
      enabledActionButtons: const <ScannerAction>{
        //ScannerAction.gallery,
        ScannerAction.cameraSwitch,
        ScannerAction.torch,
        ScannerAction.close,
      },
      showScanHint: false,
    );
    String result = capture?.firstRawValue ?? "";
    return result;
  }
}
