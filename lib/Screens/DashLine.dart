import 'package:flutter/material.dart';

class DashLinePainter extends CustomPainter {
  final Color color;
  final double dashLength;
  final double dashGap;

  DashLinePainter({
    required this.color,
    required this.dashLength,
    required this.dashGap,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = 1.0
      ..strokeCap = StrokeCap.round;

    double startX = 0.0;
    while (startX < size.width) {
      canvas.drawLine(
        Offset(startX, 0.5),
        Offset(startX + dashLength, 0.5),
        paint,
      );
      startX += dashLength + dashGap;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
