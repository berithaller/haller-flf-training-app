///
/// This unit test suite tests the [Traning] model..
///
/// See
/// https://pub.dev/packages/test

import 'package:test/test.dart';
import 'package:flftrainingapp/models.dart';
import 'package:collection/collection.dart';

void main() {
//
// Set up testing utilities
//
  Function deepOrderedEquals = const DeepCollectionEquality().equals;

  ///
  /// Test the Training model
  ///
  group('Training Model', () {
    ///
    /// Test that training does not contain initial events
    ///
    test('Training has no initial events', () {
      // 1 - given
      final Profile refProfile = Profile.createNew('Test Profile');
      final TrainingLevelDefinition refTrainingLevelDefinition =
          new TrainingLevelDefinition();

      // 2 - when
      final Training testTraining =
          new Training(refProfile, refTrainingLevelDefinition);

      // 3 - then
      expect(testTraining.events, []);
      expect(testTraining.events.isEmpty, true);
      expect(testTraining.profile, refProfile);
      expect(testTraining.trainingLevelDefinition, refTrainingLevelDefinition);
    });

    ///
    ///  Test setting a new list of events
    ///
    test('Setting new events', () {
      // 1 - given
      final Profile refProfile = Profile.createNew('Test Profile');
      final TrainingLevelDefinition refTrainingLevelDefinition =
          new TrainingLevelDefinition();

      final TrainingEvent refEvent1 =
          TrainingEvent.intermediate(null, ETrainingEventType.EXECUTION_UPDATE);
      final TrainingEvent refEvent2 =
          TrainingEvent.intermediate(null, ETrainingEventType.EXECUTION_UPDATE);

      // 2 - when
      final List<TrainingEvent> refEvents = new List();
      refEvents.add(refEvent1);
      refEvents.add(refEvent2);

      final Training testTraining =
          new Training(refProfile, refTrainingLevelDefinition);
      final List<TrainingEvent> testInitialEvents = testTraining.events;
      testTraining.events = refEvents;
      final List<TrainingEvent> testNewEvents = testTraining.events;

      // 3 - then
      // Expectation:
      // - initial list of events is empty
      // - new list of events is not empty and matches the new list
      expect(testInitialEvents.isEmpty, true);
      expect(testNewEvents.isEmpty, false);
      expect(testNewEvents, refEvents);
    });
  });

  ///
  /// Test the TrainingEvent model
  ///
  group('TrainingEvent Model', () {
    ///
    /// Test chronological sorting of Training Events: null element
    ///
    test('TrainingEvent sorting with null element', () {
      // 1 - given
      final Training refTraining = null;
      final TrainingEvent refEvent1 = new TrainingEvent(refTraining,
          ETrainingEventType.EXECUTION_UPDATE, 10, 20, 30, "event 1");

      // 2 - when
      int rc = refEvent1.compareTo(null);

      // 3 - then
      expect(rc, 1);
    });

    ///
    /// Test chronological sorting of Training Events: by timestamp
    ///
    test('TrainingEvent sorting with null element', () {
      // 1 - given
      final Training refTraining = null;
      final TrainingEvent refEvent1a = new TrainingEvent(refTraining,
          ETrainingEventType.EXECUTION_UPDATE, 10, 20, 30, "event 1a");
      final TrainingEvent refEvent1b = new TrainingEvent(
          refTraining,
          ETrainingEventType.EXECUTION_UPDATE,
          10,
          20,
          30,
          "event 1b (same time, same order)");
      final TrainingEvent refEvent1c = new TrainingEvent(
          refTraining,
          ETrainingEventType.EXECUTION_UPDATE,
          11,
          20,
          30,
          "event 1c (same time, different order)");
      final TrainingEvent refEvent2 = new TrainingEvent(refTraining,
          ETrainingEventType.EXECUTION_UPDATE, 10, 21, 30, "event 2 (later)");
      final TrainingEvent refEvent3 = new TrainingEvent(refTraining,
          ETrainingEventType.EXECUTION_UPDATE, 10, 19, 30, "event 3 (earlier)");

      // ramdomized list of events and expected list of events after sorting
      final List<TrainingEvent> testEvents = <TrainingEvent>[
        refEvent3,
        refEvent1a,
        refEvent2,
        refEvent1c,
        refEvent1b
      ];
      final List<TrainingEvent> refEventsSorted = <TrainingEvent>[
        refEvent3,
        refEvent1a,
        refEvent1b,
        refEvent1c,
        refEvent2
      ];

      // 2 - when / then
      int rc;

      // events take place at the same time, and have the same order
      rc = refEvent1a.compareTo(refEvent1b);
      expect(rc, 0);

      // events take place at the same time, and have the different order
      rc = refEvent1a.compareTo(refEvent1c);
      expect(rc, -1);

      // events take place at the different times
      rc = refEvent1a.compareTo(refEvent2);
      expect(rc, -1);

      // events take place at the different times
      rc = refEvent1a.compareTo(refEvent3);
      expect(rc, 1);

      // sort the list
      testEvents.sort();

// debug: print("refList:" + refEventsSorted.toString() );
// debug: print("testList:" + testEvents.toString() );

      expect(deepOrderedEquals(refEventsSorted, testEvents), true);
    });
  });
}
