import 'package:flutter/material.dart';
import 'dart:math' as math;

class TrackingPainter extends CustomPainter {
  final double angleInDegrees;
  TrackingPainter({required this.angleInDegrees});

  @override
  void paint(Canvas canvas, Size size) {
    final paintBase = Paint()
      ..color = Colors.white10
      ..strokeWidth = 14
      ..strokeCap = StrokeCap.round;
    final paintActive = Paint()
      ..color = const Color(0xFF2563EB)
      ..strokeWidth = 14
      ..strokeCap = StrokeCap.round;

    Offset anchor = Offset(size.width / 2, size.height * 0.2);
    canvas.drawLine(anchor, Offset(anchor.dx, anchor.dy + 60), paintBase);

    double radians = (angleInDegrees * math.pi) / 180;
    double length = 80.0;

    double endX = anchor.dx - (length * math.sin(radians));
    double endY = anchor.dy + (length * math.cos(radians));

    canvas.drawLine(anchor, Offset(endX, endY), paintActive);
    canvas.drawCircle(Offset(endX, endY), 12, paintActive);
  }

  @override
  bool shouldRepaint(covariant TrackingPainter oldDelegate) =>
      oldDelegate.angleInDegrees != angleInDegrees;
}
