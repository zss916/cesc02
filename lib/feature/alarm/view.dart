part of 'index.dart';

class AlertsView extends StatelessWidget {
  const AlertsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppPageTitle(title: LKey.alarmList.tr, subTitle: ''),
        Divider(height: 6, color: Colors.transparent),
        Expanded(
          child: DefaultTabController(
            length: 2,
            child: Column(
              children: [
                BuildTabBar(),
                Expanded(
                  child: TabBarView(
                    //physics: NeverScrollableScrollPhysics(),
                    children: [
                      AppKeepAlivePage(
                        GetBuilder<RealAlarmLogic>(
                          init: RealAlarmLogic(),
                          builder: (logic) {
                            return RealAlarmBarView(logic: logic);
                          },
                        ),
                      ),
                      AppKeepAlivePage(
                        GetBuilder<HistoryAlarmLogic>(
                          init: HistoryAlarmLogic(),
                          builder: (logic) {
                            return HistoryAlarmBarView(logic: logic);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
