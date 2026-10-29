part of 'index.dart';

class RealTimeView extends StatelessWidget {
  const RealTimeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppPageTitle(title: LKey.realtime.tr, subTitle: ''),
        Divider(height: 6, color: Colors.transparent),
        Expanded(
          child: GetBuilder<RealTimeLogic>(
            init: RealTimeLogic(),
            builder: (logic) {
              return Column(
                children: [
                  SearchBarWidget(
                    onChange: (value) {
                      logic.keyword = value;
                    },
                    onInput: (value) {
                      logic.keyword = value;
                      logic.toSearch();
                    },
                  ),
                  Divider(height: 14, color: Colors.transparent),
                  RealtimeFilterWidget(
                    onFilter: (filter) {
                      logic.status = filter;
                      logic.toSearch();
                    },
                  ),
                  Expanded(
                    child: buildBodyUI(state: logic.state, logic: logic),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  Widget buildBodyUI({required UiState state, required RealTimeLogic logic}) {
    return switch (state) {
      Success(:final data) => buildList(logic, data),
      Empty() => buildEmpty(),
      Loading() => buildLoading(),
      Offline() => buildOffline(),
      Failure() => SizedBox.shrink(),
    };
  }

  Widget buildList(RealTimeLogic logic, List<RealtimePageList> data) {
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
      child: ListView.separated(
        padding: EdgeInsetsDirectional.only(
          start: 16,
          end: 16,
          top: 0,
          bottom: 30,
        ),
        shrinkWrap: true,
        itemCount: data.length,
        separatorBuilder: (_, i) =>
            Divider(height: 14, color: Colors.transparent),
        itemBuilder: (_, i) => SiteCard(item: data[i]),
      ),
    );
  }
}
