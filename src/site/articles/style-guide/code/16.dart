class Stuff {
  num right, left, minTime;

  List getValues() => [];

  get width => right - left;
  bool ready(num time) => minTime == null || minTime <= time;
  containsValue(String value) => getValues().contains(value);
}