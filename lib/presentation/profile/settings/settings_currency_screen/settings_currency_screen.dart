import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:expenseecho/core/utils/app_styles.dart';
import 'package:expenseecho/core/utils/theme_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:expenseecho/data/models/currency/currency_model.dart';
import 'package:expenseecho/presentation/profile/settings/settings_currency_screen/settings_currency_screen_controller.dart';
import 'package:expenseecho/widgets/custom_tick_widget.dart';
import 'package:expenseecho/widgets/custom_widgets.dart';

class SettingsCurrencyScreen extends StatefulWidget {
  const SettingsCurrencyScreen({super.key});

  @override
  _SettingsCurrencyScreenState createState() => _SettingsCurrencyScreenState();
}

class _SettingsCurrencyScreenState extends State<SettingsCurrencyScreen> {
  final settingsCurrencyScreenController =
      Get.find<SettingsCurrencyScreenController>();

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
          child: FutureBuilder<List<CurrencyModel>>(
            future: settingsCurrencyScreenController.getCurriences(),
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
                final currencies = snapshot.data!;
                return SizedBox(
                  height: size.height,
                  child: ListView.separated(
                    itemCount: currencies.length,
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    separatorBuilder: buildSeperator,
                    itemBuilder: (context, index) {
                      final currency = currencies[index];
                      return Obx(() {
                        return ListTile(
                          title: Text(
                              '${currency.fullName} ( ${currency.shortForm.toUpperCase()} )'),
                          trailing: settingsCurrencyScreenController
                                      .selectedCurrency.value?.shortForm ==
                                  currency.shortForm
                              ? SizedBox(
                                  width: 30,
                                  height: 30,
                                  child: buildTickWidget(),
                                )
                              : null,
                          onTap: () {
                            settingsCurrencyScreenController
                                .selectCurrency(currency);
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
        localization.lbl_currency,
        style: AppStyle.gfPoppinsRegularBlack(fontSize: 18),
      ),
      centerTitle: true,
      backgroundColor: lightThemeColor,
    );
  }
}
