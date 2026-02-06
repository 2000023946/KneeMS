class RepCount {
  final int value;

  RepCount(this.value) {
    if (value < 0) {
      throw ArgumentError('Rep count cannot be negative.');
    }
    // CE optimization: Prevent overflow or unrealistic sensor spikes
    if (value > 999) {
      throw ArgumentError('Rep count exceeds maximum session limit.');
    }
  }

  // Helper for incrementing
  RepCount increment() => RepCount(value + 1);

  @override
  bool operator ==(Object other) => other is RepCount && other.value == value;

  @override
  int get hashCode => value.hashCode;
}
