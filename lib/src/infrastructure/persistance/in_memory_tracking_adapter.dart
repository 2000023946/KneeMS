import 'package:mobile/src/domain/tracking/policies/i_tracking_persistence_policy.dart';
import 'package:mobile/src/domain/tracking/proofs/tracking_persistence_proofs.dart';
import 'package:mobile/src/domain/tracking/proofs/tracking_state_proofs.dart';
import 'package:mobile/src/domain/tracking/states/exercise_state.dart';
import 'package:mobile/src/domain/valueObjects/leg_choice.dart';
import 'package:mobile/src/domain/valueObjects/ble_device_address.dart';
import 'package:mobile/src/domain/valueObjects/rep_count.dart';
import 'package:mobile/src/infrastructure/persistance/data_stores/setup_table.dart';

class InMemoryTrackingAdapter extends ITrackingPersistencePolicy {
  final SessionDataStore _store = SessionDataStore();

  @override
  Future<TrackingSavedPersistenceProof> saveActiveTracking(
    ExerciseStartedProof domainProof,
  ) async {
    // Extract the raw value from the Domain State
    final newCount = domainProof.state.reps.value;
    // Commit to the "Database"
    _store.updateRepCount(newCount);
    _store.putIsRepStaged(domainProof.state.isRepStaged);

    int? currentCount = _store.getActiveRepCount();
    currentCount ??= 0;

    // Return the Persistence Receipt
    return TrackingSavedPersistenceProof(currentCount);
  }

  @override
  Future<TrackingHydrationProof> getSavedProgress() async {
    // 1. Pull primitives from the store
    final count = _store.getActiveRepCount() ?? 0;
    // NOTE: In a real app, you'd also pull start_time, leg, and device from the store.
    // For this mock, we assume the session exists if we're calling hydration.
    final state = ExerciseInProgressState.fromPersistence(
      LegChoice(_store.getSetupLeg() ?? "left"),
      BLEDeviceAddress(_store.getSetupDevice() ?? "UNKNOWN"),
      DateTime.now(), // Simplified for this mock
      RepCount(count),
      _store.getIsRepStaged(),
      getTrackingStateCertificate(),
    );

    return TrackingHydrationProof(state);
  }

  @override
  Future<TrackingDeletedPersistenceProof> clearActiveTracking(
    TrackingAbortedProof abortProof,
  ) async {
    // Capture the final count for the "Death Certificate" summary
    final finalCount = abortProof.abortedState.reps.value;

    // Wipe the active tracking keys
    _store.wipeAll();

    return TrackingDeletedPersistenceProof(
      sessionSummary: "Session aborted at $finalCount reps.",
    );
  }

  @override
  Future<dynamic> startNewSession(ExerciseInProgressState exerciseState) async {
    // We update the rep count to initialize the session in the store
    _store.updateRepCount(exerciseState.reps.value);

    return ExerciseStartedProof(exerciseState);
  }
}
