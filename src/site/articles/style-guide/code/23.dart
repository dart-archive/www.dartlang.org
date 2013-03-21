class Person {
  var name;
}

main() {
  List people = [];

  test1() {
    var names = people.map((Person person) {
      return person.name;
    });
  }

  var names = people.map((person) => person.name);
}