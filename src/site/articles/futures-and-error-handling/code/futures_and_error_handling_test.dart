library future_and_error_handling_test;

import 'dart:async';
import 'dart:io';

Future myFunc() => new Future.of(() => print('I am a future. Beep boop.'));
Future funcThatThrows() => new Future.of(() => throw "Error!");
Future anotherFuncThatThrows() => new Future.of(() => throw "Error!");
successCallback(v) => print(v);
handleAuthResponse(v) => print(v);
processValue(v) => print(v);
doSomethingWith(v) => print(v);
handleError(e) => print(e);
handleResponse(e) => print(e);
handleFormatException(e) => print(e);
handleAuthorizationException(e) => print(e);
connectToServer() => print('Server!');
printErrorMessage() => print('Error');
obtainFileName(v) => print(v);
parseFileData(v) => print(v);
someFunc() => print('Stuff');

class AuthorizationException {}

void wrapEverything() {
  myFunc().then(processValue)
          .catchError(handleError);



  myFunc()
    .then((value) {
      doSomethingWith(value);
      // ...
      throw("some arbitrary error");
    })
    .catchError(handleError);

// TODO: Remove this once this is no longer code in the article.
// abstract Future then(onValue(T value), {onError(AsyncError asyncError)})


  funcThatThrows()
    .then(successCallback, onError: (e) {
      handleError(e);          // Original error.
      anotherFuncThatThrows(); // Oops, new error.
    })
    .catchError(handleError);  // Error from within then() handled.


  Future<String> one()   => new Future.immediate("from one");
  Future<String> two()   => new Future.immediateError("error from two");
  Future<String> three() => new Future.immediate("from three");
  Future<String> four()  => new Future.immediate("from four");

  void main1() {
  //  void main() {
    one()                                   // Future completes with "from one".
      .then((_) => two())                   // Future completes with two()'s error.
      .then((_) => three())                 // Future completes with two()'s error.
      .then((_) => four())                  // Future completes with two()'s error.
      .then((value) => processValue(value)) // Future completes with two()'s error.
      .catchError((e) {
        print("Got error: ${e.error}");     // Finally, callback fires.
        return 42;                          // Future completes with 42.
      })
      .then((value) {
        print("The value is $value");
      });
  }

  // Output of this program:
  //   Got error: error from two
  //   The value is 42


// TODO: Remove this once this is no longer code in the article.
// abstract Future catchError(onError(AsyncError asyncError), {bool test(Object error)})


  void main2() {
  //  void main() {
    handleAuthResponse({'username': 'johncage', 'age': 92})
//      .then((_) => ...)
      .catchError(handleFormatException,
                  test: (e) => e is FormatException)
      .catchError(handleAuthorizationException,
                  test: (e) => e is AuthorizationException);
  }


  var myUrl = '';
  var server = connectToServer();
  server.post(myUrl, fields: {"name": "john", "profession": "juggler"})
        .then(handleResponse)
        .catchError(handleError)
        .whenComplete(server.close);


  void main3() {
  //  void main() {
    funcThatThrows()
      .then((_) => print("Won't reach here..."))   // Future completes with an error.
      .whenComplete(() => print("... or here...")) // Future completes with the same error.
      .then((_) => print("... nor here."))        // Future completes with the same error.
//      .then((_) => ...)        // Future completes with an error.
//      .whenComplete(() => ...) // Future completes with the same error.
//      .then((_) => ...)        // Future completes with the same error.
      .catchError(handleError); // Error is handled here.
  }


  var someObject = '';
  void main4() {
  //  void main() {
    funcThatThrows()
//      .then((_) => ...)         // Future completes with an error.
      .catchError((e) {
        handleError(e);
        printErrorMessage();
        return someObject;
      })                                   // Future completes with someObject.
      .whenComplete(() => print("Done!")); // Future completes with someObject.
  }


  void main5() {
  //  void main() {
    funcThatThrows()
      .catchError(handleError)               // Future completes with a value.
      .whenComplete(() => throw "new error") // Future completes with an error.
      .catchError(handleError);              // Error is handled.
  }


  void main6() {
  //  void main() {
    Future future = funcThatThrows();

    // BAD. Too late to handle funcThatThrows() exception.
    new Future.delayed(const Duration(milliseconds: 500), () {
//      future.then(...)
//            .catchError(...);
    });
  }


  void main7() {
  //  void main() {
    new Future.delayed(const Duration(milliseconds: 500), () {
      funcThatThrows().then(processValue)
                      .catchError(handleError); // We get here.
    });
  }


  Future<int> parseAndRead(data) {
    var filename = obtainFileName(data);         // Could throw.
    File file = new File(filename);
    return file.readAsString().then((contents) {
      return parseFileData(contents);            // Could throw.
    });
  }


  var data = '';
  void main8() {
  //  void main() {
    parseAndRead(data).catchError((e) {
      print("inside catchError");
      print(e.error);
    });
  }

  // Program Output:
  //   Unhandled exception:
  //   <error from obtainFileName>
  //   ...


//  Future<int> parseAndRead(data) {
  Future<int> parseAndRead2(data) {
    return new Future.of(() {
      var filename = obtainFileName(data);         // Could throw.
      File file = new File(filename);
      return file.readAsString().then((contents) {
        return parseFileData(contents);            // Could throw.
      });
    });
  }


  void main9() {
  //  void main() {
    parseAndRead(data).catchError((e) {
      print("inside catchError");
      print(e.error);
    });
  }

  // Program Output:
  //   inside catchError
  //   <error from obtainFileName>


  Future myFunc() {
    return new Future.of(() {
      var x = someFunc();     // Unexpectedly throws in some rare cases.
      var y = 10 / x;         // x should not equal 0.
//      ...
    });
  }
}
