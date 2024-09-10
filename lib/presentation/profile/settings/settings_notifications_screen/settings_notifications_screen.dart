import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:expenseecho/core/utils/app_styles.dart';
import 'package:expenseecho/core/utils/theme_colors.dart';
import 'package:expenseecho/presentation/profile/settings/settings_notifications_screen/settings_notifications_screen_controller.dart';

class SettingsNotificationsScreen extends StatefulWidget {
  const SettingsNotificationsScreen({super.key});

  @override
  _SettingsNotificationsScreenState createState() =>
      _SettingsNotificationsScreenState();
}

class _SettingsNotificationsScreenState
    extends State<SettingsNotificationsScreen> {
  final settingsNotificationsController =
      Get.find<SettingsNotificationsScreenController>();

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: _buildAppBar(localization: localization),
      backgroundColor: lightThemeColor,
      body: _buildBodyWidget(localization),
    );
  }

  SafeArea _buildBodyWidget(AppLocalizations localization) {
    return SafeArea(
      child: ListView(
        children: [
          Obx(
            () => _buildSwitchTile(
              title: localization.lbl_expense_alert,
              subtitle: localization.msg_expense_alert,
              value: settingsNotificationsController.expenseAlert.value,
              onChanged: (value) =>
                  settingsNotificationsController.setExpenseAlert(value),
            ),
          ),
          Obx(() => _buildSwitchTile(
                title: localization.lbl_budget_alert,
                subtitle: localization.msg_budget_alert,
                value: settingsNotificationsController.budgetAlert.value,
                onChanged: (value) =>
                    settingsNotificationsController.setBudgetAlert(value),
              )),
          Obx(() => _buildSwitchTile(
                title: localization.lbl_tips_articles,
                subtitle: localization.msg_tips_articles,
                value: settingsNotificationsController.tipsArticles.value,
                onChanged: (value) =>
                    settingsNotificationsController.setTipsArticles(value),
              )),
        ],
      ),
    );
  }

  AppBar _buildAppBar({required AppLocalizations localization}) {
    return AppBar(
      toolbarHeight: 70,
      shape: Border(
        bottom: BorderSide(width: 0.4, color: lightThemeColor[20]!),
      ),
      title: Text(
        localization.lbl_notification,
        style: AppStyle.poppinsRegularBlack(fontSize: 18),
      ),
      centerTitle: true,
      backgroundColor: lightThemeColor,
    );
  }

  Widget _buildSwitchTile(
      {required String title,
      required String subtitle,
      required bool value,
      required ValueChanged<bool> onChanged}) {
    return SwitchListTile(
      title: Text(
        title,
        style: AppStyle.poppinsCustom(
          fontSize: 15,
          color: darkThemeColor[100]!,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: AppStyle.poppinsCustom(
          fontSize: 13,
          color: darkThemeColor[25]!,
          fontWeight: FontWeight.w300,
        ),
      ),
      activeColor: lightThemeColor,
      activeTrackColor: violetColor,
      inactiveThumbColor: lightThemeColor,
      inactiveTrackColor: violetColor[20],
      trackOutlineColor: WidgetStateProperty.resolveWith((states) {
        if (!states.contains(WidgetState.selected)) {
          return lightThemeColor; // Active thumb color
        }
        return violetColor; // Inactive thumb color
      }),
      value: value,
      onChanged: onChanged,
    );
  }
}
