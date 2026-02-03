import 'package:flutter/material.dart';
import 'package:mobile/pages/navbar/navbararrow.dart';
import 'package:mobile/pages/selection/leg_selector_row.dart';
import 'package:mobile/pages/selection/connect_gadget_card.dart';
import 'package:mobile/exercise/guided_tracking_page.dart';

class ExerciseSelectionPage extends StatefulWidget {
  const ExerciseSelectionPage({super.key});

  @override
  State<ExerciseSelectionPage> createState() => _ExerciseSelectionPageState();
}

class _ExerciseSelectionPageState extends State<ExerciseSelectionPage> {
  String selectedLeg = '';
  ConnectState gadgetState = ConnectState.idle;

  bool get canStartRound =>
      selectedLeg != '' && gadgetState == ConnectState.connected;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const KneeNavBarBack(title: 'Setup Exercise'),
      body: SizedBox(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  Flexible(
                    flex: 1,
                    child: LegSelectorRow(
                      selectedLeg: selectedLeg,
                      onChanged: (leg) {
                        setState(() {
                          selectedLeg = leg;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 11),
                  Flexible(
                    flex: 2,
                    child: ConnectGadgetCard(
                      onStateChanged: (state) {
                        setState(() {
                          gadgetState = state;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              height: 90,
              child: Container(
                color: Colors.white,
                child: Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 60,
                    child: TextButton(
                      // Logic: If canStartRound is true, it provides the function.
                      // If false, it's null, which automatically disables the button.
                      onPressed: canStartRound
                          ? () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const GuidedTrackingPage(),
                                ),
                              );
                            }
                          : null,
                      style: TextButton.styleFrom(
                        backgroundColor: canStartRound
                            ? const Color(0xFF2563EB) // Blue when active
                            : const Color(0xFFE5E7EB), // Grey when disabled
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Text(
                        'Start Round',
                        style: TextStyle(
                          color: canStartRound
                              ? Colors.white
                              : const Color(0xFF9CA3AF),
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
