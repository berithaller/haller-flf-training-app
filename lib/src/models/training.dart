///
/// Data Model: a (currently active) training
///

import 'training_level_definition.dart';
import 'profile.dart';

class Training {
  /// The trained horse
  final Profile _profile;

  /// The TrainingLevelDefinition used to create the training
  final TrainingLevelDefinition _trainingLevelDefinition;

  /// chronologically ordered list of training events
  final List<TrainingEvent> _events = new List();

  /// return a read-only property of the trained horse
  Profile get profile => _profile;

  /// return a read-only property of the training level definition
  TrainingLevelDefinition get trainingLevelDefinition =>
      _trainingLevelDefinition;

  /// Initializing constructor
  Training(this._profile, this._trainingLevelDefinition);

  /// Returns the overall list of events
  List<TrainingEvent> get events => List.unmodifiable(_events);

  /// Set the list of events
  set events(newEvents) {
    this._events.clear();
    this._events.addAll(newEvents);
  }
}

enum ETrainingEventType {
  TRAINING_INIT,
  TRAINING_RAMPUP,
  ANNOUNCEMENT,
  WORKSET_START,
  WORKSET_END,
  PAUSE_START,
  PAUSE_END,
  TRAINING_END,

  /// execution control event: execution has started
  EXECUTION_START,

  /// execution control event: execution has paused
  EXECUTION_PAUSE,

  /// execution control event: execution has resumed
  EXECUTION_RESUME,

  /// execution control event: execution has aborted
  EXECUTION_ABORT,

  /// execution control event: execution has completed
  EXECUTION_COMPLETE,

  /// execution control event: timer update tick
  EXECUTION_UPDATE
}

class TrainingEvent implements Comparable<TrainingEvent> {
  /// The parent training
  final Training training;

  /// the type of training event
  final ETrainingEventType eventType;

  /// The order of the event at its creation.
  /// If two events take place at exactly the same time,
  /// the event with the lower order number is fired first;
  final int order;

  /// point-in-time relative to the training start when the event is occurring.
  final int timestamp;

  /// duration of the event in milliseconds
  final int duration;

  /// (internal) description of the event
  final String description;

  /// Initializing constructor
  TrainingEvent(
      this.training, this.eventType, this.order, this.timestamp, this.duration,
      [this.description = ""]);

  ///
  /// Factory constructor to create intermediate events
  ///
  static TrainingEvent intermediate(
      Training training, ETrainingEventType eventType,
      [String description = ""]) {
    // TODO can we get away with timestamp == duration == -1?
    final TrainingEvent event =
        new TrainingEvent(training, eventType, -1, -1, 0, description);
    return event;
  }

  /// compare two [TrainingEvent], their natural sort order is chronologically ascending
  @override
  int compareTo(TrainingEvent other) {
    int result;
    if (other == null)
      result = 1;
    else {
      result = (this.timestamp - other.timestamp);

      // equal timestamps
      if (result == 0) {
        result = (this.order - other.order);
      }
    }
    return result;
  }

  ///
  /// Return descriptive string for the current object
  ///
  @override
  String toString() {
    String result =
        "TrainingEvent[$eventType: timestamp=$timestamp, order=$order] : $description";
    return result;
  }
}
