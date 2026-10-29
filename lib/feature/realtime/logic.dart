part of 'index.dart';

class RealTimeLogic extends BaseNetStateLogic
    with NetWorkRefreshEvent, RefreshControllerHelper {
  int pageNum = 1;
  String? keyword;
  String? status;
  List<RealtimePageList> siteList = [];

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
      },
    );
  }

  void toSearch() {
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
    ApiResult<List<RealtimePageList>> result = await RealTimeAPI.postList(
      pageNum: pageNum,
      keyword: keyword,
      commStatus: status,
    );
    switch (result) {
      case ApiSuccess(:final data):
        if (pageNum == 1) {
          siteList.assignAll(data);
        } else {
          siteList.addAll(data);
        }
        refreshAndLoadCtl(pageNum <= 1, data.length);
        state = siteList.isEmpty
            ? Empty()
            : Success<List<RealtimePageList>>(siteList);
        update();
      case ApiError(:final errorState, :final msg):
        pageNum -= 1;
        refreshAndLoadCtl(pageNum <= 1, siteList.length);
        state = Failure();
        update();
        if (errorState == ErrorState.error) {
          AppLoading.toast(msg ?? "");
        } else {
          AppLoading.toast(LKey.loadFailedText.tr);
        }
    }
  }
}
