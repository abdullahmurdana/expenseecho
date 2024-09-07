import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:get/get.dart';
import 'package:expenseecho/core/utils/app_styles.dart';
import 'package:expenseecho/core/utils/theme_colors.dart';
import 'package:expenseecho/presentation/profile/settings/settings_security_screen/settings_security_screen_controller.dart';
import 'package:expenseecho/widgets/custom_tick_widget.dart';
import 'package:expenseecho/widgets/custom_widgets.dart';

class SettingsSecurityScreen extends StatefulWidget {
  const SettingsSecurityScreen({super.key});

  @override
  _SettingsSecurityScreenState createState() => _SettingsSecurityScreenState();
}

class _SettingsSecurityScreenState extends State<SettingsSecurityScreen> {
  final settingsSecurityScreenController =
      Get.find<SettingsSecurityScreenController>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final localization = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: _buildAppBar(localization: localization),
      backgroundColor: lightThemeColor,
      body: _buildBodyWidget(localization, size),
    );
  }

  SafeArea _buildBodyWidget(AppLocalizations localization, Size size) {
    return SafeArea(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const AlwaysScrollableScrollPhysics(),
        child: FutureBuilder<List<String>>(
          future: settingsSecurityScreenController.getSecurities(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(
                  child: Text('${localization.lbl_error}: ${snapshot.error}'));
            }
            if (!snapshot.hasData) {
              return Center(child: Text(localization.msg_no_data_available));
            } else {
              final securities = snapshot.data!;
              return SizedBox(
                height: size.height,
                child: ListView.separated(
                  itemCount: securities.length,
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    final security = securities[index];
                    return Obx(() {
                      return ListTile(
                        title: Text(security),
                        trailing: settingsSecurityScreenController
                                    .selectedSecurity.value ==
                                security
                            ? SizedBox(
                                width: 30,
                                height: 30,
                                child: buildTickWidget(),
                              )
                            : null,
                        onTap: () {
                          settingsSecurityScreenController
                              .selectSecurity(security);
                          Get.back();
                        },
                      );
                    });
                  },
                  separatorBuilder: buildSeperator,
                ),
              );
            }
          },
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
        localization.lbl_currency,
        style: AppStyle.gfPoppinsRegularBlack(fontSize: 18),
      ),
      centerTitle: true,
      backgroundColor: lightThemeColor,
    );
  }
}
