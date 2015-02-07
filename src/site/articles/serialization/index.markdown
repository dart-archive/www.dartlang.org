---
layout: article
title: "Serialization in Dart"
description: "Choose the serialization strategy that's right for your project."
rel:
  author: nicolas-garnier
has-permalinks: true
article:
  written_on: 2015-02-09
  collection: libraries-and-apis
---

{% include toc.html %}
{% include breadcrumbs.html %}

# {{ page.title }}

<em>Written by Nicolas Garnier<br />
<time pubdate date="2015-02-09">February 2015</time>
</em>

Being able to serialize and deserialize objects is a common task in web apps.
Here are a few typical cases of using serialization:

* Communicating with an external system, API, or web service
* Storing objects in a database
* Sending objects between a Dart web client and a Dart server

This article provides an overview of
serialization strategies for Dart programs.
You will learn how to evaluate, choose, and implement
a serialization solution that best fits your app.


## Overview

After looking at many serialization options for Dart,
we reviewed three solutions in depth:

[dartson](https://pub.dartlang.org/packages/dartson)
: Simple JSON for simple objects.

[serialization](https://pub.dartlang.org/packages/serialization)
: A custom format for complex Dart objects.

[protobuf](https://pub.dartlang.org/packages/protobuf)
: Google's [protocol buffer](https://developers.google.com/protocol-buffers/)
  format.

As the following table shows,
dartson is the easiest of the three to install and use.
Unless you need to use protocol buffers or exchange complex Dart objects,
try dartson first.

|                         | dartson  | serialization | protobuf |
|-------------------------|----------|---------------|----------|
|Easy to install          | &#x2713; | &#x2713;      |
|Easy to use              | &#x2713; | &#x2713;      |
|Stable data format       | &#x2713; |               | &#x2713;
|Works with non-Dart languages | &#x2713; |          | &#x2713;
|Supports complex objects |          | &#x2713;      |
{: .table}

Other compelling options are likely to exist on
[pub.dartlang.org](http://pub.dartlang.org/),
so we encourage you to look around.
We focused on these solutions because they
don't rely on mirrors,
although some also provide a mirror-based implementation.

### Why do mirrors matter?

As a rule, avoid mirrors in code that runs in the browser.
The dynamic nature of mirrors interferes with dart2js tree-shaking,
and can dramatically increase the generated output code size.

For example, simple testing with a sample project shows
a generated code size of 139KB for
the mirrors version of dartson (with @MirrorsUsed annotations),
compared to 38KB for the non-mirrors version.
<span class="remark"> [PENDING: it says 133 & 56 down in the table]</span>


### What is simple JSON? {#simple-json}

We use _simple JSON_ throughout this article to refer to
the default object JSON serialization representation used in JavaScript.
When using JSON in JavaScript object are serialized by default to
a Map of their attributes with certain special cases
(for example a JavaScript Date is represented by an ISO8601 String).

We are calling this _simple JSON_, and not just _JSON_,
to differentiate it from other JSON-based serialization formats.
For example, protobuf has a JSON-based representation
that isn't simple JSON.

Simple JSON serialization is available in
many programming languages through libraries,
becoming a de facto standard.

<span class="remark">
  [PENDING: delete the drawbacks text that follows,
  since they are (or can be) covered in the dartson review?]
</span>

<!--p style="color: lightgray;" markdown="1" -->
<p class="delete" markdown="1">
Some known drawbacks are:
</p>

<div class="delete" markdown="1">
<!--div style="color: lightgray;" markdown="1"-->
* No ability to represent some complex objects,
  for example with circular dependencies.
* Need to know the base class you are deserializing to.
* Not always possible to infer the type of objects when
  deserializing if the class definition uses
  abstract classes or collections without generics.
* The type of objects with attributes using inheritance can
  be lost in the process of serialization and deserialization.
* Class definitions need to be public.
</div>


### What does your project need?

Here are some criteria that can affect
your choice of a serialization solution,
along with examples of how they could apply to your project.

Object complexity:

* Simple:
  All of the objects to be serialized are
  [data transfer objects](http://en.wikipedia.org/wiki/Data_transfer_object)
  (DTOs)
  with a no-argument constructor and only public attributes.

* Complex:
  Some or all of the objects to be serialized have cycle dependencies,
  can't be created with no-argument constructors,
  or have special setter methods.

Serialization format:

* Predefined:
  You must to use a specific serialization data format, like
  [simple JSON](#simple-json) or
  [protocol buffers](https://developers.google.com/protocol-buffers/).
* Open:
  You are free to use your own serialization format because
  you control both the emitting (serializing) and
  receiving (deserializing) systems.

Cross language support:

* Required:
  You need cross-language support.
* Not required:
  Both the serializing and deserializing system are written in Dart.

Browser support:

* Required: You need to serialize/deserialize in the browser (when Dart is
  compiled to JavaScript) and therefore small generated JavaScript code size is
  important.
* Not Required: Your app only runs on the Dart Standalone VM (server or a
  command-line tool).

Data format stability:

* Stable format: You need a stable, well defined data format that won't change
  over time.
* Open: The data is just serialized for transient operations.

Identifying your criteria is important because
no serialization library or data format works in every scenario.
Some criteria are even mutually exclusive;
for instance simple JSON cannot represent
objects with circular dependencies.

Now that you've listed the criteria that apply to your project
you can match them with the pros and cons of
Dart serialization packages and
try to find an appropriate match.


## Reviews

[PENDING: say something]


### dartson {#dartson-review}

Recommended use cases:

* Communication with a web service using simple JSON as the data format
* Communication between between a web client and a server written in
  different languages

<aside class="alert alert-warning">
**Disclaimer:**
Dartson is not an official Google project.
</aside>

Dartson allows serializing to and deserializing from
[simple JSON](#simple-json).
Several Dart packages offer simple JSON serialization,
but a significant advantage of dartson is that
it doesn't require mirrors.
Instead, it provides a
[transformer](/tools/pub/assets-and-transformers.html)
that generates static serialization rules, whereas
other libraries have only a mirrors-based implementation.

Another great point:
You can use dartson's mirrors-based
implementation at development time,
enabling you to avoid waiting for builds.
When you're ready to deploy,
building with the transformer replaces the mirrors-based implementation
with statically generated rules.

Pros:

* Uses the common simple JSON serialization.
* Produces smaller code size than other options.
* Still allows you to use mirrors during development
  (no need to wait for the build).
* Has good cross-language support:
  Lots of simple JSON
  libraries are available in other programming languages.

Cons:

* Must know the class to serialize into.
* Can't serialize complex classes.
  <span class="remark">[PENDING: do you serialize classes or objects?]</span>
  For example, you can't serialize objects that
  point to themselves (directly or indirectly),
  objects with attributes defined using abstract classes, and
  objects that can be created only by using constructors with arguments.
  Also, you're likely to lose inheritance information.

If you are looking for alternatives to
[dartson](#dartson-review)
that work with simple JSON,
here are a few. All use mirrors,
and thus should be used only with the Dart VM:

* [json_object](https://pub.dartlang.org/packages/json_object)
* [exportable](https://pub.dartlang.org/packages/exportable)
* [jsonx](https://pub.dartlang.org/packages/jsonx)

For more information about dartson, see these resources:

* Step-by-step how-to: [dartson example](#dartson-example)
* Source code: <https://github.com/eredo/dartson>
* Homepage: <https://pub.dartlang.org/packages/dartson>


### serialization {#serialization-review}

Recommended use case:

* Sending objects between a Dart client and a Dart server
  that are built and deployed together

<aside class="alert alert-warning">
**Disclaimer:**
The serialization package is a community contribution from Google, but
it's not part of the Dart SDK.
</aside>

The serialization package offers a powerful
serialization and deserialization mechanism whose goal is
to allow (de)serialization of complex arbitrary objects
(although currently some limitations still apply).
By default it uses a custom Map/JSON-based representation.
It can be a good choice when you are in control of the serialization format
as it handles the following cases transparently:

* Object graphs with relationships, including cycles
* Inheritance
* Final fields
* Objects with constructors
* Private fields with getter/setter pair
* Don't know ahead of time which class the serialized data maps into

The serialization package is pluggable to some extent so
you can customize the serialization format.
For instance it can serialize to simple JSON (but not deserialize)
but it's best used with its default format,
which makes it a Dart-only option.

Because the serialized format can change from one build to another—depending
on the objects you're serializing and whether you're using mirrors or not—this
package is best used for transient data,
and for clients and servers that are always built and deployed together.

Pros:

* Can serialize most complex objects.
* Pluggable, so you can define custom output formats.
* Supports the common simple JSON serialization format
  (but not for deserialization).
* Produces smaller code size than other options that use mirrors.

Cons:

* Dart-only technology.
* Works best with its own data format.
* Data format is not well-defined and stable;
  it's best for transient operations only,
  and only when both sides are built together.

For more information about the serialization package, see these resources:

* Step-by-step how-to: [serialization example](#serialization-example)
* Source code: <https://github.com/google/serialization.dart>
* Homepage: <https://pub.dartlang.org/packages/serialization>


### protobuf {#protobuf-review}

Recommended use cases:

* Persisting objects to database
* Communicating with a web service using protocol buffers as the data format
* Communication between a web client and a server written in
  different languages

<aside class="alert alert-warning">
**Disclaimer:**
The protobuf package is a community contribution from Google but
it's not part of the Dart SDK.
</aside>

[Protocol Buffers](https://developers.google.com/protocol-buffers/) (Protobuf)
are great to allow cross-language interoperability.
You will find protobuf code generators [for most common
languages](https://github.com/google/protobuf/wiki/Third-Party-Add-ons).
It also offers a very compact binary format as well as
a JSON-based human readable format.
The data is clearly described in proto files—which
are basically interface descriptions—allowing
convenient generation of serialization rules and DTOs.

On the other hand, Protobuf are not very flexible as
you are bound to use a fixed set of [base
types](https://developers.google.com/protocol-buffers/docs/proto#scalar) and
newly defined and generated classes.
For instance you won't be able to use
Dart's DateTime directly in your serializable objects since
only new classes generated by protoc can be serialized.

To use protobuf you'll need to generate
a data transfer Dart class using the
[Protobuf compiler](https://github.com/google/protobuf) and
its [Dart plugin](https://github.com/dart-lang/dart-protoc-plugin)
from a given proto file.
If you are interacting with a system that is providing data as protobuf
it should be providing the proto file.

The generated code does not use mirrors and
therefore a good fit for client-side code.

Pros:

* Supports the [Protocol
  Buffers](https://developers.google.com/protocol-buffers/)
  serialization format.
* Small generated code size compared to other options using mirrors.
* Very good cross-language support.
* Well defined, stable, and backward compatible format.

Cons:

* Have to know the class to serialize into.
* Can't be used to serialize into predefined Dart classes.
  The DTOs are entirely generated by the protoc compiler.

For more information about protobuf, see these resources:

* Step-by-step how-to: [protobuf example](#protobuf-example)
* Protocol buffer documentation:
  <https://developers.google.com/protocol-buffers/>
* protobuf package: <https://pub.dartlang.org/packages/protobuf>
* Dart plugin for protoc: <https://github.com/dart-lang/dart-protoc-plugin>


## Examples {#examples}

This section shows how to quickly get started with
each of the serialization libraries,
featuring code from examples in
[this GitHub repo](https://github.com/nicolasgarnier/dart-serialization-samples).

The examples show how to serialize and deserialize Person objects.
When defined in Dart code, the Person class looks like this:

{% prettify dart %}
class Person {
  int id;
  String name;
  DateTime dateOfBirth;
  List<Person> children;
}
{% endprettify %}

The Dart code creates Person objects like this:

{% prettify dart %}
Person jerome = new Person()
  ..id = 228
  ..name = "Jerome Dole"
  ..dateOfBirth = new DateTime(2013, 1, 19);

Person sarah = new Person()
  ..id = 201
  ..name = "Sarah Dole"
  ..dateOfBirth = new DateTime(2011, 4, 9);

Person bob = new Person()
  ..id = 123
  ..name = "Bob Dole"
  ..dateOfBirth = new DateTime(1980, 3, 16)
  ..children = (new List()..add(jerome)..add(sarah));
{% endprettify %}

Here is an example of the serialized form of the `bob` object,
using simple JSON:
<span class="remark">
  [PENDING: This doesn't match the dartson example below. E.g. the DateTimes below end in `0`, not `Z`, and they contain a space between the date and the time.]

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


### dartson {#dartson-example}

To serialize and deserialize using [dartson](#dartson-review),
follow these steps.

<ol markdown="1">
<li markdown="1">
  Edit the project's `pubspec.yaml`,
  adding a dependency on the dartson package and its transformer:

{% prettify yaml %}
...
dependencies:
  dartson: ">=0.2.0 <0.3.0"
transformers:
- dartson
{% endprettify %}
</li>

<li markdown="1">
  Annotate your serializable classes with `@Entity()`. For example:

{% prettify dart %}
@Entity()
class Person {
  ...
}
{% endprettify %}
</li>

<li markdown="1">
  Import `dartson.dart` and the libraries for any transformers you need.
  The dartson package supplies
  [DateTimeTransformer](http://www.dartdocs.org/documentation/dartson/latest/index.html#dartson/dartson-transformers-DateTime.DateTimeParser);
  you can create more transformers by subclassing
  [TypeTransformer](http://www.dartdocs.org/documentation/dartson/latest/index.html#dartson/dartson-type_transformer.TypeTransformer).

{% prettify dart %}
import 'package:dartson/dartson.dart';
import 'package:dartson/transformers/date_time.dart';
{% endprettify %}
</li>

<li markdown="1">
  Create an instance of
  [Dartson](http://www.dartdocs.org/documentation/dartson/latest/index.html#dartson/dartson.Dartson),
  and add any transformers you need:

{% prettify dart %}
var dson = new Dartson.JSON();
dson.addTransformer(new DateTimeParser(), DateTime);
{% endprettify %}
</li>

<li markdown="1">
  Serialize objects using Dartson's `encode()` method.

  For example, the following code serializes the `bob` Person object,
  along with the two Person objects that are children of `bob`:

{% prettify dart %}
String personString = dson.encode(bob);
print("Serialized Person: $personString");
{% endprettify %}

  Here's the output of that print:

{% prettify %}
Serialized Person: {"id":123,"name":"Bob Dole","dateOfBirth":"1980-03-16 00:00:00.000","children":[{"id":228,"name":"Jerome Dole","dateOfBirth":"2013-01-19 00:00:00.000"},{"id":201,"name":"Sarah Dole","dateOfBirth":"2011-04-09 00:00:00.000"}]}
{% endprettify %}
</li>

<li markdown="1">
  Deserialize objects using Dartson's `decode()` method:

{% prettify dart %}
Person deserializedPerson = dson.decode(personString, new Person());
{% endprettify %}
</li>
</ol>


### serialization {#serialization-example}

This package is still changing. See the
[serialization package page](https://pub.dartlang.org/packages/serialization)
and the
[sample repo](https://github.com/nicolasgarnier/dart-serialization-samples)
for the latest details.


### protobuf {#protobuf-example}

<ol markdown="1">
<li markdown="1">
  Install the protocol compiler, **protoc**.

  You can find instructions in the protocol buffer
  [download page](https://developers.google.com/protocol-buffers/docs/downloads).

  Or, on Mac: `brew install protobuf`
</li>

<li markdown="1">
  Install the Dart protobuf plugin:

  * Either clone the repo at
    [https://github.com/dart-lang/dart-protoc-plugin](https://github.com/dart-lang/dart-protoc-plugin),
    or download its ZIP file.
  * In the top directory of dart-protoc-plugin, run:
    `pub install && make build-plugin`.
  * Add `out/protoc-gen-dart` to your PATH.
</li>

<li markdown="1">
  Write a .proto file or use an existing one
  provided by the API you are communicating with.

  The .proto file describes the data types.
  For example, here is a simple proto file for Person objects:

{% prettify %}
message Person {
    required int32 id = 1;
    required string name = 2;
    required uint64 date_of_birth = 3;
    repeated Person children = 4;
}
{% endprettify %}

Note that it doesn't understand DateTime.
Instead, it uses a 64-bit integer for the field.
The Dart code for creating a Person object looks like this:

{% prettify %}
Person bob = new Person()
  ..id = 123
  ..name = "Bob Dole"
  ..dateOfBirth = new Int64(new DateTime(1980, 3, 16).millisecondsSinceEpoch)
  ..children.add(jerome)
  ..children.add(sarah);
{% endprettify %}
</li>

<li markdown="1">
  In your project's `pubspec.yaml` file,
  add protobuf as a dependency:

{% prettify yaml %}
dependencies:
  protobuf: ">=0.3.4 <0.4.0"
{% endprettify %}
</li>

<li markdown="1">
  Compile your .proto file:

{% prettify %}
protoc --dart_out=. person.proto
{% endprettify %}

  This generates a Dart file containing
  serialization and deserialization rules.
</li>

<li markdown="1">
  Import the newly created file in your code.

{% prettify dart %}
import 'person.pb.dart'; // This is the file generated by `protoc`.
{% endprettify %}
</li>

<li markdown="1">
  Serialize objects using one of the generated write methods,
  which you can find in the
  [GeneratedMessage class API docs](http://www.dartdocs.org/documentation/protobuf/latest/index.html#protobuf/protobuf.GeneratedMessage).

<span class="remark">[Note: I changed the code to match the repo.]</span>

{% prettify dart %}
Uint8List personBuffer = bob.writeToBuffer();
String personJson = bob.writeToJson();
{% endprettify %}
</li>

<li markdown="1">
  Deserialize objects using one of the generated constructors.
  These constructors are named like the
  [GeneratedMessage](http://www.dartdocs.org/documentation/protobuf/latest/index.html#protobuf/protobuf.GeneratedMessage) constructors.

{% prettify dart %}
Person deserializedPerson1 = new Person.fromBuffer(personBuffer);
Person deserializedPerson2 = new Person.fromJson(personJson);
{% endprettify %}
</li>
</ol>


## Performance: Size comparison

The following table shows the size of the compiled JavaScript output
for each package, using one serializable class
(Person, as described in the [Examples](#examples) section).

| Serialization technique               | Size of generated JavaScript code |
|---------------------------------------|-----------------------------------|
| **dartson** using transformers                                   | 56 KB  |
| **dartson** using mirrors                                        | 133 KB |
| **protobuf**                                                     | 107 KB |
| **serialization** using transformers                             | 74 KB  |
| **serialization** using mirrors and @MirrorUsed() annotation     | 154 KB |
| **serialization** using mirrors without @MirrorUsed() annotation | 785 KB |
{: .table .table-striped}

<span class="remark">
  [PENDING: what about the size of the serialized object?
  Would people care about that?]
</span>

You can find the source code for these examples [on
GitHub](https://github.com/nicolasgarnier/dart-serialization-samples).
<span class="remark">
  [PENDING: How did you generate the source code? Especially for the mirror
  versions of serialization?]
</span>


## Summary

* Serialization sounds simple at first,
  but there are many things to consider.
* There are more options than just what we listed.
  Find more at
  [pub.dartlang.org](https://pub.dartlang.org)!
* If you are considering serialization for a web client,
  be sure the solution uses @MirrorsUsed or
  a code generator to eliminate raw mirrors code,
  which can bloat your app.
