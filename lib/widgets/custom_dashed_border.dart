import 'dart:ui';

import 'package:flutter/material.dart';

class DashedBorder extends StatelessWidget {
  final Widget child;
  final double strokeWidth;
  final Color color;
  final double dashWidth;
  final double dashGap;
  final BorderRadius borderRadius;

  const DashedBorder({
    super.key,
    required this.child,
    this.strokeWidth = 2.0,
    this.color = Colors.grey,
    this.dashWidth = 5.0,
    this.dashGap = 3.0,
    this.borderRadius = BorderRadius.zero,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DashedBorderPainter(
        strokeWidth: strokeWidth,
        color: color,
        dashWidth: dashWidth,
        dashGap: dashGap,
        borderRadius: borderRadius,
      ),
      child: child,
    );
  }
}

class _DashedBorderPainter extends CustomPainter {
  final double strokeWidth;
  final Color color;
  final double dashWidth;
  final double dashGap;
  final BorderRadius borderRadius;

  _DashedBorderPainter({
    required this.strokeWidth,
    required this.color,
    required this.dashWidth,
    required this.dashGap,
    required this.borderRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final path = Path()
      ..addRRect(RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height),
        borderRadius.topLeft,
      ));

    final dashPath = Path();
    double distance = 0.0;

    for (PathMetric pathMetric in path.computeMetrics()) {
      while (distance < pathMetric.length) {
        dashPath.addPath(
          pathMetric.extractPath(distance, distance + dashWidth),
          Offset.zero,
        );
        distance += dashWidth + dashGap;
      }
    }

    canvas.drawPath(dashPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
