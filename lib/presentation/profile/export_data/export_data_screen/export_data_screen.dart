import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:get/get.dart';

import 'package:expenseecho/core/utils/app_styles.dart';
import 'package:expenseecho/core/utils/sized_box_extensions.dart';
import 'package:expenseecho/core/utils/theme_colors.dart';
import 'package:expenseecho/presentation/profile/export_data/export_data_screen/export_data_screen_controller.dart';
import 'package:expenseecho/routes/app_routes.dart';
import 'package:expenseecho/widgets/custom_widgets.dart';

class ExportDataScreen extends StatefulWidget {
  const ExportDataScreen({super.key});

  @override
  _ExportDataScreenState createState() => _ExportDataScreenState();
}

class _ExportDataScreenState extends State<ExportDataScreen> {
  final exportDataController = Get.find<ExportDataScreenController>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final localization = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: lightThemeColor,
        title: Text(localization.lbl_export_data),
      ),
      backgroundColor: lightThemeColor,
      body: SafeArea(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: <Widget>[
                    30.h,
                    buildCustomDropdownMenu(
                      title: localization.msg_export_data_title1,
                      items: exportDataController.dataTypes,
                      value: exportDataController.dataType,
                      onChanged: (value) =>
                          exportDataController.dataType.value = value!,
                    ),
                    20.h,
                    buildCustomDropdownMenu(
                      title: localization.msg_export_data_title2,
                      items: exportDataController.dateRanges,
                      value: exportDataController.dateRange,
                      onChanged: (value) =>
                          exportDataController.dateRange.value = value!,
                    ),
                    20.h,
                    buildCustomDropdownMenu(
                      title: localization.msg_export_data_title3,
                      items: exportDataController.dataFormats,
                      value: exportDataController.dataFormat,
                      onChanged: (value) =>
                          exportDataController.dataFormat.value = value!,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 25),
                  child: Center(
                    child: buildElevatedButton(
                      size: size,
                      imagePath: "assets/icons/download_icon.png",
                      onTapped: () =>
                          Get.toNamed(AppRoutes.exportDataSuccessScreen),
                      title: localization.lbl_export,
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

  Widget buildCustomDropdownMenu({
    required String title,
    required List<String> items,
    required RxString value,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppStyle.gfPoppinsMediumBlack(fontSize: 14),
        ),
        10.h,
        Obx(() {
          return Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(15),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                isExpanded: true,
                hint: Text(title),
                value: value.value,
                onChanged: onChanged,
                items: items.map((String item) {
                  return DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: AppStyle.gfPoppinsRegularBlack(fontSize: 14),
                    ),
                  );
                }).toList(),
                // style: const TextStyle(color: Colors.red, fontSize: 16),
                dropdownColor: lightThemeColor[80],
                icon: Icon(Icons.keyboard_arrow_down_rounded,
                    color: darkThemeColor[25]!),
              ),
            ),
          );
        }),
      ],
    );
  }
}
