import 'package:cesc01/core/helper/tools.dart';
import 'package:get/get.dart';

class Environment {
  static const String appName = String.fromEnvironment(
    'appName',
    defaultValue: 'CESC Core',
  );
}

class AppInfo {
  static const String appName = Environment.appName;
  static const String appVersion = "V1.0.0";

  ///协议
  static const String privacyPolicyE = 'assets/html/privacy-policy-e.html';
  static const String userPolicyE = 'assets/html/user-policy-en.html';
  static const String privacyPolicyZ = 'assets/html/privacy-policy-z.html';
  static const String userPolicyZ = 'assets/html/user-policy-zh.html';
  static String privacyPolicy = Get.isZH ? privacyPolicyZ : privacyPolicyE;
  static String userPolicy = Get.isZH ? userPolicyZ : privacyPolicyZ;
}
