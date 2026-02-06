import 'package:mobile/src/domain/feedback/policies/i_feedback_persistence_policy.dart';
import 'package:mobile/src/domain/feedback/proofs/feedback_state_proofs.dart';
import 'package:mobile/src/domain/feedback/states/partial_feedback_state.dart';
import 'package:mobile/src/domain/setup/states/initial_state.dart';
import 'package:mobile/src/domain/tracking/policies/i_tracking_persistence_policy.dart';
import 'package:mobile/src/domain/tracking/proofs/rep_confirmed_proof.dart';
import 'package:mobile/src/domain/tracking/proofs/tracking_state_proofs.dart';
import 'package:mobile/src/domain/valueObjects/ble_device_address.dart';
import 'package:mobile/src/domain/valueObjects/leg_choice.dart';
import 'package:mobile/src/domain/valueObjects/rep_count.dart';

class ExerciseInProgressState {
  final LegChoice legChoice;
  final BLEDeviceAddress deviceAddress;
  final DateTime startTime;
  final RepCount reps;

  // 🟢 The new attribute: True if the hardware policy (4s hold) is satisfied
  final bool isRepStaged;

  ExerciseInProgressState._({
    required this.legChoice,
    required this.deviceAddress,
    required this.startTime,
    required this.reps,
    this.isRepStaged = false, // Default to false
  });

  /// 2. AUTHORIZED FACTORY: Initial birth of the session.
  static ExerciseStartedProof create(
    LegChoice leg,
    BLEDeviceAddress device,
    TrackingStateCertificate cert,
  ) {
    final state = ExerciseInProgressState._(
      legChoice: leg,
      deviceAddress: device,
      startTime: DateTime.now(),
      reps: RepCount(0),
    );
    return ExerciseStartedProof(state);
  }

  // --- TRANSITIONS (The Logic Gate) ---

  /// STAGE: The hardware policy emits a RepConfirmedProof.
  /// We flip the flag to TRUE but do NOT increment the count yet.
  ExerciseStartedProof stageRep(RepConfirmedProof proof) {
    final stagedState = ExerciseInProgressState._(
      legChoice: legChoice,
      deviceAddress: deviceAddress,
      startTime: startTime,
      reps: reps,
      isRepStaged: true, // 🟢 Set staging to true
    );
    return ExerciseStartedProof(stagedState);
  }

  ExerciseStartedProof redoRep() {
    // We only perform the reset if a rep is actually staged.
    // If not staged, we return the current state unchanged.
    if (!isRepStaged) {
      return ExerciseStartedProof(this);
    }

    final resetState = ExerciseInProgressState._(
      legChoice: legChoice,
      deviceAddress: deviceAddress,
      startTime: startTime,
      reps: reps, // 🟢 Rep count stays exactly the same
      isRepStaged: false, // 🟢 Flag is reset to false
    );

    return ExerciseStartedProof(resetState);
  }

  /// COMMIT: The user (or logic) triggers the increment.
  /// This only succeeds if isRepStaged is true.
  ExerciseStartedProof incrementRep() {
    // 🛡️ Logic Guard: If no rep is staged, return 'this' unchanged (or throw)
    if (!isRepStaged) {
      return ExerciseStartedProof(this);
    }

    final nextState = ExerciseInProgressState._(
      legChoice: legChoice,
      deviceAddress: deviceAddress,
      startTime: startTime,
      reps: reps.increment(), // 🟢 Increment the actual ValueObject
      isRepStaged: false, // 🟢 Reset staging to false for the next rep
    );
    return ExerciseStartedProof(nextState);
  }

  /// Optional: Invalidate the staging if the user breaks form
  ExerciseStartedProof invalidateStaging() {
    final resetState = ExerciseInProgressState._(
      legChoice: legChoice,
      deviceAddress: deviceAddress,
      startTime: startTime,
      reps: reps,
      isRepStaged: false,
    );
    return ExerciseStartedProof(resetState);
  }

  // --- PERSISTENCE & OTHER ---

  static ExerciseInProgressState fromPersistence(
    LegChoice leg,
    BLEDeviceAddress device,
    DateTime start,
    RepCount count,
    bool staged, // Added to persistence
    TrackingStateCertificate cert,
  ) {
    return ExerciseInProgressState._(
      legChoice: leg,
      deviceAddress: device,
      startTime: start,
      reps: count,
      isRepStaged: staged,
    );
  }

  FeedbackStartedProof transitionToFeedback() {
    final cert = PartialFeedbackStateCertificateManager.issueForSessionEnd(
      this,
    );
    return PartialFeedbackState.create(this, cert);
  }

  TrackingAbortedProof abort() {
    return TrackingAbortedProof(this);
  }
}

/// The 'Token' required to instantiate an Active Exercise.
final class TrackingStateCertificate {
  TrackingStateCertificate._();
}

/// The AUTHORIZED 'Token Issuer' for Tracking.
abstract class TrackingCertificateManager {
  /// Allows the Setup domain (FullInitialSelectionState) to promote to Tracking.
  static TrackingStateCertificate issueForPromotion(
    FullInitialSelectionState state,
  ) => TrackingStateCertificate._();

  /// Allows the Persistence layer to rehydrate an active session from disk.
  static TrackingStateCertificate issueForHydration(
    ITrackingPersistencePolicy persistence,
  ) => TrackingStateCertificate._();

  static TrackingStateCertificate issueForHydrationToFeedback(
    IFeedbackPersistencePolicy persistence,
  ) => TrackingStateCertificate._();
}
