part of 'index.dart';

class StackAlarmDetailPage extends StatelessWidget {
  const StackAlarmDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: appBarColor,
        backgroundColor: appBarColor,
        centerTitle: true,
        title: AppBarTitleWidget(title: LKey.alarmDetails.tr),
      ),
      backgroundColor: appPageColor,
      body: GetBuilder<StackAlarmDetailLogic>(
        init: StackAlarmDetailLogic(),
        builder: (logic) => buildViewUI(state: logic.state),
      ),
    );
  }

  Widget buildViewUI({required UiState state}) {
    return switch (state) {
      Loading() => buildLoading(),
      Success(:final data) => buildBody(data),
      Empty() => Center(child: buildEmpty()),
      Offline() => Center(child: buildOffline()),
      Failure() => SizedBox.shrink(),
    };
  }

  Widget buildBody(StackAlarmDetailEntity data) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: BatteryStackInfoCard(
            siteId: data.siteId,
            siteName: data.showSiteName,
            siteCode: data.showSiteCode,
            stackName: data.showStackName,
            stackSn: data.showStackSn,
            alarmClusterCount: data.alarmClusterCount ?? 0,
            alarmCount: data.alarmCount ?? 0,
          ),
        ),
        SliverToBoxAdapter(
          child: AlarmDetailPanel(
            timezone: data.showTimezone,
            data: data.showClusters,
          ),
        ),
        SliverToBoxAdapter(child: SizedBox(height: 30)),
      ],
    );
  }
}
