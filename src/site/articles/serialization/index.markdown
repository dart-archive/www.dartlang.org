---
layout: article
title: "Serialization in Dart"
description: "Choose the right serialization strategy for your project."
rel:
  author: nicolas-garnier
has-permalinks: true
article:
  written_on: 2015-01-30
  collection: libraries-and-apis
---

{% include toc.html %}
{% include breadcrumbs.html %}

# {{ page.title }}

<em>Written by Nicolas Garnier<br />
<time pubdate date="2015-01-30">January 2015</time>
</em>

Being able to serialize and deserialize objects is a common task in web apps.
Serialization, though it appears simple at first,
can be a tricky topic and there is no one-size-fits-all solution.
This article provides an overview of
serialization strategies for Dart developers.
You will learn how to evaluate, choose, and implement
a serialization solution that best fits your app.

First, identify your criteria in order to
choose the serialization technology that's the most appropriate.
Here is a list of criteria that will have an impact
on your choice of a serialization library,
along with examples of how they could apply to your project:

Object complexity:

* Simple:
  All of the objects to be serialized are
  [Data Transfer Objects](http://en.wikipedia.org/wiki/Data_transfer_object)
  with a no-argument constructor and only public attributes.

* Complex:
  Some or all of the objects to be serialized have cycle dependencies,
  can't be created with no-argument constructors,
  or have special setter methods.

Serialization format:

* Predefined:
  You must to use a specific serialization data format, like
  "[Simple JSON](#simple-json)" or
  [Protocol Buffers](https://developers.google.com/protocol-buffers/).
* Open:
  You are free to use your own serialization format because
  you control both the emitting (serializing) and
  receiving (deserializing) systems.

Cross language support:

* Required:
  You need cross-language support.
* Not required:
  Both the serializing and deserializing system are written in Dart.

Browser Support:

* Required: You need to serialize/deserialize in the browser (when Dart is
  compiled to JavaScript) and therefore small generated JavaScript code size is
  important.
* Not Required: Your app only runs on the Dart Standalone VM (server or a
  command-line tool).

Data format stability:

* Stable format: You need a stable, well defined data format that won't change
  over time.
* Open: The data is just serialized for transient operations.

Now here are a few common use cases:

* Sending objects between a Dart web client and a Dart server
* Passing Objects to dynamically loading code via
  [isolates](https://api.dartlang.org/apidocs/channels/stable/dartdoc-viewer/dart:isolate)
* Communication with an external system/API/Web Service
* Storing Objects in a database

Even in these common scenarios, the requirements can vary.
This is why we're not going to prescribe a particular solution,
but instead give you the tools to find
the best option that works for you.

Identifying your criteria is important because
no serialization library or data format works in every scenario.
Some criteria are even mutually exclusive;
for instance [Simple JSON](#simple-json) cannot represent
objects with circular dependencies.

Now that you've listed the criteria that apply to your project
you can match them with the pros and cons of
Dart serialization packages and
try to find an appropriate match.


## Serialization packages comparison

We'll focus on three Dart libraries used for serialization and
explain for which use cases they're a good fit:
The [dartson package](https://github.com/eredo/dartson),
the [serialization package](https://pub.dartlang.org/packages/serialization)
and [Protocol Buffers](https://github.com/dart-lang/dart-protobuf).
Of course, there may be other compelling options in
[pub.dartlang.org](http://pub.dartlang.org/) so we
encourage you to evaluate all available options.
We're focusing on these as they
all offer static serialization rules code generation and
don't only rely on Mirrors
(although some also provide a mirror-based implementation).
Mirrors should not be used on code running in the browser
as its dynamic nature more or less disables
dart2js tree-shaking ability
which dramatically increases the generated output code size.

### dartson package

Recommended use cases:
**Communicating with a webservice using Simple JSON as the data format,
Communication between backend and frontend written in different languages.**

_Disclaimer: Dartson is not an official Google Project._

Dartson allows to serialize/deserialize to/from
[Simple JSON](#simple-json).
There are several packages out there offering
Simple JSON serialization
however a significant advantage of Dartson is that
it can be used without Mirrors.
It does that by providing a
[Transformer](/tools/pub/assets-and-transformers.html)
that generates static serialization rules whereas
other libraries only have a Mirrors-based implementation.
This is a huge advantage for client code that is
trans-compiled to JavaScript because
using Mirrors comes with a significant size penalty.
For example simple testing with a sample projects shows
a generated code size of 139KB for
the mirrors version of Dartson (with @MirrorsUsed annotations)
to 38KB for the transformers version.

Another great point:
the library allows you to use its Mirrors based
implementation—allowing easy and convenient development—while
the transformer makes sure the Mirror based implementation
is replaced by the statically generated rules at build-time.

Have a look at [a short step-by-step how to for
Dartson](#dartson).

Pros

* Supports the common [Simple JSON](#simple-json) serialization.
* Small generated code size compared to other options.
* Still allows you to use Mirrors during development
  (no need to wait-for-build).
* Good cross-language support:
  Lots of [Simple JSON](#simple-json)
  libraries available in other programming languages.

Cons

* Have to know the Class to serialize into.
* Can't be used to serialize complex Classes.
  For instance: cycle dependencies,
  attributes definitions using abstract classes,
  no default constructors,
  inheritance can be lost.

If you are looking for alternative libraries that work with Simple JSON,
here are a few which are all using the Mirrors API,
and thus should only be used on the Dart VM:

* [Json Object](https://github.com/chrisbu/dartwatch-JsonObject)
* [Exportable](https://github.com/Leksat/dart-exportable)
* [Jsonx](https://pub.dartlang.org/packages/jsonx)


### Serialization package

Recommended use cases:
**Passing Objects to dynamically loading code via Isolates,
Sending Objects between a Dart client and a Dart server.**

_Disclaimer:
The Serialization package is a community contribution from Google but
it's not part of the Dart SDK._

The Serialization package offers a powerful
serialization and deserialization mechanism whose goal is
to allow (de)serialization of complex arbitrary objects
(although currently some limitations still apply).
By default it uses a custom Map/JSON-based representation.
It's a good choice when you are in control of the serialization format
as it handles the following cases transparently:

* Object graphs with relationships, including cycles
* Inheritance
* Final fields
* Objects with constructors
* Private fields with getter/setter pair
* Don't know ahead of time which Class the serialized data maps into

The Serialization package is pluggable to some extent so
you can customize the serialization format.
For instance it can serialize to Simple JSON (but not deserialize)
but it's best used with its default format
which makes it a Dart-only option.
Also, it's preferable to use the Serialization package for
transient operations as the serialized format depends on
the current Serialization configuration and
could change from one build to the other
(for example if you add a new serialization rule).

Have a look at [a short step-by-step how to for
Serialization](#serialization).

Pros

* Can serialize most complex objects.
* Pluggable so you can define custom output formats.
  Supports the common [Simple JSON](#simple-json) serialization format
  (but not for deserialization).
* Small generated code size compared to other options using Mirrors.

Cons

* Dart-only technology and works best with own data format.
* Data format is not well defined and stable.
  Best for transient operations only.


### Protobuffer package

Recommended use cases:
**Persisting Objects to database,
Communicating with a webservice using Protobuffers as the data format,
Communication between backend and frontend written in different languages.**

_Disclaimer:
The Protobuffer package is a community contribution from Google but
it's not part of the Dart SDK._

[Protocol Buffers](https://developers.google.com/protocol-buffers/) (Protobuf)
are great to allow cross-language interoperability.
You will find protobuf code generators [for most common
languages](https://github.com/google/protobuf/wiki/Third-Party-Add-ons).
It also offers a very compact binary format as well as
a JSON-based human readable format.
The data is clearly described in proto files—which
are basically interface descriptions—allowing
convenient generation of serialization rules and Data Transfer Objects.

On the other hand, Protobuf are not very flexible as
you are bound to use a fixed set of [base
types](https://developers.google.com/protocol-buffers/docs/proto#scalar) and
newly defined and generated classes.
For instance you won't be able to use
Dart's DateTime directly in your serializable objects since
only new Classes generated by protoc can be serialized.

To use protobuf you'll need to generate
a data transfer Dart Class using the
[Protobuf compiler](https://github.com/google/protobuf) and
its [Dart plugin](https://github.com/dart-lang/dart-protoc-plugin)
from a given proto file.
If you are interacting with a system that is providing data as protobuf
it should be providing the proto file.

The generated code does not use Mirrors and
therefore a good fit for client side code.

Have a look at [a short step-by-step how to for
Protobuf](#protobuf).

Pros

* Supports the [Protocol
  Buffers](https://developers.google.com/protocol-buffers/)
  serialization format.
* Small generated code size compared to other options using Mirrors.
* Very good cross-language support.
* Well defined, stable and backward compatible format.

Cons

* Have to know the Class to serialize into.
* Can't be used to serialize into pre-defined Dart classes.
  The DTOs are entirely generated by the protoc compiler.


### Simple JSON? {#simple-json}

We use "Simple JSON" throughout this article to refer to
the default object JSON serialization representation used in JavaScript.
When using JSON in JavaScript object are serialized by default to
a Map of their attributes with certain special cases
(for example a JavaScript Date is represented by an ISO8601 String).

We are calling this "Simple JSON" and not just "JSON",
which is often used for this serialization technique,
in order to differentiate it with other JSON based serialization formats
(for instance Protobuf has a JSON based representation).

While pretty straightforward to do in JavaScript
as attributes have no types and there are no typed Object definitions
this technique has been adapted for typed languages
so that the type of the attributes can be inferred from
the class definition when deserializing.

Following that technique a Person object using
the following Dart class definition:

{% prettify dart %}
class Person {
  int id;
  String name;
  DateTime dateOfBirth;
  List<Person> children;
}
{% endprettify %}

And instantiated as:

{% prettify dart %}
Person bob = new Person()
  ..id = 123
  ..name = "Bob Dole"
  ..dateOfBirth = new DateTime(1980, 3, 16)
  ..children = [
new Person()
  ..id = 228
  ..name = "Jerome Dole"
  ..dateOfBirth = new DateTime(2013, 1, 19),
new Person()
  ..id = 201
  ..name = "Sarah Dole"
  ..dateOfBirth = new DateTime(2011, 4, 9)];
{% endprettify %}

Would, for instance, be serialized to this "Simple JSON" String:

{% prettify json %}
{
    "id": 123,
    "name": "Bob Dole",
    "dateOfBirth": "1980-03-16T00:00:00Z",
    "children": [{
        "id": 228,
        "name": "Jerome Dole",
        "dateOfBirth": "2013-01-19T00:00:00Z"
    },
    {
        "id": 201,
        "name": "Sarah Dole",
        "dateOfBirth": "2011-04-09T00:00:00Z"
    }]
}
{% endprettify %}

The opposite operations—deserialization—would
recreate identical Person objects as _jeremy, sandra _and_ bob_;
given we know we want to deserialize into a Person object.

This serialization technique is available in
many programming languages through libraries,
becoming a de-facto standard.
Some known drawbacks are:

* No ability to represent some complex objects,
  for example with circular dependencies.
* Need to know the base Class you are deserializing to.
* Not always possible to infer the type of objects when
  deserializing if the class definition is using
  abstract classes or collections without generics.
* Type of Objects with attributes using inheritance can
  be lost in serialization + deserialization process.
* Classes definitions need to be public.


## Summary

*  There are more options than just what we listed.
   Find more at
  [pub.dartlang.org](https://pub.dartlang.org)!
* "Serialization" sounds simple at first,
  but there are many things to consider
* If you are considering serialization for a web client,
  be sure the solution uses @MirrorsUsed or
  a code generator to eliminate raw Mirrors code,
  which can bloat your app.


## Step-by-step how-tos

You'll find procedures to quickly get you started on
each of the serialization libraries.
Each showcasing a simple use case of
serializing and deserializing a Person object.
These examples refer to a specific version
available at the date this article was written.
Please check if there are newer version on the packages' website.


### Dartson

<ol markdown="1">
<li markdown="1">
  Add `dartson: ">=0.1.6 <0.2.0"` as a dependency in your pubspec.yaml.
</li>

<li markdown="1">
  Add the dartson transformer to the pubspec.yaml:

{% prettify yaml %}
transformers:
- dartson
{% endprettify %}
</li>

<li markdown="1">
  Annotate your serializable classes with `@Entity()`. For example:

{% prettify dart %}
@Entity()
class Person {
  int id;
  String name;
  DateTime dateOfBirth;
  List<Person> children;
}
{% endprettify %}
</li>

<li markdown="1">
  Here is some sample code to serialize/deserialize:

{% prettify dart %}
import 'package:dartson/dartson.dart';
import 'package:dartson/transformers/date_time.dart';

void main() {
  var dson = new Dartson.JSON();
  dson.addTransformer(new DateTimeParser(), DateTime);

 Person bob = new Person()
  ..id = 123
  ..name = "Bob Dole"
  ..dateOfBirth = new DateTime(1980, 3, 16)
  ..children = [
new Person()
  ..id = 228
  ..name = "Jerome Dole"
  ..dateOfBirth = new DateTime(2013, 1, 19),
new Person()
  ..id = 201
  ..name = "Sarah Dole"
  ..dateOfBirth = new DateTime(2011, 4, 9)];

  String personString = dson.encode(bob);

  print("Serialized Person: $personString"); \\ This prints: Serialized Person: {"id":123,"name":"Bob Dole","dateOfBirth":"1980-03-16 00:00:00.000","children":[{"id":228,"name":"Jerome Dole","dateOfBirth":"2013-01-19 00:00:00.000"},{"id":201,"name":"Sarah Dole","dateOfBirth":"2011-04-09 00:00:00.000"}]}

  Person deserializedPerson = dson.decode(personString, new Person());
  String allKidsName = deserializedPerson.children.fold("", (String concat, Person child) => "${child.name}, $concat");

  print("All Kids names: $allKidsName"); // This prints: All Kids names: Sarah Dole, Jerome Dole,
}
{% endprettify %}
</li>
</ol>

### Serialization

<ol markdown="1">
<li markdown="1">
  Add `serialization: ">=0.2.0 <0.3.0"` as a dependency in
  your pubspec.yaml.
</li>

<li markdown="1">
  Add the serialization transformer to the pubspec.yaml:

{% prettify yaml %}
transformers:
- serialization:
   use_annotation: true # If you annotate serializable entities with @serializable.
   files: # Or/and you can also list the files containing serializable entities.
   - bin/person.dart
   - lib/pet.dart
{% endprettify %}
</li>

<li markdown="1">
  Here is some sample code to serialize/deserialize:

{% prettify dart %}
import 'package:serialization/serialization.dart';
...

// Create Object to serialize.
Person person = new Person();
...

// Serialize to String.
var serialization = new Serialization();
Map personMap = serialization.write(person);
String personString = JSON.encode(personMap);

// De-serialize from String.
personMap = JSON.decode(personString);
Person deserializedPerson = serialization.read(personMap);
{% endprettify %}
</li>
</ol>


### Protobuf

<ol markdown="1">
<li markdown="1">
  Install the [protobuf](https://github.com/google/protobuf)'s protoc compiler
  (in Mac: "brew install protobuf")
</li>

<li markdown="1">
  Install the Dart protobuf plugin:

  * Download
    [https://github.com/dart-lang/dart-protoc-plugin](https://github.com/dart-lang/dart-protoc-plugin)
  * Run: `pub install && make build-plugin`
  * Add `out/protoc-gen-dart` to PATH
</li>

<li markdown="1">
  Write a .proto file or use an existing one
  provided by the API you are communicating with.
  It describes the data types.
  For example here is a simple proto file for a Person:

{% prettify %}
message Person {
    required int32 id = 1;
    required string name = 2;
    required uint64 date_of_birth = 3;
    repeated Person children = 4;
}
{% endprettify %}
</li>

<li markdown="1">
  Add  `protobuf: ">=0.3.4 <0.4.0` as a dependency in your pubspec.yaml.
</li>

<li markdown="1">
  run: `protoc --dart_out=. person.proto`
  This generates a Dart file containing the Classes
  you should use that includes serialization and deserialization rules.
  Import the newly created file in your code.
</li>

<li markdown="1">
  Here is some sample code to serialize/deserialize:

{% prettify dart %}
import 'person.pb.dart'; // This is the file generated by `protoc`.
...

// Create Object to serialize.
Person jerome = new Person()
  ..id = 228
  ..name = "Jerome Dole"
  ..dateOfBirth = new Int64(new DateTime(2013, 1, 19).millisecondsSinceEpoch);

Person sarah = new Person()
  ..id = 201
  ..name = "Sarah Dole"
  ..dateOfBirth = new Int64(new DateTime(2011, 4, 9).millisecondsSinceEpoch);

Person bob = new Person()
  ..id = 123
  ..name = "Bob Dole"
  ..dateOfBirth = new Int64(new DateTime(1980, 3, 16).millisecondsSinceEpoch)
  ..children.add(jerome)
  ..children.add(sarah);

// Serialize to String or binary.
Uint8List personBuffer = person.writeToBuffer(); // Binary format
String personJson = person.writeToJson(); // JSON-based format
print(personJson) // This prints: {"1":123,"2":"Bob Dole","3":322009200000,"4":[{"1":228,"2":"Jerome Dole","3":1358550000000},{"1":201,"2":"Sarah Dole","3":1302300000000}]}

// De-serialize from String or binary.
Person deserializedPerson1 = new Person.fromBuffer(personBuffer);
Person deserializedPerson2 = new Person.fromJson(personJson);

String allKidsName = deserializedPerson1.children.fold("", (String concat, Person child) =>  "${child.name}, $concat");

print("All Kids names: $allKidsName"); // This prints: All Kids names: Sarah Dole, Jerome Dole,
{% endprettify %}
</li>
</ol>


## Performances comparison

For the very simple sample code (one serializable class "Person") shown above
the compiled JavaScript output for each package was:

* Dartson using Transformers: 56 KB
* Dartson using Mirrors: 133 KB
* Protobuf: 107 KB
* Serialization using Transformers: 74 KB
* Serialization using Mirrors and @MirrorUsed() annotation: 154 KB
* Serialization using Mirrors without @MirrorUsed() annotation: 785 KB<br/>

You can find the sources used [on
GitHub](https://github.com/nicolasgarnier/dart-serialization-samples).
