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

  // 1. PRIVATE CONSTRUCTOR: Forbidden for general use.
  ExerciseInProgressState._({
    required this.legChoice,
    required this.deviceAddress,
    required this.startTime,
    required this.reps,
  });

  /// 2. AUTHORIZED FACTORY: The only way to 'Birth' the session.
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

  /// 3. AUTHORIZED REHYDRATION: For the Persistence Adapter.
  static ExerciseInProgressState fromPersistence(
    LegChoice leg,
    BLEDeviceAddress device,
    DateTime start,
    RepCount count,
    TrackingStateCertificate cert,
  ) {
    return ExerciseInProgressState._(
      legChoice: leg,
      deviceAddress: device,
      startTime: start,
      reps: count,
    );
  }

  FeedbackStartedProof transitionToFeedback() {
    // We pass 'this' (the current session) into the PartialFeedbackState
    // to preserve the lineage of the workout data.
    final cert = PartialFeedbackStateCertificateManager.issueForSessionEnd(
      this,
    );
    return PartialFeedbackState.create(this, cert);
  }

  // --- TRANSITIONS ---

  /// Evolution: Increment the rep count.
  /// Internal calls use the private constructor to maintain the chain.
  ExerciseStartedProof incrementRep(RepConfirmedProof proof) {
    final nextState = ExerciseInProgressState._(
      legChoice: legChoice,
      deviceAddress: deviceAddress,
      startTime: startTime,
      reps: reps.increment(),
    );
    return ExerciseStartedProof(nextState);
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
