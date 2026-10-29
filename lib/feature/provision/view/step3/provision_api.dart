import 'package:cesc01/core/helper/app_loading.dart';
import 'package:cesc01/core/network/api/provision.dart';
import 'package:cesc01/core/network/bean/site_entity.dart';
import 'package:cesc01/core/translations/lan_key.dart';
import 'package:cesc01/feature/provision/helper/smart_ble_link_tools.dart';
import 'package:cesc01/feature/provision/sheet/success_sheet.dart';
import 'package:get/get.dart';

mixin ProvisionApi {
  ///新建和绑定站点
  Future<void> createAndBindingSiteApi({
    required String siteName,
    required String countryRegion,
    required String timezone,
    required String? sn,
    String? address,
  }) async {
    if ((sn ?? "").isEmpty) {
      AppLoading.toastBottom(LKey.snIsNull.tr);
      return;
    }

    if (siteName.isEmpty) {
      AppLoading.toastBottom(LKey.inputSiteNameHint.tr);
      return;
    }

    if (countryRegion.isEmpty) {
      AppLoading.toastBottom(LKey.selectCountry.tr);
      return;
    }

    if (timezone.isEmpty) {
      AppLoading.toastBottom(LKey.selectTimeZone.tr);
      return;
    }

    final (
      bool isSuccessful,
      SiteEntity? value,
    ) = await ProvisionAPI.createAndBindingSite(
      name: siteName,
      countryRegion: countryRegion,
      timezone: timezone,
      detailAddress: address,
      stackSns: [(sn ?? '')],
    );
    if (isSuccessful) {
      toSuccessfulSheet(
        title: LKey.siteCreateSuccessful.tr,
        onNext: () {
          SmartBleLinkTools.instance.stopLinking();
          Get.back<void>(closeOverlays: true);
        },
      );
    }
  }

  ///绑定站点
  Future<void> postBindSiteApi({
    required String siteId,
    required String? sn,
  }) async {
    if ((sn ?? "").isEmpty) {
      AppLoading.toastBottom(LKey.snIsNull.tr);
      return;
    }

    if (siteId.isEmpty) {
      AppLoading.toastBottom(LKey.selectExistingSite.tr);
      return;
    }

    bool isSuccessful = await ProvisionAPI.postBindSite(
      siteId: siteId,
      stackSns: [(sn ?? '')],
    );
    if (isSuccessful) {
      toSuccessfulSheet(
        title: LKey.siteEditSuccessful.tr,
        onNext: () {
          SmartBleLinkTools.instance.stopLinking();
          Get.back<void>(closeOverlays: true);
        },
      );
    }
  }
}
