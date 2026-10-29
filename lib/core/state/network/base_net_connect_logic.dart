import 'package:cesc01/core/state/network/network_status.dart';
import 'package:cesc01/core/translations/lan_key.dart';
import 'package:cesc01/feature/login/widget/dialog_utils.dart';
import 'package:get/get.dart';

abstract class BaseNetConnectLogic extends GetxController {
  ///load data
  Future<void> loadData<T>({
    required Function onFetch,
    Function? onIntercept,
  }) async {
    bool isConnected = await NetworkStatusService.instance.isConnected();
    if (!isConnected) {
      DialogUtils.showSnackBar(
        LKey.noInternetConnection.tr,
        snackbarType: SnackbarType.failure,
      );
      onIntercept?.call();
      return;
    }

    bool isPoorNetwork = NetworkStatusService.instance.isPoorNetwork;
    if (isPoorNetwork) {
      DialogUtils.showSnackBar(
        LKey.weakNetworkStatus.tr,
        snackbarType: SnackbarType.weak,
      );
      onIntercept?.call();
      return;
    }

    onFetch.call();
  }
}
