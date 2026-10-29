import 'package:cesc01/core/state/network/network_status.dart';
import 'package:cesc01/core/state/uiState.dart';
import 'package:get/get.dart';

abstract class BaseNetStateLogic extends GetxController {
  UiState state = Loading();

  ///loading
  void onLoading() {
    state = Loading();
    update();
  }

  ///offline
  void onOffline() {
    state = Offline();
    update();
  }

  ///load data
  Future<void> loadData<T>({
    bool loading = true,
    bool? isDelayed,
    required Function onFetch,
  }) async {
    if (loading) {
      onLoading();
      if (isDelayed == true) await Future.delayed(Duration(seconds: 2));
    }

    final isConnected = await NetworkStatusService.instance.isConnected();
    if (!isConnected) {
      onOffline();
      return;
    }

    onFetch.call();
  }
}
