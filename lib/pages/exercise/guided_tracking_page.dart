import 'package:flutter/material.dart';
import 'package:mobile/pages/exercise/logic/tracking_animation_manager.dart';
import 'package:mobile/pages/exercise/logic/tracking_controller.dart';
import 'package:mobile/pages/exercise/widgets/guided_tracking_top_bar.dart';
import 'package:mobile/pages/exercise/widgets/tracking_bottom_container.dart';
import 'package:mobile/pages/exercise/widgets/tracking_graphic.dart';
import 'package:mobile/pages/exercise/widgets/tracking_rep_counter.dart';

class GuidedTrackingPage extends StatefulWidget {
  const GuidedTrackingPage({super.key});
  @override
  State<GuidedTrackingPage> createState() => _GuidedTrackingPageState();
}

class _GuidedTrackingPageState extends State<GuidedTrackingPage>
    with SingleTickerProviderStateMixin {
  final TrackingController _logic = TrackingController();
  late final TrackingAnimationManager _animation;

  @override
  void initState() {
    super.initState();
    // One line, zero nested indents
    _animation = TrackingAnimationManager(
      vsync: this,
      logic: _logic,
      onStateChange: () => setState(() {}),
    );
  }

  @override
  void dispose() {
    _animation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      body: SafeArea(
        child: Column(
          children: [
            const GuidedTrackingTopBar(),
            const Spacer(),
            GuidedTrackingGraphic(
              controller: _animation.controller,
              state: _logic.currentState,
            ),
            const Spacer(),
            RepCounterDisplay(count: _logic.repsCompleted),
            const Spacer(flex: 2),
            TrackingBottomContainer(
              controller: _animation.controller,
              logic: _logic,
              onRefresh: () => setState(() {}),
            ),
          ],
        ),
      ),
    );
  }
}
