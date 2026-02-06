import 'package:mobile/src/app/app_api.dart';

void main() async {
  final api = AppApi();

  print('--- 🌐 STARTING HEADLESS UI DEBUG FLOW ---');

  // 1. SETUP STREAM LISTENER (The "Dumb UI" observer)
  api.stateStream.listen((state) {
    print('📱 [UI STREAM UPDATE]: $state');
  });

  // --- STAGE 1: SETUP ---
  print('\n[Action] Step 1: Choosing Leg...');
  await api.chooseLeg("Left");

  print('\n[Action] Step 2: Connecting Bluetooth...');
  await api.connectBluetooth("SMART-BRACE-001");

  print('\n[Action] Step 3: Pressing "Start Exercise"...');
  final startRes = await api.startExercise();
  print('   Result: ${startRes['message']}');

  // --- STAGE 2: TRACKING (THE TWO-STEP REP) ---
  print('\n[Action] Step 4: Perform Rep (Hardware Hold)...');
  // This triggers PerformRepUseCase
  final performRes = await api.performRep();
  print(
    '   Is Rep Staged: ${performRes['success']} | ${performRes['message']}',
  );

  print('\n[Action] Step 5: Record Rep (User Confirm)...');
  // This triggers RegisterRepUseCase
  final registerRes = await api.registerRep();
  print('   Rep Count: ${registerRes['new_count']}');

  // --- STAGE 3: TRANSITION ---
  print('\n[Action] Step 6: Finish Exercise (Move to Feedback)...');
  await api.finishExercise();

  // --- STAGE 4: FEEDBACK ---
  print('\n[Action] Step 7: Update Rating & Comments...');
  await api.updateRating(5);
  await api.updateComments("Brace feels secure during extension.");

  print('\n[Action] Step 8: Save Feedback (Finalize)...');
  final finalRes = await api.finalizeWorkout();
  print(
    '   Archived: ${finalRes['success']} | Message: ${finalRes['message']}',
  );

  // --- STAGE 5: VERIFICATION ---
  print('\n[Action] Step 9: Fetch History List...');
  final history = await api.getHistory();

  if (history['success']) {
    print('✅ History Count: ${history['count']}');
    final List workouts = history['data'];
    for (var w in workouts) {
      print(
        '   - Reps: ${w['reps']} | Rating: ${w['stars']}⭐ | Note: ${w['comments']}',
      );
    }
  }

  // Allow stream prints to catch up
  await Future.delayed(const Duration(milliseconds: 500));
  print('\n--- 🏁 HEADLESS UI FLOW COMPLETE ---');
}
