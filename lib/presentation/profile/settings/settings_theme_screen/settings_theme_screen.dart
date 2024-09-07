import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:get/get.dart';
import 'package:expenseecho/core/utils/app_styles.dart';
import 'package:expenseecho/core/utils/theme_colors.dart';
import 'package:expenseecho/presentation/profile/settings/settings_theme_screen/settings_theme_screen_controller.dart';
import 'package:expenseecho/widgets/custom_tick_widget.dart';
import 'package:expenseecho/widgets/custom_widgets.dart';

class SettingsThemeScreen extends StatefulWidget {
  const SettingsThemeScreen({super.key});

  @override
  _SettingsThemeScreenState createState() => _SettingsThemeScreenState();
}

class _SettingsThemeScreenState extends State<SettingsThemeScreen> {
  final settingsThemeScreenController =
      Get.find<SettingsThemeScreenController>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final localization = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: _buildAppBar(localization: localization),
      backgroundColor: lightThemeColor,
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: const AlwaysScrollableScrollPhysics(),
          child: FutureBuilder<List<String>>(
            future: settingsThemeScreenController.getThemes(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(
                    child:
                        Text('${localization.lbl_error}: ${snapshot.error}'));
              }
              if (!snapshot.hasData) {
                return Center(child: Text(localization.msg_no_data_available));
              } else {
                final themes = snapshot.data!;
                return SizedBox(
                  height: size.height,
                  child: ListView.separated(
                    itemCount: themes.length,
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    separatorBuilder: buildSeperator,
                    itemBuilder: (context, index) {
                      final theme = themes[index];
                      return Obx(() {
                        return ListTile(
                          title: Text(theme),
                          trailing: settingsThemeScreenController
                                      .selectedTheme.value ==
                                  theme
                              ? SizedBox(
                                  width: 30,
                                  height: 30,
                                  child: buildTickWidget(),
                                )
                              : null,
                          onTap: () {
                            settingsThemeScreenController.selectTheme(theme);
                            Get.back();
                          },
                        );
                      });
                    },
                  ),
                );
              }
            },
          ),
        ),
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
        localization.lbl_theme,
        style: AppStyle.gfPoppinsRegularBlack(fontSize: 18),
      ),
      centerTitle: true,
      backgroundColor: lightThemeColor,
    );
  }
}
