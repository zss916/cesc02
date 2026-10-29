part of 'index.dart';

class MessagePage extends StatelessWidget {
  const MessagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: appBarColor,
        backgroundColor: appBarColor,
        centerTitle: true,
        title: AppBarTitleWidget(title: LKey.message.tr),
      ),
      backgroundColor: appPageColor,
      body: GetBuilder<MessageLogic>(
        init: MessageLogic(),
        builder: (logic) => buildViewUI(state: logic.state),
      ),
    );
  }

  Widget buildViewUI({required UiState state}) {
    return switch (state) {
      Loading() => buildLoading(),
      // Loading() => const MessageSkeleton(),
      Success(:final data) => buildList(data),
      Empty() => Center(child: buildEmpty()),
      Offline() => Center(child: buildOffline()),
      Failure() => SizedBox.shrink(),
    };
  }

  Widget buildList(List<NotifyItemEntity> data) => ListView.separated(
    padding: EdgeInsetsDirectional.only(
      start: 16,
      end: 16,
      top: 16,
      bottom: 40,
    ),
    itemCount: data.length,
    separatorBuilder: (_, i) => Divider(height: 12, color: Colors.transparent),
    itemBuilder: (ctx, i) {
      NotifyItemEntity item = data[i];
      return buildMessage(type: item.type ?? "", item: item);
    },
  );

  Widget buildMessage({required String type, required NotifyItemEntity item}) {
    return switch (type) {
      "ALARM" => AlarmMessageItem(item: item),
      "UPGRADE" => UpgradeMessageItem(item: item),
      _ => SizedBox.shrink(),
    };
  }
}
