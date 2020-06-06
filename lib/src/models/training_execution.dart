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

  ///
  /// Start the training execution
  ///
  void start() {
    assert(_state == EState.INITIAL);

    // TODO not yet implemented
    _state = EState.RUNNING;

    // create our own little cursor and a private copy of the Training's event list
    _currentPosition = 0;
  }

  ///
  /// Temporarily pause the training execution
  ///
  void pause() {
    assert(_state == EState.RUNNING);

    // TODO not yet implemented
    _state = EState.PAUSED;
  }

  ///
  /// Resume a paused the training execution
  ///
  void resume() {
    assert(_state == EState.PAUSED);

    // TODO not yet implemented
    _state = EState.RUNNING;
  }

  ///
  /// Abort the training execution
  ///
  void abort() {
    assert(_state == EState.RUNNING || _state == EState.PAUSED);

    // TODO not yet implemented
    _state = EState.ABORTED;
  }

  ///
  /// Complete the running training execution
  ///
  void complete() {
    assert(_state == EState.RUNNING);

    // TODO not yet implemented
    _state = EState.COMPLETED;
  }

  /// return the next training event and advance the cursor
  TrainingEvent _nextEvent() {
    if (_currentPosition >= _training.events.length)
      return null;
    else
      return _training.events[_currentPosition++];
  }

// TODO create an Event Provider or Stream to listen to asynchronously
// TODO allow querying overall execution percentage
// TODO allow query current event execution percentage

}
