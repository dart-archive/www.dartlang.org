import 'dart:math';

num abs(num value) => value < 0 ? -value : value;

final TWO_PI = PI * 2.0;

int get today {
  final date = new DateTime.now();
  return date.day;
}

main() {
  print(today);
}