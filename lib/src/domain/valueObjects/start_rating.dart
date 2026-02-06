class StarRating {
  final int value;

  StarRating(this.value) {
    if (value < 1 || value > 5) {
      throw ArgumentError('Rating must be between 1 and 5');
    }
  }

  @override
  String toString() => '$value Stars';
}
