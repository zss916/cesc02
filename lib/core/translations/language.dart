import 'package:cesc01/core/translations/en.dart';
import 'package:cesc01/core/translations/zh.dart';
import 'package:get/get_navigation/src/root/internacionalization.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys {
    return {"en": en, "zh": zh};
  }
}
