// sized_box_extension.dart
import 'package:flutter/material.dart';

extension SizedBoxExtension on num {
  SizedBox get h => SizedBox(height: toDouble());
  SizedBox get w => SizedBox(width: toDouble());
}
