import 'package:flutter/material.dart';
import 'package:mobile/pages/exercise/logic/tracking_logic.dart';
import 'package:mobile/pages/exercise/logic/tracking_painter.dart';

class GuidedTrackingGraphic extends StatelessWidget {
  final AnimationController controller;
  final TrackingState state;

  const GuidedTrackingGraphic({
    super.key,
    required this.controller,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) => Center(
        child: SizedBox(
          height: 200,
          width: 200,
          child: CustomPaint(
            painter: TrackingPainter(
              angleInDegrees: TrackingMath.calculateAngle(
                controller.value,
                state,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
