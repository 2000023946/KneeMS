import 'package:flutter/material.dart';
import 'package:mobile/pages/exercise/logic/tracking_animation_manager.dart';
import 'package:mobile/pages/exercise/logic/tracking_controller.dart';
import 'package:mobile/pages/exercise/widgets/guided_tracking_top_bar.dart';
import 'package:mobile/pages/exercise/widgets/tracking_bottom_container.dart';
import 'package:mobile/pages/exercise/widgets/tracking_graphic.dart';
import 'package:mobile/pages/exercise/widgets/tracking_rep_counter.dart';
import 'package:mobile/src/app/app_api.dart';

class GuidedTrackingPage extends StatefulWidget {
  const GuidedTrackingPage({super.key});
  @override
  State<GuidedTrackingPage> createState() => _GuidedTrackingPageState();
}

class _GuidedTrackingPageState extends State<GuidedTrackingPage>
    with SingleTickerProviderStateMixin {
  final TrackingController _logic = TrackingController();
  late final TrackingAnimationManager _animation;
  // 🟢 Access your API
  final _api = AppApi();

  @override
  void initState() {
    super.initState();
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
      // 🟢 Setup the Stream
      body: StreamBuilder<Map<String, dynamic>>(
        stream: _api.stateStream,
        builder: (context, snapshot) {
          // 🟢 Link Stream data back to your existing logic variables
          final data = snapshot.data ?? {};
          final reps = data['reps'] ?? 0;

          return SafeArea(
            child: Column(
              children: [
                const GuidedTrackingTopBar(),
                const Spacer(),
                GuidedTrackingGraphic(
                  controller: _animation.controller,
                  state: _logic.currentState,
                  // You can now pass isStaged here if your widget supports it
                ),
                const Spacer(),
                RepCounterDisplay(count: reps), // 🟢 Driven by Stream
                const Spacer(flex: 2),
                TrackingBottomContainer(
                  controller: _animation.controller,
                  logic: _logic,
                  onRefresh: () => setState(() {}),
                  // You can now pass isStaged/API calls here
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
