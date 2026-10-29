import 'package:cesc01/core/network/base/interceptor/network_status/network_status.dart';
import 'package:get/get.dart';

/// 网络状态
class AppNetWorkService extends GetxService {
  static AppNetWorkService get to => Get.find();

  Future<AppNetWorkService> init() async {
    return this;
  }

  @override
  void onReady() {
    super.onReady();
    toBind();
  }

  Future<void> toBind() async {
    await NetworkStatusService.instance.init();
  }

  @override
  void onClose() {
    super.onClose();
    NetworkStatusService.instance.dispose();
  }
}
