import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:expenseecho/core/utils/sized_box_extensions.dart';
import 'package:expenseecho/core/utils/theme_colors.dart';
import 'package:expenseecho/core/utils/validation_methods.dart';
import 'package:expenseecho/widgets/custom_password_field.dart';
import 'package:expenseecho/widgets/custom_widgets.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: lightThemeColor,
        title: Text(localization.lbl_reset_password),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          color: lightThemeColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                56.h,
                PasswordField(
                  width: double.maxFinite,
                  height: 56,
                  controller: _passwordController,
                  hintText: localization.lbl_hint_enter_password,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return localization.msg_enter_password;
                    }
                    if (!isPasswordValid(value, isRequired: true)) {
                      return localization.msg_enter_valid_password;
                    }
                    return null;
                  },
                ),
                24.h,
                PasswordField(
                  height: 56,
                  width: double.maxFinite,
                  controller: _confirmPasswordController,
                  hintText: localization.lbl_retype_new_password,
                ),
                32.h,
                buildElevatedButton(
                  height: 56,
                  width: size.width,
                  onTapped: () {},
                  title: localization.lbl_reset_password,
                  bgColor: violetColor,
                  fgColor: lightThemeColor,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
