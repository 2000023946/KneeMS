class LegChoice {
  final String value;

  LegChoice(String input) : value = _normalize(input);

  static String _normalize(String input) {
    // 1. Perform lowercase comparison for validation
    final normalized = input.trim().toLowerCase();

    if (normalized == 'left') return 'Left';
    if (normalized == 'right') return 'Right';

    // 2. Fail fast if the primitive doesn't match the domain rules
    throw ArgumentError(
      'Invalid LegChoice: $input. Must be "Left" or "Right".',
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
