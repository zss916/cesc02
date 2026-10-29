import 'package:cesc01/bootstrap/application.dart';
import 'package:cesc01/core/system/theme/app_system_theme.dart';
import 'package:cesc01/core/translations/lan_tools.dart';
import 'package:cesc01/core/translations/language.dart';
import 'package:cesc01/routes/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

void main() => Application.init().then((value) => runApp(const MyApp()));

//void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      splitScreenMode: true,
      minTextAdapt: true,
      designSize: const Size(375, 812),
      builder: (context, child) {
        return GetMaterialApp(
          defaultTransition: Transition.native,
          debugShowCheckedModeBanner: false,
          translations: AppTranslations(),
          locale: (LanTools.getLocale() ?? Get.deviceLocale),
          fallbackLocale: const Locale('en', 'US'),
          builder: (context, child) => EasyLoading.init()(context, child!),
          navigatorObservers: [appRouteObserver],
          getPages: ARoute.routes,
          theme: AppSystemTheme.light,
          darkTheme: AppSystemTheme.dark,
          themeMode: ThemeMode.light,
          initialRoute: ARoute.main,
        );
      },
    );
  }
}
