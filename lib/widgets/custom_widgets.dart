import 'dart:io';

import 'package:expenseecho/core/utils/app_styles.dart';
import 'package:expenseecho/core/utils/sized_box_extensions.dart';
import 'package:expenseecho/core/utils/theme_colors.dart';
import 'package:expenseecho/data/services/attachment_helper.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:image_picker/image_picker.dart';

Widget buildSwitchTile(
    {required String title,
    required String? subtitle,
    required bool value,
    required ValueChanged<bool> onChanged}) {
  return SwitchListTile(
    title: Text(
      title,
      style: AppStyle.poppinsCustom(
        fontSize: 15,
        color: darkThemeColor[100]!,
        fontWeight: FontWeight.w500,
      ),
    ),
    subtitle: Text(
      subtitle ?? '',
      style: AppStyle.poppinsCustom(
        fontSize: 13,
        color: darkThemeColor[25]!,
        fontWeight: FontWeight.w300,
      ),
    ),
    activeColor: lightThemeColor,
    activeTrackColor: violetColor,
    inactiveThumbColor: lightThemeColor,
    inactiveTrackColor: violetColor[20],
    trackOutlineColor: WidgetStateProperty.resolveWith((states) {
      if (!states.contains(WidgetState.selected)) {
        return lightThemeColor; // Active thumb color
      }
      return violetColor; // Inactive thumb color
    }),
    value: value,
    onChanged: onChanged,
  );
}

Widget buildSeperator(BuildContext context, int index) => const Divider(
      endIndent: 20,
      indent: 10,
      thickness: 0.8,
    );

buildElevatedButton({
  required double height,
  required double width,
  required Function() onTapped,
  IconData? iconData,
  String? imagePath,
  required String title,
  required Color bgColor,
  Color? fgColor,
  TextStyle? textStyle,
}) {
  return ElevatedButton(
    onPressed: onTapped,
    style: ElevatedButton.styleFrom(
      backgroundColor: bgColor,
      foregroundColor: fgColor ?? lightThemeColor,
      fixedSize: Size(width, height),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        iconData != null
            ? Icon(
                iconData,
                size: 24,
                color: fgColor ?? lightThemeColor,
              )
            : const SizedBox(),
        imagePath != null
            ? Image.asset(
                imagePath,
                height: 27,
                width: 27,
              )
            : const SizedBox(),
        15.w,
        Text(
          title,
          style: textStyle ?? AppStyle.poppinsMediumWhite(fontSize: 22),
        ),
      ],
    ),
  );
}

Widget buildStringListDropdown({
  required String labelText,
  required String value,
  required List<String> items,
  required void Function(String?)? onChanged,
  required bool isEnabled,
}) {
  return Expanded(
    child: DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(12),
          ),
          borderSide: BorderSide(
            color: lightThemeColor[20]!,
            width: 1,
          ),
        ),
        contentPadding: const EdgeInsets.fromLTRB(12, 10, 7, 12),
      ),
      value: value,
      items: items.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            style: AppStyle.poppinsRegularBlack(fontSize: 16),
          ),
        );
      }).toList(),
      onChanged: isEnabled ? onChanged : null,
    ),
  );
}

Widget buildTextField({
  required TextEditingController controller,
  required String hintText,
  required String labelText,
  double? height,
  double? width,
  IconData? icon,
  String? Function(String?)? validator,
}) {
  return SizedBox(
    height: height ?? 60,
    width: width ?? 150,
    // decoration: BoxDecoration(
    //   color: lightThemeColor[100],
    //   borderRadius: BorderRadius.circular(16.0),
    //   border: Border.all(color: lightThemeColor[20]!, width: 1),
    // ),
    child: TextFormField(
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: darkThemeColor[50]!, fontSize: 16.0),
        labelText: labelText,
        labelStyle: TextStyle(color: darkThemeColor[50]!, fontSize: 16.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: BorderSide(color: lightThemeColor[20]!, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: BorderSide(color: lightThemeColor[20]!, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: BorderSide(color: lightThemeColor[20]!, width: 1),
        ),
        contentPadding: const EdgeInsets.fromLTRB(20, 12, 16, 20),
        suffixIcon: icon != null ? Icon(icon, color: darkThemeColor[50]) : null,
      ),
      style: TextStyle(
        color: darkThemeColor[50]!,
        fontSize: 16.0,
      ),
    ),
  );
}

Widget _buildButton({
  required double width,
  required String iconPath,
  required String label,
  required VoidCallback onPressed,
}) {
  return SizedBox(
    width: width,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: violetColor[20],
        foregroundColor: violetColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      onPressed: onPressed,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            iconPath,
            width: 32,
            height: 32,
          ),
          const SizedBox(height: 5),
          Text(
            label,
            style: AppStyle.poppinsCustom(
              fontSize: 12,
              color: violetColor,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ),
  );
}

void showAttachmentBottomSheet(BuildContext context,
    {required AppLocalizations localization,
    required Size size,
    required AttachmentController controller}) {
  final screenWidth = size.width;
  const double horizontalPadding = 16.0;
  const double gap = 16.0;
  final double availableWidthWithoutGap =
      screenWidth - (2 * horizontalPadding) - (gap * 2);
  final double availableWidth = screenWidth - (2 * horizontalPadding);

  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (BuildContext context) {
      return SizedBox(
        height: 220,
        child: Column(
          children: [
            10.h,
            Center(
              child: Container(
                height: 5,
                width: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: violetColor[20],
                ),
              ),
            ),
            60.h,
            SizedBox(
              width: availableWidth,
              height: 95,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildButton(
                    width: availableWidthWithoutGap / 3,
                    iconPath: "assets/icons/camera_icon.png",
                    label: localization.lbl_camera,
                    onPressed: () async {
                      final picker = ImagePicker();
                      final pickedFile =
                          await picker.pickImage(source: ImageSource.camera);
                      if (pickedFile != null) {
                        controller.setAttachment(File(pickedFile.path));
                      }
                    },
                  ),
                  _buildButton(
                    width: availableWidthWithoutGap / 3,
                    iconPath: "assets/icons/gallery_icon.png",
                    label: localization.lbl_image,
                    onPressed: () async {
                      final picker = ImagePicker();
                      final pickedFile =
                          await picker.pickImage(source: ImageSource.gallery);
                      if (pickedFile != null) {
                        controller.setAttachment(File(pickedFile.path));
                      }
                    },
                  ),
                  _buildButton(
                    width: availableWidthWithoutGap / 3,
                    iconPath: "assets/icons/file_icon.png",
                    label: localization.lbl_document,
                    onPressed: () async {
                      final result = await FilePicker.platform.pickFiles();
                      if (result != null) {
                        final file = File(result.files.single.path!);
                        controller.setAttachment(file);
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}
