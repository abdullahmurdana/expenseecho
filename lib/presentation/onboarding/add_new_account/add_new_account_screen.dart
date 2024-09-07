import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:expenseecho/core/utils/app_styles.dart';
import 'package:expenseecho/core/utils/sized_box_extensions.dart';
import 'package:expenseecho/core/utils/theme_colors.dart';
import 'package:expenseecho/presentation/onboarding/add_new_account/add_new_account_controller.dart';
import 'package:expenseecho/routes/app_routes.dart';

class AddNewAccountScreen extends GetView<AddNewAccountController> {
  const AddNewAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final addNewAccountController = Get.find<AddNewAccountController>();
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('Add new account',
            style: AppStyle.gfPoppinsCustom(
                fontSize: 18,
                color: lightThemeColor,
                fontWeight: FontWeight.w500)),
        centerTitle: true,
        backgroundColor: violetColor,
        iconTheme: const IconThemeData(
          color: lightThemeColor,
        ),
      ),
      backgroundColor: violetColor,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Balance",
                      style: AppStyle.gfPoppinsCustom(
                          fontSize: 16,
                          color: lightThemeColor[20]!,
                          fontWeight: FontWeight.w500),
                    ),
                    15.h,
                    Text(
                      "\$ 00.0",
                      style: AppStyle.gfPoppinsCustom(
                          fontSize: 40,
                          color: lightThemeColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            20.h,
            Container(
              height: 300,
              decoration: const BoxDecoration(
                color: lightThemeColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(
                  children: <Widget>[
                    30.h,
                    _buildTextField(
                      controller: addNewAccountController.nameController,
                      hintText: 'Enter Name',
                      labelText: 'Name',
                      obscureText: false,
                    ),
                    20.h,
                    Obx(() => Container(
                          width: double.infinity,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.0),
                            border: Border.all(
                                color: lightThemeColor[20]!, width: 1),
                          ),
                          child: DropdownButton<String>(
                            value: addNewAccountController.selectedAccountType,
                            hint: const Text('Select Account type'),
                            items: addNewAccountController.accountTypes
                                .map((accountType) {
                              return DropdownMenuItem<String>(
                                value: accountType,
                                child: Text(accountType),
                              );
                            }).toList(),
                            isExpanded: true,
                            borderRadius: BorderRadius.circular(16),
                            underline: const SizedBox.shrink(),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 10),
                            onChanged: (String? newValue) {
                              addNewAccountController
                                  .setSelectedAccountType(newValue);
                            },
                          ),
                        )),
                    30.h,
                    _buildButton(size: size),
                    10.h,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildButton({required Size size}) {
    return ElevatedButton(
      onPressed: () {
        Get.toNamed(AppRoutes.signupSuccessScreen);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: violetColor,
        foregroundColor: lightThemeColor,
        fixedSize: Size(size.width, 60),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: Text(
        'Continue',
        style: AppStyle.gfPoppinsMediumWhite(fontSize: 22),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required String labelText,
    required bool obscureText,
    IconData? icon,
    String? Function(String?)? validator,
  }) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: lightThemeColor[100],
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: lightThemeColor[20]!, width: 1),
      ),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        validator: validator,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: darkThemeColor[50]!, fontSize: 16.0),
          labelText: labelText,
          labelStyle: TextStyle(color: darkThemeColor[50]!, fontSize: 16.0),
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
          suffixIcon:
              icon != null ? Icon(icon, color: darkThemeColor[50]) : null,
        ),
        style: TextStyle(
          color: darkThemeColor[50]!,
          fontSize: 16.0,
        ),
      ),
    );
  }
}
