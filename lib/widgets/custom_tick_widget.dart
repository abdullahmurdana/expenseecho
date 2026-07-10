import 'package:flutter/material.dart';

Center buildTickWidget() {
  return const Center(
    child: CircleAvatar(
      radius: 12,
      backgroundColor: Colors.blue,
      child: Icon(
        Icons.check,
        color: Colors.white,
        size: 20,
      ),
    ),
  );
}
