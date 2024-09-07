import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:get/get.dart';
import 'package:expenseecho/core/utils/app_styles.dart';
import 'package:expenseecho/core/utils/theme_colors.dart';
import 'package:expenseecho/data/models/language/language_model.dart';
import 'package:expenseecho/presentation/profile/settings/settings_language_screen/settings_language_screen_controller.dart';
import 'package:expenseecho/widgets/custom_tick_widget.dart';
import 'package:expenseecho/widgets/custom_widgets.dart';

class SettingsLanguageScreen extends StatefulWidget {
  const SettingsLanguageScreen({super.key});

  @override
  _SettingsLanguageScreenState createState() => _SettingsLanguageScreenState();
}

class _SettingsLanguageScreenState extends State<SettingsLanguageScreen> {
  final settingsCurrencyScreenController =
      Get.find<SettingsLanguageScreenController>();

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
          child: FutureBuilder<List<LanguageModel>>(
            future: settingsCurrencyScreenController.getLanguages(),
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
                final languages = snapshot.data!;
                return SizedBox(
                  height: size.height,
                  child: ListView.separated(
                    itemCount: languages.length,
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    separatorBuilder: buildSeperator,
                    itemBuilder: (context, index) {
                      final language = languages[index];
                      return Obx(() {
                        return ListTile(
                          title: Text(
                              '${language.name} ( ${language.locale.toUpperCase()} )'),
                          trailing: settingsCurrencyScreenController
                                      .selectedLanguage.value.locale ==
                                  language.locale
                              ? SizedBox(
                                  width: 30,
                                  height: 30,
                                  child: buildTickWidget(),
                                )
                              : null,
                          onTap: () {
                            settingsCurrencyScreenController
                                .selectLanguage(language);
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
        localization.lbl_language,
        style: AppStyle.gfPoppinsRegularBlack(fontSize: 18),
      ),
      centerTitle: true,
      backgroundColor: lightThemeColor,
    );
  }
}
