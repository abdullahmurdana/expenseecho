import 'package:expenseecho/core/utils/app_styles.dart';
import 'package:expenseecho/core/utils/date_time_utils.dart';
import 'package:expenseecho/core/utils/sized_box_extensions.dart';
import 'package:expenseecho/core/utils/theme_colors.dart';
import 'package:expenseecho/data/models/accounts/accounts_model.dart';
import 'package:expenseecho/data/models/expense/expense_model.dart';
import 'package:expenseecho/presentation/profile/accounts/account_details/account_details_controller.dart';
import 'package:expenseecho/presentation/profile/accounts/add_new_account/add_new_account_screen.dart';
import 'package:expenseecho/widgets/custom_loading_indicator.dart';
import 'package:expenseecho/presentation/transactions/transactions_screen/custom_transaction_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:get/get.dart';

class AccountDetailsScreen extends StatefulWidget {
  final AccountsModel accountsModel;
  const AccountDetailsScreen({super.key, required this.accountsModel});

  @override
  _AccountDetailsScreenState createState() => _AccountDetailsScreenState();
}

class _AccountDetailsScreenState extends State<AccountDetailsScreen> {
  final accountDetailsController = Get.find<AccountDetailsController>();
  late AccountsModel accountsModel;

  @override
  void initState() {
    accountsModel = widget.accountsModel;
    super.initState();
    accountDetailsController.fetchCategories().then((_) {
      accountDetailsController.fetchAllTransactions(accountsModel.userId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: buildAppBar(localization),
      body: SafeArea(
        child: Container(
          height: size.height,
          width: size.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                32.h,
                Column(
                  children: [
                    Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: lightThemeColor[60],
                      ),
                      padding: const EdgeInsets.all(8),
                      child: Image.asset(
                        "assets/icons/wallet_icon.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                    10.h,
                    Text(
                      accountsModel.name,
                      style: AppStyle.poppinsMediumBlack(fontSize: 20),
                    ),
                    10.h,
                    Text(
                      '\$${accountsModel.balance.toInt()}',
                      style: AppStyle.poppinsBoldBlack(fontSize: 38),
                    ),
                  ],
                ),
                40.h,
                Obx(() {
                  if (accountDetailsController.isLoading.value) {
                    return const Center(
                      child: CustomLoadingIndicator(),
                    );
                  }

                  if (accountDetailsController.allTransactions.isEmpty) {
                    return const Center(
                      child: Text('No transactions yet'),
                    );
                  }

                  var todayTransactions = accountDetailsController
                      .allTransactions
                      .where((transaction) =>
                          DateTime.parse(transaction.createdAt).isToday())
                      .toList();
                  var yesterdayTransactions = accountDetailsController
                      .allTransactions
                      .where((transaction) =>
                          DateTime.parse(transaction.createdAt).isYesterday())
                      .toList();
                  var lastMonthTransactions = accountDetailsController
                      .allTransactions
                      .where((transaction) =>
                          DateTime.parse(transaction.createdAt).isLastMonth())
                      .toList();

                  return ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      if (todayTransactions.isNotEmpty) ...[
                        Text(
                          'Today',
                          style: AppStyle.poppinsBoldBlack(fontSize: 20),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: todayTransactions.length,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            var transaction = todayTransactions[index];
                            return transaction is ExpenseModel
                                ? TransactionTile(
                                    transaction: transaction,
                                  )
                                : TransactionTile(
                                    transaction: transaction,
                                  );
                          },
                        ),
                        const SizedBox(height: 10),
                      ],
                      if (yesterdayTransactions.isNotEmpty) ...[
                        Text(
                          'Yesterday',
                          style: AppStyle.poppinsBoldBlack(fontSize: 20),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: yesterdayTransactions.length,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            var transaction = yesterdayTransactions[index];
                            return transaction is ExpenseModel
                                ? TransactionTile(
                                    transaction: transaction,
                                  )
                                : TransactionTile(
                                    transaction: transaction,
                                  );
                          },
                        ),
                        const SizedBox(height: 10),
                      ],
                      if (lastMonthTransactions.isNotEmpty) ...[
                        Text(
                          'Last Month',
                          style: AppStyle.poppinsBoldBlack(fontSize: 20),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: lastMonthTransactions.length,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            var transaction = lastMonthTransactions[index];
                            return transaction is ExpenseModel
                                ? TransactionTile(
                                    transaction: transaction,
                                  )
                                : TransactionTile(
                                    transaction: transaction,
                                  );
                          },
                        ),
                        const SizedBox(height: 10),
                      ],
                    ],
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar(AppLocalizations localization) {
    return AppBar(
      centerTitle: true,
      backgroundColor: lightThemeColor,
      title: Text(localization.lbl_account_details),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: GestureDetector(
            onTap: () {
              // Navigate to AddNewAccountScreen from Account Details Screen
              Get.to(
                  () => AddNewAccountScreen(
                      isEdit: true, accountsModel: accountsModel),
                  arguments: {
                    'accountId': accountsModel.id,
                    'userId': accountDetailsController.userModel.value?.id,
                    'fromSignUp': false,
                  });
            },
            child: Image.asset(
              "assets/icons/pencil_icon.png",
              height: 28,
              width: 28,
            ),
          ),
        ),
      ],
    );
  }
}
