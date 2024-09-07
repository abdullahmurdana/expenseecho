import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

import 'package:expenseecho/core/utils/app_styles.dart';
import 'package:expenseecho/core/utils/sized_box_extensions.dart';

class SignUpSuccessScreen extends StatefulWidget {
  const SignUpSuccessScreen({super.key});

  @override
  State<SignUpSuccessScreen> createState() => _SignUpSuccessScreenState();
}

class _SignUpSuccessScreenState extends State<SignUpSuccessScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () {
      // TODO navigate to main screen after signup success
      // Get.offNamed(AppRoutes.mainScreen);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 100,
              height: 100,
              child: Image.asset(
                'assets/icons/success_icon.png',
              ),
            ),
            15.h,
            Text(
              localization.msg_you_all_set,
              style: AppStyle.gfPoppinsMediumBlack(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
