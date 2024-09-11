import 'package:expenseecho/core/utils/app_styles.dart';
import 'package:expenseecho/core/utils/date_time_utils.dart';
import 'package:expenseecho/core/utils/sized_box_extensions.dart';
import 'package:expenseecho/core/utils/theme_colors.dart';
import 'package:expenseecho/widgets/custom_dashed_divider.dart';
import 'package:expenseecho/widgets/custom_success_dialog.dart';
import 'package:expenseecho/widgets/custom_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:get/get.dart';

class TransferDetailsScreen extends StatefulWidget {
  // TODO add transfer model to constructor.
  // final TransfersModel transfersModel;
  const TransferDetailsScreen({super.key});

  @override
  _TransferDetailsScreenState createState() => _TransferDetailsScreenState();
}

class _TransferDetailsScreenState extends State<TransferDetailsScreen> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: blueThemeColor,
      statusBarIconBrightness: Brightness.light,
    ));
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: blueThemeColor,
      statusBarIconBrightness: Brightness.light,
    ));
    final size = MediaQuery.of(context).size;
    final localization = AppLocalizations.of(context)!;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: buildFloatingActionButton(size, localization),
      body: buildBody(size, localization),
      backgroundColor: lightThemeColor,
    );
  }

  Padding buildFloatingActionButton(Size size, AppLocalizations localization) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
      child: buildElevatedButton(
        height: 56,
        width: size.width,
        onTapped: () {},
        title: localization.lbl_edit,
        bgColor: violetColor,
        fgColor: lightThemeColor,
        textStyle: AppStyle.poppinsRegularWhite(
          fontSize: 20,
        ),
      ),
    );
  }

  SafeArea buildBody(Size size, AppLocalizations localization) {
    final topRowHeight = size.height * 0.08;
    final toolbarHeight = size.height * 0.35;
    final floatingContainerTopPadding = size.height * 0.31;
    final floatingContainerheight = size.height * 0.086;
    final amountColumnHeight = size.height * 0.12;
    return SafeArea(
      child: Container(
        height: size.height,
        width: size.width,
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  height: toolbarHeight,
                  width: size.width,
                  decoration: const BoxDecoration(
                    color: blueThemeColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        Container(
                          height: topRowHeight,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () => Get.back(),
                                child: const Icon(
                                  Icons.arrow_back,
                                  size: 30,
                                  color: lightThemeColor,
                                ),
                              ),
                              Text(
                                localization.lbl_transaction_detail,
                                style:
                                    AppStyle.poppinsMediumWhite(fontSize: 20),
                              ),
                              GestureDetector(
                                onTap: () {
                                  showDeleteBottomSheet(context,
                                      localization: localization, size: size);
                                },
                                child: Image.asset(
                                  "assets/icons/trash_icon_light.png",
                                  height: 30,
                                  width: 30,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: amountColumnHeight,
                          width: size.width,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // TODO use transfer amount here
                              Text(
                                '\$120',
                                style:
                                    AppStyle.poppinsMediumWhite(fontSize: 60),
                              ),
                            ],
                          ),
                        ),
                        10.h,
                        Center(
                          child: Text(
                            DateTime.now()
                                .format(pattern: displayDateTimeFormatPattern),
                            style: AppStyle.poppinsRegularWhite(fontSize: 17),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                57.h,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: DashedDivider(
                    height: 1,
                    dashWidth: 5,
                    dashHeight: 1,
                    color: lightThemeColor[20]!,
                  ),
                ),
                14.h,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        localization.lbl_description,
                        style: AppStyle.poppinsCustom(
                            fontSize: 19,
                            color: lightThemeColor[20]!,
                            fontWeight: FontWeight.w500),
                      ),
                      10.h,
                      // TODO use transfer description here
                      Text(
                        localization.msg_export_success,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 4,
                        style: AppStyle.poppinsCustom(
                          fontSize: 17,
                          color: darkThemeColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                16.h,
                // Sample Attachment
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        localization.lbl_attachment,
                        style: AppStyle.poppinsCustom(
                            fontSize: 19,
                            color: lightThemeColor[20]!,
                            fontWeight: FontWeight.w500),
                      ),
                      10.h,
                      Container(
                        height: size.height * 0.14,
                        width: size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Image.asset(
                          "assets/images/sample_attachment_image.png",
                          fit: BoxFit.fill,
                        ),
                      ),
                    ],
                  ),
                ),
                // TODO add transfer attachment here
                /* if (transferModel.attachmentLink != null)
                  {
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            localization.lbl_attachment,
                            style: AppStyle.poppinsCustom(
                                fontSize: 19,
                                color: lightThemeColor[20]!,
                                fontWeight: FontWeight.w500),
                          ),
                          15.h,
                          // TODO use transfer Attachment here here
                          Container(
                          decoration:BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          ),
                          child:CachedNetworkImage(
                            imageUrl: transferModel.attachmentLink,
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                Image.asset("assets/images/avatar_image_1.png"),
                            fit: BoxFit.cover,
                            width: size.width,
                            height: size.height * 0.14,
                            filterQuality: FilterQuality.high,
                          ),),
                        ],
                      ),
                    ),
                  } */
              ],
            ),
            Positioned(
              top: floatingContainerTopPadding,
              left: 16,
              right: 16,
              child: Container(
                height: floatingContainerheight,
                decoration: BoxDecoration(
                  color: lightThemeColor[60],
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Type",
                          style: AppStyle.poppinsCustom(
                              fontSize: 17,
                              color: lightThemeColor[20]!,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "Transfer",
                          style: AppStyle.poppinsCustom(
                              fontSize: 17,
                              color: darkThemeColor,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "From",
                          style: AppStyle.poppinsCustom(
                              fontSize: 17,
                              color: lightThemeColor[20]!,
                              fontWeight: FontWeight.w500),
                        ),
                        // TODO add transfer From here
                        Text(
                          "Bank",
                          style: AppStyle.poppinsCustom(
                              fontSize: 17,
                              color: darkThemeColor,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // TODO Add transfer to here
                        Text(
                          "To",
                          style: AppStyle.poppinsCustom(
                              fontSize: 17,
                              color: lightThemeColor[20]!,
                              fontWeight: FontWeight.w500),
                        ),
                        // TODO Add account name here
                        Text(
                          "Wallet",
                          style: AppStyle.poppinsCustom(
                              fontSize: 17,
                              color: darkThemeColor,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showDeleteBottomSheet(BuildContext context,
      {required AppLocalizations localization, required Size size}) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return Container(
          height: 220,
          padding: const EdgeInsets.symmetric(horizontal: 16),
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
                localization.lbl_remove_transaction,
                style: AppStyle.poppinsCustom(
                  fontSize: 20,
                  color: darkThemeColor[100]!,
                  fontWeight: FontWeight.w500,
                ),
              ),
              15.h,
              Text(
                localization.msg_remove_transaction,
                textAlign: TextAlign.center,
                style: AppStyle.poppinsCustom(
                  fontSize: 16,
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
                      fixedSize: Size((size.width / 2) - 30, 50),
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
                      showSuccessDialog(
                          message: localization.msg_success_remove_transaction);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: violetColor,
                      fixedSize: Size((size.width / 2) - 30, 50),
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
}
