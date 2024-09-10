import 'package:expenseecho/data/models/accounts/accounts_model.dart';
import 'package:expenseecho/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:expenseecho/core/utils/app_styles.dart';
import 'package:expenseecho/core/utils/sized_box_extensions.dart';
import 'package:expenseecho/core/utils/theme_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:expenseecho/presentation/profile/account_screen/account_screen_controller.dart';
import 'package:expenseecho/widgets/custom_widgets.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final accountScreenController = Get.find<AccountScreenController>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final localization = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: _buildAppBar(localization: localization),
      backgroundColor: lightThemeColor,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
        child: buildElevatedButton(
          height: 56,
          width: size.width,

          // Add navigation to this button
          onTapped: () => Get.offAllNamed(AppRoutes.mainScreen),
          title: "Add new wallet",
          bgColor: violetColor,
          fgColor: lightThemeColor,
          iconData: Icons.add,
          textStyle: AppStyle.poppinsRegularWhite(fontSize: 20),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            25.h,
            buildImageStack(size, localization: localization),
            Expanded(
              child: Obx(() {
                if (accountScreenController.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                } else if (accountScreenController.accounts.isEmpty) {
                  return Center(
                      child: Text(localization.msg_no_data_available));
                } else {
                  return ListView.separated(
                    separatorBuilder: buildSeperator,
                    itemCount: accountScreenController.accounts.length,
                    itemBuilder: (context, index) {
                      final account = accountScreenController.accounts[index];
                      return ListTile(
                        minTileHeight: 80,
                        leading: buildLeadingIcon(account: account),
                        title: Text(
                          account.name,
                          style: AppStyle.poppinsMediumBlack(
                            fontSize: 20,
                          ),
                        ),
                        trailing: SizedBox(
                          width: 100,
                          child: Text(
                            '\$${account.balance.toInt()}',
                            style: AppStyle.poppinsMediumBlack(
                              fontSize: 20,
                            ),
                          ),
                        ),
                        // subtitle: Text('Balance: \$${account.balance}'),
                      );
                    },
                  );
                }
              }),
            ),
          ],
        ),
      ),
    );
  }

  buildLeadingIcon({required AccountsModel account}) {
    if (account.type == 'bank') {
      return Container(
        height: 55,
        width: 55,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: violetColor[20],
        ),
        child: Center(
          child: Image.asset(
            "assets/icons/bank_icon.png",
            height: 30,
            width: 30,
            fit: BoxFit.fill,
          ),
        ),
      );
    } else if (account.type == 'wallet') {
      return Container(
        height: 55,
        width: 55,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: violetColor[20],
        ),
        child: Center(
          child: Image.asset(
            "assets/icons/wallet_icon.png",
            height: 35,
            width: 35,
            fit: BoxFit.fill,
          ),
        ),
      );
    } else {
      return Container(
        height: 55,
        width: 55,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: violetColor[20],
        ),
        child: Center(
          child: Image.asset(
            "assets/icons/credit_card_icon.png",
            height: 35,
            width: 35,
            fit: BoxFit.fill,
          ),
        ),
      );
    }
  }

  SizedBox buildImageStack(Size size,
      {required AppLocalizations localization}) {
    return SizedBox(
      width: size.width,
      height: 170,
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Image.asset(
              "assets/images/profile_screen_title_bg.png",
              fit: BoxFit.fill,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  localization.lbl_account_balance,
                  style: AppStyle.poppinsCustom(
                    fontSize: 15,
                    color: darkThemeColor[50]!,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Obx(() {
                  final totalBalance = accountScreenController.accounts
                      .fold<double>(
                          0.0, (sum, account) => sum + account.balance)
                      .toInt();
                  return Text(
                    '\$ $totalBalance',
                    style: AppStyle.poppinsBoldBlack(fontSize: 40),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  AppBar _buildAppBar({required AppLocalizations localization}) {
    return AppBar(
      title: Text(
        localization.lbl_account,
        style: AppStyle.poppinsRegularBlack(fontSize: 20),
      ),
      centerTitle: true,
      backgroundColor: lightThemeColor,
    );
  }
}
