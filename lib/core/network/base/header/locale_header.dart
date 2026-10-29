import 'package:flutter/material.dart';
import 'package:get/get.dart' as GetX;
import 'package:get/get.dart';

class LocaleHeader {
  static String getLocal() {
    Locale? locale = Get.deviceLocale;
    var language = '';
    if (locale != null) {
      if (locale == const Locale('en', 'US')) {
        language = 'en-US';
      }
      if (locale == const Locale('el', 'GR')) {
        language = 'el-GR';
      }
      if (locale == const Locale('uk', 'UA')) {
        language = 'uk-UA';
      }
      if (locale == const Locale('de', 'DE')) {
        language = 'de-DE';
      }
      if (locale == const Locale('fr', 'FR')) {
        language = 'fr-FR';
      }
      if (locale == const Locale('it', 'IT')) {
        language = 'it-IT';
      }
      if (locale == const Locale('es', 'ES')) {
        language = 'es-ES';
      }
      if (locale.languageCode == 'zh' && locale.countryCode == 'CN') {
        language = 'zh-CN';
      }
    }
    return language;
  }
}
