import 'package:mobile/src/domain/tracking/policies/i_ble_rep_tracking_policy.dart';
import 'package:mobile/src/domain/tracking/proofs/rep_confirmed_proof.dart';

class MockBLERepTrackingPolicy implements IBLERepTrackingPolicy {
  @override
  Stream<RepConfirmedProof> trackReps() async* {
    // Simulate the hardware processing time for a single rep
    await Future.delayed(Duration(milliseconds: 500));
    yield RepConfirmedProof();
  }
}
