---
layout: default
title: "Dart Puzzlers: Chapter 2"
rel:
  author: joshua-bloch
---

# {{ page.title }}
_Written by Joshua Bloch <br />
February 2012_

<section>

The second chapter of _Java Puzzlers_ is entitled
"Puzzlers with Character," and concerns "strings,
characters, and other textual data."

<section id="toc">

#### Contents

<ol class="toc">
  <li> <a href="#11">Puzzle 11: The Last Laugh</a> </li>
  <li> <a href="#12">Puzzle 12: ABC</a> </li>
  <li> <a href="#13">Puzzle 13: Animal Farm</a> </li>
  <li> <a href="#14">Puzzle 14: Escape Rout</a> </li>
  <li> <a href="#15">Puzzle 15: Hello Whirled</a> </li>
  <li> <a href="#16">Puzzle 16: Line Printer</a> </li>
  <li> <a href="#17">Puzzle 17: Huh?</a> </li>
  <li> <a href="#18">Puzzle 18: String Cheese</a> </li>
  <li> <a href="#19">Puzzle 19: Classy Fire</a> </li>
  <li> <a href="#20">Puzzle 20: What’s My Class?</a> </li>
  <li> <a href="#21">Puzzle 21:  What’s My Class, Take 2</a> </li>
  <li> <a href="#22">Puzzle 22: Dupe of URL</a> </li>
  <li> <a href="#23">Puzzle 23: No Pain, No Gain</a> </li>
  <li> <a href="#summary">Summary</a> </li>
</ol>
</section>

<h2 id="11"> Puzzle 11: The Last Laugh </h2>

In Java, this program that appears to print `HaHa` actually prints `Ha169`.

{% pretty_code java 0 %}
public class LastLaugh {
  public static void main(String args[]) {
    System.out.print("H" + "a");
    System.out.print('H' + 'a');
  }
}
{% endpretty_code %}

The puzzler is fixed by Dart's lack of a (deficient) char type;
there is no direct Dart equivalent of the program.

In the book (_Java Puzzlers_),
the solution to this puzzle contains a related puzzle:
Can you guess what the following statement prints?

{% pretty_code java 0 %}
System.out.println("2 + 2 = " + 2+2);
{% endpretty_code %}

Translating this mini-puzzle into Dart, we get:

{% pretty_code dart 0 %}
print('2 + 2 = ' + 2+2);
{% endpretty_code %}

Both the Java and Dart versions print `2 + 2 = 22`,
which may not be what you expected.
Given Dart's support for "string interpolation,"
the easiest way to fix this puzzler would be
to eliminate the string concatenation operator from Dart.
I suspect that, after a brief period of mourning,
no one would miss it.
It's just as easy, and arguably clearer, to say:

{% pretty_code java 0 %}
print('2 + 2 = ${2 + 2}');
{% endpretty_code %}

This version does print `2 + 2 = 4`,
just as you were taught in elementary school.
String interpolation is even nicer
when you're printing the value of a variable
rather than a more complex expression,
as you can leave out the braces:

{% pretty_code java 0 %}
    print('$i bottles of beer on the wall, $i bottles of beer');
{% endpretty_code %}

Although it might seem that you'd get less compile-time checking,
Dart Editor picks up the slack.
Another reason for getting rid of
the String concatenation operator is
that it can easily lead to performance problems
(see _Effective Java_ Item 51:
_Beware the performance of string concatenation_ for details).

Note that eliminating the string concatenation operator from Dart has
no effect on the language;
it is merely a library change.
It consists
of removing the + method from the String class,
and eliminating all
uses of this method from the Dart code base.
I'm working on this as we
speak.
You can stay one step ahead of the game by eliminating uses of the
String concatenation operator from your Dart programs today.

<h2 id="12">Puzzle 12: ABC</h2>

Consider this Java program:

{% pretty_code java 0 %}
public class Abc {
  public static void main(String[] args) {
    String letters = "ABC";
    char[] numbers = { '1', '2', '3' };
    System.out.println(letters + " easy as " + numbers);
  }
}
{% endpretty_code %}

Sadly, it prints `ABC easy as [C@16f0472` (or some such),
because Java's
arrays don't override the toString method they inherit from Object.
This
trap is notorious for tripping up beginning programming students.
Translating
the program to Dart, we get:

{% pretty_code dart 0 %}
main() {
  String letters = 'ABC';
  List<String> numbers = [ '1', '2', '3' ];
  print(letters + ' easy as ' + numbers);
}
{% endpretty_code %}

or if you don't like types:

{% pretty_code dart 0 %}
main() {
  var letters = 'ABC';
  var numbers = [ '1', '2', '3' ];
  print(letters + ' easy as ' + numbers);
}
{% endpretty_code %}

Because the Dart equivalent of Java’s array is a List,
which is a full-fledged Collection,
I expected the Dart version to work just fine.
It didn’t.
It printed
`ABC easy as Object`,
essentially replicating the Java behavior.
So I
[fixed it](http://blog.sethladd.com/2012/02/pretty-print-dart-collections.html)!
Now the Dart version prints `ABC easy as [1, 2, 3]` and all is well (assuming you’re
running the "bleeding edge" build).
This is true for the VM and for DartBoard.


<h2 id="13">Puzzle 13: Animal Farm</h2>

Here’s the Java program:

{% pretty_code java 0 %}
public class AnimalFarm {
  public static void main(String[] args) {
    final String pig = "length: 10";
    final String dog = "length: " + pig.length();

    System.out.println("Animals are equal: "
                       + pig == dog);
  }
}
{% endpretty_code %}

It doesn’t print `Animals are equal: true`.
It doesn’t print
`Animals are equal: false`, either.
It just prints `false`. Why?
Because the + operator binds tighter than the == operator.
Here’s the Dart version:

{% pretty_code dart 0 %}
main() {
  final String pig = 'length: 10';
  final String dog = 'length: ' + pig.length;

  print('Animals are equal: '
        + pig == dog);
}
{% endpretty_code %}

Sadly, it fails in exactly the same fashion as the Java version.
Happily, we’re hard at work eliminating
the string concatenation operator from Dart,
killing this puzzler dead.

<h2 id="14">Puzzle 14: Escape Rout</h2>

Here’s the Java program:

{% pretty_code java 0 %}
public class EscapeRout {
  public static void main(String[] args) {
    // \u0022 is the Unicode escape for double-quote (")
    System.out.println("a\u0022.length() + \u0022b".length());
  }
}
{% endpretty_code %}

A cursory glance suggests that it should print `26`,
the number of characters between the quotation marks.
A deeper analysis suggests `16`,
as `\u0022` represents but a single character.
In fact, it prints `2`,
as the Unicode escapes are translated into the characters they represent
before the compiler parses the program into tokens.
Therefore, the program is effectively:

{% pretty_code java 0 %}
public class EscapeRout {
  public static void main(String[] args) {
    // " is the Unicode escape for double-quote (")
    System.out.println("a".length() + "b".length());
  }
}
{% endpretty_code %}

Here’s the program translated into Dart:

{% pretty_code dart 0 %}
main() {
  // \u0022 is the Unicode escape for double-quote (")
  print("a\u0022.length + \u0022b".length);
}
{% endpretty_code %}

It prints `14` as per the "deeper analysis" above.
Why 14 instead of 16?
Because Dart doesn’t use parens to get the length of an array.
But the key point is that Dart _does_ support Unicode escapes,
but _doesn’t_ accept them everywhere and
process them early in the compilation process as Java does.

<h2 id="15">Puzzle 15: Hello Whirled</h2>

Here’s the original Java program,
which would appear to print `Hello world`:

{% pretty_code java 0 %}
/**
 * Generated by the IBM IDL-to-Java compiler, version 1.0
 * from F:\TestRoot\apps\a1\units\include\PolicyHome.idl
 * Wednesday, June 17, 1998 6:44:40 o'clock AM GMT+00:00
 */
public class Test {
  public static void main(String[] args) {
    System.out.print("Hell");
    System.out.println("o world");
  }
}
{% endpretty_code %}

Sadly, it doesn’t compile,
due to a malformed Unicode escape.
Where is it?
In the comment, of course.
It’s hidden in the file name: `\units`.
As soon as the compiler sees a character that
isn’t a hex digit after the `\u`, it’s all over.
You might think the compiler would ignore Unicode escapes in comments,
but it doesn’t know it’s in a comment
because it hasn’t parsed the program yet.

Here’s the (rough) Dart equivalent:

{% pretty_code dart 0 %}
/**
 * Generated by the IBM IDL-to-Java compiler, version 1.0
 * from F:\TestRoot\apps\a1\units\include\PolicyHome.idl
 * Wednesday, June 17, 1998 6:44:40 o'clock AM GMT+00:00
 */
main() {
  print("Hell");
  print("o world");
}
{% endpretty_code %}

This program prints:

    Hell
    o world

demonstrating that Dart has fixed the puzzler.
It does, however,
raise the issue that Dart doesn’t have a way to print a string
without a trailing newline character.
Because Dart is designed
primarily as a web programming language,
console support is minimal.
But there’s no reason it has to stay that way.
I hope to provide a proper console facility some day.

<h2 id="16">Puzzle 16: Line Printer</h2>

Here’s the Java program,
which looks like it ought to print a
couple of newline characters:

{% pretty_code java 0 %}
public class LinePrinter {
  public static void main(String[] args) {
    // Note: \u000A is Unicode representation of linefeed (LF)
    char c = 0x000A;
    System.out.println(c);
  } 
}
{% endpretty_code %}

Sadly, it doesn’t compile,
as the Unicode escape in the single-line comment (\u000A)
terminates the comment,
leaving the remainder of the line as garbage in the program.
This is very similar to what happened in the previous puzzle,
except that the Unicode escape is well-formed.
Here’s the Dart version:

{% pretty_code dart 0 %}
main() {
  // Note: \u000A is Unicode representation of linefeed (LF)
  int c = 0x000A;
  print(new String.fromCharCodes([c]));
}
{% endpretty_code %}

It prints two newline characters,
exactly as you’d expect.
Its verbosity does suggest that String should perhaps have
a constructor that takes a single char code,
but hey, we can fix that.


<h2 id="17">Puzzle 17: Huh?</h2>

Here’s the Java program
(and I hope you have your barf bag near at hand):

{% pretty_code java 0 %}
\u0070\u0075\u0062\u006c\u0069\u0063\u0020\u0020\u0020\u0020
\u0063\u006c\u0061\u0073\u0073\u0020\u0055\u0067\u006c\u0079
\u007b\u0070\u0075\u0062\u006c\u0069\u0063\u0020\u0020\u0020
\u0020\u0020\u0020\u0020\u0073\u0074\u0061\u0074\u0069\u0063
\u0076\u006f\u0069\u0064\u0020\u006d\u0061\u0069\u006e\u0028
\u0053\u0074\u0072\u0069\u006e\u0067\u005b\u005d\u0020\u0020
\u0020\u0020\u0020\u0020\u0061\u0072\u0067\u0073\u0029\u007b
\u0053\u0079\u0073\u0074\u0065\u006d\u002e\u006f\u0075\u0074
\u002e\u0070\u0072\u0069\u006e\u0074\u006c\u006e\u0028\u0020
\u0022\u0048\u0065\u006c\u006c\u006f\u0020\u0077\u0022\u002b
\u0022\u006f\u0072\u006c\u0064\u0022\u0029\u003b\u007d\u007d
{% endpretty_code %}

If you have any doubts that it’s a legitimate Java program copy it,
paste it into a file named Ugly.java, and run it.
Nothing like this will run in Dart
because Unicode escapes are restricted to string literals.
Now isn’t that comforting?


<h2 id="18">Puzzle 18: String Cheese</h2>

Here’s the original program,
which translates a sequence of
bytes into a string and then prints every character code in the string:

{% pretty_code java %}
public class StringCheese {
  public static void main(String args[]) {
    byte bytes[] = new byte[256];
    for(int i = 0; i < 256; i++)
      bytes[i] = (byte)i;
    String str = new String(bytes);
    for(int i = 0, n = str.length(); i < n; i++)
      System.out.print((int)str.charAt(i) + " ");
  }
}
{% endpretty_code %}

You might expect it to print the byte values it started with,
but the behavior turns out to be unspecified.
It depends on the Java Runtime Environment’s _default charset_.
This program has no equivalent in Dart,
as Dart does not (yet) have facilities for
translating byte sequences into Unicode character sequences.
If and when Dart does acquire such facilities, rest assured:
they will not rely on an unspecified default charset.
Actually, it turns out that there is one class
that translates byte sequences to char sequences
and that has a default encoding: StringInputStream.
Currently the default encoding is not specified,
but we _will_ fix this.


<h2 id="19">Puzzle 19: Classy Fire</h2>

Here’s the Java program,
which appears to classify characters:

{% pretty_code java %}
public class Classifier {
  public static void main(String[] args) {
    System.out.println(
      classify('n') + classify('+') + classify('2'));
  }

  static String classify(char ch) {
    if ("0123456789".indexOf(ch) >= 0)
      return "NUMERAL ";
    if ("abcdefghijklmnopqrstuvwxyz".indexOf(ch) >= 0)
      return "LETTER ";
/*
 *      if ("+-*/&|!=".indexOf(ch) >= 0)
 *          return "OPERATOR ";
 */
      return "UNKNOWN ";
  } 
}
{% endpretty_code %}

In fact, it doesn’t compile as the multi-line comment is terminated
"accidentally" in the middle of this line:

<pre> *      if ("+-<b>*/</b>&|!=".indexOf(ch) >= 0)
               ^^</pre>

Here is the Dart equivalent:

{% pretty_code dart %}
main() {
  print(classify('n') + classify('+') + classify('2'));
}

String classify(String ch) {
  if ('0123456789'.indexOf(ch) >= 0)
    return 'NUMERAL ';
  if ('abcdefghijklmnopqrstuvwxyz'.indexOf(ch) >= 0)
    return 'LETTER ';
<b>/*</b>
 *  (Operators not supported yet) 
 *  if ('+-<b>*/</b>&|!='.indexOf(ch) >= 0)
 *      return 'OPERATOR ';
 */
  return 'UNKNOWN ';
}
{% endpretty_code %}

This puzzler behaves exactly the same in Dart as it does in Java,
which is to say it won’t compile in Dart, either.
But that’s not such a bad thing.
The alternative, which is to have multi-line comments nest,
is no better.
This puzzle teaches the same lesson
to Dart programmers as it teaches Java programmers:
**If you must comment out code,
do it with single-line comments**,
as most IDEs do:

{% pretty_code dart %}
String classify(String ch) {
  if ('0123456789'.indexOf(ch) >= 0)
    return 'NUMERAL ';
  if ('abcdefghijklmnopqrstuvwxyz'.indexOf(ch) >= 0)
    return 'LETTER ';
<b>//</b>  (Operators not supported yet) 
<b>//</b>  if ('+-*/&|!='.indexOf(ch) >= 0)
<b>//</b>    return 'OPERATOR ';
  return 'UNKNOWN ';
}
{% endpretty_code %}

<br>
<h2 id="20">Puzzle 20: What’s My Class?</h2>

This Java puzzler can’t be be directly translated into Dart,
as Dart lacks the required reflection facilities:

{% pretty_code java 0 %}
package com.javapuzzlers;

public class Me {
  public static void main(String[] args) {
    System.out.println(
      Me.class.getName().replaceAll(".", "/") + ".class");
  }
}
{% endpretty_code %}

But the real problem has nothing to do with reflection.
The program prints <code>///////////////////.class</code>
due to surprising behavior in Java’s <code>String.replaceAll</code> method.
The first parameter is a not an ordinary string,
but a regular expression.
Luckily, this is not true of Dart’s analogous function,
as demonstrated by the following program:

{% pretty_code dart 0 %}
main() {
  print('I.like.cheese'.replaceAll('.', '/'));
}
{% endpretty_code %}

This program prints <code>I/like/cheese</code>,
just as you’d hope.


<h2 id="21">Puzzle 21:  What’s My Class, Take 2</h2>

This puzzle is similar to the previous one,
in that it uses Java’s basic reflection facilities,
but it’s really about the <code>replaceAll</code> function.
The Java program looks like it should return
the file path corresponding to the class:

{% pretty_code java 0 %}
package com.javapuzzlers;
import java.io.File;

public class MeToo {
  public static void main(String[] args) {
  System.out.println(MeToo.class.getName().
    replaceAll("\\.", File.separator) + ".class");
  }
}
{% endpretty_code %}

It works on Linux but on Windows,
it fails with a <code>StringIndexOutOfBoundsException</code>,
because the second parameter of <code>replaceAll</code> is not
an ordinary string but a <em>replacement string</em>,
as defined in the Java regex spec.

Again, we can’t exactly port the program to Dart,
because Dart lacks a reflection facility (for now),
but the underlying problem (with <code>replaceAll</code>)
has been fixed.
Also Dart has a nifty way
to suppress escape character processing in string literals:
string literals preceded with an at-sign are known as <em>raw strings</em>,
and no postprocessing of escapes or interpolation is done.
So this program prints <code>I\still\like\cheese</code>:

{% pretty_code dart 0 %}
main() {
  print("I.still.like.cheese".replaceAll('.', @'\'));
}
{% endpretty_code %}
<br>

<h2 id="22">Puzzle 22: Dupe of URL</h2>

Here’s a very strange Java program.
It looks like it shouldn’t compile, but it does.
It even runs:

{% pretty_code java 0 %}
public class BrowserTest {
  public static void main(String[] args) {
    System.out.print("iexplore:");
    http://www.google.com;
    System.out.println(":maximize");
  }
}
{% endpretty_code %}

So what does it do? Nothing much.
It just prints <code>:iexplore::maximize</code>.
Here it is ported to Dart.

{% pretty_code dart 0 %}
main() {
  print("chrome:");
  http://www.google.com;
  print(":maximize");
}
{% endpretty_code %}

Amazingly, it still compiles and runs.
Again it just prints <code>chrome:</code> and <code>maximize:</code>.
Why can you drop URLs into the middle of Java and Dart programs?
If you put the program into a syntax-highlighting IDE or text editor,
all will become apparent.
The URL is parsed as a label (<code>http:</code>)
followed by a single line comment (<code>//www.google.com;</code>).
So why is it legal to put a label at an arbitrary position
in a language without a <b>goto</b> statement?
Search me.
If it were up to me,
it wouldn’t be.
That said, this is not a very important puzzler.
I can’t imagine a serious bug popping up because this is legal.


<h2 id="23">Puzzle 23: No Pain, No Gain</h2>

Here’s a Java program that might appear to
print one of three words:
<code>Pain</code>, <code>Gain</code>,
and <code>Main</code> chosen randomly,
with equal likelihood.
But the title of the puzzle suggests that that might not be the case.

{% pretty_code java 0 %}
import java.util.*;

public class Rhymes {
  private static Random rnd = new Random();

  public static void main(String[] args) {
    StringBuffer word = null;
    switch(rnd.nextInt(2)) {
      case 1:  word = new StringBuffer('P');
      case 2:  word = new StringBuffer('G');
      default: word = new StringBuffer('M');
    }
    word.append('a');
    word.append('i');
    word.append('n');
    System.out.println(word);
  }
}
{% endpretty_code %}

In fact, the program prints the non-word <code>ain</code> every time you run it.
And why is that?
The program contains 3 (!) bugs.

First there’s a “fencepost error” in the expression <code>rnd.nextInt(2)</code>.
The argument is the <em>modulus</em>:
the random number generator returns 0 or 1, never 2.
This is a programming error, pure and simple,
not a platform problem.

Second, the switch statement is missing a break after the first two cases,
so the first two cases fall through,
and word is always set to <code>new StringBuffer('M')</code>.
Then the characters <code>a</code>, <code>i</code>, and <code>n</code>
are appended in turn.

At this point,
you might suspect that
the string buffer would contain <code>Main</code>,
but it doesn’t;
it contains <code>ain</code>.
Why? The problem is the constructor,
<code>new StringBuffer('M')</code>.
Note that the argument is a <code>char</code>,
not a <code>String</code>.
Sadly, <code>StringBuffer</code> lacks a <code>char</code> constructor.
But that’s OK;
<code>StringBuffer</code> does have an <code>int</code> constructor,
and the compiler happily and silently converts
the <code>char</code> to an <code>int</code>
(a primitive widening conversion).
And what does the <code>int</code> represent?
The <em>initial</em> capacity of the string buffer,
or the length of the <code>char</code> array backing the buffer.
But the buffer is initially empty.
So the mysterious behavior is explained.

What happens when we do a naive translation to Dart?

{% pretty_code dart 0 %}
main() {
  StringBuffer word = null;
  switch ((Math.random() * 2).toInt()) {
    case 1:  word = new StringBuffer('P');
    case 2:  word = new StringBuffer('G');
    default: word = new StringBuffer('M');
  }
  word.add('a');
  word.add('i');
  word.add('n');
  print(word);
}
{% endpretty_code %}

Of course the fencepost error remains, but that’s OK;
it’s “pilot error,” and we know enough not to make that error.
The most serious trap has been fixed in the platform:
Dart doesn’t have Java’s problematic char type.

Sadly, the fallthrough problem has not been eliminated.
If you run this program with the 2 changed to a 3 on Dartboard,
you’ll find that ⅓ of the time it prints <code>Main</code>,
and ⅔ of the time,
it fails at <em>runtime</em> with the error message
“Switch case fall-through!”
I am not thrilled with this behavior.
I have tried to convince my colleagues that
it should be a compile-time error to have
more than one statement after a sequence of case labels.
In other words, I believe the switch statement should function
much like every other control flow statement:
if you want to put multiple statements in a branch,
you should have to surround them in brackets.
I believe the fallthrough was questionable even in the ‘70s,
when the C programming language was developed,
and Java should not have propagated the mistake into the ‘90s.
I see no reason the syntax of a language developed in the new millenium
should allow a fallthrough.
And I <em>really</em> don’t understand why it’s syntactically permissible
but fails at runtime.

But wait, there’s more:
If you run the program on the VM,
you’ll find that it <em>always</em> prints <code>Main</code>,
whether or not you put break statements after each case!
Why?
Because there is (currently) no way to seed the random number generator,
and it always uses the same seed.
But don’t worry,
this will definitely be fixed.
I intend to provide
a proper pseudorandom number generator facility
with reasonable default seeding, manual seeding, multiple instances,
multiple implementations,
and proper support for integers (not just doubles).
Oh, one more thing about the behavior of this program under the VM:
if you put the body of the main method in a loop,
you’ll see that the runtime fallthrough behavior is
slightly different in the VM and on Dartboard:
in the VM, you get a
<a href="http://api.dartlang.org/dart_core/FallThroughError.html">“Switch
case fall-through” exception</a>
(with stack trace) at runtime,
rather a simple error message.


<h2 id="summary">Summary</h2>

That’s it for Chapter 2. 
Now the moment you’ve all been waiting for:
how does Dart stack up against Java?

Well, the chapter has 13 puzzles.
Nine are clear wins for Dart,
in that the trap has been eliminated
(11, 12, 14, 15, 16, 17, 18, 20, and 21).
One trap will be eliminated from Dart
when ongoing work is complete (13).
Two haven't been fixed,
but aren't really worth fixing either (19 and 22).
And one (23) is every bit as bad in Dart as it was in Java.
But with a little luck, maybe we'll fix it.
See you soon for another chapter of Puzzler fun.

{% include syntax-highlighting.html %}
