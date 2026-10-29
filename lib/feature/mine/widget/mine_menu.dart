import 'package:cesc01/core/translations/lan_key.dart';
import 'package:cesc01/core/translations/lan_tools.dart';
import 'package:cesc01/routes/index.dart';
import 'package:country_state_city_selector/country_state_city_selector.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart' show Get;
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class MineMenu extends StatelessWidget {
  final String? organization;
  final String? authorization;
  final bool? notifyStatus;
  final String? version;
  final Function(String) onOrganization;
  final Function(String) onAuth;
  final Function onNotify;
  final Function onVersion;

  const MineMenu({
    super.key,
    required this.organization,
    required this.authorization,
    required this.notifyStatus,
    required this.version,
    required this.onOrganization,
    required this.onAuth,
    required this.onNotify,
    required this.onVersion,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF102346).withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Material(
            borderRadius: BorderRadius.vertical(top: Radius.circular(14)),
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                PageTools.toProvision();
              },
              child: _mineItem2(
                icon: Icons.bluetooth,
                iconColor: Colors.red,
                iconBg: Color(0xFFFFCDD2).withValues(alpha: 0.5),
                title: LKey.blueToNetWork.tr,
                trailing: '',
              ),
            ),
          ),
          const Divider(height: 1, thickness: 1, color: Color(0xFFF0F2F7)),
          Material(
            borderRadius: BorderRadius.vertical(top: Radius.circular(14)),
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                onOrganization.call((organization ?? ''));
              },
              child: _mineItem(
                icon: Icons.apartment_rounded,
                iconColor: Color(0xFF3978F6),
                iconBg: Color(0xFFEAF1FF),
                title: LKey.organization.tr,
                trailing: organization ?? '',
              ),
            ),
          ),
          const Divider(height: 1, thickness: 1, color: Color(0xFFF0F2F7)),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                onAuth.call(authorization ?? "");
              },
              child: _mineItem(
                icon: Icons.admin_panel_settings_rounded,
                iconColor: Color(0xFFEF8F32),
                iconBg: Color(0xFFFEF1E1),
                title: LKey.authorization.tr,
                trailing: LKey.siteCountContent.trArgs([authorization ?? ""]),
              ),
            ),
          ),
          const Divider(height: 1, thickness: 1, color: Color(0xFFF0F2F7)),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                onNotify.call();
              },
              child: _mineItem(
                icon: Icons.notifications_rounded,
                iconColor: Color(0xFF11A879),
                iconBg: Color(0xFFE3F6EE),
                title: LKey.notification.tr,
                trailing: notifyStatus == null
                    ? '-'
                    : (notifyStatus == true ? LKey.open.tr : LKey.close.tr),
              ),
            ),
          ),
          const Divider(height: 1, thickness: 1, color: Color(0xFFF0F2F7)),
          Material(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(14)),
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                onVersion.call();
              },
              child: _mineItem(
                icon: Icons.info_outline_rounded,
                iconColor: Color(0xFF6F7D92),
                iconBg: Color(0xFFF0F2F7),
                title: LKey.aboutApp.tr,
                trailing: version == null ? '-' : (version ?? ''),
              ),
            ),
          ),
          if (false) themeMode(),
          buildLanguage(),
          if (false) buildSelector(),
        ],
      ),
    );
  }

  Widget buildLanguage() => Column(
    children: [
      const Divider(height: 1, thickness: 1, color: Color(0xFFF0F2F7)),
      Material(
        borderRadius: BorderRadius.vertical(top: Radius.circular(14)),
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            PageTools.toLanguage();
          },
          child: _mineItem2(
            icon: Icons.language,
            iconColor: Colors.red,
            iconBg: Color(0xFFFFCDD2).withValues(alpha: 0.5),
            title: LKey.switchLanguage.tr,
            trailing: '',
          ),
        ),
      ),
    ],
  );

  Widget _mineItem({
    required IconData icon,
    required Color iconColor,
    required Color iconBg,
    required String title,
    required String trailing,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(9),
            ),
            child: Icon(icon, color: iconColor, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF172033),
                  ),
                ),
                Text(
                  trailing,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFFA8B4C8),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 4),
          const Icon(
            Icons.chevron_right_rounded,
            color: Color(0xFFC2CCDB),
            size: 20,
          ),
        ],
      ),
    );
  }

  Widget _mineItem2({
    required IconData icon,
    required Color iconColor,
    required Color iconBg,
    required String title,
    required String trailing,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(9),
            ),
            child: Icon(icon, color: iconColor, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF172033),
              ),
            ),
          ),
          const SizedBox(width: 4),
          const Icon(
            Icons.chevron_right_rounded,
            color: Color(0xFFC2CCDB),
            size: 20,
          ),
        ],
      ),
    );
  }

  Widget themeMode() {
    return Column(
      children: [
        const Divider(height: 1, thickness: 1, color: Color(0xFFF0F2F7)),
        Material(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(14)),
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              Get.changeThemeMode(ThemeMode.dark);
            },
            child: _mineItem(
              icon: Icons.dark_mode_outlined,
              iconColor: Colors.white,
              iconBg: Colors.black,
              title: "Dark Mode",
              trailing: '--',
            ),
          ),
        ),
        const Divider(height: 1, thickness: 1, color: Color(0xFFF0F2F7)),
        Material(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(14)),
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              Get.changeThemeMode(ThemeMode.light);
            },
            child: _mineItem(
              icon: Icons.light_mode_outlined,
              iconColor: Colors.blue,
              iconBg: Colors.yellow,
              title: "Light Mode",
              trailing: '--',
            ),
          ),
        ),
      ],
    );
  }

  Widget buildSelector() => Column(
    children: [
      const Divider(height: 1, thickness: 1, color: Color(0xFFF0F2F7)),
      Material(
        borderRadius: BorderRadius.vertical(top: Radius.circular(14)),
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            showCountrySelectorSheet();
          },
          child: _mineItem2(
            icon: Icons.location_city,
            iconColor: Colors.blue,
            iconBg: Color(0xFF90CAF9).withValues(alpha: 0.5),
            title: LKey.selectCountryAndTimeZoneTitle.tr,
            trailing: '',
          ),
        ),
      ),
    ],
  );

  void showCountrySelectorSheet() {
    Get.bottomSheet(
      Container(
        padding: EdgeInsetsDirectional.only(
          top: 15,
          start: 15,
          end: 15,
          bottom: 30,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            Divider(height: 10, color: Colors.transparent),
            Expanded(
              child: CountryStateCitySelector(
                localCode: LanTools.isZh() ? "zh-CN" : null,
                enableLabels: true,
                hideCity: true,
                hideStates: true,
                hideSearch: true,
                borderColor: Colors.blue,
                borderWidth: 1.5,
                fillColor: Colors.transparent,
                labelColor: Colors.black,
                labelFontSize: 14,
                labelFontWeight: FontWeight.w600,
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
                onSelectionChanged: (String country, String state, String city) {
                  debugPrint(
                    "User picked country: $country, state:$state, city:$city",
                  );
                },
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      padding: EdgeInsetsDirectional.symmetric(
                        horizontal: 10,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(width: 1, color: Colors.black),
                      ),
                      alignment: AlignmentDirectional.center,
                      child: Text(
                        LKey.cancel.tr,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
                VerticalDivider(width: 20, color: Colors.transparent),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      padding: EdgeInsetsDirectional.symmetric(
                        horizontal: 10,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blue,
                      ),
                      alignment: AlignmentDirectional.center,
                      child: Text(
                        LKey.confirm.tr,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      isDismissible: false,
      settings: RouteSettings(name: ARoute.selectCountryAndStatesSheet),
    );
  }
}
