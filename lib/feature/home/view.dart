part of 'index.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppPageTitle(title: LKey.overviewOfBattery.tr, subTitle: ''),
        Expanded(
          child: GetBuilder<HomeLogic>(
            init: HomeLogic(),
            builder: (logic) => buildUI(logic),
          ),
        ),
      ],
    );
  }

  Widget buildUI(HomeLogic logic) {
    return logic.isLoading
        ? const HomeSkeleton()
        : buildBody(logic: logic, data: logic.summary, list: logic.sites);
  }

  Widget buildBody({
    required HomeLogic logic,
    required DashboardSummary? data,
    required List<DashboardAttentionSites> list,
  }) {
    return RefreshIndicator(
      onRefresh: () async {
        logic.loadHome();
        await Future.delayed(Duration(seconds: 2));
      },
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          Divider(height: 6, color: Colors.transparent),
          if (logic.showProvision) ProvisionQuickCard(),
          HomeOverviewWidget(data: data),
          Divider(height: 5, color: Colors.transparent),
          HomeSiteCardList(data: list),
          Divider(height: 30, color: Colors.transparent),
        ],
      ),
    );
  }
}
