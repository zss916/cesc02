import 'package:cesc01/core/translations/lan_key.dart';
import 'package:cesc01/feature/provision/sheet/success_sheet.dart';
import 'package:cesc01/feature/provision/sheet/timeout_sheet.dart';
import 'package:cesc01/routes/index.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

mixin StateSheetCtrl {
  ///提示配网成功
  void toShowSuccess() {
    showSuccessSheet(
      title: LKey.configNetWorkCompleted.tr,
      content: LKey.configNetWorkCompletedTip.tr,
      name: ARoute.configNetworkSheet,
    );
  }

  ///提示配网超时
  void toShowTimeOut() {
    showTimeOutSheet(
      title: LKey.configTimeOut.tr,
      content: '',
      name: ARoute.configTimeOutSheet,
    );
  }

  ///提示配网错误
  void toShowError({String? error}) {
    showTimeOutSheet(
      title: LKey.configFailed.tr,
      content: error ?? "",
      name: ARoute.configErrorSheet,
    );
  }
}
