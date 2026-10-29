import 'package:cesc01/core/system/util/storage/storage_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LanTools {
  static const String lanKey = "locale";

  static bool isZh() {
    Locale? locale = LanTools.getLocale() ?? Get.deviceLocale;
    return locale?.languageCode == "zh";
  }

  static Locale? getLocale() {
    String localeString = StorageUtil.getString(lanKey);
    if (localeString.isNotEmpty) {
      final localeList = localeString.split('_');
      return Locale(localeList[0], localeList.length > 1 ? localeList[1] : '');
    }
    return null;
  }

  static void setLocal() {
    var locale = Get.locale;
    if (locale != null) {
      StorageUtil.setString(lanKey, locale.toString());
    }
  }
}
