import 'package:cesc01/core/components/build_footer.dart';
import 'package:cesc01/core/components/ui_state_widget/ui_state_widget.dart';
import 'package:cesc01/core/network/bean/alarm_detail_entity.dart';
import 'package:cesc01/core/state/uiState.dart';
import 'package:cesc01/feature/alarm/index.dart';
import 'package:cesc01/feature/alarm/widget/alert_card.dart';
import 'package:cesc01/feature/alarm/widget/filter_site.dart';
import 'package:cesc01/feature/alarm/widget/filter_status_widget.dart';
import 'package:cesc01/feature/alarm/widget/summary_widget.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh_simple/pull_to_refresh_simple.dart';

class HistoryAlarmBarView extends StatelessWidget {
  final HistoryAlarmLogic logic;
  const HistoryAlarmBarView({super.key, required this.logic});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsetsDirectional.symmetric(horizontal: 16),
          width: double.maxFinite,
          child: FilterSite(
            data: logic.siteList,
            onSelect: (site, stack) {
              logic.siteId = site?.siteId;
              logic.stackSn = stack?.stackSn;
              logic.toFilter();
            },
          ),
        ),
        const SizedBox(height: 10),
        FilterStatusWidget(
          onFilter: (value) {
            logic.alarmLevel = value;
            logic.toFilter();
          },
        ),
        const SizedBox(height: 10),
        Expanded(
          child: buildViewUI(state: logic.state, logic: logic),
        ),
      ],
    );
  }

  Widget buildViewUI({
    required UiState state,
    required HistoryAlarmLogic logic,
  }) {
    return switch (state) {
      Loading() => buildLoading(),
      Success(:final data) => buildList(logic: logic, data: data),
      Empty() => buildEmpty(),
      Offline() => buildOffline(),
      Failure() => SizedBox.shrink(),
    };
  }

  Widget buildList({
    required HistoryAlarmLogic logic,
    required List<AlarmDetailEntity> data,
  }) {
    return SmartRefresher(
      header: MaterialClassicHeader(color: Color(0xFF3978F6)),
      footer: BuildFooter(),
      enableSmartPreload: true,
      enablePullDown: true,
      enablePullUp: true,
      controller: logic.refreshCtrl,
      onRefresh: () {
        logic.refreshData();
      },
      onLoading: () {
        logic.loadMoreData();
      },
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: SummaryWidget(summary: logic.summary)),
          SliverToBoxAdapter(child: SizedBox(height: 10)),
          SliverList.separated(
            itemCount: data.length,
            separatorBuilder: (_, i) =>
                Divider(height: 10, color: Colors.transparent),
            itemBuilder: (_, i) => AlertCard(item: data[i], isHistory: true),
          ),
          SliverToBoxAdapter(child: SizedBox(height: 30)),
        ],
      ),
    );
  }
}
