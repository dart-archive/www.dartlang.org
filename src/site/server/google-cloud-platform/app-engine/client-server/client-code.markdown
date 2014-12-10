---
layout: default
title: "The Client Code Explained"
short-title: "Client Code"
description: "Learn about the appengine APIs used by the client"
header:
  css: ["../styles.css"]
---

{% include breadcrumbs.html %}

# {{ page.title }} 

Two Dart files comprise the client application: `model.dart` and `index.dart`.
In addition, the application contains one HTML file,
<a href="https://github.com/dart-lang/appengine_samples/blob/master/clientserver/web/index.html">index.html</a>.

## model.dart

The `gcloud` package provides a mapping from Dart objects
to Cloud Datastore.
A Dart class that extends `Model` and is annotated with an
`Entity` can be stored in Cloud Datastore.

The
[model.dart](https://github.com/dart-lang/appengine_samples/blob/master/clientserver/web/model.dart)
source file provides these mappings for the
`Item` class, which represents an item placed in the list by the user
and is saved to the gcloud datastore by the server.
The `model.dart` file is included by the server.

Here is the model.dart file in its entirety.

{% prettify dart %}
library model;

import 'package:gcloud/db.dart';

@Kind()
class ItemsRoot extends Model { }

@Kind()
class Item extends Model {
  @StringProperty()
  String name;

  validate() {
    if (name.length == 0) return "Name cannot be empty";
    if (name.length < 3) return "Name cannot be short";
  }

  Map serialize() => {'name': name};
  static Item deserialize(json) => new Item()..name = json['name'];
}
{% endprettify %}

## index.dart

This is the complete implementation for the client program.
The only code that is specific to the App Engine Dart runtime
is the data type used for each item in the list: `Item`.
This class is backed by a `Model`,
which allows objects of this type to be placed in the gcloud datastore.
The highlighted code shows how to create an Item with a name,
serialize and deserialize it, and validate it.

Here is the
<a href="https://github.com/dart-lang/appengine_samples/blob/master/clientserver/web/index.dart">index.dart</a>
file in its entirety.

{% prettify dart %}
import 'dart:async';
import 'dart:convert';
import 'dart:html';

import 'model.dart';

var nameInput;
var itemsTable;
var errorMessage;

void main() {
  querySelector("#create")
      ..onClick.listen(onCreate);
  nameInput = querySelector("#name");
  itemsTable = querySelector("#items");
  errorMessage = querySelector("#error_text");
  
  restGet('/items').then((result) {
    result.forEach((json) => addItem(Item.deserialize(json)));
  });
}

void addItem(Item item) {
  var row = new TableRowElement();
  var cell = new TableCellElement();
  cell.text = item.name;
  row.children.add(cell);
  itemsTable.children.add(row);  
}

void onCreate(MouseEvent event) {
  var item = new Item()..name = nameInput.value;
  var error = item.validate();
  if (error != null) {
    window.alert(error);
  } else {
    restPost('/items', item.serialize()).then((result) {
      if (!result['success']) {
        errorMessage.text = 'Server error: ${result['error']}';
      } else {
        errorMessage.text = '';
        addItem(item);
      }
    });
  }
}

Future restGet(String path) {
  return HttpRequest.getString(path).then((response) {
    var json = JSON.decode(response);
    if (json['success']) {
      errorMessage.text = '';
      return json['result'];
    } else {
      errorMessage.text = 'Server error: ${json['error']}';
    }
  });
}

Future restPost(String path, json) {
  return HttpRequest.request(path, method: 'POST', sendData: JSON.encode(json))
      .then((HttpRequest request) {
        return JSON.decode(request.response);
      });
}
{% endprettify %}

## What next?

* If you are interested in how the server code works, check out
<a href="server-code.html">The Server Code Explained</a>.
The server interacts with the App Engine Dart runtime to provide
responses to HTTP requests.

* Or, go straight to
<a href="../deploy.html">Deploy a Dart Application on App Engine</a>.
