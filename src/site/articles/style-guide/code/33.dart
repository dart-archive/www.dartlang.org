import 'dart:math';

class Dice {
  roll() => null;
}

/// Rolls both [Dice] and returns the highest rolled value.
num greatestRoll(Dice a, Dice b) => max(a.roll(), b.roll());