import 'package:flutter_tts/flutter_tts.dart';
import 'package:flftrainingapp/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flftrainingapp/models.dart';

class TrainingPage extends StatefulWidget {
  @override
  _TrainingPageState createState() => _TrainingPageState();
}

class _TrainingPageState extends State<TrainingPage> {
  /// Flutter Text-To-Speech engine
  /// https://flutter.de/artikel/text-to-speech.html
  FlutterTts _flutterTts;

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

  ///
  /// Initialize the state
  ///
  @override
  void initState() {
    super.initState();

    // initialize Text-To-Speech
    _flutterTts = new FlutterTts();
    _flutterTts.setLanguage("de-DE");
    _flutterTts.setSpeechRate(1.0);
    _flutterTts.setVolume(1.0);
    _flutterTts.setPitch(1.0);
  }

  ///
  /// Cleanup
  ///
  @override
  void dispose() {
    super.dispose();
    _flutterTts.stop();
  }

  ///
  /// Build the Widget State
  ///
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

    return Scaffold(
      appBar: new AppBar(title: Text("Training mit " "+ Pferdename")),
      body: Column(
        children: <Widget>[
          SizedBox(height: 60),
          selectionField(),
          SizedBox(height: 30),
          Container(
            child: Text(
              "Laufendes Training: " + trainingExecution,
              style: TextStyle(fontSize: 17),
            ),
          ),
          SizedBox(height: 30),
          stopPlayPause(),
          createLinearProgressBar(progress)
        ],
      ),
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

    // debugging
    if (eventType != ETrainingEventType.EXECUTION_UPDATE) {
      print("Received event: " + event.toString());
    }

    // check if the current event has something to say ...
    if (event.textToSpeech != null && event.textToSpeech.isNotEmpty) {
      // stop the engine if it is currently speaking
      await _flutterTts.stop();
      await _flutterTts.speak(event.textToSpeech.toLowerCase());
    }

    setState(() {
      // TODO refresh the UI
    });
  }

  RaisedButton _createPlayButton() {
    return RaisedButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Icon(
        Icons.play_arrow,
        size: 40,
        color: MyColors.darkcontrastcolor,
      ),
      color: MyColors.buttoncolor,
      onPressed: _onStart,
    );
  }

  RaisedButton _createPauseButton() {
    return RaisedButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Icon(
        Icons.pause,
        size: 40,
        color: MyColors.darkcontrastcolor,
      ),
      color: MyColors.buttoncolor,
      onPressed: _onPause,
    );
  }

  RaisedButton _createStopButton() {
    return RaisedButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Icon(
        Icons.stop,
        size: 40,
        color: MyColors.darkcontrastcolor,
      ),
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

    return Container(
      color: MyColors.lightcontrastcolor,
      margin: EdgeInsets.all(15),
      padding: EdgeInsets.all(30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: buttons,
      ),
    );
  }

  ///
  /// Convert a given amount of milliseconds to a String in the format of "???m ??s".
  ///
  String _millisecondsToDuration(int milliseconds) {
    final String duration = (milliseconds / 60000).toStringAsFixed(0) +
        "min " +
        ((milliseconds / 1000) % 60).toStringAsFixed(0) +
        "s";
    return duration;
  }

  Widget selectionField() {
    final Iterable<DropdownMenuItem<TrainingLevelDefinition>> ddmiLevels =
        _trainingService.trainingLevelDefinitions
            .map((tld) => new DropdownMenuItem(
                  value: tld,
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                              child: new Text(
                            tld.name,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: MyColors.buttoncolor),
                          )),
                          Container(
                              margin: EdgeInsets.all(5),
                              child: new Text(
                                _millisecondsToDuration(tld.totalDuration),
                                style: TextStyle(fontSize: 20),
                              )),
                        ],
                      ),
                      new Text(
                        tld.description,
                        style: TextStyle(fontSize: 17),
                      )
                    ],
                  ),
                ))
            .toList();

    return Container(
      color: MyColors.lightcontrastcolor,
      alignment: Alignment.center,
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(15),
      child: DropdownButton<TrainingLevelDefinition>(
        isExpanded: true,
        focusColor: MyColors.backgroundcolor,
        autofocus: true,
        itemHeight: 90,
        value: _selectedTrainingLevelDefinition,
        icon: Icon(
          Icons.arrow_downward,
          size: 40,
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
      margin: EdgeInsets.all(15),
      color: MyColors.darkcontrastcolor,
      padding: EdgeInsets.all(20),
      child: LinearProgressIndicator(
        value: progress,
        backgroundColor: MyColors.lightcontrastcolor,
      ),
    );
  }
}
