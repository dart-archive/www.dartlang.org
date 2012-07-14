This section explains how to use
<a href="#libraries-import">import</a> (**#import**),
<a href="#libraries-source">include</a> (**#source**),
and <a href="#libraries-library">library</a> (**#library**)
directives,
which can help you
create a modular and shareable code base.
Libraries not only provide APIs,
but are a unit of privacy:
they can hide implementation details such as private variables.

<b>Every Dart app is a library</b>,
even if it doesn't use #library.

<aside>
  <div class="alert">
    <strong>Warning:</strong>
    The library system in Dart <b>will change</b>.
    This section describes how it currently works.
  </div>
</aside>


<section id="libraries-import" markdown="1">
### Using libraries

Use **#import** to
specify how a namespace from one library
is used in the scope of another library.

Dart web apps generally use the
[dart:html](http://api.dartlang.org/html.html)
library, which they import like this:

{% highlight dart %}
#import('dart:html');
{% endhighlight %}

The only required argument to #import
is a URI specifying the library.
For built-in libraries,
the URI has the special `dart:` prefix.
For other libraries,
the URI can be relative to the current directory.
(In the future,
you'll be able to specify a file on a web server.)
For example:

{% highlight dart %}
#import('dart:io');
#import('mylib/mylib.dart');
#import('../../util/utilslib.dart');
{% endhighlight %}


<section id="libraries-prefix" markdown="1">
#### Specifying prefixes

If you import two libraries that have conflicting identifiers,
then you can specify a prefix for one or both libraries.
For example, if library1 and library2 both define Element,
then you might have code like this:

{% highlight dart %}
#import('lib1/library1.dart');
#import('lib2/library2.dart', prefix:'lib2');
...
var element1 = new Element();      // Uses Element from library1.
var element2 = new lib2.Element(); // Uses Element from library2.
{% endhighlight %}

</section>
</section>


<section id="libraries-library" markdown="1">
### Implementing libraries

Use [#source](#libraries-source)
(also known as an _include directive_)
to specify the files that
are part of the current library,
and [#library](#libraries-library)
to specify that a file
implements a library.


<section id="libraries-source" markdown="1">
#### Associating a file with the current library

You can put your library's implementation into multiple .dart files
by using **#source** in the library's main .dart file.

<aside>
  <div class="alert alert-info">
    <strong>Tip:</strong>
    Included files can't have directives.
    A single file in each library
    must have all the directives (such as #import and #library)
    that the library needs.
  </div>
</aside>

For example, consider the following code:

{% highlight dart %}
// in Ballgame.dart:
#import('dart:html');

#source('Ball.dart');
#source('Util.dart');
...
main() {
  ...
}
{% endhighlight %}

In this example, Ball.dart and Util.dart are compiled into
the library Ballgame.dart.
Ballgame.dart doesn't have a #library statement,
but remember that each Dart app has an implicit library.


<section id="declaring-library" markdown="1">
#### Declaring a library

To explicitly declare a library, you use a **#library** statement.
For example:

{% highlight dart %}
#library('slider_sample');           // Declare that this is a library.

#import('dart:html');                // It uses the html library
#import('../ui_lib/view/view.dart'); // and a view library.

#source('SliderSample.dart');        // Grab the code from SliderSample.dart.
{% endhighlight %}

<aside>
  <div class="alert alert-info">
    <strong>Note:</strong>
    The string in the #library statement isn't currently used.
  </div>
</aside>

</section>

<section id="libraries-private-members" markdown="1">
#### Declaring private members

If an identifier starts with an underscore,
it's private to its library.
For example,
in the following code, the Incrementer class
has an instance variable
called `_hiddenNum`.

{% highlight dart %}
#library('HidingLibrary');

class Incrementer {
  num _hiddenNum = 0;

  void incrementNum() {
    _hiddenNum++;
  }

  void printNum() {
    print("The hidden number is $_hiddenNum");
  }
}

void main() {
  var o = new Incrementer();
  assert(o._hiddenNum == 0); // We can read _hiddenNum.
}
{% endhighlight %}

The main() method can refer to \_hiddenNum
because it's in the same library as Incrementer.
But outside its library, \_hiddenNum is invisible,
even to subclasses of Incrementer.

For example, the following code can't use \_hiddenNum
because it's in a different library from Incrementer
(which is implemented in the library at `HidingLib/hider.dart`):

{% highlight dart %}
#library('SubclassingLibrary');
#import('../HidingLib/hider.dart');

// This class is outside Incrementer's library, so it can't use _hiddenNum.
class DoubleIncrementer extends Incrementer {
  void incrementNum() {
    //_hiddenNum = _hiddenNum + 2; // Cannot resolve _hiddenNum.
    super.incrementNum();          // Must use super to increment _hiddenNum.
    super.incrementNum();
  }
}
{% endhighlight %}

</section>

<section id="libraries-summary" markdown="1">
### Summary of libraries and visibility
Use **#import** if you need to use a library,
**\#source** to pull files into a library,
and **#library** to declare that you're implementing a library.
Names prefixed with underscore (_) are private to the library.
</section>

</section>
