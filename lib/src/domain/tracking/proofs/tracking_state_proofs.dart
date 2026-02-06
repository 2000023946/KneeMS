import 'package:mobile/src/domain/setup/proofs/domain_proofs.dart';
import 'package:mobile/src/domain/tracking/states/exercise_state.dart';

class TrackingAbortedProof extends DomainProof {
  /// We hold the 'Final Moments' of the state for the audit trail.
  final ExerciseInProgressState abortedState;

  TrackingAbortedProof(this.abortedState);
}

class ExerciseStartedProof extends DomainProof {
  /// The live state created during the transition.
  final ExerciseInProgressState state;

  /// The official start time (usually matches the state's startTime).
  final DateTime startTime;

  ExerciseStartedProof(this.state) : startTime = state.startTime, super();
}
