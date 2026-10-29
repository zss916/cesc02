part of 'index.dart';

class SiteDetailView extends StatefulWidget {
  const SiteDetailView({super.key});

  @override
  State<SiteDetailView> createState() => SiteDetailPageState();
}

class SiteDetailPageState extends State<SiteDetailView>
    with SingleTickerProviderStateMixin, AppStateMixin {
  TabController? tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    tabController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StationLogic>(
      init: StationLogic(),
      builder: (logic) {
        return Column(
          children: [
            _siteHeader(logic),
            Divider(height: 4, color: Colors.transparent),
            Expanded(
              child: buildBodyUI(state: logic.state, logic: logic),
            ),
          ],
        );
      },
    );
  }

  Widget buildBodyUI({required UiState state, required StationLogic logic}) {
    return switch (state) {
      Success(:final data) => buildContent(logic: logic, data: data),
      //Empty() => buildEmpty(),
      Empty() => BuildEmptySite(),
      Loading() => buildLoading(),
      Offline() => buildOffline(),
      Failure() => SizedBox.shrink(),
    };
  }

  Widget buildContent({
    required StationLogic logic,
    required SiteOverViewDataEntity data,
  }) {
    return AppRefreshIndicator(
      notificationPredicate: (notification) {
        return notification.depth == 2;
      },
      child: NestedScrollView(
        headerSliverBuilder: (_, a) {
          return [
            SliverToBoxAdapter(child: SingleSiteInfoItem(data: data)),
            SliverToBoxAdapter(child: SizedBox(height: 8)),
            SliverAppBar(
              //surfaceTintColor: appPageColor,
              backgroundColor: appPageColor,
              leading: SizedBox.shrink(),
              leadingWidth: 0,
              title: BuildSiteTabBar(controller: tabController),
              centerTitle: true,
              pinned: true,
              floating: false,
              snap: false,
              elevation: 0.0,
            ),
            SliverToBoxAdapter(child: SizedBox(height: 8)),
          ];
        },
        body: TabBarView(
          controller: tabController,
          children: [
            OliveData(
              data: data,
              onTap: (item) {
                safeSetState(() {
                  tabController?.animateTo(1);
                  logic.fetchStackAndClusterApi(stackId: item.stackId ?? "");
                });
              },
            ),
            BatteryData(
              options: logic.options,
              stackAndClusterData: logic.stackAndClusterData,
              siteId: logic.siteId,
              onSwitch: (stackId, clusterId) {
                logic.fetchStackAndClusterApi(
                  stackId: stackId ?? "",
                  clusterId: clusterId,
                );
              },
            ),
          ],
        ),
      ),
      onRefresh: () => refresh(logic: logic),
    );
  }

  Future<void> refresh({required StationLogic logic}) async {
    await logic.fetchData();
    await Future.delayed(const Duration(seconds: 1));
  }

  Widget _siteHeader(StationLogic logic) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 6),
      child: Row(
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsetsDirectional.only(end: 10),
              child: Text(
                LKey.siteDetail.tr,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF172033),
                ),
              ),
            ),
          ),
          BuildSelectSite(
            selectSite: logic.siteItem,
            state: logic.locationState,
            data: logic.sites,
            onSelect: (site) {
              logic.siteId = site.siteId;
              logic.siteItem = site;
              logic.refreshStation();
            },
          ),
        ],
      ),
    );
  }
}
