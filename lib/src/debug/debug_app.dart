import 'package:mobile/src/app/app.dart';

void main() async {
  print('--- 🏗️  WIRING UP THE COMPLETE PROOF-ORIENTED SYSTEM ---');
  final app = App();
  print('--- 🚀 STARTING CLIENT ACTIONS ---');

  // --- STAGE 1: THE SETUP ---
  print('\n[Step 1] Initializing Handshake...');
  await app.connectUseCase.execute("SMART_BRACE_001");
  await app.chooseLegUseCase.execute('left');
  print('✅ Setup phase completed.');

  // --- STAGE 2: THE LAUNCH ---
  print('\n[Step 2] Promoting to Live Tracking...');
  final startResult = await app.startUseCase.execute();

  if (!startResult.success) {
    print('❌ Launch Failed: ${startResult.message}');
    return;
  }
  print('✅ ${startResult.message}');

  // --- STAGE 3: THE ACTION (Live Tracking with Staging) ---
  print('\n--- 🏃 TRACKING COMMENCED ---');

  // --- Rep 1 Simulation ---
  print('\n[Sensor] Hardware detects 4s hold for Rep 1...');
  // 🟢 STEP A: Stage the rep (Flip isRepStaged to true)
  final stage1 = await app.performRepUseCase.execute();
  _printResult('Rep 1 Staging', stage1.isReady, stage1.message);

  print('[UI] User taps "Confirm Rep 1"...');
  // 🟢 STEP B: Register the rep (Increment + Reset Flag)
  final reg1 = await app.registerRepUseCase.execute();
  _printResult('Rep 1 Registration', reg1.success, reg1.message);

  // --- Rep 2 Simulation ---
  print('\n[Sensor] Hardware detects 4s hold for Rep 2...');
  final stage2 = await app.performRepUseCase.execute();
  _printResult('Rep 2 Staging', stage2.isReady, stage2.message);

  print('[UI] User taps "Confirm Rep 2"...');
  final reg2 = await app.registerRepUseCase.execute();
  _printResult('Rep 2 Registration', reg2.success, reg2.message);

  // --- STAGE 4: TRANSITION TO FEEDBACK ---
  print('\n[Action] User hits "FINISH WORKOUT"...');
  final finishResult = await app.finishExerciseUseCase.execute();

  if (finishResult.success) {
    print('✅ ${finishResult.message}');
    print('   Transitioned to: ${finishResult.feedbackState.runtimeType}');
  }

  // --- STAGE 5: REFINING THE FEEDBACK ---
  print('\n[Action] User selects a 5-star rating and comments...');
  await app.updateCommentsUseCase.execute("Feeling much stronger today!");
  final ratingResult = await app.updateRatingUseCase.execute(5);

  if (ratingResult.success) {
    print('✅ ${ratingResult.message}');
  }

  // --- STAGE 6: FINAL ARCHIVE ---
  print('\n[Action] User hits "SUBMIT FEEDBACK" (Final Archive)...');
  final archiveResult = await app.finalizeUseCase.execute();

  if (archiveResult.success) {
    print('✅ ${archiveResult.message}');
    print('--- 📊 FINAL WORKOUT SUMMARY ---');
    print('   Reps:   ${archiveResult.totalReps}');
    print('   Rating: ${archiveResult.starRating} ⭐');
    print('--------------------------------');
  }

  // --- STAGE 7: VERIFICATION ---
  print('\n[Action] Fetching Permanent History...');
  final historyResult = await app.getHistoryUseCase.execute();

  if (historyResult.success) {
    print(
      '📋 History Vault contains ${historyResult.workoutList.length} items:',
    );
    for (var workout in historyResult.workoutList) {
      print('   - Reps: ${workout['reps']} | Rating: ${workout['stars']}⭐');
    }
  }

  print('\n--- 🏁 FULL SYSTEM CYCLE COMPLETE ---');
}

/// Helper to format log output
void _printResult(String step, bool success, String message) {
  final icon = success ? '✅' : '❌';
  print('$icon $step: $message');
}
