import 'package:mobile/src/domain/valueObjects/ble_device_address.dart';
import 'package:mobile/src/domain/valueObjects/leg_choice.dart';

abstract class DomainProof {
  final DateTime timestamp;

  DomainProof() : timestamp = DateTime.now();
}

abstract class BLEPersistenceProof {
  BLEDeviceAddress get address;
}

abstract class LegPersistenceProof extends DomainProof {
  LegChoice get leg;
}

abstract class ILegUpdateable {
  LegPersistenceProof updateLeg(LegChoice choice);
}

/// Interface for any state that can accept a BLE Connection.
abstract class IBLEUpdateable {
  BLEPersistenceProof updateBLE(BLEDeviceAddress address);
}
