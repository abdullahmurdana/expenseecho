import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:get/get.dart';

import 'package:expenseecho/core/utils/app_styles.dart';
import 'package:expenseecho/core/utils/sized_box_extensions.dart';
import 'package:expenseecho/core/utils/theme_colors.dart';
import 'package:expenseecho/presentation/profile/settings/settings_currency_screen/settings_currency_screen_controller.dart';
import 'package:expenseecho/presentation/profile/settings/settings_language_screen/settings_language_screen_controller.dart';
import 'package:expenseecho/presentation/profile/settings/settings_security_screen/settings_security_screen_controller.dart';
import 'package:expenseecho/presentation/profile/settings/settings_theme_screen/settings_theme_screen_controller.dart';
import 'package:expenseecho/routes/app_routes.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final settingsCurrencyScreenController =
      Get.find<SettingsCurrencyScreenController>();
  final settingsLanguageScreenController =
      Get.find<SettingsLanguageScreenController>();
  final settingsThemeScreenController =
      Get.find<SettingsThemeScreenController>();
  final settingsSecurityScreenController =
      Get.find<SettingsSecurityScreenController>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final localization = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: _buildAppBar(localization: localization),
      backgroundColor: lightThemeColor,
      body: Obx(
        () => SafeArea(
          child: Column(
            children: <Widget>[
              15.h,
              _buildListTile(size,
                  onTapped: () => Get.toNamed(AppRoutes.settingsCurrencyScreen),
                  titleText: localization.lbl_currency,
                  valueText: settingsCurrencyScreenController
                          .selectedCurrency.value?.shortForm ??
                      'USD'),
              10.h,
              // _buildDivider(),
              _buildListTile(
                size,
                onTapped: () => Get.toNamed(AppRoutes.settingsLanguageScreen),
                titleText: localization.lbl_language,
                valueText: settingsLanguageScreenController
                    .selectedLanguage.value.name,
              ),
              10.h,
              // _buildDivider(),
              _buildListTile(size,
                  onTapped: () => Get.toNamed(AppRoutes.settingsThemeScreen),
                  titleText: localization.lbl_theme,
                  valueText: settingsThemeScreenController.selectedTheme.value),
              10.h,
              // _buildDivider(),
              _buildListTile(size,
                  onTapped: () => Get.toNamed(AppRoutes.settingsSecurityScreen),
                  titleText: localization.lbl_security,
                  valueText:
                      settingsSecurityScreenController.selectedSecurity.value),
              10.h,
              // _buildDivider(),
              _buildListTile(
                size,
                onTapped: () =>
                    Get.toNamed(AppRoutes.settingsNotificationsScreen),
                titleText: localization.lbl_notification,
              ),
              40.h,
              _buildListTile(
                size,
                onTapped: () {},
                titleText: localization.lbl_about,
              ),
              10.h,
              _buildListTile(
                size,
                onTapped: () {},
                titleText: localization.lbl_help,
              ),
            ],
          ),
        ),
      ),
    );
  }

  GestureDetector _buildListTile(
    Size size, {
    required Function() onTapped,
    required String titleText,
    String? valueText,
  }) {
    return GestureDetector(
      onTap: onTapped,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: SizedBox(
          height: 50,
          width: size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                titleText,
                style: AppStyle.gfPoppinsRegularBlack(fontSize: 16),
              ),
              Row(
                children: [
                  valueText != null
                      ? Text(
                          valueText,
                          style: AppStyle.gfPoppinsCustom(
                            fontSize: 15,
                            color: darkThemeColor[25]!,
                            fontWeight: FontWeight.w400,
                          ),
                        )
                      : const SizedBox(),
                  5.w,
                  const Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: violetColor,
                    size: 20,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar({required AppLocalizations localization}) {
    return AppBar(
      toolbarHeight: 70,
      shape: Border(
        bottom: BorderSide(width: 0.5, color: darkThemeColor[25]!),
      ),
      title: Text(
        localization.lbl_settings,
        style: AppStyle.gfPoppinsRegularBlack(fontSize: 18),
      ),
      centerTitle: true,
      backgroundColor: lightThemeColor,
    );
  }

  /* Divider _buildDivider() {
    return Divider(
      indent: 10,
      endIndent: 10,
      color: lightThemeColor[20],
      thickness: 0.7,
    );
  } */
}
