part of 'index.dart';

class LanguagePage extends StatelessWidget {
  const LanguagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: appBarColor,
        backgroundColor: appBarColor,
        centerTitle: true,
        title: AppBarTitleWidget(title: LKey.switchLanguage.tr),
      ),
      backgroundColor: appPageColor,
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        margin: EdgeInsetsDirectional.only(top: 20, start: 15, end: 15),
        width: double.maxFinite,
        child: GetBuilder<LanguageLogic>(
          init: LanguageLogic(),
          builder: (logic) {
            return ListView.builder(
              itemCount: logic.list.length,
              padding: EdgeInsetsDirectional.zero,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                Map<String, dynamic> item = logic.list[index];
                return buildSwitchLanguage(
                  // title: "${item['title']}".tr,
                  title: item['title'],
                  subTitle: "",
                  locale: item['locale'],
                  isCheck: item['isCheck'],
                  logic: logic,
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget buildSwitchLanguage({
    required String title,
    required String subTitle,
    required Locale? locale,
    required bool isCheck,
    required LanguageLogic logic,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () async {
          logic.switchLocale(locale);
        },
        child: Container(
          padding: EdgeInsetsDirectional.symmetric(
            horizontal: 15,
            vertical: 20,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              width: 2,
              color: isCheck ? Colors.blue : Colors.transparent,
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: isCheck ? Colors.blue : Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              VerticalDivider(width: 10, color: Colors.transparent),
              Icon(Icons.arrow_forward_ios, color: Colors.black, size: 18),
            ],
          ),
        ),
      ),
    );
  }
}
