---
layout: article
title: "Mocking with Dart"
rel:
  author: graham-wheeler
description: "Using Dart's unit test library for mocking and spying."
has-permalinks: true
article:
  written_on: 2012-07-01
  updated_on: 2013-03-29
  collection: libraries-and-apis
---

{% include toc.html %}

# {{ page.title }}

_Written by Graham Wheeler <br />
July 2012 
(updated March 2013)_


The Dart unit test library now supports testing with mocks. The 
mocks provide the ability to:

* substitute thin proxy objects for the objects that a system under test 
  interacts with and depends on
* control the behavior of those proxy objects
* log all of the interactions that occur with those objects
* perform various kinds of verification on the logs
* view the logs for auditing or debugging purposes

There are some restrictions in the current API that we hope to lift in the 
future as more language features are implemented. In particular, we can only 
mock calls to methods that use only positional parameters, and are limited to 10 
parameters. 

Note that this article assumes you are familiar with the unit test library; in 
particular with `expect()` and the `Matcher`s. If not, you should first read 
[Unit Testing with Dart](/articles/dart-unit-tests/).

## Getting ready for mocking

Most libraries that support mocking allow you to create substitutes for classes 
that can fake and verify the interactions with that class. Nonetheless, the mock 
object is typically an object of a different class to the object being mocked 
(most commonly a subclass). Unless you want to have to modify your code 
significantly at test time to use mocking, you should build your code to support 
it upfront. This implies that you need a way to substitute classes. Let's say we 
have a class `Game` that depends on class `Player`:

{% prettify dart %}
class Game {
  Player player;

  Game() {
    player = new Player();
  }
}
{% endprettify %}

Testing this code with a mock of `Player` is difficult. Instead, you should 
write your code so that it is possible to substitute a subclass of `Player` for 
player without changing the code of class `Game`. One way to do this is with 
factory allocators:

{% prettify dart %}
class Game {
  Player player;

  Game(PlayerFactory playerFactory) {
    player = playerFactory.CreatePlayer();
  }
}
{% endprettify %}

Another is by passing the `Player` instance in the constructor:

{% prettify dart %}
class Game {
  Player player;
  Game(this.player);
}
{% endprettify %}

Whichever approach you use, you should be cognizant that planning for mocking 
early will save you pain later on.

## An example of mocking with Dart

In this example, we are going to test a login controller class. This class makes 
use of a credential store that stores users names, password information, numbers 
of failed login attempts, and the ability to lock accounts (we will ignore 
unlocking for now). The credential store class is shown below (with the bodies 
of the functions missing as the actual implementation is not relevant here):

{% prettify dart %}
class CredentialStore {
  bool validate(String user, password) { … }
  void lockAccount(String user) { … }
  bool isLocked(String user) { … }
  int getFailures(String user) { … }
  void setFailures(String user, int failures) { … }
}
{% endprettify %}

The class we are testing is the controller class, part of which looks like this:

{% prettify dart %}
class LoginController {
  CredentialStore _store;

  // Note that we support injection of the store.
  LoginController([CredentialStore store = null]) {
    _store = (store == null) ? new CredentialStore() : store;
  }

  bool login(String name, String password) {
    if (!_store.isLocked(name)) {
      if (_store.validate(name, password)) {
        _store.setFailures(name, 0);
        return true;
      }
      int failures = _store.getFailures(name) + 1;
      _store.setFailures(name, failures);
      if (failures > 3) {
        _store.lockAccount(name);
      }
    }
    return false;
  }
}
{% endprettify %}

The `login()` method is responsible for validating a login attempt, locking the 
account if more than 3 failed consecutive logins have occurred, and clearing the 
count of failed logins on success.

We are going to illustrate two types of mocking. First we will substitute a 
simple mock class for the `CredentialStore`:

{% prettify dart %}
class MockStore extends Mock implements CredentialStore {}
{% endprettify %}

As you can see, for the dependency class that we want to mock, the code is very 
simple - we just declare a new class that extends `Mock` and implements the 
class (interface) that we want to mock.

Next we will make a "spy" class for observing the `LoginController`. Spies are a 
special case of mocking where we still want the real object's behavior, but we 
want interactions with the object to be audited. Here is the code for the class, 
which is a bit more involved than the store mock:

{% prettify dart %}
class ControllerSpy extends Mock implements LoginController {
  LoginController _real;

  ControllerSpy(CredentialStore store) {
    _real = new LoginController(store);
    when(callsTo('login')).alwaysCall(_real.login);
  }
}
{% endprettify %}

The spy class is a bit more interesting than the store mock: here we wrap an 
instance of the real class, and in the constructor we add a dispatch rule for 
the `login()` method to dispatch the call to the real object:

{% prettify dart %}
when(callsTo('login')).alwaysCall(_real.login);
{% endprettify %}

The benefit we get here is that all calls to mock object methods are logged and 
can be inspected later, so we get an audit trail.

Spying should be used with care - typically you will want to add `alwaysCall()` 
spy actions for all public methods of the class that you will be exercising, and 
you want to do this only on classes where these public methods do not call other 
public methods in the same class that are also being spied upon. If not, be 
aware that these nested calls will be made from within the real object and so 
will not go through the spy, and  won't be audited.

So now we have our mock classes, what can we do with them? Let's start by 
testing a happy path, by adding this `main()`:

{% prettify dart %}
void main() {
  // Create the objects.
  CredentialStore store = new MockStore();
  LoginController controller = new ControllerSpy(store);

  // Specify the behavior of the mock store.
  store.when(callsTo('isLocked')).thenReturn(false);
  store.when(callsTo('validate')).thenReturn(true);

  // Exercise the login method.
  controller.login('me', 'secret');

  // View the results.
  print(controller.log);
  print(store.log);
}
{% endprettify %}

We're not using any assertions yet; we are simply printing the captured audit 
trail which is kept in the log property of `Mock` objects. Later we will see how 
we can make assertions with this trail.

Notice how we specify behavior for a mock: we call the `when()` method and pass 
it the result of a call to `callsTo()`; the latter creates a `CallMatcher` which 
will be applied to method calls to determine the action to take. `callsTo()` can 
take multiple positional parameter restrictions too. This means we could, for 
example, have specified that Alice could log in but Bob could not, as follows:

{% prettify dart %}
store.when(callsTo('validate', 'Alice')).thenReturn(true);
store.when(callsTo('validate', 'Bob')).thenReturn(false);
{% endprettify %}

The parameter matchers need not be literal values; you can use any of the 
matchers in the unit test library that work with `expect()`.

The actions defined above are single-shot; if we called validate twice for Alice 
we would get an exception on the second call. To specify an endlessly repeating 
action we can use `alwaysReturn()` instead of `thenReturn()`. Alternatively we 
could specify that Alice logs in successfully once, and then fails forever 
after, like this:

{% prettify dart %}
store.when(callsTo('validate', 'Alice')).
  thenReturn(true).alwaysReturn(false);
{% endprettify %}

Notice how we can chain multiple calls; each call to an action function returns 
the same object so further calls are possible.

Actions are executed in the order they were defined so we can specify sequences 
of behavior.  However, it is important to make the `callsTo()` matchers 
unambiguous. These are not ordered, so if a method call matches more than one 
`callsTo()` behavior the one that is used is unpredictable. For example, the 
behavior here is unambiguous for Alice:

{% prettify dart %}
store.when(callsTo('validate', 'Alice')).thenReturn(true);
store.when(callsTo('validate', 'Alice')).thenReturn(false);
{% endprettify %}

The above is equivalent to:

{% prettify dart %}
store.when(callsTo('validate', 'Alice')).
  thenReturn(true).thenReturn(false);
{% endprettify %}

because the arguments to `callsTo` are the same, and so these 'actions' are 
added to the same 'behavior', and actions in a behavior are sequential. However, 
the sequence below is ambiguous:

{% prettify dart %}
store.when(callsTo('validate', 'Alice')).thenReturn(true);
store.when(callsTo('validate')).thenReturn(false);
{% endprettify %}

because this creates two separate 'behaviors' and there is no guaranteed order 
of match testing of behaviors.

When we run the full program above and the log is printed, we will see output 
similar to:

    16:41:34.63>  login('me', 'secret') returned <true>
    16:41:34.63>  isLocked('me') returned <false>
    16:41:34.63>  validate('me', 'secret') returned <true>
    16:41:34.63>  setFailures('me', <0>) returned <null>

Your output should be similar, apart from the timestamps.

The log member of each `Mock` object contains a detailed audit trace like the 
above that we can inspect. There is a way to make objects share a log, which can 
be useful for seeing how the calls to multiple objects are interleaved; we will 
see how to do this later.

The above is certainly useful, but what if we just want to write assertions to 
automate testing? That can be done easily as well. For example, let's say we 
want to assert that there was exactly one call to `setFailures()` as a result of 
calling `login()`. We can use the `getLogs()` method to extract the subset of 
matching log entries, and the `verify()` method to make assertions about the log 
entries:

{% prettify dart %}
controller.getLogs(callsTo('setFailures')).verify(happenedOnce);
{% endprettify %}

We will now take a more detailed look at the mocking API's features, and 
periodically revisit the example above.

## The mocking API

### Creating Mock classes

As shown in our example, if you want to create a mock for class T, you need to 
create a new class:

{% prettify dart %}
class MockT extends Mock implements T {}
{% endprettify %}

This assumes that you have declared variables or parameters of type T and so 
MockT must be substitutable for T. If on the other hand you always use untyped 
variables of parameters, you can simply use an instance of Mock as your mock; 
you do not need to create a new class.

`Mock` has the following constructors:

{% prettify dart %}
Mock() 
Mock.custom({this.name,
               this.log,
               throwIfNoBehavior: false,
               enableLogging: true}) 
{% endprettify %}

The first is equivalent to `Mock.custom()`.

The `logging` flag controls whether this Mock will log its actions. This
flag takes effect whether or not `log` is null. Usually you will want 
logging enabled so you can verify the behavior of the mock; however if you
just want the mock to act as a stub for testing some other class and don't
want the memory and performance overhead of logging you can set this to 
false.

The `throwIfNoBehavior` flag defined 
what should happen if you invoke a method on the mock that you have not defined 
any behavior for. If false (the default), the call will be swallowed and logged. 
This means you can mock a class with many methods and only define behavior for 
the subset of methods you are testing. On the other hand, if you are defining 
behavior for all the public methods of the class, you may want to set this flag 
to true to catch any that you may have missed.

The `name` argument can be used to give the mock a unique name. This isn't 
usually necessary unless you are also using the log argument, and passing in a 
shared log object that the `Mock` should use. Usually log is omitted or null and 
the `Mock` object will get its own activity log, but there may be times when you 
are using several mocks and you want to see in the log how their behavior is 
interleaved. In this case you can create a `LogEntryList` and pass it to several 
`Mock`s to share, but you should then give each `Mock` a unique name to identify 
its log entries. We will discuss logs in more detail below.

If you are creating a spy, you will typically want to set up the methods that 
you want to proxy (using `alwaysCall()`), and the logical place to do this is in 
the constructor of the spy object, as we did in our login controller example 
above.

### Specifying actions

To specify actions, we use the `when()` method of the mock object, and pass it a 
`CallMatcher`. `CallMatchers` (which are discussed more in the next section) are 
specialized matchers that are applied against method names and arguments. The 
`CallMatcher` will determine which calls the behavior will be applied to. 
`when()` returns a `Behavior` object to which actions can be added.

The currently supported actions are:

* `thenReturn(v, [count=1])`
* `alwaysReturn(v)`
* `thenThrow(v, [count=1])`
* `alwaysThrow(v)`
* `thenCall(v, [count=1])`
* `alwaysCall(v)`

The `thenX()` action creators are single-shot by default, but can be made n-shot 
by passing a count parameter; the `alwaysX()` action creators create endlessly 
repeating actions (so any actions added to the behavior after an `alwaysX()` 
action will never be executed).

`thenReturn(v)`/`alwaysReturn(v)` will return the value v upon a matching call; 
`thenThrow(v)`/`alwaysThrow(v)` will do a "throw v" upon a matching call, and 
`thenCall(v)`/`alwaysCall(v)` will call the function v (passing the same 
parameters as were passed to the mock method - up to ten positional paramaters), 
and return the value returned from that call.

A behavior with no remaining actions will throw exceptions if it is matched. 
Thus you should make sure you define enough responses for the number of matching 
calls you will make, or have the last (or only) action be an `alwaysX()` action.

If a method call is made with no matching behavior, then the result depends on 
the `throwIfNoBehavior` flag in the Mock constructor - either the call will 
result in a thrown `Exception` or it will be logged and swallowed.

### Call matching

`CallMatcher`s are used both by `Mock.when(m)` to get a `Behavior` (which is 
then typically used to add actions), and by `Mock.getLogs(m)` to find matching log 
entries after exercising the system under test. Typically you would use 
`callsTo()` to allocate a `CallMatcher`, but you could construct them yourself.

A `CallMatcher` is different to the `Matcher`s we use with `expect()`. It is 
designed specifically to match a method call, so it matches both on the method 
name and on the arguments. The constructor (wrapped by `callsTo()`) takes a 
method name and a number of parameter matchers. The parameter matchers 
themselves can be `expect()`-style `Matcher`s, for example:

{% prettify dart %}
m.when(callsTo('sqrt', isNegative)).
  alwaysThrow('No imaginary number support');
m.when(callsTo('sqrt', isNonNegative)).alwaysCall((x) => math.sqrt(x));
{% endprettify %}

You don't need to provide argument matchers in `callsTo()` for all arguments of a method, but you do need 
to provide enough arguments for all matchers when calling the method. So this is allowed:

{% prettify dart %}
m.when(callsTo('add')).alwaysReturn(0);
m.add(1, 2);
{% endprettify %}

And this is allowed, and will match all calls to 'add' where the first argument 
is 1:

{% prettify dart %}
m.when(callsTo('add', 1)).alwaysReturn(0);
m.add(1, 2);
m.add(1);
{% endprettify %}

But this is not allowed and will throw an exception:

{% prettify dart %}
m.when(callsTo('add', anything, anything)).alwaysReturn(0);
m.add(1);
{% endprettify %}

You can specify `CallMatcher`s for getters too. You just need to include 'get ' 
in front of the property name. So for example, if you were mocking a container 
class with a length property, you could use something like:

{% prettify dart %}
m.when(callsTo('get length')).alwaysReturn(0); 
{% endprettify %} 

Finally, you can pass null for the method name argument, and in this case only 
the arguments will be checked. In particular, these (equivalent) `CallMatcher`s 
will match all log entries:

* `callsTo()`
* `callsTo(null)`
    

### The activity logs

One we have created our mocks, defined their behavior, and have injected them 
into the system under test, we can do our test activities. Afterwards, we want 
to verify that what happened was what we expected to happen. Unlike some mocking 
frameworks where you assert up front what behavior you expect, in the Dart 
library verification happens afterwards. Each mock keeps a detailed log of all 
the method calls that occurred, including the parameters, the time, and the 
resulting action. This log can be inspected, or various assertions can be 
applied to it. In order to do so we need to be able to query the log.

In the simplest case we may want to look at the whole log. We can do that by 
accessing the log object we created (for mocks with shared logs) or the 
`Mock.log` property (for mocks with their own logs). The logs are stored in 
`LogEntryList`s:

{% prettify dart %}
class LogEntryList {
  final String filter;
  List<LogEntry> logs;
  …
  LogEntryList getMatches([String mockNameFilter,
                      CallMatcher logFilter,
                      Matcher actionMatcher,
                      bool destructive = false]);
}
{% endprettify %}

The filter property is only used for `LogEntryList`s that are returned from 
`getMatchers` (which is called from `Mock.getLogs()`), and contains a 
human-friendly textual description of the filter.

Each `LogEntry` has the form:

{% prettify dart %}
class LogEntry {
  Date time; // The time of the event.
  final String mockName; // The mock object name, if any.
  final String methodName; // The method name.
  final List args; // The parameters.
  final Action action; // The behavior that resulted.
  final value; // The value that was returned (if no throw).
  …
}
{% endprettify %}

`LogEntry`s have a `toString()` method that will produce a textual 
representation of the entry. This `toString()` method will normally format the 
`time` timestamp as an absolute time of day (in local time), but if you pass a 
`Date` as an argument, e.g.  `LogEntry.toString(start)`, then the timestamps 
will be formatted as elapsed seconds from that `Date`.

If you want to examine or make assertions on a subset of the logs, you need to 
filter the logs, which you do by calling `LogEntryList.getMatches()` or 
`Mock.getLogs`:

{% prettify dart %}
class Mock {
...
  LogEntryList getLogs([CallMatcher logFilter, Matcher actionMatcher,
    bool destructive = false]);
}
{% endprettify %}


The `destructive` flag, if set, will cause the removal of the matching log 
entries from the `Mock`'s log. This can be useful if you want to query the log 
for several expected calls and then assert that there were no other interactions 
with the object.

The `actionMatcher` is a special matcher that can be used to filter based on the 
method action. Action matchers are passed a `LogEntry` to their `matches()` 
method. There are two predefined action matchers available:

* `returning(m)`
* `throwing(m)`

m can be a value or another Matcher. Thus the call matcher filters the log by 
the method calls, while the action matcher filters the log by the method 
results.

### LogEntryList verification with Matchers

Apart from looking at the content of the logs explicitly, we can also perform 
assertions on them.  We can make use of `expect()` and our unit test `Matcher`s, 
for example. There are several common types of assertions that we would like to 
make, and the library has custom `Matcher`s already available for these. There 
are two groups, one that matches based on results:

* `alwaysReturned(value)`
* `sometimeReturned(value)`
* `neverReturned(value)`
* `alwaysThrew(value)`
* `sometimeThrew(value)`
* `neverThrew(value)`

`value` here can be a literal value or yet another `Matcher`.

The other group matches based on number of occurrences:

* `neverHappened`
* `happenedOnce`
* `happenedAtLeastOnce`
* `happenedAtMostOnce`
* `happenedExactly(num)`
* `happenedAtLeast(num)`
* `happenedAtMost(num)`

`LogEntryList` has a `verify()` method that takes a `Matcher` and saves you 
having to write `expect()`. This means you can write assertions like the 
following examples:

{% prettify dart %}
m.getLogs(callsTo('bar')).verify(happenedExactly(2)).
    verify(sometimeReturned(6)).verify(neverReturned(5));
{% endprettify %}

In English: verify that there were 2 calls to the 'bar' method, at least one of 
which returned 6, and neither of which returned 5.

{% prettify dart %}
m.getLogs(callsTo('bar'), returning(5)).verify(neverHappened);
{% endprettify %}

In English: no calls to 'bar' ever returned 5, which is equivalent to:

{% prettify dart %}
m.getLogs(callsTo('bar')).verify(neverReturned(5));
{% endprettify %}

### Shared logs

It is possible for more than one mock object to use a common log. The reason you 
might want to do this is to verify the expected interleaving of behavior. In 
order to do this you need to create the log yourself, and then pass it as a 
named `log` parameter to `Mock.custom`. For example:

{% prettify dart %}
var log = new LogEntryList();
var m1 = new Mock.custom(name:'m1', log:log);
var m2 = new Mock.custom(name:'m2', log:log);
m1.foo();
m2.foo();
m1.bar();
m2.bar();
{% endprettify %}

If we printed the result, we would see something like:

    16:42:30.560> m1.foo() returned <null>
    16:42:30.561> m2.foo() returned <null>
    16:42:30.561> m1.bar() returned <null>
    16:42:30.561> m2.bar() returned <null>

To access the shared log for verification, you can still use the 
`Mock.getLogs()` and `LogEntryList.getMatches()` methods. So the following are 
equivalent, using our example above:

{% prettify dart %}
m1.getLogs(callsTo('foo'));
log.getMatches('m1', callsTo('foo'));
{% endprettify %}

The advantage you get from using this method is that you can name Mocks with a 
class name and treat them collectively. You can even pass `null` as the 
`mockName` argument to match against the actions for all the mocks that shared 
the log. Using our example above, this test would pass:

{% prettify dart %}
log.getMatches(null, callsTo('foo')).verify(happenedExactly(2));
{% endprettify %}


## Temporal assertions

So far, you should have learned that:

* you can create subclasses of `Mock` that 'implement' the interfaces of other classes you want to mock, and you can specify the behavior of these mock objects;
* the actual behavior in any test run is optionally captured in one or more audit trail logs, which can be used later to make assertions about the behavior of the system.

That is, assertions about the behavior of the system over time are made by filtering the execution logs and then verifying some properties of the remaining log messages.

We will now look at more complex ways of verifying the behavior of a system under test over time, using a more complex example, a vending machine.

Our vending machine will be made up of two classes - a `VendingMachineDispenser` responsible for maintaining an inventory of items that it can dispense, and a `VendingMachineCashier` class that takes coin deposits and item selections, and knows about the price of items.

### The dispenser


The dispenser class is very simple. All the dispenser does is take a command to dispense an item, and return success or failure depending on whether it has inventory, updating the inventory accordingly:

{% prettify dart %}
class VendingMachineDispenser {
   
  List<int> inventory;
   
  VendingMachineDispenser(int numItems, int level) {
    restock(numItems, level);
  }
   
  void restock(int numItems, int level) {
    inventory = new List(numItems);
    for (var i = 0; i < numItems; i++) {
      inventory[i] = level;
    }
  }

  bool dispenseItem(int itemNumber) {
    if (itemNumber >= 0 && itemNumber < inventory.length &&
        inventory[itemNumber] > 0) {
      --inventory[itemNumber];
      return true;
    }
    return false;
  }
}
{% endprettify %}

### The cashier

The cashier will tell the dispenser to dispense a selected item if enough money has been deposited, and will give the user change. Selecting an item can fail if the dispenser has no stock, insufficient money has been inserted, or the cashier cannot issue change. The cashier will accept nickels (5c) and dimes (10c), up to a maximum of 50c, after which further coins will be rejected.

{% prettify dart %}
class VendingMachineCashier {
   
  static const int MaxCapacity = 50;
   
  VendingMachineDispenser _dispenser;
  List<int> _prices;
  int _deposited = 0;
  int numNickels = 0, numDimes = 0;

  int get deposited => _deposited;

  VendingMachineCashier(VendingMachineDispenser dispenser,
      List<int> prices)
      : _dispenser = dispenser,
        _prices = prices;
   
  String _depositCoin(int amount) {
    if (amount == 0 || _deposited > (MaxCapacity - amount)) {
      rejectCoin();
    } else {
      _deposited += amount;
    }
    return '${_deposited}c';
  }
   
  String depositNickel() => _depositCoin(5);   
  String depositDime() => _depositCoin(10);
  String depositOther() => _depositCoin(0);
   
  String selectItem(int itemNumber) {
    if (_deposited >=  _prices[itemNumber]) {
      // Make sure we have change.
      int change = deposited - _prices[itemNumber];
      if ((change % 10) == 5 && numNickels == 0) {
        giveChange(_deposited);
        _deposited = 0;
        return 'No change';
      } else if (_dispenser.dispenseItem(itemNumber)) {
        giveChange(change);
        _deposited = 0;
        return 'Insert coin';
      } else {
        giveChange(_deposited);
        _deposited = 0;
        return 'Item ${itemNumber} out';
      }
    }
    return '${_deposited}c';
  }
   
  String cancel() {
    giveChange(_deposited);
    _deposited = 0;
    return 'Insert coin';
  }
   
  void giveChange(int amount) {
    while (amount >= 10 && numDimes > 0) {
      --numDimes;
      dispenseDime();
      amount -= 10;
    }
    if (amount == 5) {
      --numNickels;
      dispenseNickel();
    }
  }
   
  // Hardware interface; stubs for now.   
  void rejectCoin() { /* Instruct hardware to reject current coin. */ }
  void dispenseNickel() { /* Instruct hardware to dispense nickel. */ }
  void dispenseDime() { /* Instruct hardware to dispense dime. */ }
}
{% endprettify %}

The external interface of the cashier consists of the nickel and dime deposit slots, the item select buttons, and the cancel button.  `selectItem()` is called when an item select button is pressed, and it returns a message that is displayed to the user, which can be 'Insert coin' (the initial message which is also displayed after a successful purchase), 'Item nnn out' if there is no inventory of an item that has just been selected, 'No change' if an item can’t be purchased because the machine cannot issue the correct change, or a total amount currently deposited.

### Mocking the classes

In this example we are trying to validate the behavior of this system. We are not using mocks as stubs, but rather as spys (i.e. we are monitoring the behavior of a real class, not substituting for the class). We need a dispenser spy and a cashier spy:

{% prettify dart %}
class DispenserSpy extends Mock implements VendingMachineDispenser {
  VendingMachineDispenser _real;

  DispenserSpy(LogEntryList log, int numItems, int level)
      : super.custom(name: 'dispenser', log: log),
        _real = new VendingMachineDispenser(numItems, level) {
    when(callsTo('dispenseItem')).alwaysCall(_real.dispenseItem);
  }
}

class CashierSpy extends Mock implements VendingMachineCashier {
  VendingMachineCashier _real;

  CashierSpy(LogEntryList log, VendingMachineDispenser d,
      List<int>  prices)
      : super.custom(name: 'cashier', log: log),
        _real = new VendingMachineCashier(d, prices) {
    when(callsTo('depositNickel')).alwaysCall(_real.depositNickel);
    when(callsTo('depositDime')).alwaysCall(_real.depositDime);
    when(callsTo('depositOther')).alwaysCall(_real.depositOther);
    when(callsTo('selectItem')).alwaysCall(_real.selectItem);
    when(callsTo('cancel')).alwaysCall(_real.cancel);
    when(callsTo('get deposited')).alwaysCall(()=>_real.deposited);
  }
}
{% endprettify %}

### Driving the system under test

To generate test logs for verification, we can use random testing (if you are familiar with fuzz testing, this is similar, although the idea is much older). We will simply call the public interface of the system based on the results of a random number generator:

{% prettify dart %}
void main() {
  var rand = new Random();
  LogEntryList log = new LogEntryList();
  List<int> prices = [25, 40, 50 ];
  var dispenser = new DispenserSpy(log, 3, 5);
  var cashier = new CashierSpy(log, dispenser, prices);
  int numEvents = 500;
  cashier.deposited; // useful for audit trail
  while (--numEvents >= 0) {
    var eNum = rand.nextInt(6);
    switch (eNum) {
      case 0:
        cashier.depositNickel();
        break;
      case 1:
        cashier.depositDime();
        break;
      case 2:
        cashier.depositOther();
        break;
      default:
        cashier.selectItem(eNum - 3);
        break;
    }
    cashier.deposited; // useful for audit trail
  }
}
{% endprettify %}

The code is quite straightforward; the main oddities are the calls to cashier.deposited; we do this because it is useful for validation purposes to generate log messages at the start and after each action that have the current amount deposited in the cashier; most of our assertions will be assertions about this value.

### Sample temporal assertions

Now we want to make some assertions about the behavior of the system. The behavior we are going to verify is the following:

* when the dispenser successfully dispensed an item, there was enough money in the cashier to pay for it;
* if the user tried to select an item and no item was dispensed, and this was not due to lack of change or inventory, then this was because there was not enough money;
* because we are not restocking in the code above after the initial stock, if an item fails to dispense due to lack of stock, any further attempts to dispense the item will also fail;
* if the user deposits a dime, then the amount in the cashier will go up by 10c provided there was no more than 40c in the cashier; otherwise the amount will be unchanged.

We will break these down step by step. In the first case:

* “when the dispenser successfully dispensed an item” translates to “calls to `VendingMachineDispenser.dispenseItem` that returned true”;
* “there was enough money” - we can find the amount of money by getting the closest preceding calls to `VendingMachineCashier.deposited`;
* “to pay for it” means the amount of money we retrieved in the last step was at least as great as the item price.

We can assert this separately for each item, as follows:

{% prettify dart %}
for (var item = 0; item < 3; item++) {
  int price = prices[item];
  // Get all calls to VendingMachineDispenser.dispenseItem that
  // returned true.
  LogEntryList dispenses = log.getMatches('dispenser',
                 callsTo('dispenseItem', item), returning(isTrue));

  // Find the closest preceding calls to VendingMachineCashier.deposited.
  LogEntryList lastDeposits = log.preceding(dispenses,
            mockNameFilter: 'cashier', logFilter: callsTo('get deposited'));

  // Verify that the value returned was at least as high as item price.
  lastDeposits.verify(alwaysReturned(greaterThanOrEqualTo(price)));
}
{% endprettify %}

For the second example:

* “if the user tried to select an item” translates to calls to `VendingMachineCashier.selectItem`;
* “and no item was dispensed” means we don’t care about cases where `selectItem` returned 'Insert coin';
* “and this was not due to lack of change or inventory” means that we don’t care about cases where `selectItem` returned “No change” or “Item nnn out”;
* “then this was because there was not enough money” means we want to look at the preceding calls to `VendingMachineCashier.deposited` and assert that the deposited amount was less that the item price.

In code:

{% prettify dart %}
for (var item = 0; item < 3; item++) {
  // Get the calls to selectItem that did not return ‘Insert coin’,
  // ‘No change’, or ‘Item nnn out’.
  LogEntryList failedDispenses = log.getMatches('cashier',
      callsTo('selectItem', item),
      returning(
         isNot(anyOf('Insert coin', 'No change', startsWith('Item')))));
  // Get the closest preceding calls to VendingMachineCashier.deposited.
  LogEntryList lastDeposits = log.preceding(failedDispenses,
                mockNameFilter: 'cashier', logFilter: callsTo('get deposited'));
  // Verify that the value returned was lower than the  item price.
  lastDeposits.verify(alwaysReturned(lessThan(prices[item])));
}
{% endprettify %}

For the third example:

* “if an item fails to dispense due to lack of stock” means `selectItem` returned ‘Item nnn out’;
* “any further attempts to dispense the item” means we want all logs for `selectItem` that followed the first log for `selectItem` in the prior step;
* “will also fail” means that none of the logs returned in the second step will have a return value of 'Insert coin'.

In code:

{% prettify dart %}
for (var item = 0; item < 3; item++) {
  // We query the logs for selectItem calls twice so save the
  // CallMatcher for reuse.
  CallMatcher selectItem = callsTo('selectItem', item);
  // Get the set of log entries where selectItem return no stock.
  LogEntryList noStockDispenses = log.getMatches('cashier',
      selectItem, returning('Item $item out'));
  // Get the set of log messages for selectItem that came
  // after the first no stock message.
  LogEntryList laterDispenses = log.fromFirst(noStockDispenses).
      getMatches('cashier', selectItem);
  // Verify that none of those returned success.
  laterDispenses.verify(neverReturned('Insert coin'));
}
{% endprettify %}

An alternative way that would also work:

{% prettify dart %}
for (var item = 0; item < 3; item++) {
  // Get the set of log entries where selectItem return no stock.
  LogEntryList noStockDispenses = log.getMatches('cashier',
      callsTo('selectItem', item), returning('Item $item out'));
  // Get the set of log messages for dispenseItem that came
  // after the first no stock message.
  LogEntryList laterDispenses = log.fromFirst(noStockDispenses).
      getMatches('dispenser', callsTo(‘dispenseItem’, item));
  // Verify that none of those returned success.
  laterDispenses.verify(neverReturned(true));
}
{% endprettify %}

For the fourth example, we will use a stepwise validator function. We will get all calls to `depositDime`, and the closest preceding calls to the `deposited` getter, and then we will make assertions about each such pair:

{% prettify dart %}
// Get all calls to depositDime.
LogEntryList dd = log.getMatches('cashier', callsTo('depositDime'));
// Get the closest preceding calls to get deposited, and include
// the calls to depositDime in the result.
LogEntryList pairs = log.preceding(dd, mockNameFilter: 'cashier',
      logFilter: callsTo('get deposited'), includeKeys: true);
// Our validator will operate on each pair, and return 0 upon failure or
// 2 upon success (so we advance the position by 2 for the next call).
pairs.stepwiseValidate((l, pos) =>
    (l[pos+1].value ==
     '${l[pos].value+(l[pos].value <= 40 ? 10 : 0)}c') ?
        2 : 0);
{% endprettify %}

## Reducing logging for regression tests

Once you have a system working and a collection of assertions that you want to use for regression testing, you may want to reduce the amount of logging that is done by the mocks. For example, in our assertions we never made any use of `depositNickel` in the logs. To reduce the memory requirements and improve performance, we can turn off logging for this method.

Logging is enabled both at the level of `Mock` objects, and `Behavior` objects. In each case the `logging` getter/setter can be used to turn logging on or off. Recall from the earlier that `Behavior` methods such as `alwaysReturn` return the `Behavior` itself, to support chaining of calls. Thus we could have specified the mock behavior for `depositNickel` and turned off logging for that behavior at the same time with a line such as:

{% prettify dart %}
when(callsTo('depositNickel')).
    alwaysCall(_real.depositNickel).logging = false;
{% endprettify %}

Note that that logging property applies to the `Behavior`, not the specific `Action` in the `Behavior`, so this is equivalent to:

{% prettify dart %}
when(callsTo('depositNickel')).logging = false;
when(callsTo(‘depositNickel’)).alwaysCall(_real.depositNickel);
{% endprettify %}

## Conclusion

The Mock support currently available should be a good start. We expect that the library will become richer, more 
comprehensive, and easier to use as more language features become available. In 
the meantime, we welcome your [feedback](/support/).
