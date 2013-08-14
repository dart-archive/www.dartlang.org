import 'dart:io';
import 'dart:async';

void printDailyNewsDigest() {
  File file = new File('dailyNewsDigest.txt');
  file.readAsString()                  // readAsString() returns a Future.
    .then((content) => print(content)) // Handle successful completion.
    .catchError((error) =>             // Handle failure.
        print("Sorry, no news today. Here's why:\n$error"));
}

main() {
  printDailyNewsDigest();
}
