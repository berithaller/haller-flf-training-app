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
        description: "8 Einheiten, 60s Arbeit, 30s Pause",
        nrOfWorkSets: 8,
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
        description: "10 Einheiten, 60s Arbeit, 30s Pause",
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
        name: "Beginner-3",
        description: "12 Einheiten, 60s Arbeit, 30s Pause",
        nrOfWorkSets: 12,
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
        description: "12 Einheiten, 90s Arbeit, 30s Pause",
        nrOfWorkSets: 12,
        timeToRampUp: 5000,
        durationOfWorkSet: 90000,
        durationOfPause: 30000,
        announceWorkSet: 5000,
        announcePause: 5000,
        announceEndOfTraining: 5000,
        nrOfAnnouncements: 5,
        durationOfAnnouncement: 1000));

    _trainingLevelDefinitions.add(new TrainingLevelDefinition(
        name: "Intermediate-2",
        description: "14 Einheiten, 60s Arbeit, 30s Pause",
        nrOfWorkSets: 14,
        timeToRampUp: 5000,
        durationOfWorkSet: 60000,
        durationOfPause: 30000,
        announceWorkSet: 5000,
        announcePause: 5000,
        announceEndOfTraining: 5000,
        nrOfAnnouncements: 5,
        durationOfAnnouncement: 1000));

    _trainingLevelDefinitions.add(new TrainingLevelDefinition(
        name: "Intermediate-3",
        description: "14 Einheiten, 90s Arbeit, 30s Pause",
        nrOfWorkSets: 14,
        timeToRampUp: 5000,
        durationOfWorkSet: 90000,
        durationOfPause: 30000,
        announceWorkSet: 5000,
        announcePause: 5000,
        announceEndOfTraining: 5000,
        nrOfAnnouncements: 5,
        durationOfAnnouncement: 1000));

    _trainingLevelDefinitions.add(new TrainingLevelDefinition(
        name: "Advanced-1",
        description: "16 Einheiten, 60s Arbeit, 30s Pause",
        nrOfWorkSets: 16,
        timeToRampUp: 5000,
        durationOfWorkSet: 60000,
        durationOfPause: 30000,
        announceWorkSet: 5000,
        announcePause: 5000,
        announceEndOfTraining: 5000,
        nrOfAnnouncements: 5,
        durationOfAnnouncement: 1000));

    _trainingLevelDefinitions.add(new TrainingLevelDefinition(
        name: "Advanced-2",
        description: "16 Einheiten, 90s Arbeit, 30s Pause",
        nrOfWorkSets: 16,
        timeToRampUp: 5000,
        durationOfWorkSet: 90000,
        durationOfPause: 30000,
        announceWorkSet: 5000,
        announcePause: 5000,
        announceEndOfTraining: 5000,
        nrOfAnnouncements: 5,
        durationOfAnnouncement: 1000));

    _trainingLevelDefinitions.add(new TrainingLevelDefinition(
        name: "Test",
        description: "nicht ernst gemeint, Funktionstest",
        nrOfWorkSets: 3,
        timeToRampUp: 5000,
        durationOfWorkSet: 40000,
        durationOfPause: 30000,
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
