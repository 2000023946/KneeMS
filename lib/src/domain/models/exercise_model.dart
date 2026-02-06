import 'package:mobile/src/domain/feedback/states/feedback_state.dart';
import 'package:mobile/src/domain/models/history_persistence_proofs.dart';
import 'package:mobile/src/domain/valueObjects/ble_device_address.dart';
import 'package:mobile/src/domain/valueObjects/leg_choice.dart';
import 'package:mobile/src/domain/valueObjects/rep_count.dart';
import 'package:mobile/src/domain/valueObjects/start_rating.dart';

class ExerciseModel {
  final LegChoice legChoice;
  final BLEDeviceAddress deviceAddress;
  final RepCount totalReps;
  final DateTime startTime;
  final DateTime endTime;
  final StarRating rating;
  final String? comments;

  ExerciseModel._({
    required this.legChoice,
    required this.deviceAddress,
    required this.totalReps,
    required this.startTime,
    required this.endTime,
    required this.rating,
    this.comments,
  });

  /// The Witnessed Factory: Binds the creation to an authorized certificate.
  static ExerciseModelCreatedProof create(
    FullFeedbackState feedbackState,
    ExerciseModelCertificate cert,
  ) {
    final model = ExerciseModel._(
      legChoice: feedbackState.sessionData.legChoice,
      deviceAddress: feedbackState.sessionData.deviceAddress,
      totalReps: feedbackState.sessionData.reps,
      startTime: feedbackState.sessionData.startTime,
      endTime: DateTime.now(), // Marking the exact moment of archival
      rating: feedbackState.rating,
      comments: feedbackState.comments,
    );

    return ExerciseModelCreatedProof(model);
  }

  static ExerciseModel fromPersistence({
    required LegChoice leg,
    required BLEDeviceAddress device,
    required RepCount reps,
    required DateTime start,
    required DateTime end,
    required StarRating rating,
    required String? comments,
    required ExerciseModelCertificate cert, // Certificate required
  }) {
    return ExerciseModel._(
      legChoice: leg,
      deviceAddress: device,
      totalReps: reps,
      startTime: start,
      endTime: end,
      rating: rating,
      comments: comments,
    );
  }

  int get currentReps => totalReps.value;
  Duration get totalDuration => endTime.difference(startTime);
}

final class ExerciseModelCertificate {
  ExerciseModelCertificate._();
}

/// The AUTHORIZED 'Token Issuer' for long-term storage models.
abstract class ExerciseModelCertificateManager {
  /// Allows the terminal transition from a FullFeedbackState to the Model.
  static ExerciseModelCertificate issueForArchival(FullFeedbackState state) =>
      ExerciseModelCertificate._();

  /// Allows the Infrastructure layer to rehydrate history from a database.
  static ExerciseModelCertificate issueForHistoryFetch() =>
      ExerciseModelCertificate._();
}
