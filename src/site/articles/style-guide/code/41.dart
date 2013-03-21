main() {
  if (true) {
    print('sanity');
  } else {
    print('opposite day!');
  }

  // Bad

  if (true) print('sanity');
  else
    print('opposite day!');

  // OK
  var arg;
  var defaultValue;

  if (arg == null) return defaultValue;
}