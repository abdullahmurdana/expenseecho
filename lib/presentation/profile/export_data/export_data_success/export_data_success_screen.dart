import 'package:expenseecho/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:expenseecho/core/utils/app_styles.dart';
import 'package:expenseecho/core/utils/sized_box_extensions.dart';
import 'package:expenseecho/core/utils/theme_colors.dart';
import 'package:expenseecho/widgets/custom_widgets.dart';
import 'package:get/get.dart';

class ExportDataSuccessScreen extends StatefulWidget {
  const ExportDataSuccessScreen({super.key});

  @override
  _ExportDataSuccessScreenState createState() =>
      _ExportDataSuccessScreenState();
}

class _ExportDataSuccessScreenState extends State<ExportDataSuccessScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final localization = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: lightThemeColor,
      body: SafeArea(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    40.h,
                    SizedBox(
                        height: 300,
                        width: size.width,
                        child: Image.asset(
                            "assets/images/export_success_image.png")),
                    45.h,
                    Text(
                      localization.msg_export_success,
                      softWrap: true,
                      style: AppStyle.gfPoppinsCustom(
                        fontSize: 15,
                        color: darkThemeColor[75]!,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 25.0),
                  child: Center(
                    child: buildElevatedButton(
                      size: size,
                      onTapped: () {
                        return Get.toNamed(AppRoutes.mainScreen);
                      },
                      title: localization.lbl_back_to_main,
                      bgColor: violetColor,
                      fgColor: lightThemeColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
