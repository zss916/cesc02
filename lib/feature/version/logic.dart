part of 'index.dart';

class VersionInfoLogic extends BaseNetStateLogic with NetWorkRefreshEvent {
  late String id;

  @override
  void onInit() {
    super.onInit();
    id = Get.arguments['stackId'].toString();
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
    loadData(
      onFetch: () {
        fetchDataApi();
      },
    );
  }

  Future<void> fetchDataApi() async {
    ApiResult<VersionDataEntity> result = await SiteAPI.getVersionInfo(
      stackId: id,
    );
    switch (result) {
      case ApiSuccess(:final data):
        state = Success<VersionDataEntity>(data);
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
