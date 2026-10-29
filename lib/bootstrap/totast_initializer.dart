import 'package:cesc01/core/helper/app_loading.dart';

import 'app_initializer.dart';

class ToastInitializer implements AppInitializer {
  @override
  Future<void> init() async {
    AppLoading();
  }
}
