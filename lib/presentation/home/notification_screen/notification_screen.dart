import 'package:expenseecho/core/utils/theme_colors.dart';
import 'package:expenseecho/presentation/home/notification_screen/notification_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:get/get.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final notificationScreenController = Get.find<NotificationScreenController>();
  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: buildAppBar(localization),
      body: Container(),
    );
  }

  AppBar buildAppBar(AppLocalizations localization) {
    return AppBar(
      iconTheme: const IconThemeData(
        color: darkThemeColor,
      ),
      title: Text(localization.lbl_notification),
      centerTitle: true,
      backgroundColor: lightThemeColor,
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: PopupMenuButton<String>(
            icon: const Icon(
              Icons.more_horiz_outlined,
              size: 34,
            ),
            onSelected: (String result) {
              if (result == 'markAllAsRead') {
                notificationScreenController.markAllAsRead();
              } else if (result == 'deleteAll') {
                notificationScreenController.deleteAll();
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'markAllAsRead',
                child: Text('Mark All as Read'),
              ),
              const PopupMenuItem<String>(
                value: 'deleteAll',
                child: Text('Delete All'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
