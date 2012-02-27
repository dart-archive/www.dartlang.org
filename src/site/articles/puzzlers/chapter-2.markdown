---
layout: default
title: "Dart Puzzlers : Chapter 2"
rel:
  author: joshua-bloch
---

# {{ page.title }}
_Written by Joshua Bloch <br />
January 2012_

<section>

The second Chapter of Java Puzzlers is entitled
"Puzzlers with Character," and concerns "strings,
characters, and other textual data."

<section id="toc">

#### Contents

* [Puzzle 11: The Last Laugh](#11)
* [Puzzle 12: ABC](#12)
* [Puzzle 13: Animal Farm](#13)
* [Puzzle 14: Escape Rout](#14)
* [Puzzle 15: Hello Whirled](#15)
* [Puzzle 16: Line Printer](#16)
* [Puzzle 17: Huh?](#17)
* [Puzzle 18: String Cheese](#18)
* [Puzzle 19: Classy Fire](#19)

</section>

<h2 id="11"> Puzzle 11: The Last Laugh </h2>

In Java, this program, which appears to print `HaHa` actually prints `Ha88`.

{% pretty_code java %}
public class LastLaugh {
    public static void main(String args[]) {
        System.out.print("H" + "a");
        System.out.print('H' + 'a');
    }
}
{% endpretty_code %}

The puzzlers is fixed by Dart's lack of a (deficient) char
type; there is no direct Dart equivalent of the program.

In the book (Java Puzzlers), the solution to this puzzle
contains a related puzzle: Can you guess what the following statement prints?

{% pretty_code java %}
    System.out.println("2 + 2 = " + 2+2);
{% endpretty_code %}

Translating this mini-puzzle into Dart, we get:

{% pretty_code java %}
    print('2 + 2 = ' + 2+2);
{% endpretty_code %}

Both the Java and Dar versions print `2 + 2 = 22`, which may not
be what you expected. Given Dart's support for "string interpolation,"
the easiest way to fix this puzzler would be to eliminate the string
concatenation operator from Dart. I suspect that, after a brief period
of mourning, no one would miss it. It's just as easy, and arguably
clearer, to say:

{% pretty_code java %}
    print('2 + 2 = ${2 + 2}');
{% endpretty_code %}

Theis version does print "2 + 2 = 4", just as you were taught in elementary
school. String interpolation is even nicer when you're printing the value
of a variable rather than a more complex expression, as you can leave out
the braces:

{% pretty_code java %}
    print('$i bottles of beer on the wall, $i bottles of beer');
{% endpretty_code %}

It might seem that you'd get less compile-time checking, the Dart editor
picks up the slack. Another reason for getting rid of the String concatenation
operator is that it can easily lead to performance problems (see _Effective
Java Item 51: Beware the performance of string concatenation_ for details).

Note that eliminating the string concatenation operator from Dart has
no effect on the language; it is merely a library change. It consists
of removing the + method from the String class, and eliminating all
uses of this method from the Dart code base. I'm working on this as we
speak. You can stay one step ahead of the game by eliminating uses of the
String concatenation operator from your Dart programs today.

<h2 id="12">Puzzle 12: ABC</h2>

Consider this Java program:

{% pretty_code java %}
public class Abc {
    public static void main(String[] args) {
        String letters = "ABC";
        char[] numbers = { '1', '2', '3' };
        System.out.println(letters + " easy as " + numbers);
    }
}
{% endpretty_code %}

Sadly, it prints `ABC easy as [C@16f0472` (or some such), bcause Java's
arrays don't override the toString method they inherit from Object.  This
trap is notorious for tripping up beginning programming students. Translating
the program to Dart, we get:

{% pretty_code dart %}
main() {
       String letters = 'ABC';
       List<String> numbers = [ '1', '2', '3' ];
       print(letters + ' easy as ' + numbers);
}
{% endpretty_code %}

or if you don't like types:

{% pretty_code dart %}
main() {
       var letters = 'ABC';
       var numbers = [ '1', '2', '3' ];
       print(letters + ' easy as ' + numbers);
}
{% endpretty_code %}

The dart equivalent of Java’s array is a List, which is a full-fledged Collection,
so I expected the dart version to work fine just  but it didn’t. It printed
`ABC easy as Object`, essentially replicating the Java behavior. So I
[fixed it](http://blog.sethladd.com/2012/02/pretty-print-dart-collections.html)!
Now the Dart version prints `ABC easy as [1, 2, 3]` and all is well (assuming you’re
running the "bleeding edge" build). This is true for the VM and for DartBoard.

<h2 id="13">Puzzle 13: Animal Farm</h2>

Here’s the Java program:

{% pretty_code java %}
public class AnimalFarm {
    public static void main(String[] args) {
        final String pig = "length: 10";
        final String dog = "length: " + pig.length();

        System.out.println("Animals are equal: "
                           + pig == dog);
    }
}
{% endpretty_code %}

It doesn’t print `Animals are equal: true`.  It doesn’t print
`Animals are equal: false`, either.  It just prints `false`. Why?
Because the + operator binds tighter than the == operator.  Here’s the dart version:

{% pretty_code dart %}
main() {
    final String pig = 'length: 10';
    final String dog = 'length: ' + pig.length;

    print('Animals are equal: '
          + pig == dog);
}
{% endpretty_code %}

Sadly, it fails in exactly the same fashion as the Java version.
Happily, we’re hard at work eliminating the string concatenation
operator from Dart, killing this puzzler dead.

<h2 id="14">Puzzle 14: Escape Rout</h2>

Here’s the Java program:

{% pretty_code java %}
main() {
  // \u0022 is the Unicode escape for double-quote (")
  print("a\u0022.length + \u0022b".length);
}
{% endpretty_code %}

A cursory glance suggests that it should print `26`, the number
of characters between the quotation marks.  A deeper analysis
suggests `16`, as `\u0022` represents but a single character. In fact,
it prints `2`, as the Unicode escapes are translated into the characters
they represent before the compiler parses the program into tokens.
Therefore, the program is effectively:

{% pretty_code java %}
main() {
  // " is the Unicode escape for double-quote (")
  print("a".length + "b".length);
}
{% endpretty_code %}

Here’s the program translated into Dart:

{% pretty_code dart %}
main() {
  // \u0022 is the Unicode escape for double-quote (")
  print("a\u0022.length + \u0022b".length);
}
{% endpretty_code %}

It prints 14 as per the "deeper analysis" above.  Why 14 instead
of 16? Because Dart doesn’t use parens to get the length of an
array. But the key point is that Dart does support Unicode
escapes, but doesn’t accept  them everywhere and process them
early in the compilation process as Java does.

<h2 id="15">Puzzle 15: Hello Whirled</h2>

Here’s the original Java program, which would appear to print `Hello world`:

{% pretty_code java %}
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

Sadly, it doesn’t compile, as it a malformed Unicode escape.
Where is it?  In the comment, of course. It’s hidden in the
file name: `\units`. As soon as the compiler sees a character that
isn’t a hex digit after the `\u`, it’s all over.  You might think the
compiler would ignore unicode escapes in comments, but it doesn’t
know it’s in a comment because it hasn’t parsed the program yet.

Here’s the (rough) Dart equivalent:

{% pretty_code dart %}
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

demonstrating that Dart has fixed the Puzzler. It does, however,
raise the issue that Dart doesn’t have a way to print a string
without a trailing newline character. Because Dart is designed
primarily as a web programming language, console support is minimal.
But there’s no reason it has to stay that way. I hope to provide a
proper console facility some day.

<h2 id="16">Puzzle 16: Line Printer</h2>

Here’s the Java program, which looks like it ought to print a
couple of newline characters:

{% pretty_code java %}
public class LinePrinter {
  public static void main(String[] args) {
    // Note: \u000A is Unicode representation of linefeed (LF)
    char c = 0x000A;
    System.out.println(c);
  } 
}
{% endpretty_code %}

Sadly, it doesn’t compile, as the unicode escape in the single-line
comment (\u000A) terminates the comment, leaving the remainder of
the line as garbage in the program. This is very similar to what
happened in the previous puzzle, except that the Unicode escape
is well-formed.  Here’s the Dart version:

{% pretty_code dart %}
main() {
  // Note: \u000A is Unicode representation of linefeed (LF)
  int c = 0x000A;
  print(new String.fromCharCodes([c]));
}
{% endpretty_code %}

It prints two newline characters, exactly as you’d expect. Its
verbosity does suggest that String should perhaps have a constructor
that takes a single char code, but hey, we can fix that.

<h2 id="17">Puzzle 17: Huh?</h2>

Here’s the Java program (and I hope you have your barf bag near at hand):

{% pretty_code java %}
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
paste it into a file named Ugly.java, and run it.  Nothing like this
will run Dart, at it restricts the use of Unicode escapes to string
literals. Now isn’t that comforting?

<h2 id="18">Puzzle 18: String Cheese</h2>

Here’s the original program, which translates a sequence of
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

You might expect it to print the byte values it started with, but the
behavior turns out to be unspecified. It depends on the Java Runtime
Environment’s _default charset_. This program has no equivalent in Dart,
as it does not (yet) have facilities for translated byte sequences into
Unicode character sequences. If and when Dart does acquire such facilities,
rest assured: they will not rely on an unspecified default charset.

<h2 id="19">Puzzle 19: Classy Fire</h2>

Here’s the Java program, which appears to classify characters:

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
 *      (Operators not supported yet) 
 *      if ("+-*/&|!=".indexOf(ch) >= 0)
 *          return "OPERATOR "; 
 */
        return "UNKNOWN "; 
    } 
}
{% endpretty_code %}

In fact, it doesn’t compile as the multiline comment is terminated
"accidentally" in the middle of this line:

 *      if ("+-*/&|!=".indexOf(ch) >= 0)
               ^^
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
/*
 *  (Operators not supported yet) 
 *  if ('+-*/&|!='.indexOf(ch) >= 0)
 *      return 'OPERATOR ';
 */
    return 'UNKNOWN '; 
}
{% endpretty_code %}

This puzzler behaves exactly the same in Dart as it does in Java,
which is to say it won’t compile in Dart, either.  But that’s not
such a bad thing.  The alternative, which is to have multiline
comments nest, is no better.  This puzzle teaches the same lesson
to Dart programmer as it teaches Java programmers:
**If you must comment out code, do it with single-line comments**,
as most IDEs do:

{% pretty_code dart %}
String classify(String ch) {
    if ('0123456789'.indexOf(ch) >= 0)
        return 'NUMERAL ';
    if ('abcdefghijklmnopqrstuvwxyz'.indexOf(ch) >= 0)
        return 'LETTER ';
//  (Operators not supported yet) 
//  if ('+-*/&|!='.indexOf(ch) >= 0)
//     return 'OPERATOR ';
    return 'UNKNOWN '; 
}
{% endpretty_code %}

</section>

{% include syntax-highlighting.html %}
