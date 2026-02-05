class BLEDeviceAddress {
  final String address;

  BLEDeviceAddress(this.address) {
    if (address.trim().isEmpty) {
      throw ArgumentError('BLE Device Address cannot be empty.');
    }
  }

  // Normalized getter for comparison
  String get normalized => address.toLowerCase().trim();

  @override
  String toString() => address;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BLEDeviceAddress && other.normalized == normalized);

  @override
  int get hashCode => normalized.hashCode;
}
