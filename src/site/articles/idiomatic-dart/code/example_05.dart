bool isShouting(String message) {
  return (message.toUpperCase() == message);
}

main() {
  print(isShouting("I'M JUST VERY EXCITED")); // true

  var messages = ['hello', 'DART IS FUN'];
  var shouts = messages.where(isShouting).toList();

  print(shouts); // ['DART IS FUN']

  var shouts2 = messages.where((m) {
    return (m.toUpperCase() == m);
  }).toList();

  var shouts3 = messages.where((m) => m.toUpperCase() == m).toList();
}