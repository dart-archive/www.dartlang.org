test1() {
  lookUpOrDefault(String name, Map map, defaultValue) {
    var value = map[name];
    if (value != null) return value;
    return defaultValue;
  }
}

test2() {
  dynamic lookUpOrDefault(String name, Map map, dynamic defaultValue) {
    var value = map[name];
    if (value != null) return value;
    return defaultValue;
  }
}