part of 'index.dart';

// ---------- Step 4: 云端建站 ----------
class BuildStepSite extends StatefulWidget {
  final ProvisionLogic logic;
  const BuildStepSite({super.key, required this.logic});

  @override
  State<BuildStepSite> createState() => _BuildStepSiteState();
}

class _BuildStepSiteState extends State<BuildStepSite> with AppStateMixin {
  int siteTab = 0; // 0 = 并入现有, 1 = 新建
  final siteNameCtrl = TextEditingController();
  final addressCtrl = TextEditingController();
  String selectedExistingSite = '';
  String siteCountry = '';
  String siteTimeZone = '';
  SiteItemEntity? siteItem;

  @override
  void initState() {
    super.initState();
    safeSetState(() {
      siteTab = widget.logic.siteList.isEmpty ? 1 : 0;
    });
  }

  @override
  void dispose() {
    siteNameCtrl.dispose();
    addressCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StepShell(
      icon: Icons.home_rounded,
      iconColor: const Color(0xFF34C759),
      iconBg: const Color(0xFFE7F8EE),
      title: LKey.createSite.tr,
      desc: LKey.webCreateSite.tr,
      children: [
        buildTabTitle(),
        Divider(height: 18, color: Colors.transparent),
        if (siteTab == 0)
          ..._existingSiteForm(items: widget.logic.siteList)
        else
          ..._newSiteForm(),
      ],
    );
  }

  /// TabTitle
  Widget buildTabTitle() => Container(
    padding: const EdgeInsets.all(4),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Row(
      children: [
        Expanded(
          child: TabItem(
            label: LKey.mergeIntoSites.tr,
            selected: siteTab == 0,
            onTap: () => safeSetState(() => siteTab = 0),
          ),
        ),
        Expanded(
          child: TabItem(
            label: LKey.addNewSite.tr,
            selected: siteTab == 1,
            onTap: () => safeSetState(() => siteTab = 1),
          ),
        ),
      ],
    ),
  );

  ///并入现有站点
  List<Widget> _existingSiteForm({required List<SiteItemEntity> items}) {
    return [
      FieldLabel(LKey.selectExistingSite.tr),
      Dropdown(
        value: selectedExistingSite,
        items: items.map((e) => e.showSiteName).toList(),
        onChanged: (v) {
          safeSetState(() => selectedExistingSite = v.$1);
          siteItem = items[v.$2];
        },
      ),
      const SizedBox(height: 14),
      if (selectedExistingSite.isNotEmpty)
        Container(
          width: double.maxFinite,
          clipBehavior: Clip.hardEdge,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.lightBlue.withValues(alpha: 0.4),
            ),
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                LKey.bindingAndMerged.tr,
                style: TextStyle(fontSize: 11, color: Color(0xFFA8B4C8)),
              ),
              const SizedBox(height: 4),
              Text(
                selectedExistingSite,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF172033),
                ),
              ),
              //const SizedBox(height: 2),
              /*const Text(
              'BP26NEW00001 · 本创建新站点',
              style: TextStyle(fontSize: 12, color: Color(0xFF6F7D92)),
            ),*/
            ],
          ),
        ),
      const SizedBox(height: 14),
      PrimaryBtn(
        label: siteTab == 0
            ? LKey.confirmMergeIntoSites.tr
            : LKey.submitAndCreateSite.tr,
        loading: false,
        onTap: () {
          widget.logic.toBind(siteId: siteItem?.siteId ?? "");
        },
      ),
      const SizedBox(height: 30),
    ];
  }

  ///创建新的站点
  List<Widget> _newSiteForm() {
    return [
      FieldLabel(LKey.siteName.tr),
      TextField(
        controller: siteNameCtrl,
        style: const TextStyle(fontSize: 14, color: Color(0xFF172033)),
        cursorColor: const Color(0xFF3978F6),
        decoration: inputDecoration(hint: LKey.inputSiteNameHint.tr),
        onTapOutside: (_) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        onSubmitted: (_) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
      ),
      Divider(height: 14, color: Colors.transparent),
      CountryStateCitySelector(
        localCode: LanTools.isZh() ? "zh-CN" : null,
        enableLabels: true,
        hideCity: true,
        hideStates: true,
        hideSearch: true,
        hintColor: Color(0xFFA8B4C8),
        borderColor: Color(0xFFE3E9F2),
        borderWidth: 1.5,
        fillColor: Color(0xFFF8FAFD),
        labelColor: Color(0xFF5B6B85),
        labelFontSize: 12.5,
        labelFontWeight: FontWeight.w500,
        selectedTextColor: Colors.black,
        selectedTextFontSize: 14,
        selectedTextFontWeight: FontWeight.normal,
        pickerItemTextColor: Colors.black,
        pickerItemFontSize: 16,
        pickerItemFontWeight: FontWeight.normal,
        modalBackgroundColor: Colors.white,
        modalTitleFontSize: 18,
        modalTitleColor: Colors.black,
        modalTitleFontWeight: FontWeight.normal,
        countryHintText: LKey.selectCountry.tr,
        stateHintText: LKey.selectState.tr,
        cityHintText: LKey.selectCity.tr,
        timeZoneHintText: LKey.selectTimeZone.tr,
        timeZoneTextFieldHintText: LKey.selectTimeZone.tr,
        countryTextFieldHintText: LKey.searchAndSelectCountry.tr,
        stateTextFieldHintText: LKey.searchAndSelectState.tr,
        cityTextFieldHintText: LKey.searchAndSelectCity.tr,
        onSelectionChanged: (String country, _, _) {
          siteCountry = country;
        },
        onTimeZoneChanged: (String timeZone) {
          siteTimeZone = timeZone;
        },
      ),
      //const SizedBox(height: 14),
      /*const FieldLabel('国家/区域'),
      const Dropdown(
        value: '中国 · 浙江省',
        items: ['中国 · 浙江省', '中国 · 广东省', '荷兰 · 北荷兰省'],
      ),
      const SizedBox(height: 14),*/
      FieldLabel(LKey.detailedAddress.tr),
      TextField(
        controller: addressCtrl,
        maxLines: 3,
        style: const TextStyle(fontSize: 14, color: Color(0xFF172033)),
        cursorColor: const Color(0xFF3978F6),
        decoration: inputDecoration(hint: LKey.inputAddressHint.tr),
        onTapOutside: (_) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        onSubmitted: (_) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
      ),
      Divider(height: 14, color: Colors.transparent),
      PrimaryBtn(
        label: siteTab == 0
            ? LKey.confirmMergeIntoSites.tr
            : LKey.submitAndCreateSite.tr,
        loading: false,
        onTap: () {
          String siteName = siteNameCtrl.text;
          String siteAddress = addressCtrl.text;
          widget.logic.toCreateAndBind(
            siteName: siteName,
            countryRegion: siteCountry,
            timezone: siteTimeZone,
            address: siteAddress,
          );
        },
      ),
      Divider(height: 30, color: Colors.transparent),
      /*const FieldLabel('区域/时区'),
      const Dropdown(
        value: 'Asia/Shanghai',
        items: ['Asia/Shanghai', 'Europe/Amsterdam', 'America/Los_Angeles'],
      ),*/
    ];
  }
}
