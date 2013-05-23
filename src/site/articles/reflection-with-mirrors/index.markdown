---
layout: default
title: "Reflection in Dart with Mirrors: An Introduction"
rel:
  author: gilad-bracha
description: "An introduction to reflection in Dart,
              which is based on the concept of mirrors."
has-permalinks: true
article:
  written_on: 2013-05-22
  collection: libraries-and-apis
---

# {{ page.title }}

_Written by Gilad Bracha <br />
May 2013_


Reflection in Dart is based on the concept of _mirrors_,
which are simply objects that reflect other objects.
In a mirror-based API,
whenever one wants to reflect on an entity,
one must obtain a separate object called a mirror. 

Mirror-based reflective APIs have substantial advantages
with respect to security, distribution, and deployment.
On the other hand,
using them is sometimes more verbose than older approaches.  

For a thorough introduction to the rationale for mirror-based reflection,
see the references at the end of this document.
However, you don’t need to delve into all that if you don’t want to;
all you really need to know about Dart’s mirror API will be covered here.  

<aside>
<div class="alert alert-warning">
<strong>Caveat 1:</strong>
Everything is subject to change and should be treated with due caution.
</div>
</aside>

At this time, only part of the planned API has been realized.
The part that exists deals with _introspection_,
the ability of a program to discover and use its own structure.
The introspection API has been largely implemented on the Dart VM.
The dart2js version is in progress and will be ready soon.  

There is also a closely related source mirror API
that is designed for compile-time reflection,
and is being used to support DartDoc.
Given this state of affairs,
we will concentrate on introspection.

The introspection API is declared in a library named `mirrors`
and is for the most part synchronous.
If you wish to experiment with reflection,
you can import dart:mirrors.

{% prettify dart %}
import 'dart:mirrors';
{% endprettify %}

<aside>
<div class="alert alert-warning">
<strong>Caveat 2:</strong>
Since the API described here works only on the Dart VM,
you will get a warning from Dart Editor
when you import the mirror library. This warning will go away 
once the dart2js implementation is complete.
In the meantime, we don’t want you to spend time and effort 
developing code
that relies on mirrors only to discover
that you cannot deploy it to the browser. 
</div>
</aside>

For the sake of illustration,
we’ll assume you’ve defined the following class:

{% prettify dart %}
class MyClass {
  int i, j;
  int sum() => i + j;

  MyClass(this.i, this.j);

  static noise() => 42;

  static var s;
}
{% endprettify %}


The easiest way to get a mirror is to call the top-level function
[reflect()](http://api.dartlang.org/dart_mirrors.html#reflect).

<aside>
<div class="alert alert-warning">
<strong>Caveat 3:</strong>
Currently, reflection works only if the reflection code
and the object being reflected are running in the same isolate.
In the future, reflection should work across isolates.
</div>
</aside>

The reflect() method takes an object and returns an
[InstanceMirror](http://api.dartlang.org/dart_mirrors/InstanceMirror.html)
on it. 

{% prettify dart %}
InstanceMirror myClassInstanceMirror = reflect(new MyClass(3, 4));
{% endprettify %}

InstanceMirror is a subclass of
[Mirror](http://api.dartlang.org/dart_mirrors/Mirror.html),
the root of the mirror hierarchy.
An InstanceMirror allows one to invoke dynamically chosen code on an object. 

{% prettify dart %}
InstanceMirror res = myClassInstanceMirror.invoke(const Symbol('sum'), []); 
// Returns an InstanceMirror on 7.
{% endprettify %}

The invoke() method takes the method name,
a list of positional arguments,
and (optionally) a map describing named arguments.

The method name must be encoded as a Symbol object.
Symbol has a constructor that takes a string. Calling the constructor with
const rather than new allows dart2js to minify all identifiers in the program, 
keeping the
generated Javascript small. A fuller explanation of why we use Symbol appears
toward the end of this article.

Suppose you want to print out all the members of a class.
You’ll need a
[ClassMirror](http://api.dartlang.org/dart_mirrors/ClassMirror.html),
which as you’d expect reflects a class.
One way to get a class mirror is from an instance mirror.

{% prettify dart %}
ClassMirror MyClassMirror = myClassInstanceMirror.type; // Reflects MyClass
{% endprettify %}

Now we can print out the names of all members of the class
reflected by `MyClassMirror`.

{% prettify dart %}
for (var m in MyClassMirror.members.values) print(MirrorSystem.getName(m.simpleName));
{% endprettify %}

ClassMirror has a getter
[members](http://api.dartlang.org/dart_mirrors/ClassMirror.html#members)
that returns a map from the names of the reflected class’ members
to mirrors on those members.
We extract the values from the map;
each of these will be a mirror on one of 
the members of MyClass. Each such mirror has a getter `simpleName`
that returns the name of the corresponding member. 
Since names are represented by symbols, we use the utility function
MirrorSystem.getName() which converts symbols back into strings.

Obviously, we know what the members of MyClass are in this case;
the point is that the `for` loop above works for any class mirror,
and therefore we can use it to print the members of any class.

{% prettify dart %}
printAllMembersOf(ClassMirror cm) {
  for (var m in cm.members.values) print(m.simpleName);
}
{% endprettify %}

A number of methods in the mirror API
return maps in a similar fashion.
The maps allow you to look up members by name,
to iterate over all the names, or to iterate over all the members.
In fact, there is a simpler way to accomplish what we just did.

{% prettify dart %}
printAllMembersOf(ClassMirror cm) {
  for (var k in cm.members.keys) print(MirrorSystem.getName(k));
}
{% endprettify %}


What if we want to invoke static code reflectively?
We can call invoke() on a ClassMirror as well.

{% prettify dart %}
MyClassMirror.invoke(const Symbol('noise'), []); // Returns an InstanceMirror on 42
{% endprettify %}

In fact, invoke() is defined in class
[ObjectMirror](http://api.dartlang.org/dart_mirrors/ObjectMirror.html),
a common superclass for mirror classes
that reflect Dart entities that have state and executable code
such as regular instances, classes, libraries, and so on.

Here is a complete example incorporating what we’ve done so far:

{% prettify dart %}
import 'dart:mirrors';

class MyClass {
  int i, j;
  void my_method() {  }
  
  int sum() => i + j;

  MyClass(this.i, this.j);
  
  static noise() => 42;
  
  static var s;
}

main() {

  MyClass myClass = new MyClass(3, 4);

  InstanceMirror myClassInstanceMirror = reflect(myClass);
  ClassMirror MyClassMirror = myClassInstanceMirror.type;
  InstanceMirror res = myClassInstanceMirror.invoke(const Symbol('sum'), []);
  print('sum = ${res.reflectee}'));
  
  InstanceMirror v = MyClassMirror.invoke(const Symbol('noise'), []);
  print('noise = ${v.reflectee}'));
  
  print('methods:');
  Map<Symbol, MethodMirror> map = MyClassMirror.methods;
  map.values.forEach((MethodMirror mm) {print(MirrorSystem.getName(mm.simpleName));});
  
  print('members:');
  for (var k in MyClassMirror.members.keys) print(MirrorSystem.getName(k));
  MyClassMirror.setField(const Symbol('s'), 91);
  print(MyClass.s);
}
{% endprettify %}

And here’s the output:

{% prettify %}
sum = 7
noise = 42
methods:
my_method
noise
sum
members:
noise
my_method
i
j
s
sum
91
{% endprettify %}

At this point we’ve shown you enough to get started.
Some more things you should be aware of follow.


<aside>
<div class="alert alert-warning">
<strong>Caveat 4:</strong>
What you deploy is often less than what you wrote.
This may interact with reflection in annoying ways. 
</div>
</aside>

Because the size of web applications needs to be kept down,
deployed Dart applications may be subject to tree shaking and minification.
_Tree shaking_ refers to the elimination of source code that isn’t called;
_minification_ refers to the compaction of the code,
which may include replacing symbols used in the original source.

Such optimizations are a fact of life in Dart,
because of the need to deploy to JavaScript.
We need to avoid downloading the entire Dart platform
with every web page written in Dart.
Tree shaking does this by detecting
what method names are actually invoked in the source code.
However, code that is invoked based on dynamically computed symbols
cannot be detected this way, and is therefore subject to elimination.

The above means that the actual code that exists at runtime
may differ from the code you had during development.
Code you only used reflectively may not be deployed.
Runtime reflection is only aware of what actually exists at
runtime in the running program.
This can lead to surprises.
For example, one may attempt to reflectively invoke a method
that exists in the source code,
but has been optimized away because no non-reflective invocations exist.
Such an invocation will result in a call to
[noSuchMethod()](http://api.dartlang.org/dart_core/Object.html#noSuchMethod).
Tree shaking has implications for structural introspection as well.
Again, what members a library or type has at runtime
may be at variance with what the source code states.

In the presence of mirrors, one could choose to be more conservative.
Unfortunately, since one can obtain mirrors for any object in an application,
all code in the application would have to be preserved,
including the Dart platform itself.
Instead, we may choose to treat such invocations
as if the method never existed in the source. 

We intend provide a reliable, portable, and straightforward mechanism
for programmers to specify that certain code
may not be eliminated by tree shaking.
The planned approach is to use metadata.

Minification also poses a challenge, which Dart's mirror system addresses
by using instances of Symbol to describe names used in the program. If we
simply used strings to refer to, say, the members of a class, the minified 
code would no longer use those same names, and reflection would fail to find
the members when used in minified code. However, class Symbol encodes strings
using the same minification scheme used by dart2js for program identifiers,
so reflection works under minification. To help dart2js optimize away the
strings, we recommend using constant Symbols as much as possible, as shown
in the code above.


The above should be enough to get you started using mirrors.
There is a good deal more to the introspection API;
you can
[explore the API](http://api.dartlang.org/dart_mirrors.html)
to see what else is there. 

We’d like to support more powerful reflective features in the future.
These would include _mirror builders_,
designed to allow programs to extend and modify themselves,
and a mirror-based debugging API as well.  


## References

Gilad Bracha and David Ungar.
_[Mirrors: Design Principles for Meta-level Facilities of Object-Oriented
Programming Languages](http://www.bracha.org/mirrors.pdf)._
In  Proc. of the ACM Conf. on Object-Oriented Programming,
Systems, Languages and Applications, October 2004.

Gilad Bracha.
_[Linguistic Reflection via Mirrors](http://www.hpi.uni-potsdam.de/hirschfeld/events/past/media/100105_Bracha_2010_LinguisticReflectionViaMirrors_HPI.mp4)._
Screencast of a lecture at HPI Potsdam in January 2010.  57 minutes.

These blog posts on mirrors may also prove useful
(and less time consuming to digest):

* Gilad Bracha.
  [Through the Looking Glass Darkly](http://gbracha.blogspot.com/2010/03/through-looking-glass-darkly.html).
* Allen Wirfs-Brock.
  [Experimenting with Mirrors for JavaScript](http://www.wirfs-brock.com/allen/posts/228).
* Gilad Bracha.
  [Seeking Closure in the Mirror](http://gbracha.blogspot.com/2012/07/seeking-closure-in-mirror.html). 
