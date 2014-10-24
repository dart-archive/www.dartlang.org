---
layout: default
title: "Deferred Loading in Dart"
short-title: "Deferred Loading"
description: "An experimental Dart feature that allows libraries to be loaded lazily."
---

# {{page.title}}

**Contents:**
{% include default_toc.html %}

Deferred loading (also called _lazy loading_) allows an application to
load a library on demand, when (or if) it becomes needed. This technique
can be used to reduce the initial startup time of an application.

Some situations where deferred loading might be used:

* Localization&ndash;with different language translations placed in
  different libraries.
* A/B testing&ndash; with
  alternative implementations of an algorithm placed in different libraries:
  one tester uses library A, while another uses library B.
* User surveys&ndash;a randomly selected user might be asked
  to fill out a dynamically loaded survey.
* Optional screens and dialogs&ndash;functionality that a user may use
  only rarely can be loaded dynamically, such as a settings panel.

<aside class="alert alert-info" markdown="1">
**Note:** Deferred loading is available in Dart 1.6 as an
**experimental** feature. For more information, see the
[Dart specification that includes the proposed deferred loading support][].
The working details may change in future releases as this feature matures.<br>
You can file issues and requests on [dartbug.com](http://dartbug.com/new).
</aside>

## Set up

No setup is required. The language extension that supports deferred loading
is currently always on.

## A HelloWorld example

You can create a simple example to understand how deferred loading works.
These instructions create a sample project named `deferred_loading_example`.

First, create the library to be loaded lazily.
In the deferred_loading_example/lib directory,
create a hello.dart file containing a single method, `printGreeting`.
The completed hello.dart file looks like the following:

{% prettify dart %}
library deferred_loading_example.hello;

printGreeting() {
  print('Hello World, from the deferred library!');
}
{% endprettify %}

Next, in the deferred_loading_example/bin directory, create a file,
named main.dart, that contains the `main()` method.
The hello library is loaded from main.dart on startup,
but you can load a library from any Dart file, at any time.

At the top of main.dart, import the hello.dart library
using the **deferred as** version of the **import** statement.

{% prettify dart %}
import 'package:deferred_loading_example/hello.dart' deferred as hello;
{% endprettify %}

The identifier that follows **deferred as** in the import
statement (in this example, `hello`) is used to reference the
library in the code.

All that remains is to load the hello library (within `main()`)
and invoke its `printGreeting` method. Libraries are loaded
asynchronously, so the code to be executed once the library has finished
loading is placed inside of a Future's `then()` method, which is chained to
the `loadLibrary()` method.

The completed main.dart file looks like the following:

{% prettify dart %}
import 'package:deferred_loading_example/hello.dart' deferred as hello;

main() {
  hello.loadLibrary().then((_) => hello.printGreeting());
}
{% endprettify %}

That's it!

When running the example (using [pub run](/tools/pub/cmd/pub-run.html),
for example), you should see the following output:

{% prettify sh %}
$ pub run bin/main
Hello World, from the deferred library!
{% endprettify %}

## A browser-based example

The lazyloader example shows how you can set up a button to load
a library on a click.

<iframe class="running-lazyloader-frame"
        style="height:150px;width:350px;"
        src="examples/lazyloader/index.html">
</iframe>

Clicking the **Breakfast menu** button loads the
`breakfast.dart` library. Clicking **Lunch menu**
loads the `lunch.dart` library, and **Dinner menu** loads `dinner.dart`.
The menu is then displayed in the window.

[Download][] the Dart samples and unzip the file to create a
`dart-samples-master` directory. The `lazyloader` example is in 
`dart-samples-master/deferred_loading_samples/`.

The lib/breakfast.dart file, contains a single constant.

{% prettify dart %}
library lazyloader.breakfast;

const String menu = "Scrambled eggs, toast, berries, and coffee.";
{% endprettify %}

The lib/lunch.dart and lib/dinner.dart have a similar format.

The web/index.html file defines three buttons:

{% prettify html %}
<button id="show-breakfast">Breakfast menu</button>
<button id="show-lunch">Lunch menu</button>
<button id="show-dinner">Dinner menu</button>
{% endprettify %}

The web/main.dart file listens for a click to any button and
loads the corresponding library, based on the button's ID.
Here is the complete file:

{% prettify dart %}
import 'dart:html';

import "package:lazyloader/breakfast.dart" deferred as breakfast;
import "package:lazyloader/lunch.dart"     deferred as lunch;
import "package:lazyloader/dinner.dart"    deferred as dinner;

main() {
  querySelector('#show-breakfast').onClick.listen((_) {
    breakfast.loadLibrary().then(onBreakfastLoaded);
  });
  querySelector('#show-lunch').onClick.listen((_) {
    lunch.loadLibrary().then(onLunchLoaded);
  });
  querySelector('#show-dinner').onClick.listen((_) {
    dinner.loadLibrary().then(onDinnerLoaded);
  });
}

void onBreakfastLoaded(e) {
  print('breakfast loaded');
  changeMenu(breakfast.menu);
}

void onLunchLoaded(e) {
  print('lunch loaded');
  changeMenu(lunch.menu);
}

void onDinnerLoaded(e) {
  print('dinner loaded');
  changeMenu(dinner.menu);
}

void changeMenu(String menu) {
  var el = querySelector("#text_id");
  el.text = menu;
}
{% endprettify %}

You might notice that `loadLibrary` is called each time a button is clicked,
even if it has already been called on a library. As you'll see in
[fun facts](#multiple-loads), this is a reasonable approach,
as the library is loaded only once even when `loadLibrary` is called on that
file multiple times.
If you prefer, you can maintain state to ensure that `loadLibrary`
is called only once for each library.

<aside class="alert alert-info" markdown="1">
**Note:** At the time of publication, when running this example in Dartium,
the app works fine when the first library is loaded,
but it crashes Dartium when the second library is loaded. See
[issue 20605](https://code.google.com/p/dart/issues/detail?id=20605).
</aside>

## Fun facts about deferred loading

The following FAQ answers some commonly asked questions about deferred loading.

### What happens if I call `loadLibrary` more than once on the same library? {#multiple-loads}

Calling `loadLibrary` multiple times on the same library will not
load the library multiple times. The performance penalty should be
minimal.

---

### How can I determine if a library has already been loaded?

We recommend that you maintain a bit of state indicating whether the 
library has been loaded.
Alternatively, you can just call `loadLibrary` again.

---

### What if I need to use a constant from a deferred library?

First, make sure the library is loaded before using the constant.
Also, constants from the library are not seen as constants in the
importing file&ndash;they only come into existence once the deferred
library is loaded.
  
---

### Can I use types from the deferred library in the importing file?

No, they are treated as malformed types.
(Malformed types are explained in section 18.1 of the
[Dart Language spec](/docs/spec/).)
We suggest that you move the interface types to a library
imported by both the deferred library and the importing file.

---

### Where does the `loadLibrary` function come from?

When you make a deferred import, such as
`import 'lib.dart' deferred as <prefix>`,
dart implicitly inserts the `loadLibrary` function into the &lt;prefix&gt;
namespace.

There are currently no API docs for the `loadLibrary` method.

---

### How does dart2js implement deferred loading?

The dart2js compile splits the output into one main js-file,
and one additional js-file per deferred import. These additional
files contain all dependencies for that import.
If a dependency is required by several deferred imports,
it is placed in another shared js-file.

---

### Can I use deferred loading with Polymer Dart elements?

Deferred loading does not yet work with Polymer Dart. 
If you are interested in this feature, you can track
[issue 17873](https://code.google.com/p/dart/issues/detail?id=17873).

---

### Is deferred loading available for all of the Dart tools?

The dart-vm and dart2js tools fully support deferred loading,
but dart2dart does not. If you are interested, you can track
[issue 17933](https://code.google.com/p/dart/issues/detail?id=17933).

[Dart specification that includes the proposed deferred loading support]: /docs/spec/proposedDartLangSpec.pdf

[Download]: https://github.com/dart-lang/dart-samples/archive/master.zip
