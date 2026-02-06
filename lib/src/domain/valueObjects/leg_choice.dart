class LegChoice {
  final String value;

  LegChoice(String input) : value = _normalize(input);

  static String _normalize(String input) {
    // 1. Clean the input
    final normalized = input.trim().toLowerCase();

    // 2. Map variations to the strict Domain Value
    if (normalized == 'left' || normalized == 'l') return 'Left';
    if (normalized == 'right' || normalized == 'r') return 'Right';

    // 3. Fail fast if the primitive doesn't match the domain rules
    throw ArgumentError(
      'Invalid LegChoice: "$input". Expected "Left", "Right", "L", or "R".',
    );
  }

  /// Convenience factory for parsing strings from the SetupTable
  factory LegChoice.parse(String input) => LegChoice(input);

  @override
  String toString() => value;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is LegChoice && other.value == value);

  @override
  int get hashCode => value.hashCode;
}
