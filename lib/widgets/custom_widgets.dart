import 'package:expenseecho/core/utils/app_styles.dart';
import 'package:expenseecho/core/utils/sized_box_extensions.dart';
import 'package:expenseecho/core/utils/theme_colors.dart';
import 'package:flutter/material.dart';

Widget buildSeperator(BuildContext context, int index) => const Divider(
      endIndent: 20,
      indent: 10,
      thickness: 0.8,
    );

buildElevatedButton({
  required Size size,
  required Function() onTapped,
  IconData? iconData,
  String? imagePath,
  required String title,
  required MaterialColor bgColor,
  MaterialColor? fgColor,
  TextStyle? textStyle,
}) {
  return ElevatedButton(
    onPressed: onTapped,
    style: ElevatedButton.styleFrom(
      backgroundColor: bgColor,
      foregroundColor: fgColor ?? lightThemeColor,
      fixedSize: Size(size.width, 60),
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
          style: textStyle ?? AppStyle.gfPoppinsMediumWhite(fontSize: 22),
        ),
      ],
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
          SizedBox(height: 5),
          Text(
            label,
            style: AppStyle.gfPoppinsCustom(
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
