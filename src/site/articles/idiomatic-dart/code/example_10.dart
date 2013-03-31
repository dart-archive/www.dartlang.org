/// This method used to only take an [int] but now it takes a [Duration] or
/// [int]. Use of [int] is deprecated, please use [Duration].
calculateTimePeriod(var duration) {
  if (duration is int) {
    // ...
  } else if (duration is Duration) {
    // ...
  } else {
    throw new ArgumentError('duration must be an int or Duration');
  }
}