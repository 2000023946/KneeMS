import 'package:mobile/src/domain/feedback/useCases/finish_feedback_usecase.dart';
import 'package:mobile/src/domain/feedback/useCases/update_comments_use_case.dart';
import 'package:mobile/src/domain/feedback/useCases/update_rating_use_case.dart';
import 'package:mobile/src/domain/models/fetch_history_usecase.dart';
import 'package:mobile/src/domain/setup/useCases/choose_leg_use_case.dart';
import 'package:mobile/src/domain/setup/useCases/connect_bluetooth_use_case.dart';
import 'package:mobile/src/domain/setup/useCases/start_exercise_use_case.dart';
import 'package:mobile/src/domain/tracking/useCases/finish_exercise_use_case.dart';
import 'package:mobile/src/domain/tracking/useCases/redo_rep_usecase.dart';
import 'package:mobile/src/domain/tracking/useCases/register_rep_use_case.dart';
import 'package:mobile/src/domain/tracking/useCases/abort_exercise_use_case.dart';
import 'package:mobile/src/domain/tracking/useCases/rep_stage_usecase.dart';
import 'package:mobile/src/infrastructure/adapters/ble_connection_adapter.dart';
import 'package:mobile/src/infrastructure/adapters/ble_rep_tracking_policy.dart';
import 'package:mobile/src/infrastructure/persistance/data_stores/setup_table.dart';
import 'package:mobile/src/infrastructure/persistance/in_memory_feedback_adapter.dart';
import 'package:mobile/src/infrastructure/persistance/in_memory_history_adapter.dart';
import 'package:mobile/src/infrastructure/persistance/in_memory_setup_adapter.dart';
import 'package:mobile/src/infrastructure/persistance/in_memory_tracking_adapter.dart';

class App {
  // --- SINGLETON SETUP ---
  static final App _instance = App._internal();
  factory App() => _instance;

  // --- 1. PRIVATE Infrastructure & Persistence ---
  // These are now private (_) to enforce use-case-only access.
  final _setupPersistence = InMemorySetupAdapter();
  final _trackingPersistence = InMemoryTrackingAdapter();
  final _feedbackPersistence = InMemoryFeedbackAdapter();
  final _historyPersistence = InMemoryHistoryAdapter();
  final _bleHardware = BLEConnectionAdapter();
  final _repTrackingPolicy = MockBLERepTrackingPolicy();

  // --- 2. PUBLIC Domain Use Cases ---
  // The UI only sees these.
  late final RedoRepUseCase redoRepUseCase;
  late final ConnectBluetoothUseCase connectUseCase;
  late final ChooseLegUseCase chooseLegUseCase;
  late final StartExerciseUseCase startUseCase;
  late final RegisterRepUseCase registerRepUseCase;
  late final PerformRepUseCase performRepUseCase; // Stages the rep (true)
  late final AbortExerciseUseCase abortUseCase;
  late final FinishExerciseUseCase finishExerciseUseCase;
  late final UpdateCommentsUseCase updateCommentsUseCase;
  late final UpdateRatingUseCase updateRatingUseCase;
  late final FinalizeWorkoutUseCase finalizeUseCase;
  late final GetWorkoutHistoryUseCase getHistoryUseCase;

  App._internal() {
    // 1. Setup
    connectUseCase = ConnectBluetoothUseCase(_bleHardware, _setupPersistence);
    chooseLegUseCase = ChooseLegUseCase(_setupPersistence);

    // 2. Tracking (Keep these together)
    startUseCase = StartExerciseUseCase(
      _setupPersistence,
      _bleHardware,
      _trackingPersistence,
    );
    performRepUseCase = PerformRepUseCase(
      _repTrackingPolicy,
      _trackingPersistence,
    );
    registerRepUseCase = RegisterRepUseCase(_trackingPersistence);

    // 🟢 Move this up here so it's initialized with the other tracking logic
    redoRepUseCase = RedoRepUseCase(_trackingPersistence);

    abortUseCase = AbortExerciseUseCase(
      _trackingPersistence,
      _setupPersistence,
    );

    // 3. Feedback & History
    finishExerciseUseCase = FinishExerciseUseCase(
      _trackingPersistence,
      _feedbackPersistence,
    );
    updateCommentsUseCase = UpdateCommentsUseCase(_feedbackPersistence);
    updateRatingUseCase = UpdateRatingUseCase(_feedbackPersistence);
    finalizeUseCase = FinalizeWorkoutUseCase(
      _feedbackPersistence,
      _historyPersistence,
    );
    getHistoryUseCase = GetWorkoutHistoryUseCase(_historyPersistence);
  }

  get isBleConnected => SessionDataStore().hasActiveBleAddress();

  get currentReps => SessionDataStore().getActiveRepCount();

  get currentLeg => SessionDataStore().getSetupLeg();

  get isRepStaged => SessionDataStore().getIsRepStaged();

  get getStars => SessionDataStore().getFeedbackStars();

  get getComments => SessionDataStore().getFeedbackComments();
}
