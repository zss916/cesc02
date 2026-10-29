part of 'index.dart';

class MessageLogic extends BaseNetStateLogic with NetWorkRefreshEvent {
  List<NotifyItemEntity> list = [];
  List<String> levelFilterList = [];

  @override
  void onInit() {
    super.onInit();
    onNetWorkRefresh(
      onRefresh: () {
        loadData(
          loading: true,
          isDelayed: true,
          onFetch: () {
            fetchDataApi();
          },
        );
      },
    );
  }

  @override
  void onClose() {
    super.onClose();
    onDisposeNetWork();
  }

  @override
  void onReady() {
    super.onReady();
    initCacheData();
    loadData(
      onFetch: () {
        fetchDataApi();
      },
    );
  }

  void initCacheData() {
    List<String> value = UserHelper.instance
        .getNotifyFilter()
        .map((e) => e.toString())
        .toList();
    levelFilterList.assignAll(value);
  }

  Future<void> fetchDataApi() async {
    ApiResult<List<NotifyItemEntity>> result =
        await NotifyAPI.getNotifications();
    switch (result) {
      case ApiSuccess(:final data):
        List<NotifyItemEntity> value = data
            .where((e) => !levelFilterList.contains(e.level))
            .toList();
        list.assignAll(value);
        state = list.isEmpty ? Empty() : Success<List<NotifyItemEntity>>(list);
        update();
      case ApiError(:final errorState, :final msg):
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
