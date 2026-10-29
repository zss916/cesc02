part of 'index.dart';

class StackAlarmDetailLogic extends BaseNetStateLogic with NetWorkRefreshEvent {
  String? siteId;
  String? stackSn;
  String? status;
  bool? isMessage;

  @override
  void onInit() {
    super.onInit();
    siteId = Get.arguments['siteId'].toString();
    stackSn = Get.arguments['stackSn'].toString();
    status = Get.arguments['status'].toString();
    isMessage = Get.arguments['isMessage'] as bool?;
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
    ApiResult<StackAlarmDetailEntity> result =
        await AlarmAPI.getStackAlarmDetail(
          siteId: siteId,
          stackSn: stackSn,
          status: status,
        );
    switch (result) {
      case ApiSuccess(:final data):
        state = Success<StackAlarmDetailEntity>(data);
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
