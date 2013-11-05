// Copyright (c) 2012, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:html';

ButtonElement genButton;

void  main() {
  querySelector('#inputName').onInput.listen(updateBadge);
  genButton = querySelector('#generateButton');
  genButton.onClick.listen(generateBadge);
}

void updateBadge(Event e) {
  String inputName = (e.target as InputElement).value;
  
  setBadgeName(inputName);
  if (inputName.trim().isEmpty) {
    genButton..disabled = false
             ..text = 'Aye! Gimme a name!';
  } else {
    genButton..disabled = true
             ..text = 'Arrr! Write yer name!';
  }
}

void generateBadge(Event e) {
  setBadgeName('Anne Bonney');
}

void setBadgeName(String newName) {
  querySelector('#badgeName').text = newName;
}
