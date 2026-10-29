part of '../index.dart';

class HistoryAlarmLogic extends BaseNetStateLogic
    with NetWorkRefreshEvent, RefreshControllerHelper {
  int pageNum = 1;
  int? alarmLevel;
  String? siteId;
  String? stackSn;
  List<AlarmDetailEntity> alarmList = [];
  AlarmSummaryEntity? summary;
  List<SiteItemEntity> siteList = [];

  @override
  void onInit() {
    super.onInit();
    onNetWorkRefresh(
      onRefresh: () {
        loadData(
          loading: true,
          isDelayed: true,
          onFetch: () {
            refreshData();
          },
        );
      },
    );
  }

  @override
  void onClose() {
    super.onClose();
    onRefreshDispose();
    onDisposeNetWork();
  }

  @override
  void onReady() {
    super.onReady();
    loadData(
      onFetch: () {
        refreshData();
        fetchSiteOptionsApi();
      },
    );
  }

  void toFilter() {
    state = Loading();
    update();
    refreshData();
  }

  void refreshData() {
    pageNum = 1;
    fetchDataApi(pageNum: pageNum);
  }

  void loadMoreData() {
    pageNum += 1;
    fetchDataApi(pageNum: pageNum);
  }

  Future<void> fetchDataApi({required int pageNum}) async {
    AlarmSummaryEntity? summaryValue = await AlarmAPI.getAlarmsSummary(
      siteId: siteId,
      stackSn: stackSn,
      alarmLevel: alarmLevel,
      status: AlarmStatus.recovered.value,
    );
    summary = summaryValue;
    update();

    ApiResult<List<AlarmDetailEntity>> result = await AlarmAPI.postList(
      pageNum: pageNum,
      siteId: siteId,
      stackSn: stackSn,
      alarmLevel: alarmLevel,
      status: AlarmStatus.recovered.value,
    );
    switch (result) {
      case ApiSuccess(:final data):
        if (pageNum == 1) {
          alarmList.assignAll(data);
        } else {
          alarmList.addAll(data);
        }
        refreshAndLoadCtl(pageNum <= 1, data.length);
        state = alarmList.isEmpty
            ? Empty()
            : Success<List<AlarmDetailEntity>>(alarmList);
        update();
      case ApiError(:final errorState, :final msg):
        pageNum -= 1;
        refreshAndLoadCtl(pageNum <= 1, alarmList.length);
        state = Failure();
        update();
        if (errorState == ErrorState.error) {
          AppLoading.toast(msg ?? "");
        } else {
          AppLoading.toast(LKey.loadFailedText.tr);
        }
    }
  }

  Future<void> fetchSiteOptionsApi() async {
    final (bool isSuccessful, List<SiteItemEntity> list) =
        await SiteAPI.getSiteList();
    if (isSuccessful) {
      siteList.assignAll(list);
      update();
    }
  }
}
