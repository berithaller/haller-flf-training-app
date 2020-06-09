import 'package:flftrainingapp/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flftrainingapp/models.dart';

class TrainingPage extends StatefulWidget {
  @override
  _TrainingPageState createState() => _TrainingPageState();
}

class _TrainingPageState extends State<TrainingPage> {
  @override
  String dropdownValue = 'One';

  /// reference to the ProfileService
  final ProfileService _profileService =
      ApplicationContext().get(name: "profileService");

  /// reference to the TrainingService
  final TrainingService _trainingService =
      ApplicationContext().get(name: "trainingService");

  /// the selected TrainingLevelDefinition
  TrainingLevelDefinition _selectedTrainingLevelDefinition;

  /// the currently active training execution (valid after START button has been pressed)
  TrainingExecution _currentTrainingExecution;

  Widget build(BuildContext context) {
    // TODO temporary: show state of currently executing training
    String trainingExecution;
    double progress;
    if (_currentTrainingExecution != null) {
      trainingExecution = "Training: " +
          _millisecondsToDuration(_currentTrainingExecution.timeIntoTraining);

      // Overall progress: we divide the current time into the running training
      // to the total duration as defined in the TrainingLevelDefinition.
      progress = _currentTrainingExecution.timeIntoTraining /
          _currentTrainingExecution
              .training.trainingLevelDefinition.totalDuration;
    } else {
      trainingExecution = "Nothing is executing";
      progress = 0.0;
    }

    return Column(
      children: <Widget>[
        SizedBox(height: 30),
        Container(
          child: Text(
            "Training mit + Pferdename",
            style: TextStyle(fontSize: 20, letterSpacing: 1),
          ),
        ),
        SizedBox(height: 30),
        selectionField(),
        SizedBox(height: 30),
        Container(
          child: Text("Beschreibung zum ausgewählten Level"),
        ),
        SizedBox(height: 30),
        Container(
          child: Text("Laufendes Training:" + trainingExecution),
        ),
        SizedBox(height: 30),
        stopPlayPause(),
        SizedBox(height: 30),
        createLinearProgressBar(progress)
      ],
    );
  }

  ///
  /// User has pressed PAUSE/RESUME button
  ///
  void _onPause() {
    assert(_currentTrainingExecution != null);

    setState(() {
      // toggle between PAUSE and RESUME
      if (_currentTrainingExecution.state == EState.PAUSED)
        _currentTrainingExecution.resume();
      else if (_currentTrainingExecution.state == EState.RUNNING)
        _currentTrainingExecution.pause();
      else
        print("Error: unknown training execution state");
    });
  }

  ///
  /// User has pressed START button
  ///
  void _onStart() {
    assert(_selectedTrainingLevelDefinition != null);
    // TODO assert(_currentTrainingExecution == null);

    setState(() {
      // TODO Berit: need to manage the current app state with all its currently selected "things"
      final Profile _selectedProfile = Profile.createNew("TODO Test");

      // 1 - build the new training
      final TrainingBuilder builder = _trainingService.builder();
      final Training training = builder
          .withProfile(_selectedProfile)
          .withTrainingLevelDefinition(_selectedTrainingLevelDefinition)
          .build();

      // 2 - initialize the training execution
      final TrainingExecution trainingExecution =
          _trainingService.execute(training);
      _currentTrainingExecution = trainingExecution;

      // 3 - start listening to the training execution
      _currentTrainingExecution.eventStream.listen(_onTrainingEvent);

      // 4 - start the training execution
      _currentTrainingExecution.start();
    });
  }

  ///
  /// User has pressed STOP button
  ///
  void _onStop() {
    assert(_currentTrainingExecution != null);

    setState(() {
      _currentTrainingExecution.abort();
    });
  }

  ///
  /// Process an event received from the [TrainingExecution]
  ///
  void _onTrainingEvent(TrainingEvent event) async {
    ETrainingEventType eventType = event.eventType;
    int timestamp = event.timestamp;
    int order = event.order;
    String description = event.description;

    if (eventType != ETrainingEventType.EXECUTION_UPDATE) {
      print("Received event: " + event.toString());
    }

    setState(() {
      // TODO refresh the UI
    });
  }

  RaisedButton _createPlayButton() {
    return RaisedButton(
      child: Icon(Icons.play_arrow, size: 40, color: MyColors.darkcontrastcolor,),
      color: MyColors.buttoncolor,
      onPressed: _onStart,
    );
  }

  RaisedButton _createPauseButton() {
    return RaisedButton(
      child: Icon(Icons.pause, size: 40, color: MyColors.darkcontrastcolor,),
      color: MyColors.buttoncolor,
      onPressed: _onPause,
    );
  }

  RaisedButton _createStopButton() {
    return RaisedButton(
      child: Icon(Icons.stop, size: 40, color: MyColors.darkcontrastcolor,),
      color: MyColors.buttoncolor,
      onPressed: _onStop,
    );
  }

  Widget stopPlayPause() {
    List<Widget> buttons = new List();

    // 1 - if no training has been started, then only the START button makes sense
    if (_currentTrainingExecution == null) {
      buttons.add(_createPlayButton());
    } else {
      switch (_currentTrainingExecution.state) {
        case EState.INITIAL:
          // TODO Berit
          buttons.add(new Text("INITIAL: not started"));
          break;
        case EState.RUNNING:
          buttons.add(_createPauseButton());
          buttons.add(_createStopButton());
          // TODO Berit
          break;
        case EState.PAUSED:
          // TODO Berit
          buttons.add(_createPlayButton());
          buttons.add(_createStopButton());
          break;
        case EState.ABORTED:
          // TODO Berit
          buttons.add(new Text("ABORTED"));
          break;
        case EState.COMPLETED:
          // TODO Berit
          buttons.add(new Text("COMPLETED"));
          break;

        default:
          print("Unhandled training execution state");
          break;
      }
    }

    // 2 - insert some spacers between the buttons
    for (int i = buttons.length - 1; i > 0; i--) {
      buttons.add(new SizedBox(width: 20));
    }

    return Container(
      color: MyColors.lightcontrastcolor,
      padding: EdgeInsets.all(30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: buttons,
      ),
    );
  }

  ///
  /// Convert a given amount of milliseconds to a String in the format of "???m ??s".
  ///
  String _millisecondsToDuration(int milliseconds) {
    final String duration = (milliseconds / 60000).toStringAsFixed(0) +
        "m " +
        ((milliseconds / 1000) % 60).toStringAsFixed(0) +
        "s";
    return duration;
  }

  Widget selectionField() {
    final List<DropdownMenuItem> ddmiLevels =
        _trainingService.trainingLevelDefinitions
            .map((tld) => new DropdownMenuItem(
                  value: tld,
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      new Text(tld.name +
                          " (" +
                          _millisecondsToDuration(tld.totalDuration) +
                          ")"),
                      new Text(tld.description)
                    ],
                  ),
                ))
            .toList();

    return Container(
      color: MyColors.lightcontrastcolor,
      alignment: Alignment.center,
      padding: EdgeInsets.all(10),
      child: DropdownButton<TrainingLevelDefinition>(
        value: _selectedTrainingLevelDefinition,
        icon: Icon(
          Icons.arrow_downward,
          size: 20,
          color: MyColors.buttoncolor,
        ),
        elevation: 16,
        style: TextStyle(color: MyColors.darkcontrastcolor, fontSize: 20),
        underline: Container(
          height: 2,
          color: MyColors.buttoncolor,
        ),
        onChanged: (TrainingLevelDefinition newValue) {
          setState(() {
            _selectedTrainingLevelDefinition = newValue;
          });
        },
        items: ddmiLevels,
      ),
    );
  }

  Widget createLinearProgressBar(double progress) {
    return Container(
      color: MyColors.darkcontrastcolor,
      padding: EdgeInsets.all(20),
      child: LinearProgressIndicator(
        value: progress,
        backgroundColor: MyColors.lightcontrastcolor,
      ),
    );
  }
}
