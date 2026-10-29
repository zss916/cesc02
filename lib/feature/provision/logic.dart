part of 'index.dart';

class ProvisionLogic extends BaseNetConnectLogic with ProvisionApi {
  String? sn;
  List<SiteItemEntity> siteList = [];

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    getSiteListApi();
  }

  void toBind({required String siteId}) {
    loadData(
      onFetch: () {
        postBindSiteApi(siteId: siteId, sn: sn);
      },
    );
  }

  void toCreateAndBind({
    required String siteName,
    required String countryRegion,
    required String timezone,
    String? address,
  }) {
    createAndBindingSiteApi(
      siteName: siteName,
      countryRegion: countryRegion,
      timezone: timezone,
      address: address,
      sn: sn,
    );
  }

  ///查询站点下拉选项
  Future<void> getSiteListApi() async {
    final (bool isSuccessful, List<SiteItemEntity> list) =
        await SiteAPI.getSiteList();
    if (isSuccessful) {
      siteList.assignAll(list);
      update();
    }
  }
}
