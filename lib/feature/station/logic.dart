part of 'index.dart';

class StationLogic extends BaseNetStateLogic
    with NetWorkRefreshEvent, RefreshControllerHelper {
  int pageNum = 0;
  String? siteId;
  SiteItemEntity? siteItem;
  List<SiteItemEntity> sites = [];
  LocationWidgetState locationState = LocationWidgetState.loading;
  List<OptionsStacks> options = [];
  StackAndClusterEntity? stackAndClusterData;

  @override
  void onInit() {
    super.onInit();
    getCacheData();
    onNetWorkRefresh(
      onRefresh: () {
        loadData(
          loading: true,
          isDelayed: true,
          onFetch: () {
            fetchData();
          },
        );
      },
    );
  }

  @override
  void onReady() {
    super.onReady();
    refreshStation(loading: true);
  }

  void getCacheData() async {
    RecentlyData? recentlyData = await UserHelper.instance.getRecentlyViewed();
    siteId = recentlyData?.siteId ?? "";
  }

  void refreshStation({bool loading = false}) {
    loadData<String>(
      loading: loading,
      onFetch: () {
        fetchData();
      },
    );
  }

  @override
  void onClose() {
    super.onClose();
    onRefreshDispose();
    onDisposeNetWork();
  }

  ///下拉刷新全部数据
  Future<void> fetchData() async {
    fetchOverViewApi();
    //_refreshData();
    getSiteListApi();
    getOptionsApi();
  }

  ///预览数据
  Future<void> fetchOverViewApi() async {
    if ((siteId ?? '').isEmpty) {
      state = Empty();
      return;
    }
    ApiResult<SiteOverViewDataEntity> result = await SiteAPI.getOverView(
      siteId: siteId,
    );
    switch (result) {
      case ApiSuccess(:final data):
        state = Success<SiteOverViewDataEntity>(data);
        update();
      case ApiError(:final errorState, :final msg):
        state = Failure();
        update();
        if (errorState == ErrorState.error) {
          AppLoading.toast(msg ?? "");
        } else if (errorState == ErrorState.paramError) {
          state = Empty();
          update();
        } else {
          AppLoading.toast(LKey.loadFailedText.tr);
        }
    }
  }

  ///查询站点下拉选项
  Future<void> getSiteListApi() async {
    if ((siteId ?? '').isNotEmpty) {
      final (bool isSuccessful, List<SiteItemEntity> list) =
          await SiteAPI.getSiteList();

      if (isSuccessful) {
        sites.assignAll(list);
        if (siteId != null) {
          List<SiteItemEntity> data = sites
              .where((e) => e.siteId == siteId)
              .toList();
          if (data.isNotEmpty) {
            siteItem = data.first;
            locationState = LocationWidgetState.success;
            update();
          } else {
            locationState = LocationWidgetState.error;
            update();
          }
        } else {
          locationState = LocationWidgetState.error;
          update();
        }
      } else {
        locationState = LocationWidgetState.error;
        update();
      }
    } else {
      locationState = LocationWidgetState.error;
      update();
    }
  }

  ///下拉数据
  Future<void> getOptionsApi() async {
    OptionsEntity? data = await SiteAPI.getOptions(siteId: siteId);
    if (data != null) {
      options = (data.stacks ?? []);
      update();
      if (options.isNotEmpty) {
        StackAndClusterEntity? value = await SiteAPI.getStackAndCluster(
          stackId: options.first.stackId ?? "",
          clusterId: null,
        );
        if (value != null) {
          stackAndClusterData = value;
          update();
        }
      }
    }
  }

  Future<void> fetchStackAndClusterApi({
    required String stackId,
    String? clusterId,
  }) async {
    StackAndClusterEntity? value = await SiteAPI.getStackAndCluster(
      stackId: stackId,
      clusterId: clusterId,
    );
    if (value != null) {
      stackAndClusterData = value;
      update();
    }
  }
}
