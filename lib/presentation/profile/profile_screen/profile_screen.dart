import 'package:cached_network_image/cached_network_image.dart';
import 'package:expenseecho/core/utils/app_styles.dart';
import 'package:expenseecho/core/utils/sized_box_extensions.dart';
import 'package:expenseecho/core/utils/theme_colors.dart';
import 'package:expenseecho/data/services/shared_preferences/shared_preferences_handler.dart';
import 'package:expenseecho/presentation/profile/profile_screen/profile_screen_controller.dart';
import 'package:expenseecho/routes/app_routes.dart';
import 'package:expenseecho/widgets/blurred_background_widget.dart';
import 'package:expenseecho/widgets/custom_loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final profileScreenController = Get.find<ProfileScreenController>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final localization = AppLocalizations.of(context)!;
    return Scaffold(
      body: SafeArea(
        child: Obx(() {
          return Stack(
            children: [
              Container(
                width: size.width,
                height: size.height,
                color: lightThemeColor[60],
                child: Column(
                  children: <Widget>[
                    60.h,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 40,
                                backgroundColor: greenThemeColor,
                                child: ClipOval(
                                  child: CachedNetworkImage(
                                    imageUrl: profileScreenController
                                                .user.value?.avatarLink !=
                                            null
                                        ? profileScreenController
                                                .user.value!.avatarLink ??
                                            ''
                                        : "https://img.freepik.com/free-psd/3d-illustration-human-avatar-profile_23-2150671122.jpg", // Provide a default valid URL
                                    placeholder: (context, url) =>
                                        const CircularProgressIndicator(),
                                    errorWidget: (context, url, error) =>
                                        Image.asset(
                                            "assets/images/avatar_image_1.png"),
                                    fit: BoxFit.cover,
                                    width: 78,
                                    height: 78,
                                    filterQuality: FilterQuality.high,
                                  ),
                                ),
                              ),
                              15.w,
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    localization.lbl_username,
                                    style: AppStyle.poppinsCustom(
                                        fontSize: 13,
                                        color: darkThemeColor[25]!,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Text(
                                    profileScreenController.user.value?.name ??
                                        'Default',
                                    style: AppStyle.poppinsMediumBlack(
                                        fontSize: 20),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Image.asset(
                              "assets/icons/pencil_icon.png",
                              height: 50,
                              width: 50,
                            ),
                          ),
                        ],
                      ),
                    ),
                    30.h,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Container(
                        width: size.width,
                        height: 370,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: lightThemeColor,
                        ),
                        child: Column(
                          children: <Widget>[
                            _buildButtonTile(
                              onTapped: () =>
                                  Get.toNamed(AppRoutes.accountScreen),
                              titleText: localization.lbl_account,
                              assetPath: "assets/icons/wallet_icon.png",
                              iconBgColor: violetColor[20],
                            ),
                            _buildDivider(),
                            _buildButtonTile(
                              onTapped: () =>
                                  Get.toNamed(AppRoutes.settingsScreen),
                              titleText: localization.lbl_settings,
                              assetPath: "assets/icons/settings_icon.png",
                              iconBgColor: violetColor[20],
                            ),
                            _buildDivider(),
                            _buildButtonTile(
                              onTapped: () =>
                                  Get.toNamed(AppRoutes.exportDataScreen),
                              titleText: localization.lbl_export_data,
                              assetPath: "assets/icons/upload_icon.png",
                              iconBgColor: violetColor[20],
                            ),
                            _buildDivider(),
                            _buildButtonTile(
                              onTapped: () {
                                showLogoutBottomSheet(context,
                                    localization: localization, size: size);
                              },
                              titleText: localization.lbl_logout,
                              assetPath: "assets/icons/logout_icon_red.png",
                              iconBgColor: redThemeColor[20],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (profileScreenController.isLoading)
                const BlurredBackground(
                  child: CustomLoadingIndicator(),
                ),
            ],
          );
        }),
      ),
    );
  }

  void showLogoutBottomSheet(BuildContext context,
      {required AppLocalizations localization, required Size size}) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return Container(
          height: 220,
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              10.h,
              Center(
                child: Container(
                  height: 5,
                  width: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: darkThemeColor[50],
                  ),
                ),
              ),
              15.h,
              Text(
                localization.msg_logout,
                style: AppStyle.poppinsCustom(
                  fontSize: 22,
                  color: darkThemeColor[100]!,
                  fontWeight: FontWeight.w500,
                ),
              ),
              15.h,
              Text(
                localization.msg_logout_confirm,
                style: AppStyle.poppinsCustom(
                  fontSize: 18,
                  color: darkThemeColor[50]!,
                  fontWeight: FontWeight.w400,
                ),
              ),
              25.h,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Get.back(); // Close the bottom sheet
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: violetColor[20]!,
                      fixedSize: Size((size.width / 2) - 50, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Text(
                      localization.lbl_no,
                      style: AppStyle.poppinsCustom(
                          fontSize: 19,
                          color: violetColor,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      Get.back();
                      profileScreenController.setLoading(true);
                      await UserPreferences.clearAllUserData();
                      Future.delayed(
                        const Duration(seconds: 2),
                      );
                      profileScreenController.setLoading(false);
                      Get.offAllNamed(AppRoutes.onboardingScreen);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: violetColor,
                      fixedSize: Size((size.width / 2) - 50, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Text(
                      localization.lbl_yes,
                      style: AppStyle.poppinsCustom(
                          fontSize: 19,
                          color: lightThemeColor,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
              15.h,
            ],
          ),
        );
      },
    );
  }

  Divider _buildDivider() {
    return Divider(
      indent: 10,
      endIndent: 10,
      color: lightThemeColor[20],
      thickness: 0.7,
    );
  }

  GestureDetector _buildButtonTile(
      {required Function() onTapped,
      required String titleText,
      required String assetPath,
      required iconBgColor}) {
    return GestureDetector(
      onTap: onTapped,
      child: SizedBox(
        height: 80,
        width: double.maxFinite,
        child: Row(
          children: <Widget>[
            20.w,
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: iconBgColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Image.asset(
                assetPath,
                height: 60,
                width: 60,
              ),
            ),
            15.w,
            Text(
              titleText,
              style: AppStyle.poppinsRegularBlack(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
