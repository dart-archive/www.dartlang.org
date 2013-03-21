class Person {
  var zip;
}

test1() {
  
  Map<int, List<Person>> groupByZip(Iterable<Person> people) {
    var peopleByZip = new Map<int, List<Person>>();
    for (var person in people) {
      peopleByZip.putIfAbsent(person.zip, () => <Person>[]);
      peopleByZip[person.zip].add(person);
    }
    return peopleByZip;
  }

}

test2() {

  Map<int, List<Person>> groupByZip(Iterable<Person> people) {
    Map<int, List<Person>> peopleByZip = new Map<int, List<Person>>();
    for (Person person in people) {
      peopleByZip.putIfAbsent(person.zip, () => <Person>[]);
      peopleByZip[person.zip].add(person);
    }
    return peopleByZip;
  }

}