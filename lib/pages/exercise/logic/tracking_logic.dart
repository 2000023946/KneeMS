import 'dart:math' as math;

enum TrackingState { idle, extending, review }

class TrackingMath {
  /// Calculates a 0 -> 90 -> 0 degree swing over the 4s duration
  static double calculateAngle(double progress, TrackingState state) {
    if (state != TrackingState.extending) return 0.0;

    if (progress <= 0.5) {
      // First 2 seconds: 0 to 90 degrees
      return (progress * 2) * 90.0;
    } else {
      // Last 2 seconds: 90 back to 0 degrees
      return 90.0 - ((progress - 0.5) * 2 * 90.0);
    }
  }

  static double degreesToRadians(double degrees) => (degrees * math.pi) / 180;
}
