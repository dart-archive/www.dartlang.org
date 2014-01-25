// Copyright (c) 2012, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.


// Demonstrates:
// list, maps, random, strings, string interpolation
// cascade, fat arrow, ternary operator
// named constructors
// optional parameters
// a class
// getters
// httprequest, JSON
// local storage
// static class-level methods/fields
// top-level variables and functions
// typecasting with 'as'
// futures
// import, also with show
// dart:core, html, math, convert and async libraries

import 'dart:html';
import 'dart:math' show Random;
import 'dart:convert' show JSON;
import 'dart:async' show Future;

final String TREASURE_KEY = 'pirateName';

ButtonElement genButton;
SpanElement badgeNameElement;

void  main() {
  InputElement inputField = querySelector('#inputName');
  inputField.onInput.listen(updateBadge);
  genButton = querySelector('#generateButton');
  genButton.onClick.listen(generateBadge);
  
  badgeNameElement = querySelector('#badgeName');
  
  PirateName.readyThePirates()
    .then((_) {
      //on success
      inputField.disabled = false; //enable
      genButton.disabled = false;  //enable
      setBadgeName(getBadgeNameFromStorage());
    })
    .catchError((arrr) {
      print('Error initializing pirate names: $arrr');
      badgeNameElement.text = 'Arrr! No names.';
    });
}

void updateBadge(Event e) {
  String inputName = (e.target as InputElement).value;
  
  setBadgeName(new PirateName(firstName: inputName));
  if (inputName.trim().isEmpty) {
    genButton..disabled = false
             ..text = 'Aye! Gimme a name!';
  } else {
    genButton..disabled = true
             ..text = 'Arrr! Write yer name!';
  }
}

void generateBadge(Event e) {
  setBadgeName(new PirateName());
}

void setBadgeName(PirateName newName) {
  if (newName == null) {
    return;
  }
  badgeNameElement.text = newName.pirateName;
  window.localStorage[TREASURE_KEY] = newName.jsonString;
}

PirateName getBadgeNameFromStorage() {
  String storedName = window.localStorage[TREASURE_KEY];
  if (storedName != null) {
    return new PirateName.fromJSON(storedName);
  } else {
    return null;
  }
}

/* 
 * A class declaration.
 */
class PirateName {
  
  // static variables are shared by all instances.
  // Random is a random number generator in dart:math.
  static final Random indexGen = new Random();

  // List is a parameterized type. You can declare the type of the objects it contains.
  static List<String> names = [];
  static List<String> appellations = [];

  // Instance variables. Private variables have names that start with underscore '_'.
  String _firstName;
  String _appellation;
  
  // A constructor with two optional, named parameters.
  PirateName({String firstName, String appellation}) {
    
    // Use nextInt to get a random integer from a Random object.
    // Use length to get the number of items in a list.
    if (firstName == null) {
      _firstName = names[indexGen.nextInt(names.length)];
    } else {
      _firstName = firstName;
    }
    if (appellation == null) {
      _appellation = appellations[indexGen.nextInt(appellations.length)];
    } else {
      _appellation = appellation;
    }
  }

  // A named constructor.
  PirateName.fromJSON(String jsonString) {
    // JSON is the default implementation of a JSON encoder/decoder.
    // Map is a collection of key-value pairs.
    Map storedName = JSON.decode(jsonString);
    _firstName = storedName['f'];
    _appellation = storedName['a'];
  }

  // Fat arrow syntax is shorthand for a one-line function that returns a value.
  String toString() => pirateName;

  // A getter provides read access to the member of an object.
  String get jsonString => '{ "f": "$_firstName", "a": "$_appellation" } ';

  // The ternary operator is shorthand for if-then-else. 
  // String interpolation lets you easily build strings from other objects.
  String get pirateName => _firstName.isEmpty ? '' : '$_firstName the $_appellation';

  static Future readyThePirates() {
    String path = 'piratenames.json';
    return HttpRequest.getString(path)
        .then(_parsePirateNamesFromJSON);
  }
  
  static _parsePirateNamesFromJSON(String jsonString) {
    Map pirateNames = JSON.decode(jsonString);
    names = pirateNames['names'];
    appellations = pirateNames['appellations'];
  }
}