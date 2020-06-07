///
/// Data Model: a (currently active) training execution
///

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

  /// The StopWatch tracks the time into the Training.
  /// - it is stoppable and restartable
  /// - it starts with base 0 when the Training Execution is started
  final Stopwatch _stopWatch = new Stopwatch();

  ///
  /// Return the milliseconds elapsed since start of the training execution
  ///
  int get timeIntoTraining => _stopWatch.elapsedMilliseconds;

  ///
  /// Start the training execution
  ///
  void start() {
    assert(_state == EState.INITIAL);

    // TODO not yet implemented
    _state = EState.RUNNING;

    // Create our own little cursor and a private copy of the Training's event
    // list. And restart the StopWatch.
    _currentPosition = 0;
    _stopWatch.reset();
    _stopWatch.start();
  }

  ///
  /// Temporarily pause the training execution
  ///
  void pause() {
    assert(_state == EState.RUNNING);

    // TODO not yet implemented
    _state = EState.PAUSED;
    _stopWatch.stop();
  }

  ///
  /// Resume a paused the training execution
  ///
  void resume() {
    assert(_state == EState.PAUSED);

    // TODO not yet implemented
    _state = EState.RUNNING;
    _stopWatch.start();
  }

  ///
  /// Abort the training execution
  ///
  void abort() {
    assert(_state == EState.RUNNING || _state == EState.PAUSED);

    // TODO not yet implemented
    _state = EState.ABORTED;
    _stopWatch.stop();
  }

  ///
  /// Complete the running training execution
  ///
  void complete() {
    assert(_state == EState.RUNNING);

    // TODO not yet implemented
    _state = EState.COMPLETED;
    _stopWatch.stop();
  }

  /// return the next training event and advance the cursor
  TrainingEvent _nextEvent() {
    if (_currentPosition >= _training.events.length)
      return null;
    else
      return _training.events[_currentPosition++];
  }

  /// return the next training event without advancing the cursor
  TrainingEvent _peekEvent() {
    if (_currentPosition >= _training.events.length)
      return null;
    else
      return _training.events[_currentPosition];
  }

  ///
  /// Pump events from the Training until the current
  /// elapsed time within the TrainingExecution is reached.
  /// And push these events to the event stream,
  /// so listeners can react to them.
  ///
  void _pumpEvents() async {
    final int tsNow = _stopWatch.elapsedMilliseconds;

    do {
      final TrainingEvent event = _peekEvent();

      // if we still have events left in the Training to process,
      // check if the event is already due to be processed
      if (event != null && event.timestamp <= tsNow) {
        // push the event onto the stream
        // TODO await stream push

        // consume the event
        _nextEvent();
      } else {
        // no more events to pump, leave the loop.
        return;
      }
    } while (true);
  }

// TODO create an Event Provider or Stream to listen to asynchronously
// TODO allow querying overall execution percentage
// TODO allow query current event execution percentage

}
