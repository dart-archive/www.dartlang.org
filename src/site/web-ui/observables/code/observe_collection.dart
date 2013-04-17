library observe_collections;

import 'package:web_ui/web_ui.dart';

final List<DateTime> timestamps = toObservable([]);

void addTimestamp() {
  timestamps.add(new DateTime.now());
}

clear() {
  timestamps.clear();
}

main() {}