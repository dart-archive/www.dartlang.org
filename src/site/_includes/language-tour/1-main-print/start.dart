// Define a function.
printNumber(num smallNumber) {
  assert(smallNumber < 100);            // Check our assumptions.
  print("The number is $smallNumber."); // Print to the console.
}

// This is where the app starts executing.
main() {
  var number = 42;           // Declare and initialize a variable.
  printNumber(number);       // Call a function.
}