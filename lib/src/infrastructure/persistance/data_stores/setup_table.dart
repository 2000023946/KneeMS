class SessionDataStore {
  static final SessionDataStore _instance = SessionDataStore._internal();
  final Map<String, dynamic> _table = {};

  SessionDataStore._internal();
  factory SessionDataStore() => _instance;

  // --- 🏗️ SETUP SECTION ---

  void putLegChoice(String legValue) {
    _table['setup_leg'] = legValue;
  }

  void putDeviceAddress(String address) {
    _table['setup_device'] = address;
  }

  String? getSetupLeg() => _table['setup_leg'] as String?;
  String? getSetupDevice() => _table['setup_device'] as String?;

  // --- 🏃‍♂️ TRACKING SECTION ---

  void updateRepCount(int newCount) {
    _table['active_rep_count'] = newCount;
  }

  int? getActiveRepCount() => _table['active_rep_count'] as int?;

  /// Stores the validated star rating (1-5)
  void putFeedbackStars(int stars) {
    _table['feedback_stars'] = stars;
  }

  /// Stores the optional user comments
  void putFeedbackComments(String comments) {
    _table['feedback_comments'] = comments;
  }

  void putIsRepStaged(bool isStaged) {
    _table['is_rep_staged'] = isStaged;
  }

  bool hasActiveBleAddress() {
    final address = getSetupDevice();
    return address != null && address.isNotEmpty;
  }

  bool getIsRepStaged() => _table['is_rep_staged'] as bool? ?? false;
  int? getFeedbackStars() => _table['feedback_stars'] as int?;
  String? getFeedbackComments() => _table['feedback_comments'] as String?;

  // --- 🧹 MAINTENANCE UPDATES ---

  /// Clears setup keys specifically
  void clearSetup() {
    _table.remove('setup_leg');
    _table.remove('setup_device');
  }

  /// Clears active tracking keys specifically
  void clearTracking() {
    _table.remove('active_rep_count');
    _table.remove('is_rep_staged'); // 🧹 Keep it clean!
  }

  /// NEW: Clears feedback specific keys
  void clearFeedback() {
    _table.remove('feedback_stars');
    _table.remove('feedback_comments');
  }

  /// Wipe everything (App Reset)
  void wipeAll() => _table.clear();
}
