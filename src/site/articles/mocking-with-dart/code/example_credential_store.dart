#!/usr/bin/env dart_analyzer --enable_type_checks --extended-exit-code --type-checks-for-inferred-types

import 'package:unittest/unittest.dart';
import 'package:unittest/mock.dart';

class CredentialStore {
  bool validate(String user, password) { /* … */ }
  void lockAccount(String user) { /* … */ }
  bool isLocked(String user) { /* … */ }
  int getFailures(String user) { /* … */ }
  void setFailures(String user, int failures) { /* … */ }
}

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

class MockStore extends Mock implements CredentialStore {}

class ControllerSpy extends Mock implements LoginController {
  LoginController _real;

  ControllerSpy(CredentialStore store) {
    _real = new LoginController(store);
    when(callsTo('login')).alwaysCall(_real.login);
  }
}

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