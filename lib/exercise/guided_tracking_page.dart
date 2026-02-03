import 'package:flutter/material.dart';
import 'dart:math' as math;
// Import your SessionSummaryPage here
import 'package:mobile/session_summary_page.dart';

class GuidedTrackingPage extends StatefulWidget {
  const GuidedTrackingPage({super.key});

  @override
  State<GuidedTrackingPage> createState() => _GuidedTrackingPageState();
}

enum TrackingState { idle, extending, review }

class _GuidedTrackingPageState extends State<GuidedTrackingPage>
    with SingleTickerProviderStateMixin {
  TrackingState _currentState = TrackingState.idle;
  int repsCompleted = 0;
  late AnimationController _progressController;

  @override
  void initState() {
    super.initState();
    _progressController =
        AnimationController(vsync: this, duration: const Duration(seconds: 4))
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              setState(() {
                _currentState = TrackingState.review;
              });
            }
          });
  }

  @override
  void dispose() {
    _progressController.dispose();
    super.dispose();
  }

  void _startExercise() {
    setState(() {
      _currentState = TrackingState.extending;
    });
    _progressController.forward(from: 0.0);
  }

  void _saveRep() {
    setState(() {
      repsCompleted++;
      _currentState = TrackingState.idle;
      _progressController.reset();
    });
  }

  void _redoRep() {
    setState(() {
      _currentState = TrackingState.idle;
      _progressController.reset();
    });
  }

  double _calculateAngle(double progress) {
    if (_currentState == TrackingState.review) return 0.0;
    if (_currentState == TrackingState.idle) return 0.0;

    if (progress <= 0.5) {
      return (progress * 2) * 90.0;
    } else {
      return 90.0 - ((progress - 0.5) * 2 * 90.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white54),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Expanded(
                    child: Center(
                      child: Text(
                        'GUIDED TRACKING',
                        style: TextStyle(
                          color: Colors.white54,
                          letterSpacing: 2,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 48),
                ],
              ),
            ),
            const Spacer(),
            AnimatedBuilder(
              animation: _progressController,
              builder: (context, child) {
                return Center(
                  child: SizedBox(
                    height: 200,
                    width: 200,
                    child: CustomPaint(
                      painter: TrackingPainter(
                        angleInDegrees: _calculateAngle(
                          _progressController.value,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            const Spacer(),
            Text(
              '$repsCompleted',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 80,
                fontWeight: FontWeight.w900,
                fontStyle: FontStyle.italic,
              ),
            ),
            const Text(
              'REPS COMPLETED',
              style: TextStyle(
                color: Colors.white38,
                letterSpacing: 1.5,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            const Spacer(flex: 2),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: _buildBottomUI(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomUI() {
    switch (_currentState) {
      case TrackingState.extending:
        return _buildExtendingUI();
      case TrackingState.review:
        return _buildReviewUI();
      default:
        return _buildStartUI();
    }
  }

  Widget _buildStartUI() {
    return Container(
      key: const ValueKey('start'),
      padding: const EdgeInsets.all(30),
      decoration: const BoxDecoration(
        color: Color(0xFF1E293B),
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 100,
            child: ElevatedButton(
              onPressed: _startExercise,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2563EB),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.play_arrow, size: 40, color: Colors.white),
                  Text(
                    "Start Rep",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          // UPDATED: Added TextButton for navigation
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      SessionSummaryPage(totalReps: repsCompleted),
                ),
              );
            },
            child: const Text(
              "Finish Session",
              style: TextStyle(
                color: Colors.white38,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExtendingUI() {
    return Container(
      key: const ValueKey('extending'),
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
      decoration: const BoxDecoration(
        color: Color(0xFF1E293B),
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.timer_outlined, color: Colors.white54, size: 20),
              SizedBox(width: 8),
              Text(
                "Extending...",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          AnimatedBuilder(
            animation: _progressController,
            builder: (context, child) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(
                  value: _progressController.value,
                  minHeight: 10,
                  backgroundColor: Colors.white10,
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    Color(0xFF2563EB),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 16),
          const Text(
            "Follow the animation",
            style: TextStyle(color: Colors.white24, fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewUI() {
    return Container(
      key: const ValueKey('review'),
      padding: const EdgeInsets.all(30),
      decoration: const BoxDecoration(
        color: Color(0xFF1E293B),
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Column(
        children: [
          const Text(
            "How was that rep?",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: _buildReviewButton(
                  label: "Redo",
                  icon: Icons.refresh,
                  color: const Color(0xFF334155),
                  onTap: _redoRep,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildReviewButton(
                  label: "Save Rep",
                  icon: Icons.check,
                  color: const Color(0xFF10B981),
                  onTap: _saveRep,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildReviewButton({
    required String label,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 30),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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
