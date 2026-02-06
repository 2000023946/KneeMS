import '../proofs/rep_confirmed_proof.dart';

abstract class IBLERepTrackingPolicy {
  /// Watches the hardware and emits a RepConfirmedProof once the 4s hold is met.
  /// It requires the Hydration Proof to ensure it's tracking for a valid, existing session.
  Stream<RepConfirmedProof> trackReps();
}
