///
/// Config Model: a definition of a training level.
///

class TrainingLevelDefinition {
  /// A screen-visible name of the training level
  final String name;

  /// description for the training level,
  /// giving tips about how to use it and conduct the training.
  final String description;

  /// number of work-out sets
  final int nrOfWorkSets;

  /// time in milliseconds to ramp-up into the first work-set of the training
  final int timeToRampUp;

  /// duration in milliseconds of a work-set
  final int durationOfWorkSet;

  /// duration in milliseconds of a inter-work-set pause
  final int durationOfPause;

  /// lead time in milliseconds to announce work-set
  final int announceWorkSet;

  /// lead time in milliseconds to announce pause
  final int announcePause;

  /// lead time in milliseconds to announce end of training
  final int announceEndOfTraining;

  /// number of announcements leading into the next phase
  final int nrOfAnnouncements;

  /// duration per annountement increment
  final int durationOfAnnouncement;

  /// Initializing constructor
  TrainingLevelDefinition(
      this.name,
      this.description,
      this.nrOfWorkSets,
      this.timeToRampUp,
      this.durationOfWorkSet,
      this.durationOfPause,
      this.announceWorkSet,
      this.announcePause,
      this.announceEndOfTraining,
      this.nrOfAnnouncements,
      this.durationOfAnnouncement);

  /// calculate number of pauses
  int get nrOfPauses => max(0, nrOfWorkSets - 1);

  /// calculate the total duration of the training
  int get totalDuration =>
      timeToRampUp +
      (nrOfWorkSets * durationOfWorkSet) +
      (nrOfPauses * durationOfPause);

  /// return the bigger of two integers
  int max(int a, int b) {
    return (a > b) ? a : b;
  }
}
