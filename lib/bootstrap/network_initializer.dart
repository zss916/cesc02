import 'package:cesc01/core/service/app_network_service.dart';
import 'package:get/get.dart';

import 'app_initializer.dart';

class NetworkInitializer implements AppInitializer {
  @override
  Future<void> init() async {
    Get.putAsync<AppNetWorkService>(() => AppNetWorkService().init());
  }
}
