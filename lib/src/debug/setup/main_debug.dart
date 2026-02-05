import 'package:mobile/src/domain/feedback/useCases/finish_feedback_usecase.dart';
import 'package:mobile/src/domain/feedback/useCases/update_comments_use_case.dart';
import 'package:mobile/src/domain/feedback/useCases/update_rating_use_case.dart';
import 'package:mobile/src/domain/models/fetch_history_usecase.dart';
import 'package:mobile/src/domain/setup/useCases/choose_leg_use_case.dart';
import 'package:mobile/src/domain/setup/useCases/connect_bluetooth_use_case.dart';
import 'package:mobile/src/domain/setup/useCases/start_exercise_use_case.dart';
import 'package:mobile/src/domain/tracking/proofs/rep_confirmed_proof.dart';
import 'package:mobile/src/domain/tracking/useCases/finish_exercise_use_case.dart';
import 'package:mobile/src/domain/tracking/useCases/register_rep_use_case.dart';
import 'package:mobile/src/domain/tracking/useCases/abort_exercise_use_case.dart';
import 'package:mobile/src/domain/tracking/policies/i_ble_rep_tracking_policy.dart';
import 'package:mobile/src/infrastructure/adapters/ble_connection_adapter.dart';
import 'package:mobile/src/infrastructure/persistance/in_memory_feedback_adapter.dart';
import 'package:mobile/src/infrastructure/persistance/in_memory_history_adapter.dart';
import 'package:mobile/src/infrastructure/persistance/in_memory_setup_adapter.dart';
import 'package:mobile/src/infrastructure/persistance/in_memory_tracking_adapter.dart';

void main() async {
  print('--- 🏗️  WIRING UP THE COMPLETE PROOF-ORIENTED SYSTEM ---');

  // 1. Setup & Persistence Layer
  final setupPersistence = InMemorySetupAdapter();
  final trackingPersistence = InMemoryTrackingAdapter();
  final bleHardware = BLEConnectionAdapter();

  // 2. Hardware/Sensor Policy Layer
  final repTrackingPolicy = MockBLERepTrackingPolicy();

  // 3. Domain Use Cases
  final connectUseCase = ConnectBluetoothUseCase(bleHardware, setupPersistence);
  final chooseLegUseCase = ChooseLegUseCase(setupPersistence);
  final startUseCase = StartExerciseUseCase(
    setupPersistence,
    bleHardware,
    trackingPersistence,
  );

  final registerRepUseCase = RegisterRepUseCase(
    repTrackingPolicy,
    trackingPersistence,
  );
  final abortUseCase = AbortExerciseUseCase(
    trackingPersistence,
    setupPersistence,
  );

  final feedbackPersistence = InMemoryFeedbackAdapter();

  final finishExerciseUseCase = FinishExerciseUseCase(
    trackingPersistence,
    feedbackPersistence,
  );

  final updateCommentsUseCase = UpdateCommentsUseCase(feedbackPersistence);
  final updateRatingUseCase = UpdateRatingUseCase(feedbackPersistence);

  final historyPersistence = InMemoryHistoryAdapter(); // New

  // Use Case
  final finalizeUseCase = FinalizeWorkoutUseCase(
    feedbackPersistence,
    historyPersistence,
  );

  // --- Query Use Case ---
  final getHistoryUseCase = GetWorkoutHistoryUseCase(historyPersistence);

  print('--- 🚀 STARTING CLIENT ACTIONS ---');

  // --- STAGE 1: THE SETUP ---
  print('\n[Step 1] Initializing Handshake...');
  await connectUseCase.execute("SMART_BRACE_001");
  await chooseLegUseCase.execute('left');
  print('✅ Setup phase completed.');

  // --- STAGE 2: THE LAUNCH ---
  print('\n[Step 2] Promoting to Live Tracking...');
  final startResult = await startUseCase.execute();

  if (!startResult.success) {
    print('❌ Launch Failed: ${startResult.message}');
    return;
  }
  print('✅ ${startResult.message}');
  print(
    '   Active State: ${startResult.activeState.runtimeType} | Reps: ${startResult.activeState?.reps.value}',
  );

  // --- STAGE 3: THE ACTION (Live Tracking) ---
  print('\n--- 🏃 TRACKING COMMENCED ---');

  // Simulate Rep 1
  print('\n[Sensor] User completes 1st Rep...');
  final rep1 = await registerRepUseCase.execute();
  _printResult('Rep 1', rep1.success, rep1.message);

  // Simulate Rep 2
  print('\n[Sensor] User completes 2nd Rep...');
  final rep2 = await registerRepUseCase.execute();
  _printResult('Rep 2', rep2.success, rep2.message);

  // --- STAGE 4: THE REGRESSION (Abort) ---
  print('\n[Action] User hits "CANCEL" to quit workout...');
  final abortResult = await abortUseCase.execute();

  print('\n[Action] User hits "FINISH WORKOUT"...');
  final finishResult = await finishExerciseUseCase.execute();

  if (finishResult.success) {
    print('✅ ${finishResult.message}');
    print('   Transitioned to: ${finishResult.feedbackState.runtimeType}');
  }

  // --- STAGE 5: REFINING THE FEEDBACK (The Draft Phase) ---
  print('\n[Action] User types a comment...');
  final commentResult = await updateCommentsUseCase.execute(
    "Feeling much stronger today!",
  );
  _printResult('Comment Update', commentResult.success, commentResult.message);

  print('\n[Action] User selects a 5-star rating...');
  final ratingResult = await updateRatingUseCase.execute(5);

  if (ratingResult.success) {
    print('✅ ${ratingResult.message}');
    print('   State Promoted to: ${ratingResult.nextState.runtimeType}');
    print('   Ready to Archive: YES');
  }

  // --- STAGE 6: FINAL ARCHIVE ---
  // Here is where you'd call a "FinalizeWorkoutUseCase" if you've built it.
  print('\n[Action] User hits "SUBMIT FEEDBACK" (Final Archive)...');
  final archiveResult = await finalizeUseCase.execute();

  if (archiveResult.success) {
    print('✅ ${archiveResult.message}');
    print('--- 📊 FINAL WORKOUT SUMMARY ---');
    print('   Reps:   ${archiveResult.totalReps}');
    print('   Leg:    ${archiveResult.legUsed}');
    print('   Rating: ${archiveResult.starRating} ⭐');
    print('   Notes:  "${archiveResult.userComments}"');
    print('--------------------------------');
    print(
      '✅ Infrastructure Status: Session Store Cleared. History Vault Updated.',
    );
  } else {
    print('❌ Archive Failed: ${archiveResult.message}');
  }

  // --- STAGE 7: VERIFICATION ---
  print('\n[Action] Fetching Permanent History...');
  final historyResult = await getHistoryUseCase.execute();

  if (historyResult.success) {
    print(
      '📋 History Vault contains ${historyResult.workoutList.length} items:',
    );
    for (var workout in historyResult.workoutList) {
      print(
        '   - Date: ${workout['date']} | Reps: ${workout['reps']} | Rating: ${workout['stars']}⭐',
      );
    }
  } else {
    print('❌ Fetch Failed: ${historyResult.errorMessage}');
  }

  print('\n--- 🏁 FULL SYSTEM CYCLE COMPLETE: WORKOUT ARCHIVED ---');

  if (abortResult.success) {
    print('✅ ${abortResult.message}');
    print('   System Status: Session deleted. Reverted to Setup domain.');
  }

  print('\n--- 🏁 FULL SYSTEM CYCLE COMPLETE ---');
}

/// Helper to format log output
void _printResult(String step, bool success, String message) {
  final icon = success ? '✅' : '❌';
  print('$icon $step: $message');
}

/// Mock Policy to simulate the BLE sensor identifying a valid rep
class MockBLERepTrackingPolicy implements IBLERepTrackingPolicy {
  @override
  Stream<RepConfirmedProof> trackReps() async* {
    // Simulate the hardware processing time for a single rep
    await Future.delayed(Duration(milliseconds: 500));
    yield RepConfirmedProof();
  }
}
