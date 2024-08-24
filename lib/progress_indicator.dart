import 'dart:ui';

import 'package:flutter/material.dart';
import 'dart:math';

class DashedCircularProgressIndicator extends StatelessWidget {
  final double progress;
  final double strokeWidth;
  final Color fillColor;
  final Color dashColor;
  final Duration duration;

  DashedCircularProgressIndicator({
    required this.progress,
    this.strokeWidth = 8.0,
    required this.fillColor,
    required this.dashColor,
    this.duration = const Duration(seconds: 1),
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: progress),
      duration: duration,
      builder: (context, value, child) {
        return CustomPaint(
          painter: _DashedCircularPainter(
            progress: value,
            strokeWidth: strokeWidth,
            fillColor: fillColor,
            dashColor: dashColor,
          ),
        );
      },
    );
  }
}

class _DashedCircularPainter extends CustomPainter {
  final double progress;
  final double strokeWidth;
  final Color fillColor;
  final Color dashColor;

  _DashedCircularPainter({
    required this.progress,
    required this.strokeWidth,
    required this.fillColor,
    required this.dashColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    double radius = (size.width / 2) - strokeWidth / 2;
    Offset center = Offset(size.width / 2, size.height / 2);
    double sweepAngle = 2 * pi * progress;

    // Draw filled arc
    Paint fillPaint = Paint()
      ..color = fillColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      sweepAngle,
      false,
      fillPaint,
    );

    // Draw dashed arc for unfilled portion
    Paint dashPaint = Paint()
      ..color = dashColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    Path dashPath = Path()
      ..addArc(
        Rect.fromCircle(center: center, radius: radius),
        -pi / 2 + sweepAngle,
        2 * pi - sweepAngle,
      );

    double dashLength = 10.0;
    double gapLength = 5.0;
    double distance = 0.0;

    for (PathMetric pathMetric in dashPath.computeMetrics()) {
      while (distance < pathMetric.length) {
        final segment = pathMetric.extractPath(
          distance,
          distance + dashLength,
        );
        canvas.drawPath(segment, dashPaint);
        distance += dashLength + gapLength;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
