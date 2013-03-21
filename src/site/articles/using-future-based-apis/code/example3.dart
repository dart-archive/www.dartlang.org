import 'dart:io';
import 'dart:async';

void printDailyNewsDigest() {
  File file = new File("dailyNewsDigest.txt");
  Future future = file.readAsString();
  future.then((content) => doSomethingWith(content))
        .catchError((e) => handleError(e));
}

void main() {
  printDailyNewsDigest();
  printWinningLotteryNumbers();
  printWeatherForecast();
  printBaseballScore();
}

doSomethingWith(content) {
  print('do something with content');
}

handleError(e) {
  print('handleError');
}

printWinningLotteryNumbers() {
  print('Winning lotto numbers: [23, 63, 87, 26, 2]');
}

printWeatherForecast() {
  print('Tomorrow\'s forecast: 70F, sunny.');
}

printBaseballScore() {
  print('Baseball score: Red Sox 10, Yankees 0');
}
