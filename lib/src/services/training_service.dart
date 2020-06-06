///
/// Service managing trainings:
/// - managing statically defined Training Level Definitions
///
import 'package:flftrainingapp/models.dart';
import 'training_builder.dart';

class TrainingService {
  /// in-memory copy of all known TrainingLevelDefinitions
  final List<TrainingLevelDefinition> _trainingLevelDefinitions =
      new List<TrainingLevelDefinition>();

  /// Constructor
  TrainingService() {
    _initializeTrainingLevelDefinitions();
  }

  ///
  /// Initialize the list of [TrainingLevelDefinition]s.
  ///
  void _initializeTrainingLevelDefinitions() {
    _trainingLevelDefinitions.add(new TrainingLevelDefinition(
        name: "Beginner-1",
        description: "Beginner''s Training: slow and easy",
        nrOfWorkSets: 4,
        timeToRampUp: 5000,
        durationOfWorkSet: 60000,
        durationOfPause: 30000,
        announceWorkSet: 5000,
        announcePause: 5000,
        announceEndOfTraining: 5000,
        nrOfAnnouncements: 5,
        durationOfAnnouncement: 1000));

    _trainingLevelDefinitions.add(new TrainingLevelDefinition(
        name: "Beginner-2",
        description: "Beginner''s Training: slow and easy, but more sets",
        nrOfWorkSets: 10,
        timeToRampUp: 5000,
        durationOfWorkSet: 60000,
        durationOfPause: 30000,
        announceWorkSet: 5000,
        announcePause: 5000,
        announceEndOfTraining: 5000,
        nrOfAnnouncements: 5,
        durationOfAnnouncement: 1000));

    _trainingLevelDefinitions.add(new TrainingLevelDefinition(
        name: "Intermediate-1",
        description: "Intermediate''s Training: moderate pace",
        nrOfWorkSets: 10,
        timeToRampUp: 5000,
        durationOfWorkSet: 90000,
        durationOfPause: 20000,
        announceWorkSet: 5000,
        announcePause: 5000,
        announceEndOfTraining: 5000,
        nrOfAnnouncements: 5,
        durationOfAnnouncement: 1000));

    _trainingLevelDefinitions.add(new TrainingLevelDefinition(
        name: "Intermediate-2",
        description: "Intermediate''s Training: moderate pace, but more sets",
        nrOfWorkSets: 15,
        timeToRampUp: 5000,
        durationOfWorkSet: 90000,
        durationOfPause: 20000,
        announceWorkSet: 5000,
        announcePause: 5000,
        announceEndOfTraining: 5000,
        nrOfAnnouncements: 5,
        durationOfAnnouncement: 1000));
  }

  ///
  /// Get all TrainingLevelDefinitions
  ///
  List<TrainingLevelDefinition> get trainingLevelDefinitions =>
      List.unmodifiable(_trainingLevelDefinitions);

  ///
  /// Get a builder to create a Training
  ///
  TrainingBuilder builder() {
    return new TrainingBuilder();
  }

  ///
  /// Start the execution of a Training
  ///
  TrainingExecution execute(Training training) {
    TrainingExecution result = new TrainingExecution(training);
    return result;
  }
}
