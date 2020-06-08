///
/// A builder for active trainings
///
/// It constructs a sequence of chronological events, that
/// happen during execution of a training, from a
/// [TrainingLevelDefinition].
///

import 'package:flftrainingapp/models.dart';

class TrainingBuilder {
  /// the horse to train with
  Profile _profile;

  /// the training level definition to use
  TrainingLevelDefinition _trainingLevelDefinition;

  /// builder pattern: set the horse to train
  TrainingBuilder withProfile(Profile profile) {
    this._profile = profile;
    return this;
  }

  /// builder pattern: set the training level definition
  TrainingBuilder withTrainingLevelDefinition(
      TrainingLevelDefinition trainingLevelDefinition) {
    this._trainingLevelDefinition = trainingLevelDefinition;
    return this;
  }

  /// builder pattern: build the training
  ///
  /// How does this work:
  /// based on the number of work-sets, various durations and lead times,
  /// this method calculates the individual events and when exactly they
  /// take place.
  /// Then all the events are sorted chronologically, so that a simple
  /// timer-based replay can be used to call back the user interface
  /// and business logic. As a reaction to each event, the 'current training'
  /// display can be updated and either sound or voice can be replayed
  /// at the right time.
  /// This decouples any state management from the [Training] itself.
  /// The called-back code can do this as needed.
  ///
  /// This makes it also quite simple to set up and verify the choreography
  /// of a training.
  ///
  /// During execution, this also should allow for easy pause / resumed
  /// operations.
  Training build() {
    final List<TrainingEvent> events = List();
    final Training training =
        new Training(this._profile, this._trainingLevelDefinition);

    // time relative to the training start
    int time = 0;
    int order = 0;

    // 1 - generate all events
    // 1.1 - training initialization
    {
      TrainingEvent e = new TrainingEvent(
          training, ETrainingEventType.TRAINING_INIT, order++, 0, 0);
      events.add(e);
    }

    // 1.2 - training ramp-up
    {
      TrainingEvent e = new TrainingEvent(
          training,
          ETrainingEventType.TRAINING_RAMPUP,
          order++,
          0,
          _trainingLevelDefinition.timeToRampUp);
      events.add(e);
      time += e.duration;
    }

    // 2 - work-sets
    for (int iWorkSet = 0;
        iWorkSet < _trainingLevelDefinition.nrOfWorkSets;
        iWorkSet++) {
      // 2.1 - announcements to the next work-set
      {
        int timeAnnouncement = time -
            (_trainingLevelDefinition.nrOfAnnouncements *
                _trainingLevelDefinition.durationOfAnnouncement);
        for (int iAnnouncement = 0;
            iAnnouncement < _trainingLevelDefinition.nrOfAnnouncements;
            iAnnouncement++) {
          TrainingEvent e = new TrainingEvent(
              training,
              ETrainingEventType.ANNOUNCEMENT,
              order++,
              timeAnnouncement,
              _trainingLevelDefinition.durationOfAnnouncement,
              "Announcement $iAnnouncement for Work-Set $iWorkSet");
          events.add(e);
          timeAnnouncement += e.duration;
        }
      }

      // 2.2 - work-set start + end
      {
        TrainingEvent e0 = new TrainingEvent(
            training,
            ETrainingEventType.WORKSET_START,
            order++,
            time,
            _trainingLevelDefinition.durationOfWorkSet,
            "Start of Work-Set $iWorkSet");
        events.add(e0);
        time += e0.duration;

        TrainingEvent e1 = new TrainingEvent(
            training,
            ETrainingEventType.WORKSET_END,
            order++,
            time,
            0,
            "End of Work-Set $iWorkSet");
        events.add(e1);
      }

      final bool needPause =
          (iWorkSet < (_trainingLevelDefinition.nrOfWorkSets - 1));
      if (needPause) {
        // 2.3 - unless last work-set: announcement to the pause
        {
          int timeAnnouncement = time -
              (_trainingLevelDefinition.nrOfAnnouncements *
                  _trainingLevelDefinition.durationOfAnnouncement);
          for (int iAnnouncement = 0;
              iAnnouncement < _trainingLevelDefinition.nrOfAnnouncements;
              iAnnouncement++) {
            TrainingEvent e = new TrainingEvent(
                training,
                ETrainingEventType.ANNOUNCEMENT,
                order++,
                timeAnnouncement,
                _trainingLevelDefinition.durationOfAnnouncement,
                "Announcement $iAnnouncement for Pause after Work-Set $iWorkSet");
            events.add(e);
            timeAnnouncement += e.duration;
          }
        }

        // 2.4 - unless last work-set: pause
        {
          TrainingEvent e0 = new TrainingEvent(
              training,
              ETrainingEventType.PAUSE_START,
              order++,
              time,
              _trainingLevelDefinition.durationOfWorkSet,
              "Start of Pause after Work-Set $iWorkSet");
          events.add(e0);
          time += e0.duration;

          TrainingEvent e1 = new TrainingEvent(
              training,
              ETrainingEventType.PAUSE_END,
              order++,
              time,
              0,
              "End of Pause after Work-Set $iWorkSet");
          events.add(e1);
        }
      }
    }

    // 3.1 - announcement of end-of-training
    {
      int timeAnnouncement = time -
          (_trainingLevelDefinition.nrOfAnnouncements *
              _trainingLevelDefinition.durationOfAnnouncement);
      for (int iAnnouncement = 0;
          iAnnouncement < _trainingLevelDefinition.nrOfAnnouncements;
          iAnnouncement++) {
        TrainingEvent e = new TrainingEvent(
            training,
            ETrainingEventType.ANNOUNCEMENT,
            order++,
            timeAnnouncement,
            _trainingLevelDefinition.durationOfAnnouncement,
            "Announcement $iAnnouncement for End of Training");
        events.add(e);
        timeAnnouncement += e.duration;
      }
    }

    // 3.2 - end-of-training
    {
      TrainingEvent e = new TrainingEvent(
          training,
          ETrainingEventType.TRAINING_END,
          order++,
          time,
          0);
      events.add(e);
      time += e.duration;
    }

    // 8 - sort the events chronologically
    events.sort();

    // 9 - produce result
    training.events = events;
    return training;
  }
}
