import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shimmer/shimmer.dart'; // Add this package to your pubspec.yaml

class CustomLoadingIndicator extends StatelessWidget {
  const CustomLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.black.withOpacity(0.5),
      statusBarIconBrightness: Brightness.light,
    ));
    return Center(
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Image.asset(
          "assets/icons/expense_echo_logo.png",
          width: 200, // Adjust width as needed
          height: 200, // Adjust height as needed
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
