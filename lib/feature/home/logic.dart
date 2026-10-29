part of 'index.dart';

class HomeLogic extends BaseNetConnectLogic {
  bool isSupportBLE = true;
  DashboardSummary? summary;
  List<DashboardAttentionSites> sites = [];

  ///没有站点就显示，有站点就隐藏
  bool showProvision = false;

  ///首屏加载中（仅首次进入展示骨架屏，下拉刷新不展示）
  bool isLoading = true;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  @override
  void onReady() {
    super.onReady();
    supportBLE();
    loadHome();
  }

  Future<void> loadHome() async {
    loadData(
      onFetch: () {
        fetchHomeApi();
      },
      onIntercept: () {
        isLoading = false;
        update();
      },
    );
  }

  void supportBLE() async {
    isSupportBLE = await BLEManager.instance.isSupportedBLE();
  }

  ///去配网
  void toProvision() {
    if (isSupportBLE) {
      PageTools.toProvision();
    } else {
      AppLoading.toast(LKey.bleSupportTip.tr);
    }
  }

  Future<void> fetchHomeApi() async {
    final (
      bool isSuccessful,
      DashboardEntity data,
    ) = await HomeAPI.getDashboard().whenComplete(() {
      isLoading = false;
    });
    if (isSuccessful) {
      summary = data.summary;
      sites.assignAll(data.sites ?? []);
      showProvision = sites.isEmpty;
    }
    update();
  }
}
