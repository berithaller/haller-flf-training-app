///
/// Data Model: a (currently active) training execution
///

import 'dart:async';
import 'training.dart';

enum EState {
  /// initial state before the training is started
  INITIAL,

  /// the training is running
  RUNNING,

  /// the training has been paused
  PAUSED,

  /// the training is aborted
  ABORTED,

  /// the training is completed
  COMPLETED
}

///
/// Execution and execution state of a Training
///
/// States:
/// INITIAL --> RUNNING
/// RUNNING --> PAUSED | ABORTED | COMPLETED
/// PAUSED  --> RUNNING | ABORTED
class TrainingExecution {
  /// the Training being executed
  final Training _training;

  /// the current state of the training execution
  EState _state;

  ///
  /// Initializing constructor
  ///
  TrainingExecution(this._training) : _state = EState.INITIAL;

  /// return the current training execution state
  EState get state => _state;

  /// return the currently executing Training
  Training get training => _training;

  /// position of the current Training Event
  int _currentPosition;

  /// Stream of TrainingEvents for a caller to subscribe to.
  /// This can be used by the user interface to retrieve
  /// asynchronous events from the Training Execution.
  ///
  /// The asynchronous, single listener stream does buffer
  /// unprocessed events until the listener receives them.
  final StreamController<TrainingEvent> _eventStreamController =
      new StreamController<TrainingEvent>();

  /// The StopWatch tracks the time into the Training.
  /// - it is stoppable and restartable
  /// - it starts with base 0 when the Training Execution is started
  final Stopwatch _stopWatch = new Stopwatch();

  /// Time that looks for events to process every
  /// n milliseconds and pumps [TrainingEvent]s into
  /// the event stream.
  Timer _timer;

  ///
  /// Return the milliseconds elapsed since start of the training execution
  ///
  int get timeIntoTraining => _stopWatch.elapsedMilliseconds;

  ///
  /// Start the training execution
  ///
  void start() {
    assert(_state == EState.INITIAL);

    _state = EState.RUNNING;
    _postIntermediateEvent(ETrainingEventType.EXECUTION_START);

    // Create our own little cursor and a private copy of the Training's event
    // list. And restart the StopWatch.
    _currentPosition = 0;
    _stopWatch.reset();

    _timerCreate();
    _stopWatch.start();
  }

  ///
  /// Temporarily pause the training execution
  ///
  void pause() {
    assert(_state == EState.RUNNING);
    _postIntermediateEvent(ETrainingEventType.EXECUTION_PAUSE);

    _state = EState.PAUSED;
    _stopWatch.stop();
  }

  ///
  /// Resume a paused the training execution
  ///
  void resume() {
    assert(_state == EState.PAUSED);
    _postIntermediateEvent(ETrainingEventType.EXECUTION_RESUME);

    _state = EState.RUNNING;
    _stopWatch.start();
  }

  ///
  /// Abort the training execution
  ///
  void abort() {
    assert(_state == EState.RUNNING || _state == EState.PAUSED);

    _state = EState.ABORTED;
    _postIntermediateEvent(ETrainingEventType.EXECUTION_ABORT);
    _stopWatch.stop();

    // stop the timer and close the event stream
    _timerDestroy();
    _eventStreamController.close();
  }

  ///
  /// Complete the running training execution
  ///
  void complete() {
    assert(_state == EState.RUNNING);

    _state = EState.COMPLETED;
    _postIntermediateEvent(ETrainingEventType.EXECUTION_COMPLETE);
    _stopWatch.stop();

    // stop the timer and close the event stream
    _timerDestroy();
    _eventStreamController.close();
  }

  ///
  /// Create a timer that periodically
  /// pumps [TrainingEvent]s into the event stream.
  ///
  void _timerCreate() {
    assert(_timer == null);

    // Create and start the timer that pumps events
    _timer = Timer.periodic(new Duration(milliseconds: 100),
        // anonymous callback function
        (Timer t) {
      _pumpEvents();
    });
  }

  ///
  /// Stop the timer from producing events,
  /// and destroy it.
  ///
  void _timerDestroy() {
    if (_timer != null) {
      _timer.cancel();
      _timer = null;
    }
  }

  ///
  /// return the next training event and advance the cursor
  ///
  TrainingEvent _nextEvent() {
    if (_currentPosition >= _training.events.length)
      return null;
    else
      return _training.events[_currentPosition++];
  }

  ///
  /// return the next training event without advancing the cursor
  ///
  TrainingEvent _peekEvent() {
    if (_currentPosition >= _training.events.length)
      return null;
    else
      return _training.events[_currentPosition];
  }

  ///
  /// Create and post an intermediate event to the event stream.
  ///
  void _postIntermediateEvent(ETrainingEventType eventType) {
    final TrainingEvent event =
        TrainingEvent.intermediate(_training, eventType);

    if( ETrainingEventType.EXECUTION_UPDATE != eventType ) {
      print("Sending event: " + event.toString());
    }

    _eventStreamController.sink.add(event);
  }

  ///
  /// Pump events from the Training until the current
  /// elapsed time within the TrainingExecution is reached.
  /// And push these events to the event stream,
  /// so listeners can react to them.
  ///
  /// The method is called frequently from the timer.
  /// It enables a listeneing client to react to events
  /// of the training and update its state or presentation
  /// frequently even in between [TrainingEvent]s happening.
  /// Therefore, if no [TrainingEvent] is relayed, a
  /// intermediate event is generated with type
  /// ETrainingEventType.EXECUTION_UPDATE.
  ///
  void _pumpEvents() async {
    final int tsNow = _stopWatch.elapsedMilliseconds;
    bool pushedAnEvent = false;

    do {
      final TrainingEvent event = _peekEvent();

      // if we still have events left in the Training to process,
      // check if the event is already due to be processed
      if (event != null && event.timestamp <= tsNow) {
        // push the event onto the stream
        print("Sending event: " + event.toString());
        _eventStreamController.sink.add(event);
        pushedAnEvent = true;

        // consume the event
        _nextEvent();
      } else {
        // no more events to pump, leave the loop.
        break;
      }
    } while (true);

    // Send a ETrainingEventUpdate event to let callers
    // update their state frequently
    // - if no other event was pushed, hence no other reason to update the
    // state exists in the event stream
    // - unless the stream already contains a pending EXECUTION_UPDATE event
    // TODO
    if (!pushedAnEvent) {
      _postIntermediateEvent(ETrainingEventType.EXECUTION_UPDATE);
    }
  }

  ///
  /// Return a stream of [TrainingEvent] a caller can listen to
  ///
  Stream<TrainingEvent> get eventStream => _eventStreamController.stream;

// TODO allow querying overall execution percentage
// TODO allow query current event execution percentage

}
