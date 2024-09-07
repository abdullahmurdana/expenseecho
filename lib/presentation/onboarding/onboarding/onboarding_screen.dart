import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:get/get.dart';

import 'package:expenseecho/core/utils/app_styles.dart';
import 'package:expenseecho/core/utils/hex_color.dart';
import 'package:expenseecho/core/utils/sized_box_extensions.dart';
import 'package:expenseecho/core/utils/theme_colors.dart';
import 'package:expenseecho/routes/app_routes.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _currentIndex = 0;

  final List<String> _imagePaths = [
    'assets/images/onboarding_image1.png',
    'assets/images/onboarding_image2.png',
    'assets/images/onboarding_image3.png',
  ];

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: lightThemeColor,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    final List<String> titletexts = [
      localization.txt_onboarding_title1,
      localization.txt_onboarding_title2,
      localization.txt_onboarding_title3,
    ];
    final List<String> subTitletexts = [
      localization.txt_onboarding_subtitle1,
      localization.txt_onboarding_subtitle2,
      localization.txt_onboarding_subtitle3,
    ];

    final size = MediaQuery.of(context).size;
    // Define your design size
    final double designHeight = size.height;
    final double designWidth = size.width;

    // Calculate dynamic sizes
    final double imageCarouselHeight = designHeight * 0.73;
    final double topVerticalGap = designHeight * 0.068;
    final double verticalGap = designHeight * 0.02;
    // final double horizontalGap = designHeight * 0.02;

    return Scaffold(
      body: Container(
        color: Colors.white,
        width: designWidth,
        height: designHeight,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              topVerticalGap.h,
              SizedBox(
                height: imageCarouselHeight, // Adjusted height for the carousel
                child: buildImageCarousel(
                    height: imageCarouselHeight,
                    titletexts,
                    subTitletexts,
                    screenHeight,
                    screenWidth),
              ),
              verticalGap.h,
              buildButtonsColumn(
                  localization: localization,
                  screenHeight: screenHeight,
                  screenWidth: screenWidth),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildButtonsColumn(
      {required AppLocalizations localization,
      required double screenHeight,
      required double screenWidth}) {
    final double buttonHeight = screenHeight * 0.068;
    final double buttonWidth = screenWidth * 0.92;
    final double buttonRadius = buttonHeight / 0.028;
    final double buttonTextSize = screenHeight * 0.03;
    final double verticalGap = screenHeight * 0.02;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: violetColor[100],
              fixedSize: Size(buttonWidth, buttonHeight),
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(buttonRadius), // 56 / 2
              )),
          onPressed: () {
            Get.toNamed(AppRoutes.signupScreen);
          },
          child: Text(
            localization.txt_signup,
            style: AppStyle.gfPoppinsMediumWhite(
                fontSize: buttonTextSize), // Adjusted font size
          ),
        ),
        verticalGap.h,
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              fixedSize: Size(buttonWidth, buttonHeight),
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(buttonRadius), // 56 / 2
              )),
          onPressed: () {
            Get.toNamed(AppRoutes.loginScreen);
          },
          child: Text(
            localization.txt_login,
            style: AppStyle.gfPoppinsCustom(
                fontSize: buttonTextSize,
                color: violetColor,
                fontWeight: FontWeight.w500), // Adjusted font size
          ),
        ),
      ],
    );
  }

  Widget buildImageCarousel(List<String> titleTexts, List<String> subTitleTexts,
      double screenHeight, double screenWidth,
      {required double height}) {
    var titleFontSize = screenHeight * 0.035;
    var carouselHeight = screenHeight * 0.52;
    var horizontalPadding = screenWidth * 0.04;
    var verticalGap = screenHeight * 0.02;
    var subtitleFontSize = screenHeight * 0.018;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          children: [
            CarouselSlider(
              items: _imagePaths.map((path) {
                return Image.asset(path, fit: BoxFit.cover, width: screenWidth);
              }).toList(),
              options: CarouselOptions(
                height: carouselHeight,
                autoPlay: true,
                enlargeCenterPage: false,
                aspectRatio: 16 / 9,
                viewportFraction: 1.0,
                autoPlayInterval: const Duration(seconds: 5),
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
              ),
            ),
            verticalGap.h,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Column(
                children: [
                  Text(
                    titleTexts[_currentIndex],
                    style: AppStyle.gfPoppinsBoldBlack(
                      fontSize: titleFontSize, // Adjusted font size
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    subTitleTexts[_currentIndex],
                    style: AppStyle.gfPoppinsCustom(
                      fontSize: subtitleFontSize, // Adjusted font size
                      color: lightThemeColor[20]!,
                      fontWeight: FontWeight.w300,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _imagePaths.map((path) {
            int index = _imagePaths.indexOf(path);
            return AnimatedContainer(
              duration: const Duration(milliseconds: 100),
              width: _currentIndex == index
                  ? screenHeight * 0.02
                  : screenHeight * 0.01,
              height: _currentIndex == index
                  ? screenHeight * 0.02
                  : screenHeight * 0.01,
              margin: EdgeInsets.symmetric(
                  vertical: screenHeight * 0.01,
                  horizontal: screenHeight * 0.01),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color:
                    _currentIndex == index ? violetColor : HexColor('#EEE5FF'),
              ),
            );
          }).toList(),
        )
      ],
    );
  }
}
