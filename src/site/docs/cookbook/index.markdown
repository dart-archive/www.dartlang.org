---
layout: default
title: "Dart Cookbook"
description: "Recipes and prescriptions for using Dart."
has-permalinks: true
---

# Dart Cookbook

{::options parse_block_html="true" /}
<div class="row">
<div class="col-md-4">
<div class="bs-sidebar hidden-print affix-top" role="complementary">
{::options parse_block_html="false" /}  

## Contents

1. [Strings](#strings)
    1. [Concatenating strings](#concatenating-strings)
    1. [Interpolating expressions inside strings](#interpolating-expressions-inside-strings)
    1. [Handling special characters within strings](#handling-special-characters-within-strings)
    1. [Incrementally building a string using a StringBuffer](#incrementally-building-a-string-using-a-stringbuffer)
    1. [Determining whether a string is empty](#determining-whether-a-string-is-empty)
    1. [Removing leading and trailing whitespace](#removing-leading-and-trailing-whitespace)
    1. [Changing string case](#changing-string-case)
    1. [Handling extended characters that are composed of multiple code units](#handling-extended-characters-that-are-composed-of-multiple-code-units)
    1. [Converting between characters and numerical codes](#converting-between-characters-and-numerical-codes)
    1. [Calculating the length of a string](#calculating-the-length-of-a-string)
    1. [Processing a string one character at a time](#processing-a-string-one-character-at-a-time)
    1. [Splitting a string into substrings](#splitting-a-string-into-substrings)
    1. [Determining whether a string contains another string](#determining-whether-a-string-contains-another-string)
    1. [Finding matches of a regular expression](#finding-matches-of-a-regular-expression)
    1. [Substituting strings using regular expressions](#substituting-strings-using-regular-expressions)
1. [Lists](#lists)
    1. [Creating a fixed length list](#creating-a-fixed-length-list)
    1. [Creating an immutable List](#creating-an-immutable-list)
    1. [Creating a list and initializing it with default values](#creating-a-list-and-initializing-it-with-default-values)
    1. [Copying a list](#copying-a-list)
    1. [Appending items to a list](#appending-items-to-a-list)
1. [Numbers](#numbers)
    1. [Converting a string to a number](#converting-a-string-to-a-number)
    1. [Converting a number to a string](#converting-a-number-to-a-string)
1. [JSON](#json)
    1. [Encoding JSON](#encoding-json)
    1. [Decoding JSON](#decoding-json)
1. [URIs](#uris)
    1. [Encoding and decoding fully qualified URIs](#encoding-and-decoding-fully-qualified-uris)
    1. [Parsing URIs](#parsing-uris)
    1. [Building URIs](#building-uris)
1. [Testing](#testing)
    1. [Running only a single test](#running-only-a-single-test)
    1. [Filtering which tests are run](#filtering-which-tests-are-run)
    1. [Running code before and after each test](#running-code-before-and-after-each-test)
    1. [Testing synchronous exceptions](#testing-synchronous-exceptions)
    1. [Testing for double equality](#testing-for-double-equality)
1. [HTML DOM](#html-dom)
    1. [Using CSS selectors to find DOM elements](#using-css-selectors-to-find-dom-elements)
    1. [Using CSS selectors within a limited scope](#using-css-selectors-within-a-limited-scope)
    1. [Traversing the DOM starting from a particular element](#traversing-the-dom-starting-from-a-particular-element)
    1. [Creating DOM elements](#creating-dom-elements)
    1. [Inserting child elements inside an existing DOM element](#inserting-child-elements-inside-an-existing-dom-element)
    1. [Inserting elements before or after an existing DOM element](#inserting-elements-before-or-after-an-existing-dom-element)
    1. [Cloning DOM elements](#cloning-dom-elements)
    1. [Replacing DOM elements](#replacing-dom-elements)
    1. [Removing an element from the DOM](#removing-an-element-from-the-dom)
    1. [Getting and setting DOM element attributes](#getting-and-setting-dom-element-attributes)
    1. [Getting and setting element style properties](#getting-and-setting-element-style-properties)
1. [Web UI](#web-ui)
    1. [Using a Dart expression inside HTML](#using-a-dart-expression-inside-html)
    1. [Observing a Dart variable for changes](#observing-a-dart-variable-for-changes)
    1. [Creating a bidirectional binding using text elements](#creating-a-bidirectional-binding-using-text-elements)
    1. [Creating a binding using radio buttons](#creating-a-binding-using-radio-buttons)
    1. [Creating bindings for booleans using checkboxes](#creating-bindings-for-booleans-using-checkboxes)
    1. [Selecting multiple items from a list of checkboxes using data binding](#selecting-multiple-items-from-a-list-of-checkboxes-using-data-binding)
{:.toc .nav .bs-sidenav}

{::options parse_block_html="true" /}
</div>
</div>
<div class="col-md-8"> <!-- Start of content -->
{::options parse_block_html="false" /}  

## Strings

### Concatenating strings

#### Problem

You want to concatenate strings in Dart. 

#### Solution

Use the `+` operator:

{% prettify dart %}
var fact = 'Dart ' + 'is ' + 'fun!'; // 'Dart is fun!'
{% endprettify %}

You can use the `+` operator to concatenate single-line and multi-line
strings:

{% prettify dart %}
var funnyGuys = 'Dewey ' + 'Cheatem' + 
''' and
Howe'''; // 'Dewey Cheatem and\n Howe'
{% endprettify %}

#### Discussion

You can also use adjacent string literals:

{% prettify dart %}
var fact = 'Dart '  'is '  'fun!'; // 'Dart is fun!'
{% endprettify %}

Adjacent literals work over multiple lines:

{% prettify dart %}
var fact = 'Dart '
'is '
'fun!'; // 'Dart is fun!'
{% endprettify %}


If the string fragments you wish to concatenate are already in a list, use
`join()`:

{% prettify dart %}
var film = ['The', 'Big', 'Lebowski'].join(' '); // 'The Big Lebowski'
{% endprettify %}

If you want to incrementally build a longish string from its parts, a
StringBuffer works more efficiently than string concatenation (see
_Incrementally building a string efficiently using a StringBuffer_, below).

You can also use string interpolation (see _Interpolating expressions inside
strings_, below).


### Interpolating expressions inside strings

#### Problem

You want to embed Dart code inside strings.

#### Solution

You can put the value of an expression inside a string by using
$\{expression}.

{% prettify dart %}
var favFood = 'sushi';
var whatDoILove = 'I love ${favFood.toUpperCase()}'; // 'I love SUSHI'
{% endprettify %}

You can skip the \{} if the expression is an identifier:

{% prettify dart %}
var whatDoILove = 'I love $favFood'; // 'I love sushi'
{% endprettify %}

#### Discussion

The interpolated string, `'string ${expression}` is equivalent to the
concatenation of the strings `string` and `expression.toString()`.
Consider this code:

{% prettify dart %}
var four = 4;
var seasons = 'The $four seasons'; // 'The 4 seasons'
{% endprettify %}

This is functionally equivalent to the following:

{% prettify dart %}
var seasons = 'The ' + 4.toString() + ' seasons';
// 'The 4 seasons'
{% endprettify %}

You should consider implementing a `toString()` method for classes that you
define. Here's what happens if you don't:

{% prettify dart %}
class Point {
  num x, y;
  Point(this.x, this.y);
}

var point = new Point(3, 4);
print('Point: $point'); // "Point: Instance of 'Point'"
{% endprettify %}

Probably not what you wanted. Here is the same example with an explicit
`toString()`:

{% prettify dart %}
class Point {
  ...
    
  String toString() => 'x: $x, y: $y';
}

print('Point: $point'); // 'Point: x: 3, y: 4'
{% endprettify %}

### Handling special characters within strings

#### Problem

You want to put newlines, dollar signs, or other special characters in strings.

#### Solution

Prefix special characters with a `\`.

{% prettify dart %}
  print('Wile\nCoyote'); 
  // Wile
  // Coyote
{% endprettify %}

#### Discussion

Dart designates a few characters as special, and these can be escaped:

* \n for newline, equivalent to \x0A.
* \r for carriage return, equivalent to \x0D.
* \f for form feed, equivalent to \x0C.
* \b for backspace, equivalent to \x08.
* \t for tab, equivalent to \x09.
* \v for vertical tab, equivalent to \x0B.

If you prefer, you can use `\x` or `\u` notation to indicate the special
character:

{% prettify dart %}
print('Wile\x0ACoyote');   // Same as print('Wile\nCoyote')
print('Wile\u000ACoyote'); // Same as print('Wile\nCoyote') 
{% endprettify %}

You can also use `\u{}` notation:

{% prettify dart %}
print('Wile\u{000A}Coyote'); // same as print('Wile\nCoyote')
{% endprettify %}

You can also escape the `$` used in string interpolation:

{% prettify dart %}
var superGenius = 'Wile Coyote';
print('$superGenius and Road Runner');  // 'Wile Coyote and Road Runner'
print('\$superGenius and Road Runner'); // '$superGenius and Road Runner'
{% endprettify %}

If you escape a non-special character, the `\` is ignored:

{% prettify dart %}
print('Wile \E Coyote'); // 'Wile E Coyote'
{% endprettify %}

##### Raw strings

You can turn off string interpolation by using raw strings. Prefix the starting
quote of a string with `r` to make a regular string into a raw string:

{% prettify dart %}
print(r'Wile \E Coyote');               // 'Wile \E Coyote'
print(r'$superGenius and Road Runner'); // '$superGenius and Road Runner'
{% endprettify %}

Special characters and the `$` symbol are stripped of any special meaning in raw
strings.


### Incrementally building a string using a StringBuffer

#### Problem

You want to collect string fragments and combine them in an efficient
manner.

#### Solution

Use a StringBuffer to programmatically generate a string. Consider this code
below for assembling a series of urls from fragments:

{% prettify dart %}
var data = [{'scheme': 'https', 'domain': 'news.ycombinator.com'}, 
            {'domain': 'www.google.com'}, 
            {'domain': 'reddit.com', 'path': 'search', 'params': 'q=dart'}
           ];

String assembleUrlsUsingStringBuffer(entries) {
  StringBuffer sb = new StringBuffer();
  for (final item in entries) {
    sb.write(item['scheme'] != null ? item['scheme']  : 'http');
    sb.write("://");
    sb.write(item['domain']);
    sb.write('/');
    sb.write(item['path'] != null ? item['path']  : '');
    if (item['params'] != null) {
      sb.write('?');
      sb.write(item['params']);
    }
    sb.write('\n');
  }
  return sb.toString();
}

// https://news.ycombinator.com/
// http://www.google.com/
// http://reddit.com/search?q=dart
{% endprettify %}

A StringBuffer collects string fragments, but does not generate a new string
until `toString()` is called. 

#### Discussion

Using a StringBuffer is vastly more efficient than concatenating fragments
at each step: Consider this rewrite of the above code:

{% prettify dart %}
String assembleUrlsUsingConcatenation(data) {
  var urls = '';
  for (final item in data) {
    urls += item['scheme'] != null ? item['scheme']  : 'http';
    urls += "://";
    urls += item['domain'];
    urls += '/';
    urls += item['path'] != null ? item['path']  : '';
    if (item['params'] != null) {
      urls += '?';
      urls += item['params'];
    }
    urls += '\n';
  }
  return urls;
}
{% endprettify %}

This approach produces the exact same result, but incurs the cost of
joining strings multiple times. 


##### Other StringBuffer methods

In addition to `write()`, the StringBuffer class provides methods to
write a list of strings (`writeAll()`), write a numerical character code
(`writeCharCode()`), write with an added newline (`writeln()`), and
more. The example below shows how to use these methods:

{% prettify dart %}
var sb = new StringBuffer();
sb.writeln('The Beatles:');
sb.writeAll(['John, ', 'Paul, ', 'George, and Ringo']);
sb.writeCharCode(33); // charCode for '!'.
var beatles = sb.toString(); // 'The Beatles:\nJohn, Paul, George, and Ringo!' 
{% endprettify %}


### Determining whether a string is empty

#### Problem

You want to know whether a string is empty. You tried `if (string) {...}`, but
that did not work.

#### Solution

Use `string.isEmpty`:

{% prettify dart %}
var emptyString = '';
print(emptyString.isEmpty); // true
{% endprettify %}

You can also just use `==`:

{% prettify dart %}
if (string == '') {...} // True if string is empty.
{% endprettify %}

A string with a space is not empty:

{% prettify dart %}
var space = ' ';
print(space.isEmpty); // false
{% endprettify %}

#### Discussion

Don't use `if (string)` to test the emptiness of a string. In Dart, all objects
except the boolean true evaluate to false, so `if(string)` is always false. You
will see a warning in the editor if you use an 'if' statement with a non-boolean
in checked mode.


### Removing leading and trailing whitespace

#### Problem

You want to remove spaces, tabs, and other whitespace from the beginning and
end of strings.

#### Solution

Use `string.trim()`:

{% prettify dart %}
var space = '\n\r\f\t\v';       // A variety of space characters.
var string = '$space X $space';
var newString = string.trim();  // 'X'
{% endprettify %}

The String class has no methods to remove only leading or only trailing
whitespace. You can always use a RegExp.

Remove only leading whitespace:

{% prettify dart %}
var newString = string.replaceFirst(new RegExp(r'^\s+'), ''); // 'X \n\r\f\t\v'
{% endprettify %}

Remove only trailing whitespace:

{% prettify dart %}
var newString = string.replaceFirst(new RegExp(r'\s+$'), ''); // '\n\r\f\t\v X'
{% endprettify %}


### Changing string case

#### Problem

You want to change the case of strings.

#### Solution

Use String's `toUpperCase()` and `toLowerCase()` methods: 

{% prettify dart %}
var theOneILove = 'I love Lucy';
theOneILove.toUpperCase();                           // 'I LOVE LUCY!'
theOneILove.toLowerCase();                           // 'i love lucy!'

// Zeus in modern Greek.
var zeus = '\u0394\u03af\u03b1\u03c2';               // 'Δίας'
zeus.toUpperCase();                                  // 'ΔΊΑΣ'

var resume = '\u0052\u00e9\u0073\u0075\u006d\u00e9'; // 'Résumé'
resume.toLowerCase();                                // 'résumé'
{% endprettify %}

The `toUpperCase()` and `toLowerCase()` methods don't affect the characters of
scripts such as Devanagri that don't have distinct letter cases.

{% prettify dart %}
var chickenKebab = '\u091a\u093f\u0915\u0928 \u0915\u092c\u093e\u092c'; 
// 'चिकन कबाब'  (in Devanagari)
chickenKebab.toLowerCase();  // 'चिकन कबाब'
chickenKebab.toUpperCase();  // 'चिकन कबाब'
{% endprettify %}

If a character's case does not change when using `toUpperCase()` and
`toLowerCase()`, it is most likely because the character only has one
form.


### Handling extended characters that are composed of multiple code units

#### Problem

You want to use emoticons and other special symbols that don't fit into 16
bits. How can you create such strings and use them correctly in your code? 

#### Solution

You can create an extended character using `'\u{}'` syntax:

{% prettify dart %}
var clef = '\u{1D11E}'; // 𝄞
{% endprettify %}

#### Discussion

Most UTF-16 strings are stored as two-byte (16 bit) code sequences.
Since two bytes can only contain the 65,536 characters in the 0x0 to 0xFFFF
range, a pair of strings is used to store values in the 0x10000 to 0x10FFFF
range. These strings only have semantic meaning as a pair. Individually, they
are invalid UTF-16 strings. The term 'surrogate pair' is often used to
describe these strings. 

The treble clef glyph `'\u{1D11E}'` is composed of the `'\uD834'` and
`'\uDD1E'` surrogate pair.

You can get an extended string's surrogate pair through its `codeUnits`
property:

{% prettify dart %}
clef.codeUnits.map((codeUnit) => codeUnit.toRadixString(16)); 
// ['D834', 'DD1E']
{% endprettify %}

Accessing a surrogate pair member leads to errors, and you should avoid
properties and methods that expose it:

{% prettify dart %}
print('\uD834');          // Error: '\uD834' is not a valid string.
print('\uDD1E');          // Error: '\uDD1E' is not a valid string either.
print(clef.split('')[1]); // Invalid string. Dart Editor prints '?'
print(clef[0]);           // Invalid string. Dart Editor prints '?'
{% endprettify %}

When dealing with strings containing extended characters, you should use the
`runes` getter.

To get the string's length, use `string.runes.length`. Don't use
`string.length`:

{% prettify dart %}
print(clef.runes.length);     // 1
print(clef.length);           // 2
print(clef.codeUnits.length); // 2
{% endprettify %}

To get an individual character or its numeric equivalent, index the rune list:

{% prettify dart %}
print(clef.runes.toList()[0]); // 119070 ('\u{1D11E}')
{% endprettify %}

To get the string's characters as a list, map the string runes:

{% prettify dart %}
var clef = '\u{1D11E}'; // 𝄞
var title = '$clef list:'
print(subject.runes.map((rune) => new String.fromCharCode(rune)).toList());
// ['𝄞', ' ', 'l', 'i', 's', 't', ':']
{% endprettify %}


### Converting between characters and numerical codes

#### Problem

You want to convert string characters into numerical codes and vice versa.
You want to do this because sometimes you need to compare characters in a string
to numerical values coming from another source. Or, maybe you want to split a
string and then operate on each character.

#### Solution

Use the `runes` getter to get a string's code points:

{% prettify dart %}
'Dart'.runes.toList();            // [68, 97, 114, 116]

var smileyFace = '\u263A';        // ☺
print(smileyFace.runes.toList()); // [9786], (equivalent to ['\u263A']).

var clef = '\u{1D11E}';           // 𝄞
print(clef.runes.toList());       // [119070], (equivalent to ['\u{1D11E}']).
{% endprettify %}

Use `string.codeUnits` to get a string's UTF-16 code units:

{% prettify dart %}
'Dart'.codeUnits.toList();     // [68, 97, 114, 116]
smileyFace.codeUnits.toList(); // [9786]
clef.codeUnits.toList();       // [55348, 56606]
{% endprettify %}

##### Using codeUnitAt() to get individual code units

To get the code unit at a particular index, use `codeUnitAt()`:

{% prettify dart %}
'Dart'.codeUnitAt(0);     // 68
smileyFace.codeUnitAt(0); // 9786 (the decimal value of '\u263A')
clef.codeUnitAt(0);       // 55348 (does not represent a legal string) 
{% endprettify %}

#### Converting numerical codes to strings

You can generate a new string from numerical codes using the factory
`String.fromCharCodes(charCodes)`. You can pass either runes or code units and
`String.fromCharCodes(charCodes)` can tell the difference and do the right
thing automatically:

{% prettify dart %}
print(new String.fromCharCodes([68, 97, 114, 116]));                  // 'Dart'

print(new String.fromCharCodes([73, 32, 9825, 32, 76, 117, 99, 121]));
// 'I ♡ Lucy'

// Passing code units representing the surrogate pair.
print(new String.fromCharCodes([55348, 56606]));                      // 𝄞

// Passing runes.
print(new String.fromCharCodes([119070]));                            // 𝄞
{% endprettify %}

You can use the `String.fromCharCode()` factory to convert a single rune
or code unit to a string:

{% prettify dart %}
new String.fromCharCode(68);     // 'D'
new String.fromCharCode(9786);   // ☺
new String.fromCharCode(119070); // 𝄞
{% endprettify %}

Creating a string with only one half of a surrogate pair is permitted,
but not recommended.


### Calculating the length of a string

#### Problem

You want to get the length of a string, but are not sure how to calculate the
length correctly when working with variable length Unicode characters.

#### Solution

Use `string.runes.length` to get the number of characters in a string.

{% prettify dart %}
print('I love music'.runes.length); // 12
{% endprettify %}

You can safely use `string.runes.length` to get the length of strings that
contain extended characters:

{% prettify dart %}
var clef = '\u{1D11E}';        // 𝄞
var subject = '$clef list:';   // 
var music = 'I $hearts $clef'; // 'I ♡ 𝄞'

clef.runes.length;             // 1
music.runes.length             // 5
{% endprettify %}

#### Discussion

You can directly use a string's `length` property (minus `runes`). This returns
the string's code unit length. Using `string.length` produces the same length
as `string.runes.length` for most unicode characters.

For extended characters, the code unit length is one more than the rune
length:

{% prettify dart %}
clef.length;                   // 2

var music = 'I $hearts $clef'; // 'I ♡ 𝄞'
music.length;                  // 6
{% endprettify %}

Unless you specifically need the code unit length of a string, use
`string.runes.length`.

##### Working with combined characters

It is tempting to brush aside the complexity involved in dealing with runes and
code units and base the length of the string on the number of characters it
appears to have. Anyone can tell that 'Dart' has four characters, and 'Amelié'
has six, right? Almost. The length of 'Dart' is indeed four, but the length of
'Amelié' depends on how that string was constructed:

{% prettify dart %}
var name = 'Ameli\u00E9';               // 'Amelié'
var anotherName = 'Ameli\u0065\u0301';  // 'Amelié'
print(name.length);                     // 6
print(anotherName.length);              // 7
{% endprettify %}

Both `name` and `anotherName` return strings that look the same, but where
the 'é' is constructed using a different number of runes. This makes it
impossible to know the length of these strings by just looking at them.


### Processing a string one character at a time

#### Problem

You want to do something with each character in a string.

#### Solution

Map the results of calling `string.split('')`:

{% prettify dart %}
var lang= 'Dart';

// ['*D*', '*a*', '*r*', '*t*']
print(lang.split('').map((char) => '*${char}*').toList());

var smileyFace = '\u263A';
var happy = 'I am $smileyFace';
print(happy.split('')); // ['I', ' ', 'a', 'm', ' ', '☺']
{% endprettify %}

Or, loop over the characters of a string:

{% prettify dart %}
var list = [];
for(var i = 0; i < lang.length; i++) {
  list.add('*${lang[i]}*'); 
}

print(list); // ['*D*', '*a*', '*r*', '*t*']
{% endprettify %}

Or, map the string runes:

{% prettify dart %}
// ['*D*', '*a*', '*r*', '*t*']
var charList = "Dart".runes.map((rune) {
  return '*${new String.fromCharCode(rune)}*').toList();
});

// [[73, 'I'], [32, ' '], [97, 'a'], [109, 'm'], [32, ' '], [9786, '☺']]
var runeList = happy.runes.map((rune) {
  return [rune, new String.fromCharCode(rune)]).toList();
});
{% endprettify %}

When working with extended characters, you should always map the string runes.
Don't use `split('')` and avoid indexing an extended string. See the _Handling
extended characters that are composed of multiple code units_ recipe for
special considerations when working with extended strings.


### Splitting a string into substrings

#### Problem

You want to split a string into substrings using a delimiter or a pattern.

#### Solution

Use the `split()` method with a string or a RegExp as an argument.

{% prettify dart %}
var smileyFace = '\u263A';
var happy = 'I am $smileyFace';
happy.split(' '); // ['I', 'am', '☺']
{% endprettify %}

Here is an example of using `split()` with a RegExp:

{% prettify dart %}
var nums = '2/7 3 4/5 3~/5';
var numsRegExp = new RegExp(r'(\s|/|~/)');
nums.split(numsRegExp); // ['2', '7', '3', '4', '5', '3', '5']
{% endprettify %}

In the code above, the string `nums` contains various numbers, some of which
are expressed as fractions or as int-divisions. A RegExp splits the string to
extract just the numbers.

You can perform operations on the matched and unmatched portions of a string
when using `split()` with a RegExp:

{% prettify dart %}
var phrase = 'Eats SHOOTS leaves';

var newPhrase = phrase.splitMapJoin((new RegExp(r'SHOOTS')),
  onMatch:    (m) => '*${m.group(0).toLowerCase()}*',
  onNonMatch: (n) => n.toUpperCase());

print(newPhrase); // 'EATS *shoots* LEAVES'
  
{% endprettify %}

The RegExp matches the middle word ('SHOOTS'). A pair of callbacks are
registered to transform the matched and unmatched substrings before the
substrings are joined together again.


### Determining whether a string contains another string

#### Problem

You want to find out whether a string is the substring of another string.

#### Solution

Use `string.contains()`:

{% prettify dart %}
var fact = 'Dart strings are immutable';
print(fact.contains('immutable')); // True.
{% endprettify %}

You can use a second argument to specify where in the string to start looking:

{% prettify dart %}
print(fact.contains('Dart', 2)); // False
{% endprettify %}

#### Discussion

The String class provides a couple of shortcuts for testing whether a
string is a substring of another:

{% prettify dart %}
print(string.startsWith('Dart')); // True.
print(string.endsWith('e'));      // True.
{% endprettify %}

You can also use `string.indexOf()`, which returns -1 if the substring
is not found within a string, and otherwise returns the matching index:

{% prettify dart %}
var found = string.indexOf('art') != -1; // True, `art` is found in `Dart`.
{% endprettify %}

You can also use a RegExp and `hasMatch()`:

{% prettify dart %}
var found = new RegExp(r'ar[et]').hasMatch(string);
//  True, 'art' and 'are' match.
{% endprettify %}

### Finding matches of a regular expression

#### Problem

You want to use RegExp to match a pattern in a string, and want to be
able to access the matches.

#### Solution

Construct a regular expression using the RegExp class, and find matches
using the `allMatches()` method:

{% prettify dart %}
var neverEatingThat = 'Not with a fox, not in a box';
var regExp = new RegExp(r'[fb]ox');
List matches = regExp.allMatches(neverEatingThat);
print(matches.map((match) => match.group(0)).toList()); // ['fox', 'box']
{% endprettify %}

#### Discussion

You can query the object returned by `allMatches()` to find out the
number of matches:

{% prettify dart %}
var howManyMatches = matches.length; // 2
{% endprettify %}

To find the first match, use `firstMatch()`:

{% prettify dart %}
var firstMatch = RegExp.firstMatch(neverEatingThat).group(0); // 'fox'
{% endprettify %}

To directly get the matched string, use `stringMatch()`:

{% prettify dart %}
print(regExp.stringMatch(neverEatingThat));         // 'fox'
print(regExp.stringMatch('I like bagels and lox')); // null
{% endprettify %}

### Substituting strings using regular expressions

#### Problem

You want to match substrings within a string and make substitutions
based on the matches.

#### Solution

Construct a regular expression using the RegExp class and make
replacements using `replaceAll()` method:

{% prettify dart %}
var resume = 'resume'.replaceAll(new RegExp(r'e'), '\u00E9'); // 'résumé'
{% endprettify %}

If you want to replace just the first match, use `replaceFirst()`:

{% prettify dart %}
// Replace the first match of one or more zeros with an empty string.
var smallNum = '0.0001'.replaceFirst(new RegExp(r'0+'), ''); // '.0001'
{% endprettify %}

You can use `replaceAllMapped()` to register a function that modifies the
matches:

{% prettify dart %}
var heart = '\u2661'; // '♡'
var string = 'I like Ike but I $heart Lucy';
var regExp = new RegExp(r'[A-Z]\w+');
var newString = string.replaceAllMapped(regExp, (match) {
  return match.group(0).toUpperCase()
}); 
print(newString); // 'I like IKE but I ♡ LUCY'
{% endprettify %}




## Lists

### Creating a fixed length list

#### Problem

You want to create a list but don't want to allow it's size to be
changed.

#### Solution

Pass the list size as an argument to the List constructor. This creates a
fixed-length list:

{% prettify dart %}
var fixedList = new List(3); // fixedList can have exactly 3 items.
{% endprettify %}

You cannot change the size of the list:

{% prettify dart %}
fixedList.add(2);       // UnsupportedError
fixedList.removeLast(); // UnsupportedError
fixedList.length = 10;  // UnsupportedError
{% endprettify %}

You _can_ change the values of list elements:

{% prettify dart %}
fixedList[0] = 'red';
fixedList[1] = 'green';
fixedList[2] = 'blue';
print(fixedList); // ['red', 'green', 'blue']
{% endprettify %}


### Creating an immutable List

#### Problem

Because you want to protect your data from being accidentally overwritten, you
want to use a list that cannot be changed after it is created.  You don't want
anyone to be able to modify list elements, add new elements, or remove
existing elments.

#### Solution

Create an immutable list using the reserved word 'const':

{% prettify dart %}
const List<String> vowels = const ['A', 'E', 'I', 'O', 'U'];
{% endprettify %}

A list constructed using const is a compile-time constant. Each element of a
const list must also be a compile-time constant.

{% prettify dart %}
const List<String> vowels = const ['A', 'E', 'I', 'O', 'U'];
const List<String> rgb = const ['R', 'G', 'B'];
const List<List<String>> chars = const [vowels, rgb];
{% endprettify %}

Attempting to use non-const values in a const list results in a compile-time
error:

{% prettify dart %}
// ILLEGAL.
const List<List<String>> chars = const [
    ['A', 'E', 'I', 'O', 'U'], ['R', 'G', 'B']];
{% endprettify %}

Once a const list is constructed, you cannot change its length:

{% prettify dart %}
vowels.add('Y'); // UnsupportedError
{% endprettify %}

And, you cannot modify any list element:

{% prettify dart %}
vowels[0] = 'a'; // UnsupportedError
{% endprettify %}

Two const lists are considered equal _and identical_ if they have the same
length, and the same values in the same order. In other words, const lists are
canonicalized:

{% prettify dart %}
const List<String> colors = const ['R', 'G', 'B'];    
const List<String> rgb    = const ['R', 'G', 'B']; 
      
colors == rgb;                   // true
identical(colors, rgb);          // true
colors.hashCode == rgb.hashCode; // true
{% endprettify %}


### Creating a list and initializing it with default values

#### Problem

You want to create a new list and want to assign defalt values at every position
when the list is created.

#### Solution

Use the `List.generate()` constructor. Pass it a function that generates the
fill value: 

{% prettify dart %}
var filledList = new List<bool>.generate(3, (_) => false);
print(filledList); // [false, false, false]

filledList.add(true);
print(filledList); // [false, false, false, true]
{% endprettify %}

If you want a fixed-length list, set the optional `growable` argument to
`false` (it is `true` by default):

{% prettify dart %}
var fixedAndFilled = new List<bool>.generate(3, (_) => false, growable: false);
{% endprettify %}

You can generate fill values dynamically:

{% prettify dart %}
List<List<int>> grid = new List.generate(3, (x) => [x, x + 1, x + 2]);
{% endprettify %}

The code above generates a 3 X 3 grid:

{% prettify dart %}
print(grid); // [[0, 1, 2], [1, 2, 3], [2, 3, 4]]
{% endprettify %}

#### Discussion

You will optionally use the `List.filled()` constructor to create a list and
initialize it with default values:

{% prettify dart %}
var filledList = new List<bool>.filled(3, false);
print(filledList); // [false, false, false]
{% endprettify %}

The `List.filled()` constructor has two restrictions that `List.generate()`
does not:

- You can only create fixed-length lists.
- You cannot dynamically generate fill values.

If these restrictions are not important to your code, you can use
`List.filled()` instead of `List.generate()`.


### Copying a list

#### Problem

You want to create a new list with the elements of another list.

#### Solution

Use the `List.from()` constructor and pass the original list as an argument:

{% prettify dart %}
var fruit1 = ['orange', 'banana', 'mango'];
var fruit2 = new List.from(fruit1);
{% endprettify %}

#### Discussion

The `List.from()` constructor creates a new, independent list:

{% prettify dart %}
identical(names, namesCopy); // false
{% endprettify %}

However, compound elements in the new list retain a reference to the original:

{% prettify dart %}
var names = [{'first': 'Reggie', 'last': 'Jackson'}, 
             {'first': 'Cy', 'last': 'Young'}];

var namesCopy = new List.from(names);
identical(names.first, namesCopy.first); // true
{% endprettify %}

Modifying an element in the original changes the corresponding element in the
copy (and vise versa):

{% prettify dart %}
names[0]['last'] = 'Jefferson';
print(namesCopy[0]['last']); // 'Jefferson'
{% endprettify %}

Since the lists themselves do not share a reference, adding a new element to
one does not affect the other:

{% prettify dart %}
names.add({'first' : 'Micky', 'last' : 'Mantle'});
names.length;     // 3
namesCopy.length; // 2
{% endprettify %}

##### Fixed-length vs. flexible-length lists

By default, the new list created will be growable. This is true even if you
passed a `const` list as an argument to `List.from()`:

{% prettify dart %}
const List<String> vowels1 = const ['A', 'E', 'I', 'O', 'U'];
var vowels2 = new List.from(vowels1);

vowels2.add('Y');
print(vowels2); // ['A', 'E', 'I', 'O', 'U', 'Y']

vowels2[0] = 'Y';
print(vowels2[0]); // 'Y'
{% endprettify %}

To make the copy fixed-length, set `List.from()`s `growable` argument to
`false`:

{% prettify dart %}
const List<String> vowels1 = const ['A', 'E', 'I', 'O', 'U'];
var vowelsFixed = new List.from(vowels1, growable: false);
var fruitFixed = new List.from(fruit1, growable: false);
{% endprettify %}

You can then modify an element:

{% prettify dart %}
vowelsFixed[0] = 'Y';
print(vowelsFixed[0]); 'Y'
{% endprettify %}

But you cannot add or remove elements:

{% prettify dart %}
vowelsFixed.add('Y');     // UnsupportedError
vowelsFixed.removeLast(); // UnsupportedError
{% endprettify %}


### Appending items to a list

#### Problem

You want to add items to the end of a list, and want to know the most
efficient way to do so.

#### Solution

To add one item at a time to a list, use `add()`:

{% prettify dart %}
var names = ['Seth', 'Timothy', 'John'];
names.add('Kathy');
names.add('Mary');
print(names); // ['Seth', 'Timothy', 'John', 'Kathy', 'Mary']
{% endprettify %}

If the items to be added are already in a list, you can add them all at once
using `addAll()`:

{% prettify dart %}
var names = ['Seth', 'Timothy', 'John'];
names.addAll(['Kathy', 'Mary']);
print(names); // ['Seth', 'Timothy', 'John', 'Kathy', 'Mary']
{% endprettify %}

Or, you can increase the `length` property of a list. This generates
additional entries that are initialized to null. 

{% prettify dart %}
names.length += 2; // Creates 2 more null items.
print(names);      // ['Seth', 'Timothy', 'John', null, null]
{% endprettify %}

You can then replace the `null` values with actual values:

{% prettify dart %}
var names = ['Seth', 'Timothy', 'John'];
var moreNames = ['Kathy', 'Mary'];
      
var oldLength = names.length;
names.length += 2;
      
for (var i = 0; i < moreNames.length; i++) {
  names[i + oldLength] = moreNames[i];
}

print(names); ['Seth', 'Timothy', 'John', 'Kathy', 'Mary']
{% endprettify %}

Appending items to a list by increasing the list length first is generally more
efficient than using `add()` or `addAll()`.



## Numbers

### Converting a string to a number

#### Problem

You want to parse a string and convert it to a number.

#### Solution

Use `int.parse` to convert a string to an int:

{% prettify dart %}
print(int.parse('231')); // 231
{% endprettify %}

The strings can be prefixed with a '+' or a '-':

{% prettify dart %}
print(int.parse('+231')); // 231
print(int.parse('-231')); // -231
{% endprettify %}

You can pass in the radix as a second argument:

{% prettify dart %}
print(int.parse('231', radix: 16));  // 561
print(int.parse('F34A', radix: 16)); // 62282
{% endprettify %}

Strings starting with '0x', '-0x' or '+0x' are assumed to have a radix of 16:

{% prettify dart %}
print(int.parse('0x231')); // 561
{% endprettify %}

Use `double.parse` to convert a string to a double:

{% prettify dart %}
print(double.parse('3.14')); // 3.14
{% endprettify %}

The method accepts exponential notation:

{% prettify dart %}
print(double.parse('3.14e5')); // 314000.0
{% endprettify %}

Both `int.parse` and `double.parse` throw a FormatException if they are passed
invalid arguments.


### Converting a number to a string

#### Problem

You want to convert a number to a string.

#### Solution

Use `toString()` for a no-frills number to string conversion:

{% prettify dart %}
1234.toString();   // '1234'
3.1519.toString(); // '3.1519'
{% endprettify %}

To specify the number of signficant digits, use the `toStringAsPrecision()`
method: 

{% prettify dart %}
1234.toStringAsPrecision(5);   // '1234.0'
3.1519.toStringAsPrecision(8); // '3.1519000'
{% endprettify %}

To specify the number of digits after the decimal, use `toStringAsFixed()`:

{% prettify dart %}
1234.toStringAsFixed(2);   // '1234.00'
3.1519.toStringAsFixed(2); // '3.15'
{% endprettify %}

To convert the number to decimal exponential notation, use the
`toStringAsExponential()` method: 

{% prettify dart %}
1234.toStringAsExponential();   // '1.234e+3'
{% endprettify %}

You can specify the radix when converting an integer to a string:

{% prettify dart %}
64.toRadixString(2);  // '1000000'
64.toRadixString(8);  // '100'
64.toRadixString(16); // '40'
{% endprettify %}


## JSON

JSON (JavaScript Object Notation) is a text-based format for representing
objects and collections. You can use the 'dart:json' library to decode JSON
strings into Dart objects, and encode Dart objects into JSON strings.

To use the examples in this chapter, you need to import the `dart:json`
library. We prefer to declare our import of the libary in a manner that
provides helpful namespacing for top level functions:

{% prettify dart %}
import 'dart:json' as json;

void main() {
  json.stringify( ... );
  json.parse( ... );
  ...
}
{% endprettify %}

You can read the API documentation for the dart:json library at
http://api.dartlang.org/docs/releases/latest/dart_json.html.


### Encoding JSON

#### Problem

You want to convert a Dart object into JSON.

#### Solution

Use the `stringify()` function to encode a Dart object into a JSON-formatted
string.

The following Dart objects are automatically encoded into JSON by
`stringify()`:

* int
* double
* String
* bool
* null
* List
* Map

{% prettify dart %}
import 'dart:json' as json;

void main() {
  var person = {'name': 'joe', 
                'born':  2002,
                'into': {'films' : ['crime', 'noir']},
                'aliases': []};
  
  json.stringify(person);
  // '{"name":"joe","born":2002,"into":{"films":["crime","noir"]},"aliases":[]}'
}
{% endprettify %}

Note that `stringify()` encodes List and Map objects recursively.

If an object of a type not in the list above is passed to `stringify()` as an
argument, `stringify()` calls that object's `toJson()` method:

{% prettify dart %}
import 'dart:json' as json;

class Person {
  String name;
  num age;
  
  Person(this.name, this.age);
  dynamic toJson() => {"name": name, "age": age};
}

void main() {
  var person = new Person('john', 32);
  json.stringify(person); // '"{\"name\":\"john\",\"age\":32}"'
}
{% endprettify %}

If the `toJson()` method is not defined on an object that `stringify()`
doesn't know how to handle, `stringify()` throws an exception:

{% prettify dart %}
import 'dart:json' as json;

class Book {
  String title;
  num numPages;
 
  Book(this.title, this.numPages);
}

void main() {
  var book = new Book('War and Peace', 1089);
  json.stringify(book); // json.JsonUnsupportedObjectError
}
{% endprettify %}

It is possible that `stringify()` calls `toJson()` on several objects in your
code, and throws an exception if any one of those objects lacks a `toJson()`.
Use `JsonUnsupportedObjectError`'s `cause` property to see which
object triggered the exception:

{% prettify dart %}
void main() {
  var person = new Person('john', 32);              // toJson() defined.
  var book = new Book('War and Peace', 1089);       // toJson() not defined.
  var object = {'person': person, 'reads' : book};

  try {
    json.stringify(object);
  } catch(e) {
    print(e.cause.toString());
    // "Class 'Book' has no instance method 'toJson'..."
  }
}
{% endprettify %}

### Decoding JSON

#### Problem

You want to convert a JSON string into a Dart object.

#### Solution

Use `parse()` to decode a JSON-encoded string into a Dart object:

{% prettify dart %}
import 'dart:json' as json;

void main() {
  var jsonPerson = '{"name" : "joe", "date" : [2013, 3, 10]}';
    
  var person = json.parse(jsonPerson);
  
  person['name'];         // 'joe'
  person['date'];         // [2013, 3, 10]
  person['date'] is List; // true
}
{% endprettify %}

Sometimes you want to transform the data parsed by `parse`. For
example, you may prefer to express a date field as a DateTime object, and not
as a list of numbers representing the year, month and day. Specify a 'reviver'
function as a second argument to `parse`. 

This function is called once for each object or list property parsed, and the 
return value of the reviver function is used instead of the parsed value:

{% prettify dart %}
import 'dart:json' as json;

void main() {
  var jsonPerson = '{"name" : "joe", "date" : [2013, 10, 3]}';

  var person = json.parse(jsonPerson, (key, value) {
    if (key == "date") {
      return new DateTime(value[0], value[1], value[2]);
    }
    return value;
  });

  person['name'];             // 'joe'
  person['date'] is DateTime; // true
}
{% endprettify %}


## URIs

Note: all examples require that you load 'dart:uri':

{% prettify dart %}
import 'dart:uri';
{% endprettify %}


### Encoding and decoding fully qualified URIs


Use `encodeUri()` to encode a fully qualified URI:

{% prettify dart %}
encodeUri('http://www.example.com/file with spaces.html')
// 'http://www.example.com/file+with+spaces.html'
{% endprettify %}

Characters that have special meaning in the URI (such as #;,/?:@&=$) are not
escaped:

{% prettify dart %}
encodeUri('http://example.com/?x=10&y=20#last');
// 'http://example.com/?x=10&y=20#last'

encodeUri('mailto:bob@example.com'); // 'mailto:bob@example.com'
{% endprettify %}

Call `encodeUriComponent()` to encode any user-provided parameters that are
passed to the server as part of a URI:

{% prettify dart %}
var params = encodeUriComponent('?param1=10&param2=20');
print(params); // '%3Fparam1%3D10%26param2%3D20'

encodeUri('http://www.example.com/') + params;
// 'http://www.example.com/%3Fparam1%3D10%26param2%3D20'));
{% endprettify %}

Don't call `encodeUriComponent()` on the complete URI. It escapes characters
like : and / and renders the URI unusable:

{% prettify dart %}
encodeUriComponent('http://www.example.com/'); 
// 'http%3A%2F%2Fwww.example.com%2F'
{% endprettify %}

To decode a URI previously encoded using `encodeUri()`, use `decodeUri()`:

{% prettify dart %}
var uri = 'http://www.example.com/file with spaces.html';
var encodedUri = encodeUri(uri);
decodeUri(encodedUri) == uri; // true
{% endprettify %}

To decode a URI component previously encoded using `encodeUriComponent()`, use
`decodeUriComponent()`: 

{% prettify dart %}
var params = encodeUriComponent('?param1=10&param2=20');
var encodedParams = encodeUriComponent(params);
decodeUriComponent(encodedParams) == params; // true
{% endprettify %}


### Parsing URIs

#### Problem

You want to access the parts of a URI.

#### Solution

The properties of a URI created using the `Uri()` constructor can be directly
accessed in the following manner: 

{% prettify dart %}
var uri = new Uri('http://example.org:8080/content/a.html#intro');

uri.scheme;     // 'http'
uri.userInfo;   // ''
uri.port        // ''
uri.domain;     // 'example.org'
uri.path;       // '/content/a.html'
uri.fragment;   // 'intro'
{% endprettify %}

Get the query parameters using the URI's `query` property:

{% prettify dart %}
var params = 'name=john&age=32';
var uri = new Uri('http://example.org/?name=john&age=32');
uri.query; // 'name=john&age=32'
{% endprettify %}

For http/https schemes, you can access the `origin` property:

{% prettify dart %}
var uri = new Uri('http://example.org:8080/content/a.html#intro');
uri.origin;     // 'http://example.org:8080'
{% endprettify %}

#### Discussion

The Uri class treats all URs that do not explicitly begin with a scheme as
relative:

{% prettify dart %}
new Uri('//example.org:8080/content/').isAbsolute; // false
new Uri('example.org:8080/content/').isAbsolute;   // false
{% endprettify %}

URIs that begin with a scheme, but that contain a fragment, are also considered
relative:

{% prettify dart %}
new Uri('http//example.org:8080/content/#intro').isAbsolute; // false
{% endprettify %}

The `scheme` and `domain` properties for  relative URIs are empty. Instead, a 
relative URI starts with the path component:

{% prettify dart %}
var uri = new Uri('example.org/content/a.html#intro');
      
uri.isAbsolute; // false
uri.scheme;     // ''
uri.domain;     // ''
uri.path;       // 'example.org/content/a.html'
{% endprettify %}

Accessing the `origin` property of a relative URI throws an exception:

{% prettify dart %}
var uri = new Uri('example.org/content/a.html#intro');
uri.isAbsolute; // false

try {
  var origin = uri.origin;
} catch(e) {
  print(e); // 'Illegal argument(s): Cannot use origin without a scheme'
}
{% endprettify %}


### Building URIs

#### Problem

You want to build URIs from individual parts.

#### Solution

Use the `Uri.fromComponents()` constructor to build up a URI from individual
parts:

{% prettify dart %}
var uri = new Uri.fromComponents(
  scheme: 'http',
  domain: 'example.org',
  path: '/content/a.html',
  query: 'name=john');

uri.isAbsolute;        // true
print(uri.toString()); // 'http://example.org/content/a.html?name=john'
{% endprettify %}

If you do not pass in the scheme as an argument, `Uri.fromComponents()` creates
a relative URI, and prefixes the URI with leading '//`:

{% prettify dart %}
var uri = new Uri.fromComponents(domain: '/content/a.html');
         
uri.isAbsolute;       // false
print(uri.toString(); // '//content/a.html'
{% endprettify %}

You should remove the leading '//' before using the URI.


## Testing

### Running only a single test

#### Problem

You want to run just a single test.  Maybe it is the test you are
currently working on and want to make that pass before running all your tests.
Or, perhaps it is a failing test that you want to explore in the debugger,
without dealing with the noise from other tests. 

#### Solution

To isolate a test, change `test()` to `solo_test()`.

{% prettify dart %}
test('if y == 0', ()  => expect(() => ...));
solo_test('if y != 0', () => expect(() => ...));
{% endprettify %}

Only the `solo_test()` will run:

{% prettify dart %}
unittest-suite-wait-for-done
PASS: if y != 0

All 1 tests passed.
unittest-suite-success
{% endprettify %}

Do not have multiple `solo_test()`s:

{% prettify dart %}
solo_test('if y == 0', () => expect(() => ...));
solo_test('if y != 0', () => expect(() => ...));
{% endprettify %}

This raises an exception, and only the first `solo_test()` runs:

{% prettify dart %}
unittest-suite-wait-for-done
Exception: Only one test can be soloed right now.
PASS: if y == 0

All 1 tests passed.
unittest-suite-success
{% endprettify %}


### Filtering which tests are run

#### Problem

You want to run just a subset of all your tests. Maybe you've divided up your
tests into `group()`s and want to run the tests for one or more group. Or
perhaps you carefully placed certain keywords in your test descriptions, and
want to run only tests whose desciption contains a specific keyword.

#### Solution

Use the `filterTests()` function provided by the Unittest library. This
function takes a String or RegExp argument and matches it against each test
description.  If the description matches, the test runs, otherwise, it doesn’t.

By default, the Unittest library is configured to run _all_ tests called
within `main()`. You want to override this behavior. Subclass the default
Configuration class to create a custom configuration, and disable the
auto-running of all tests:

{% prettify dart %}
class CustomConfiguration extends Configuration {
  get autoStart => false;
}
{% endprettify %}

Then, after telling the test runner to use the new configuration, you can
define groups and tests, call `filteredTests()`, and run your tests using
`runTests()`:

{% prettify dart %}
void main() {
  unittestConfiguration = new CustomConfiguration();
  
  // Your tests go here.

  filterTests(someStringOrRegExp);
  runTests();
}
{% endprettify %}

A complete example that uses `filterTests()` is shown below. You can run the
code from the command line, adding a keyword argument that is then passed on
to `filterTests()`: 

{% prettify dart %}
$ dart filter_tests.dart <keyword>
{% endprettify %}

Here is the code:

{% prettify dart %}
import 'package:unittest/unittest.dart';
import 'package:args/args.dart';
import 'dart:io';

class CustomConfiguration extends Configuration {
  get autoStart => false;
}

void main() {
  unittestConfiguration = new CustomConfiguration();
  
  // Get the args from the command line.
  ArgParser argParser = new ArgParser();
  Options options = new Options();
  ArgResults results = argParser.parse(options.arguments);
  List<String> args = results.rest;

  test('a test',     () => expect(1 + 0, equals(1))); 
  test('crucial test', () => expect('crucial'.length, 7));
  test('another crucial test',  () => expect('crucial'.startsWith('c'),
    isTrue));

  group('case change', () {
    test('to upper', () => expect('this'.toUpperCase(), equals('THIS'))); 
    test('to lower', () => expect('THAT'.toLowerCase(), equals('that')));
  });

  if (!args.isEmpty) {
    filterTests(args[0]);
  }
  runTests();
}
{% endprettify %}

Run the tests with 'crucial' as an argument:

{% prettify dart %}
$ dart filter_tests.dart crucial
{% endprettify %}

Only tests with 'crucial' in the description run:

{% prettify dart %}
unittest-suite-wait-for-done
PASS: crucial test
PASS: another crucial test

All 2 tests passed.
unittest-suite-success
{% endprettify %}

Run the tests with 'case' as an argument: 

{% prettify dart %}
$ dart filter_tests.dart case
{% endprettify %}

Only tests within the 'case change' group run:

{% prettify dart %}
unittest-suite-wait-for-done
PASS: case change to upper
PASS: case change to lower

All 2 tests passed.
unittest-suite-success
{% endprettify %}

The keyword argument is optional. If you omit it, all tests in the file run.


### Running code before and after each test

#### Problem

You want initialization code to run before each test, and cleanup code to run
after each test, but want to avoid code duplication.

#### Solution

Within each `group()`, call `setUp()` for initialization and `tearDown()` for
cleanup. The function passed as an argument to `setUp()` runs before each
test, and that passed to `tearDown()` runs after each test.

##### setUp() example

Assume you have defined a Point class that contains several methods. You want
to test each method, and need a Point object in each test. Place the Point
initialization code inside `setUp()`, and the Point object becomes available in
each test:

{% prettify dart %}
void main() {
  group('test Point with setUp()', () {
    Point point;
    setUp(() {  
      point = new Point(3, 4);
    });

    test('toString',  () => expect(point.toString(), equals(...)));
    test('[](index)', () => expect(point[0], equals(...)));
  });
}
{% endprettify %}

##### setUp() and tearDown() example

Tests that create files and directories need to clean up after themselves.
Here is a function that creates a file inside a given directory: 

{% prettify dart %}
// Writes a file in 'dir' directory.
Path writeFileToDirectory(dir) {
  ...
}
{% endprettify %}

The code to create the directory goes in `setUp()`. The code to remove the
directory and its contents goes in `tearDown()`:

{% prettify dart %}
void main() {
  group('test writeFileToDirectory()', () {
    var tempDir;
    
    setUp(() {
       tempDir = new Directory('').createTempSync();
    });

    tearDown(() {
      if (tempDir.existsSync()) {
        tempDir.deleteSync(recursive: true);
      }
    });

    test('creates the correct path', () => ...);
    test('throws with a non-existent directory', () => ...);
  });
}
{% endprettify %}

The code inside `tearDown()` runs regardless of whether `setUp()` sets up a
resource successfully or not, and regardless of whether a test passes or
fails. If there is an error inside a test, code within `tearDown()` still runs:

{% prettify dart %}
group('tearDown behavior when', () {
  var tempDir;

  setUp(() {
    print('setting up');
    tempDir = new Directory('').createTempSync();
  });

  tearDown(() {
    print('tearing down');
    if (tempDir.existsSync()) {
      tempDir.deleteSync(recursive: true);
    }
  });

  test('test has error in it', () {
    22 ~/ 0; // Trigger an IntegerDivisionByZeroException.
    ...
  });
});
{% endprettify %}

Here is the (truncated) test run output:

{% prettify dart %}
unittest-suite-wait-for-done
setting up
tearing down

FAIL: tearDown behavior when test has error in it
  Caught IntegerDivisionByZeroException
  ...

0 PASSED, 1 FAILED, 0 ERRORS
Uncaught Error: Exception: Some tests failed.
Stack Trace:
...
{% endprettify %}

##### setUp() and tearDown() in nested group()s

The `setUp()` and `tearDown()` functions reset with the start of a new `group()`.
This applies to nested `group()`s, which do not inherit these functions:

{% prettify dart %}
group('test Point with nested setUp()', () {
  Point point;
  setUp(() {  
    point = new Point(3, 4);
  });
  
  group('[]()', () {
    // setUp() from outer group() does not run here. point is null.
    test('with valid index', () => ... );
    test('with invalid index', () => ... );
  });
});
{% endprettify %}

You can fix this problem by assigning each nested `group()` its own `setUp()`
and `tearDown()`.


### Testing synchronous exceptions

#### Problem

You want to test exceptions in your code. You want to know if some code returns
normally, or if it throws. Or, you want to test that a specific error is raised,
and that the error message is correct. 

#### Solution

The Matcher library, bundled together with the Unittest package, provides
several handy assertion shortcuts that you can use in your tests. 

To test whether code throws, use the `throws` matcher: 

{% prettify dart %}
expect(() => 10 ~/ 0, throws);
{% endprettify %}

To test that code runs without generating an exception, use the
`returnsNormally` matcher:

{% prettify dart %}
expect(() => 10 ~/ 1, returnsNormally);
{% endprettify %}

The Unittest library provides matchers for commonly occuring exceptions and
errors:

{% prettify dart %}
throwsException
throwsFormatException
throwsArgumentError
throwsRangeError
throwsNoSuchMethodError
throwsUnimplementedError
throwsStateError
throwsUnsupportedError
{% endprettify %}

You can use one of these matchers to test the type of the error thrown by your
code:

{% prettify dart %}
expect(() => throw new StateError('functions called in the wrong order'), 
    throwsStateError);
{% endprettify %}

You can also use the `throwsA()` and `predicate()` functions for more granular
testing of exceptions.

The `predicate()` function returns a Matcher based on an assertion about the
error object:

{% prettify dart %}
Matcher isIntegerDivisionByZeroException =
  predicate((e) => e is IntegerDivisionByZeroException);
{% endprettify %}

The `throwsA()` function takes the Matcher returned by `predicate()` and
matches the exception thrown by the code under test against it:

{% prettify dart %}
expect(() => 10 ~/ 0, throwsA(isIntegerDivisionByZeroException));
{% endprettify %}

You can test the error message using a combination of `throwsA()` and
`predicate()`:

{% prettify dart %}
expect(() => throw new ArgumentError('bad argument'), 
  throwsA(predicate((e) => e.message == 'bad argument')));
{% endprettify %}

You can also test the error type and the error message together:

{% prettify dart %}
expect(() => throw new RangeError('out of range'), 
  throwsA(predicate((e) => (e is RangeError && e.message == 'out of range'))));
{% endprettify %}


### Testing for double equality

#### Problem

Arithmetic involving doubles is inexact. You want to compare two doubles to
determine if they are acceptably close.

#### Solution 

Use the `closeTo()` matcher for testing approximate numerical equality:

{% prettify dart %}
closeTo(value, delta)
{% endprettify %}

This matcher checks if the number under test is within delta of some value.

Consider this code that computes the distance between two points: 

{% prettify dart %}
Point point1 = new Point(-2, -3);
Point point2 = new Point(-4, 4);

print(point1.distanceTo(point2)); // 7.280109889280518.  
{% endprettify %}

Here's how you can test for approximate equality:

{% prettify dart %}
expect(point1.distanceTo(point2)), closeTo(7.28, .001)); 
{% endprettify %}

## HTML DOM

### Using CSS selectors to find DOM elements

#### Problem

You want to find DOM elements on a web page.

#### Solution

Use the top-level `query()` and `queryAll()` functions provided by the
`dart:html` library. Both functions take CSS selectors as arguments. The
`query()` function returns the first matching element, and the `queryAll()`
function returns all matching elements.

#### Example

Here are a few examples of the using `query()` and `queryAll()` with CSS
selectors to find DOM elements:

{% prettify dart %}
<!DOCTYPE html>

<html>
  <body>
    <h1>Breakfast</h1> 
    <ul>
      <li id='first' class='must-have'>Milk</li>
      <li class='must-have'>Cereal
        <ul>
          <li>Bran Flakes</li>
          <li><a href='https://en.wikipedia.org/wiki/Nut_(fruit)'>Nuts</a></li>
        </ul>
      </li>
      <li>Juice</li>
    </ul>    
    
    <script type="application/dart">
      import 'dart:html';
      
      void main() {
    
        // Find by ID.
        Element element = query('#first');
        print(element.id);                 // 'first'
        print(element.text);               // 'Milk'
        
        // Find by class.
        List<Element> elements = queryAll('.must-have');
        print(elements.length);            // 2
        
        // Find by ID or class.
        elements = queryAll('#first, .must-have');
        print(elements.length);            // 2
        
        // Find by tag.
        elements = queryAll('li');
        print(elements.length);            // 5
        
        // Use hierarchical selectors.
        elements = queryAll('li > ul > li');
        print(elements.first.text);        // 'Bran Flakes'
        
        // Use pseudo-elements.
        element = query('li:nth-child(1)');
        print(element.text);               // 'Milk'
        
        // Find by attribute.
        elements = queryAll('[href *= Nut]');
        print(elements.length);            // 1
      
      }
    </script>
    <script src="packages/browser/dart.js"></script>
  </body>
</html>
{% endprettify %}

For a comprehensive list of selectors that you can use for querying, see
http://www.w3.org/TR/css3-selectors/[The CSS Selector Specification guide].

#### Discussion

Calling `queryAll()` returns a list of DOM elements:

{% prettify dart %}
<!DOCTYPE html>

<html>
  <body>   
    <ol>
      <li>Google</li>
      <li>StackOverflow</li>
      <li>Reddit</li>
      <li>Github</li>
    </ol>
     
    <script type="application/dart">
      import 'dart:html';
      
      void main() {
        List<Element> elements = queryAll('li');
      }
    </script>
    <script src="packages/browser/dart.js"></script>
  </body>
</html>
{% endprettify %}

Use the `[]` operator to access individual elements. You can also use the
`first` and `last` getters:

{% prettify dart %}
print(elements[2].text);    // 'Reddit'
print(elements.first.text); // 'Google'
print(elements.last.text);  // 'Github'
{% endprettify %}

You can iterate over the list, map list elements to a new list, and filter list
contents:

{% prettify dart %}
for (var element in elements) {
   doSomethingWith(element);
}

Iterable sites = elements.map((site) => site.text);
print(sites.join(', ')); // "Google, StackOverflow, Reddit, Github"

sites = elements.where((site) => site.text.length != 6);
print(sites.first.text); // "StackOverflow"
{% endprettify %}

You can slice the list to obtain a sublist:
        
{% prettify dart %}
var sublist = elements.sublist(1, 3); // Get the elements at positions 1 and 2.
print(sublist.first.text);            // 'StackOverflow'
print(sublist.last.text);             // 'Reddit'
{% endprettify %}

Since the list returned by `queryAll()` is read only, you cannot add, modify,
or remove list elements. Attempting to change the list in any way generates an
error:

{% prettify dart %}
elements.length = 2; // Error message: 'Cannot resize immutable List.'
{% endprettify %}

Other recipes in this chapter show how you can create elements and insert them
into the DOM, and how to modify existing DOM elements.


### Using CSS selectors within a limited scope

#### Problem

You want to find elements that are contained by a particular element.

#### Solution

Call the `query()` or `queryAll()` methods on a DOM element. Invoking one of
these methods on an element restricts the scope of the query to that
element's descendants:

{% prettify dart %}
containerElement.query(cssSelector);
containerElement.queryAll(cssSelector);
{% endprettify %}

#### Examples

Consider the following table of user records:

{% prettify dart %}
<table>
  <tr><td>Jose</td><td class='status'>Accepted</td></tr>
  <tr><td>Marie</td><td class='status'>Accepted</td></tr>
  <tr><td>Kwame</td><td class='status'>Accepted</td></tr>
  <tr><td>Rohan</td><td class='status'>Accepted</td></tr>
</table>
{% endprettify %}

The following code attaches an event handler to each <tr>. When a <tr> is
clicked, the text within the matching descendant <td> toggles:

{% prettify dart %}
queryAll('tr').forEach((element) {
  element.onClick.listen((event) {
    var record = event.currentTarget.query('.status');
    record.innerHtml = record.innerHtml == 'Accepted' ? 'Declined' : 'Accepted';
  });
});
{% endprettify %}

Because the query is scoped to the just-clicked row, cells with the 'status'
class in other rows are not affected.

Note the use of `queryAll()` as a top-level function in the code above. Used
in this manner, `queryAll()` is scoped to the entire document.


### Traversing the DOM starting from a particular element

#### Problem

You have a reference to a DOM element and want to locate its ancestor,
sibling, and descendant elements within the DOM structure.

#### Solution

The dart:html API provides methods for DOM traversal based on your current
position in the DOM.

Consider the example below:

{% prettify dart %}
<!DOCTYPE html>

<html>
  <ol>
    <li>Head</li>
    <li>Shoulders</li>
    <li>Knees</li>
    <li>Toes</li>
  </ol>
    
  <body>   
    <script type="application/dart">
      import 'dart:html';

      void main() {
        LIElement knees = query('ol > li:nth-child(3)');       
        print(knees.text); // 'Knees'
      }
    </script>
    <script src="packages/browser/dart.js"></script>
  </body>
</html>

{% endprettify %}

Using the top level `query()` function, you obtain a reference to an <li>
element. This is your starting point within the DOM structure.

Use the `nextElementSibling` and `previousElementSibling` properties to locate
an element's immediate siblings:

{% prettify dart %}
print(knees.nextElementSibling.text);     // 'Toes'
print(knees.previousElementSibling.text); // 'Shoulders'
{% endprettify %}
        
Use the `parent` property to locate an element's immediate ancestor:

{% prettify dart %}
print(knees.parent.tagName);              // 'OL'
print(knees.parent.parent.tagName);       // 'BODY'
{% endprettify %}

Use the `children` property to locate an element's immediate descendants:

{% prettify dart %}
print(knees.parent.children.length);      // 4
{% endprettify %}

Invoking the `children` property on an element returns a list, and you can
define functions to filter that list:

{% prettify dart %}
List<Element> previousSiblings(item) {
  return item.parent.children.takeWhile(
      (element) => element != item).toList();
}

List<Element> nextSiblings(item) {
  Element nextElement = item.nextElementSibling;
  return item.parent.children.skipWhile(
      (element) => element != nextElement).toList();
}
{% endprettify %}

The `knees` element has two previous siblings, and a single next sibling:

{% prettify dart %}
List<Element> previousSiblings = previousSiblings(knees);
print(previousSiblings.first.text);    // 'Head'
print(previousSiblings.last.text);     // 'Shoulders'

print(nextSiblings(knees).first.text); // 'Toes'
{% endprettify %}


### Creating DOM elements

#### Problem

You want to create new DOM elements.

#### Solution

The dart:html library provides several ways to create new DOM elements.

You can use constructors provided by specialized element classes:

{% prettify dart %}
var item = new LIElement();
{% endprettify %}

These classes inherit from Element. Here are a few examples of specialized
properties that these classes provide:

{% prettify dart %}
var anchor = new AnchorElement();
anchor.href = 'http://dartlang.org';
print(anchor.outerHtml); // '<a href="http://dartlang.org"></a>'

var label = new LabelElement();
label.htmlFor = 'color';
label.text = 'Color';
print(label.outerHtml); // '<label for="color">Color</label>'

var form = new FormElement();
form.method = 'PUT';
print(form.outerHtml); // '<form method="PUT"></form>'
{% endprettify %}

You can also use constructors provided by the Element class.

Use the `Element.tag()` constructor to create an element with a specified tag:

{% prettify dart %}
LIElement item = new Element.tag('li');
print(item.tagName); // 'LI'
{% endprettify %}
        
You can then assign content to the element using the element's text property:

{% prettify dart %}
item.text = 'learn Dart';
print(item.outerHtml); //  '<li>learn Dart</li>'
{% endprettify %}

An invalid HTML tag passed to `Element.tag()` creates an UnknownElement object:

{% prettify dart %}
var newElement = new Element.tag('bogusTag');
print(newElement is UnknownElement); // true
{% endprettify %}

You can use the 'isTagSupported' static method provided by the Element class
to test whether a tag is valid:

{% prettify dart %}
print(Element.isTagSupported('bogusTag')); // false
{% endprettify %}
        
Another way of creating elements is through the use of the `Element.html()`
constructor. This constuctor takes a String argument representing a valid HTML
fragment:

{% prettify dart %}
DivElement div = new Element.html('<div>I love Strawberries.</div>');
{% endprettify %}

Note that creating an element does not insert it into the DOM. Other recipes
in this chapter discuss different ways in which you can add elements to the DOM.


### Inserting child elements inside an existing DOM element

#### Problem

You want to insert one or more elements inside an existing DOM element.

#### Solution

Get the list of the DOM element's children, and add new child elements to that
list.                                                                            

Consider this sparse web page with an empty <ul>. You want to use Dart code to 
dynamically add <li> elements to the <ul>:

{% prettify dart %}
<!DOCTYPE html>

<html>
  <body>
    <ul></ul>
    
    <script type="application/dart" src='main.dart'></script>
    <script src="packages/browser/dart.js"></script>
  </body>
</html>
{% endprettify %}

In the corresponding Dart file, begin by getting a reference to the parent
element:

{% prettify dart %}
import 'dart:html';

void main() {
  var ul = query('ul');
  // Code for inserting elements goes here.
}
{% endprettify %}

Use `add()` to append a new element to the parent's children:

{% prettify dart %}
var li = new LIElement();
li.text = 'One banana';
ul.children.add(li);

print(ul.children.last.outerHtml); '<li>One banana</li>'
{% endprettify %}

The code for creating a new <li> and adding it to the <ul> can be more
succinctly written using the cascade operator, and we will use this synax for
subsequent examples:

{% prettify dart %}
items.add(new LIElement()..text = 'Three banana');                                       
{% endprettify %}

Use `addAll()` to add several elements to the list:

{% prettify dart %}
List<LIElement> items = [];                                                      
items.add(new LIElement()..text = 'Three banana');                                       
items.add(new LIElement()..text = 'Four banana');
ul.children.addAll(items);  
{% endprettify %}
                
This is what the list looks like:

{% prettify dart %}
One banana
Three banana
Four banana
{% endprettify %}

Looks like we skipped an item. Use `insert()` to place the missing item in the
list:

{% prettify dart %}
ul.children.insert(1, new LIElement()..text = 'Two banana');
{% endprettify %}

This adds the new <li>  after the second item. The list now looks like this:

{% prettify dart %}
One banana
Two banana
Three banana
Four banana
{% endprettify %}

You can use `insert()` to prepend to a list:

{% prettify dart %}
ul.children.insert(0, new LIElement()..text = 'Zero banana');
print(ul.children.first.outerHtml == '<li>Zero banana</li>');
{% endprettify %}

The Element class defines a couple of helpful methods that provide additional
ways of adding child elements to a parent element.

Use `append()` to add a single element to a parent:

{% prettify dart %}
ul.append(new LIElement()..text = 'Five banana');
{% endprettify %}

Or, you can use the `appendHtml()` method. This method parses the String
argument passed to it as HTML and adds the resulting node as the last child of
the parent:

{% prettify dart %}
ul.appendHtml('<li>Six banana</li>');
{% endprettify %}

Here is the final version of the list:

{% prettify dart %}
Zero banana
One banana
Two banana
Three banana
Four banana
Five banana
Six banana
{% endprettify %}

### Inserting elements adjacent to an existing DOM element

#### Problem

You want to insert an element before or after another element.

#### Solution

Use an element's `insertAdjacentElement()` method to insert another element
immediately before or immediately after it. Or, use the `insertBefore()` method.
Examples of both are shown below.

#### Examples

Consider this HTML file. You want to insert two new <li> elements into the <ul>,
one before the <li> with the 'target' ID, and one after it:

{% prettify dart %}
<!DOCTYPE html>

<html>
  <body>   
    <ul>
      <li>First item</li>
      <li id='target'>Target item</li>
      <li>Last item</li>
    </ul>
    
    <script type='application/dart' src='main.dart'></script>
    
    <script src="packages/browser/dart.js"></script>
  </body>
</html>
{% endprettify %}

In the accompanying Dart file, get a reference to the target <li>.  Then,
invoke the `insertAdjacentElement()` method on that <li> to insert new
elements next to it:

{% prettify dart %}
import 'dart:html';

void main() {
  var targetItem = query('#target');

  var li = new LIElement();
  li.text = 'Added before target';
  targetItem.insertAdjacentElement('beforeBegin', li);
  
  li = new LIElement();
  li.text = 'Added after target';
  targetItem.insertAdjacentElement('afterEnd', li);
}

{% endprettify %}

The first argument to `insertAdjacentElement()` indicates where the new
element is inserted. If it is 'beforeBegin', the new element is inserted
immediately before the target element. If it is 'afterEnd', the new element is
inserted immediately after the target element.

The list looks like this after the new elements have been inserted:

{% prettify dart %}
First item
Added before target
Target item
Added after target
Last item
{% endprettify %}

You can also use the `insertBefore()` method to insert an element into the
DOM. Call `insertBefore()` on the target element's parent node:

{% prettify dart %}
import 'dart:html';
      
void main() {
  var targetItem = query('#target');

  var li = new LIElement();
  li.text = 'Added before target';
  targetItem.parent.insertBefore(li, targetItem);
  
  li = new LIElement();
  li.text = 'Added after target';
  // Insert after the target element.
  targetItem.parent.insertBefore(li, targetItem.nextElementSibling);
}
{% endprettify %}


### Cloning DOM elements

#### Problem

You want to duplicate a DOM element.

#### Solution

Call the `clone()` method on the element.

Assume you have the following HTML, and want to clone the <ul>:

{% prettify dart %}
<ul>
  <li>Sam</li>
  <li>Green Eggs</li>
  <li>Ham</li>
</ul>
{% endprettify %}

First, obtain a reference to the original element:

{% prettify dart %}
UListElement ul = query('ul');
{% endprettify %}

Then, call `clone()` with a boolean argument. This argument determines whether
you create a deep or a shallow copy. 

If the argument to `clone()` is `true`, a deep copy is created, and the entire
subtree of the original node is cloned:

{% prettify dart %}
UListElement deepCopy = ul.clone(true);
print(deepCopy.children.length); // 3
{% endprettify %}

If the argument to `clone()` is `false`, a shallow copy is created, and the
original element's child nodes are not copied:

{% prettify dart %}
UListElement shallowCopy = ul.clone(false);
print(shallowCopy.children.length); // 0
{% endprettify %}

Cloning a node copies all of the node's attributes, as well as the values of 
those attributes.

Assume a page contains the following HTML:

{% prettify dart %}
<input type="text" name="username" maxlength="10">
{% endprettify %}

The clone of the \<input\> element contains the same attributes as the original:

{% prettify dart %}
import 'dart:html';

void main() {
  var original = query('input');
  var clone = original.clone(true);

  print(original.attributes['type'] == original.attributes['type']); // true
  print(original.attributes['name'] == original.attributes['name']); // true
  print(original.attributes['size'] == original.attributes['size']); // true
}
{% endprettify %}


#### Example

We want to display to create a new page that displays some fun [Google
Doodles](www.google.com/doodles), but don't want to load up all the images when
the page loads. We provide a link that the user can click to see the logos.

We use a \<template\> element to store the barebones structure for displaying each
logo and the accompanying caption. The \<template\> element allows us to declare
fragments of markup. These fragments are not rendered when the page loads, but
they can be activated at runtime.

The \<template\> element is new and not supported by every modern browser. For
an excellent introduction to this new element, see
[HTML's New Template Tag](http://www.html5rocks.com/en/tutorials/webcomponents/template/).

The \<template\> in the HTML below contains \<img\>, <div> and <hr> tags. The
\<img\>
tag has no src and alt properties, and the <div> element contains no text. These
tags are placeholders.

{% prettify dart %}
<!DOCTYPE html>

<html>
  <body>   
    <template id='myTemplate'>
      <img width='150px'>
      <div class='caption'></div>
      <hr>
    </template> 
    
    <div><a href=''>Click to see Google Doodles</a></div>
      
    <script type='application/dart' src='main.dart'></script>
    <script src="packages/browser/dart.js"></script>
  </body>
</html>

{% endprettify %}

Once the user clicks the link to see the logos, we fill in the missing fields
using hard-coded data. Then, we clone the template contents, and we insert them
into the document:

{% prettify dart %}
import 'dart:html';

void main() {
  
  var data = [
    {'src': 'http://www.google.com/logos/2013/parents_day_2013-1508005-hp.jpg', 
      'alt': "Parent's Day",
      'caption': "Parent's Day"},
    {'src': 'http://www.google.com/logos/2013/new_years_day_2013-983008-hp.jpg',
     'alt': "New Year's Day",
     'caption': "New Year's Day"},
    {'src': 'http://www.google.com/logos/2013/zamboni-1005006-hp.jpg',
     'alt': 'Zamboni',
     'caption': 'Zamboni'}
  ];

  AnchorElement link = query('a');
  
  link.onClick.listen((event) { 
    event.preventDefault();

    var content = document.query('#myTemplate').content;
    ImageElement img = content.query('img');
    DivElement div = content.query('div');

    for (Map item in data) {
      img.src = item['src'];
      img.alt = item['alt'];
      div.text = item['caption'];

      document.body.append(content.clone(true));
    }
    event.target.remove();
  });
}
{% endprettify %}

We get the template contents using the template element's `content` property.

{% prettify dart %}
var content = document.query('#myTemplate').content;
{% endprettify %}

We get references to the \<img\> and <div> elements using scoped queries:

{% prettify dart %}
ImageElement img = content.query('img');
DivElement div = content.query('div');
{% endprettify %}

Cloning the template contents activates the \<template\> element's inert HTML, and
inserting it into the DOM makes the logos visible to the user:

{% prettify dart %}
document.body.append(content.clone(true));
{% endprettify %}


### Replacing DOM elements

#### Problem

You want to replace one or more DOM elements with other elements.

#### Solution

Call the `replaceWith()` method on a DOM element and pass to it the new
element as an argument.

#### Example

The following example allows the user to edit a snippet of text. The text is
displayed within a <span> element. A text \<input\> replaces the <span> when the
user wants to edit the text. When the user is done editing, the <span> replaces
the \<input\>:

{% prettify dart %}
<!DOCTYPE html>

<html>
  <body> 
    <span>You can edit this.&nbsp;</span><a href='#'>Edit</a>
       
    <script type="application/dart">
      
      import 'dart:html';
      
      void main() {
      
        var span = query('span');
        var link = query('a');
        
        // Create input but don't insert into DOM.
        var input = new Element.html(
            "<input type='text' value='${span.innerHtml}' />");  

        bool editing = false;
        
        // Add event-listener to replace a span with an input, and vice-versa.
        link.onClick.listen((event) {
          editing = !editing; 
          if (editing) {
            span.replaceWith(input);
            link.innerHtml = 'Done';
          } else {
            input.replaceWith(span);
            link.innerHtml = 'Edit';
          }
          event.preventDefault();
        });     
      }
    </script>

    <script src="packages/browser/dart.js"></script>
  </body>
</html>
{% endprettify %}


### Removing an element from the DOM

#### Problem

You want to find an element and remove it from the DOM structure. 

#### Solution

Call the `remove()` method on the element. Doing so removes it from the DOM.

#### Example

The following example shows a list of exotic fruits, some of which are out of
stock.  The application allows the user to click a link to stop displaying the out
of stock items. Clicking the link triggers a callback that removes the items from
the DOM. Here is the HTML file:

{% prettify dart %}
<!DOCTYPE html>
<head>
  <style> .out-of-stock {color: #aaa}; </style>  
</head>
<html>
  <body>
    <ul>
      <li>Rambutan</li>
      <li>Jackfruit</li>
      <li class='out-of-stock'>Passion Fruit</li> 
      <li>Lychee</li>
      <li class='out-of-stock'>Kumquat</li>           
    </ul>
  
    <p><a href='#'>Show only in-stock</a></p>
   
    <script type="application/dart" src='main.dart'></script>
    <script src="packages/browser/dart.js"></script>
  </body>
</html>
{% endprettify %}

And here is the Dart code that handles the element removal:

{% prettify dart %}
import 'dart:html';
      
void main() {
  
  query('a').onClick.listen((event) {
  
    // Find all out of stock items and remove them from the DOM.
    queryAll('.out-of-stock').forEach((item) {
      item.remove();
    });
    
    event.preventDefault();
    
    // Remove the link from the DOM.
    event.target.remove();
  });
}
{% endprettify %}

#### Discussion

Using `remove()` works well if you have a reference to the DOM element you
want to remove. But sometimes, you have a reference to the element's
parent, not to the element itself. For example, you may want to remove an <li>, 
but you only have a reference to the <ul> or <ol> that contains the <li>. 

In such cases, get a list of the parent element's children. Removing elements
from this list removes them from the DOM.

Use `removeAt()` to remove a child by its index position:

{% prettify dart %}
element.children.removeAt(1); // Removes the second child.
{% endprettify %}

Remove the last child using `removeLast()`: 

{% prettify dart %}
element.children.removeLast();
{% endprettify %}

You can query the collection of children and remove a matching child using
`remove()`. The code below finds the first child with the class `largest`,
and removes it from the DOM:

{% prettify dart %}
element.children.remove(element.query('.largest'));
{% endprettify %}

You can remove all of an element's children using the `clear()` method:

{% prettify dart %}
element.children.clear();
{% endprettify %}


### Getting and setting DOM element attributes

#### Problem

You have a DOM element and want to get or set the value of its attributes.

#### Solution

Most attributes have a corresponding property that you can use to get or set
the attribute value. You can also use the an element's `attributes` map. In
general, using properties is more Darty, since properties allow tools to check
the attribute name and type.

#### Examples

Consider the following element:

{% prettify dart %}
<input type='text' name='fname' id='fname' data-purpose='informational' />
{% endprettify %}

The Element class defines several properties, such as `id` and `classes`, that
correspond to element attributes. Here are some examples:

{% prettify dart %}
print(element.id);                 // 'fname'

element.classes.add('first-name');
print(element.classes.first);      // 'first-name'
{% endprettify %}

Subclasses of Element define additional properties, such as the href property of
AnchorElement, or the size and maxLength properties of InputElement:

{% prettify dart %}
element.size = 30;
element.maxLength = 10;
{% endprettify %}

When an element attribute does not have a corresponding property, or when
using a property is not convenient, you can use an element's attributes map:

{% prettify dart %}
print(element.attributes['id']);                   // 'fname'
print(element.attributes['name']);                 // 'fname'
{% endprettify %}

Use the attributes map to access an element's data-* attributes:

{% prettify dart %}
print(element.attributes['data-purpose']); // 'informational'
{% endprettify %}
        
If you want to get or set _only_ the data-* attributes, use the `dataset`
property:

{% prettify dart %}
print(element.dataset.length);     // 1

// The key is 'purpose', not 'data-purpose'.
print(element.dataset.keys.first); // 'purpose'
print(element.dataset['purpose']); // 'informational'

element.dataset['purpose'] = 'biographical';
print(element.dataset['purpose']); // 'biographical'
{% endprettify %}

Both the `attributes` and the `dataset` properties return Map objects. Any
modifications to an element's attributes map automatically apply to the
element:

{% prettify dart %}
// Change attribute value.
element.attributes['id'] = 'first-name';
print(element.attributes['id']);        // 'first-name'

// Create a new attribute.
element.attributes['maxLength'] = 10;
print(element.attributes['maxLength']); // '30'

// Remove an attribute.
element.attributes.remove('id');
print(element.attributes['id']);       // null
{% endprettify %}


### Getting and setting element style properties

#### Problem

You want to get and set an element's CSS style properties.

#### Solution

You have three options:
 
* To get an element's style properties, use the `getComputedStyle()` method.
 
* To get or set the classes associated with an element, use the `classes`
field.

* To assign style properties directly to an element, use the `style` field.
To get an element's style properties, use the `getComputedStyle()` method.


#### Examples
 
The examples below assume the following HTML:

{% prettify dart %}
<!DOCTYPE html>

<html>
  <head>
    <title>manipulating_styles</title>
    <link rel='stylesheet' type='text/css' href='main.css'>
  </head>
  <body>
    <div class='bold'>Dart Cookbook</div>
    
    <script type='application/dart' src='main.dart'></script>
    <script src="packages/browser/dart.js"></script>
  </body>
</html>
{% endprettify %}

Here are the associated style declarations:

{% prettify dart %}
// main.css

body {font-family: sans-serif;}
div:after {content: ' rocks!';}
.bold {font-weight: bold;}
.underlined {text-decoration: underline;}
{% endprettify %}

##### Getting an element's CSS styles

Use the `getComputedStyle()` method to get a collection of all CSS styles
applied to an element:

{% prettify dart %}
// main.dart

import 'dart:html';

void main() {
  DivElement element = query('div');

  print(element.getComputedStyle().fontFamily); // 'sans-serif'

  // Inherited style.
  print(element.getComputedStyle().fontWeight); // 'bold'
}
{% endprettify %}

The `getComputedStyle()` method gets the style information for pseudo-elements.
Just pass in the pseudo-element as an argument:

{% prettify dart %}
print(element.getComputedStyle(':after').content); // "' rocks!'"
{% endprettify %}

##### Accessing the classes associated with an element

Use the `classes` field to get a set of an element's CSS classes:

{% prettify dart %}
print(element.classes.first); // 'bold'
{% endprettify %}

You can associate a new class with an element. Doing this applies the class
styles to the element:

{% prettify dart %}
element.classes.add('underlined');
print(element.classes.contains('underlined'));    // true
print(element.getComputedStyle().textDecoration); // 'underline'
{% endprettify %}

You can remove a class associated with an element. Doing this removes the
class styles from the element:

{% prettify dart %}
element.classes.remove('underlined');
print(element.getComputedStyle().textDecoration); // 'none'
{% endprettify %}

You can use the class list's `toggle()` method to toggle a class:

{% prettify dart %}
element.classes.toggle('underlined');
print(element.classes.contains('underlined')); // true

element.classes.toggle('underlined');
print(element.classes.contains('underlined')); // false
{% endprettify %}

##### Directly applying a style property

While using classes is a common way of associating an element with a set of
styles, you can also attach a style property directly to the element:

{% prettify dart %}
element.style.color = 'rgb(120, 120, 120)';
element.style.border = '1px solid rgb(0, 0, 0)';
{% endprettify %}

It is idiomatic Dart to write the above code using the cascade operator (..):

{% prettify dart %}
element.style
  ..color =  'rgb(120, 120, 120)';
  ..border = '1px solid rgb(0, 0, 0)';
{% endprettify %}

## Web UI

The Web UI package provides web components and templates to help you write web
applications at scale.

The examples in this chapter can be compiled and run. The instructions below
for how this can be done assume you are using Dart Editor. For information 
on how to compile Web UI apps from the command line (and to read more about the
Web UI compile process), see http://www.dartlang.org/articles/web-ui/tools.html.

#### Pub dependency 

The Web UI package is available from Pub, Dart's package manager.  In a Dart
application that you have opened in the Editor, add the dependency to the Web
UI package:

{% prettify dart %}
dependencies:
  web_ui: any
{% endprettify %}

This is what a sample `pubspec.yaml` file looks like:

{% prettify dart %}
name: sample
description: A sample web application
dependencies:
  browser: any
  web_ui: any
{% endprettify %}

Run `pub install` from the Editor's Tools menu to install the web_ui package.

#### Example file

Copy any example from this chapter in a new file in the top level `web/`
directory (create that directory if it does not exist). Call the new file
`main.html`.

#### Build file

Create a top level `build.dart` file with the following contents:

{% prettify dart %}
import 'package:web_ui/component_build.dart';
import 'dart:io';

void main() {
  build(new Options().arguments, ['web/main.html']);
}
{% endprettify %}

This assumes that you called your example file `main.html`. Modify the filename
in `build.dart` if you picked a different name for your example file.

#### Compiling the example

Right-click the `build.dart` file, and choose `Run` from the drop down menu.

This runs the Web UI compile script (`packages/web_ui/dwc.dart`) and generates
an `out` directory containing the compiled files. 

Right-click on `web/main.html`, and select either the `Run in Dartium` or
"Run as JavaScript" option to run the example.

#### Making changes

You need to go through the manual compile process only once. After the intial
compilation is done, Dart Editor detects changes you make to the example file,
and automatically invokes the `dwc.dart` compiler script. You can directly run
the example file (`web/main.html`) and Dart Editor automatically runs the
compiled file.


### Using a Dart expression inside HTML

#### Problem

You want to inject the value of a Dart expression in your markup.

#### Solution

Place the Dart expression within `{{'{{'}} }}`. At runtime, the Web UI framework
evaluates the expression, and injects the result into the HTML.  Commonly used
Dart expressions include identifiers, method and function calls, getters, string
interpolation, and raw strings:

{% prettify dart %}
{% raw %}
<!DOCTYPE html>

<html>
  <body>
    <ul>
      <li>Using identifiers: var x = {{x}} and var y = {{y}}</li>
      <li>Calling a method: {{x}} in hex is {{x.toRadixString(16)}}</li>
      <li>Calling functions: (x ~/ y) = {{intDivision()}} and (x / y) = 
        {{doubleDivision().toStringAsPrecision(4)}}</li>
      <li>Using a getter: {{cityNameAsChars}}</li>
      <li>Using string interpolation: {{'city = ${city.toUpperCase()}'}}</li>
      <li>Using a raw string: {{r'$city'}}</li>
    </ul>

    <script type="application/dart">
      import 'package:web_ui/web_ui.dart';

      num x = 32;
      num y = 3;
      String city = 'Boston';
      
      int intDivision() => x ~/ y;
      double doubleDivision() => x / y;
      
      List<String> get cityNameAsChars => city.split(''); 

      void main() {}
    </script>
  </body>
</html>
{% endraw %}
{% endprettify %}

Building and running the above code displays the following in the browser:

{% prettify dart %}
Using identifiers: var x = 32 and var y = 3
Calling a method: 32 in hex is 20
Calling functions: (x ~/ y) = 10 and (x / y) = 10.67
Using a getter: [B, o, s, t, o, n]
Using string interpolation: city = BOSTON
Using a raw string: $city
{% endprettify %}

The expression interpolation shown in the code above creates a _static_ binding
between a Dart variable and its representation in the UI. When the page loads,
all expressions inside `{{'{{'}} }}` are evaluated. If the evaluated variable's value
changes later on, the UI does not automatically update.

We will look at how we can make the binding between Dart variables and the UI
live in other recipes in this chapter.


### Observing a Dart variable for changes

#### Problem

You want to sync a variable and its display. Every time the variable's value
changes, you want its display to automatically change. You want this to happen
without a page refresh, and without having to do any manual DOM manipulation.

#### Solution

Add an `@observable` declaration right before you define the variable:

{% prettify dart %}
@observable 
var myVar;
{% endprettify %}

Then, put that variable within `{{'{{'}} }}` in the HTML:

{% prettify dart %}
{% raw %}
<li>The value is {{myVar}}</li>
{% endraw %}
{% endprettify %}

This creates a dynamic binding between that variable and its display in the UI.
If the variable's value changes, the UI updates automatically.

#### Example

Imagine you have a collection of movie quotes, and you want to display them on
a web page one by one in slideshow fashion.

Begin by creating a collection of quotes. Then, define a variable to store the
current quote, and make that variable observable:

{% prettify dart %}
class Quote {
  final String quote, saidBy; 
  Quote(this.quote, this.saidBy);
}

List<Quote> quotes = [ ... ];

@observable 
Quote currentQuote;
{% endprettify %}

Wrap the observable variable inside `{{'{{'}} }}` in the UI to get its value:

{% prettify dart %}
{% raw %}
<div><em>{{currentQuote.quote}}</em> - {{currentQuote.saidBy}}</div>
{% endraw %}
{% endprettify %}

Now, cycle through the collection of quotes, picking a new quote every few
seconds:

{% prettify dart %}
var i = 0;
currentQuote = quotes[i];

new Timer.periodic(new Duration(seconds: 2), (_) {
  i = (i == quotes.length - 1) ? 0 : i + 1;
  currentQuote = quotes[i];
});
{% endprettify %}

The quote displayed on the page changes as the observable variable's value
changes. The rest of the page remains the same, and you don't have to modify
the page's markup!

Here is the entire script:

{% prettify dart %}
{% raw %}
<!DOCTYPE html>

<html>
  <body>
    <div><em>{{currentQuote.quote}}</em> - {{currentQuote.saidBy}}</div>
  
    <script type="application/dart">
      
      import 'dart:async';
      import 'package:web_ui/web_ui.dart';
      
      class Quote {
        final String quote, saidBy; 
        Quote(this.quote, this.saidBy);
      }
      
      @observable 
      Quote currentQuote;
        
      void main() {
        List<Quote> quotes = [
          new Quote('This agression will not stand, man.', 'The Dude'),
          new Quote('You are entering a world of pain', 'Walter'),
          new Quote('The rug really tied the room together.', 'The Dude'),
          new Quote('Sometimes you get the bar, sometimes the bar gets you.',
          'The Stranger'),
          new Quote('Mark it zero, dude', 'Walter')
        ];
            
        var i = 0;
        currentQuote = quotes[i];
         
        new Timer.periodic(new Duration(seconds: 2), (_) {
          i = (i == quotes.length - 1) ? 0 : i + 1;
          currentQuote = quotes[i];
        });
      }   
    </script>
  </body>
</html>
{% endraw %}
{% endprettify %}


### Creating a bidirectional binding using text elements

#### Problem

You are using a text field (text input or textarea) to set the value of a Dart
variable. You want that variable to be modified in real time, without a page
refresh.

#### Solution

First, make the variable observable:

{% prettify dart %}
{% raw %}
@observable
var myVar = value;
{% endraw %}
{% endprettify %}

Then, bind a text input or a textarea to that variable. Use 'bind-value='
syntax:

{% prettify dart %}
<input type='text' bind-value='myVar'>
<textarea bind-value='myVar'></textarea>
{% endprettify %}

This creates a bidirectional binding: changing the variable's value updates 
the UI, and changing the UI updates the variable's value.

#### Example

You've started micro-blogging. You have a webpage where you display one of your
posts, along with a simple textarea to edit that post. You're restricting
yourself to 140 characters, and want the UI to tell you how many characters
you have remaining when you type.

To enable real-time editing of a post, make the post variable observable:

{% prettify dart %}
@observable
var post = 'This is my very first post about Dart, and the' + 
           ' only thing I have to say is ...it is awesome!!!';
{% endprettify %}

Use `{{'{{'}} }}` syntax for displaying the post and its length:

{% prettify dart %}
{% raw %}
<p>{{post}}</p>
<p><em>Post Length:</em>  {{post.length}}</p>
{% endraw %}
{% endprettify %}

Then, create the binding in the textarea for editing the post, along with a
tracker that tells you how many characters you have remaining:

{% prettify dart %}
{% raw %}
<textarea rows='4' cols='40' bind-value="post"></textarea>
<p><em>Chars remaining:</em> {{MAXLENGTH - post.length}}</p> 
{% endraw %}
{% endprettify %}

That's it, you're done!

By sprinkling a few declarative statements in your code, you get to enjoy all
the functionality that bidirectional binding gives you:

* You need to do nothing to make the textarea sticky: it automatically contains
the post text.
* Modifying the post in the textarea changes the post object in real
time. There is no DOM manipulation required.
* By observing the post object, you get to observe its attributes (in this
case, the `length` property) for free.

Here is the entire script:

{% prettify dart %}
{% raw %}
<!DOCTYPE html>

<html>
<body>
  <h3>Post</h3>
  <p>{{post}}</p>
  <p><em>Post Length:</em>  {{post.length}}</p>

  <p>
    <em>Edit Post:</em><br>
    <textarea rows='4' cols='40' bind-value="post"></textarea>
  </p>
  <p><em>Chars remaining:</em> {{MAXLENGTH - post.length}}</p>

  <script type="application/dart">
    import 'package:web_ui/web_ui.dart';

    @observable
    var post = 'This is my very first post about Dart, and the' + 
               ' only thing I have to say is ...it is awesome!!!';
    const num MAXLENGTH = 140;

    main() {}

  </script>
</body>
</html>
{% endraw %}
{% endprettify %}


### Creating a binding using radio buttons

#### Problem

You want to use radio buttons to allow a user to select a single value from a
set of choices. You want to bind the value of the selected radio button to a
Dart variable.

#### Solution

First, make the Dart variable used to store the value of the radio button
observable:

{% prettify dart %}
@observable
var myVar = '';
{% endprettify %}

Then, use 'bind-value=' syntax to bind the value of a radio button to that
variable:

{% prettify dart %}
<input type='radio' name='someName' value='someValue' bind-value='myVar' />
{% endprettify %}

As the user selects a button, its value is automatically stored in the
observable variable. The display of the observable variable is updated as its
value changes if it is placed within `{{'{{'}} }}` in the HTML.

To bind multiple radio buttons to the same variable, assign the same value to
each radio button's name attribute. See the example below.

#### Example

Here is a simple example of how you can create a bidirectional binding when
using radio buttons. Giving the observable variable a value selects the
radio button with that value:

{% prettify dart %}
{% raw %}
<!DOCTYPE html>

<html>
  <body>
    <div>
      <input type='radio' name='veggies' value='kale' bind-value='veg'>
        Kale<br>
      <input type='radio' name='veggies' value='spinach' bind-value='veg'>
        Spinach<br>
      <input type='radio' name='veggies' value='carrots' bind-value='veg'>
        Carrots
    </div>
    
    <p>veg = {{veg}}</p>
     
    <script type='application/dart'>
      
      import 'package:web_ui/web_ui.dart';

      @observable
      String veg = 'spinach'; // Sets an initial value. Button with 
                              // value == 'spinach' is auto-selected.

      void main() {}
      
    </script>
  </body>
</html>
{% endraw %}
{% endprettify %}


### Creating bindings for booleans using checkboxes

#### Problem

You want to use a checkbox to store the value of a boolean object. And because
you have parts of your UI dependent on that boolean object, you want its value
to update automatically as a user checks or unchecks the checkbox.

#### Solution

Make the boolean observable:

{% prettify dart %}
@observable
bool someBool = false;
{% endprettify %}

Bind the checkbox to a boolean using `bind-checked=` syntax:

{% prettify dart %}
<input type='checkbox' bind-checked='someBool'>
{% endprettify %}

Checking the checkbox sets the boolean value to true, and unchecking it sets
the value to false:

{% prettify dart %}
{% raw %}
<!DOCTYPE html>
<html>
  <body>
    <input type='checkbox' bind-checked='someBool'>Check or uncheck<br>

    <p>The checkbox is {{someBool ? 'checked' : 'unchecked'}}</p>
 
 
    <script type='application/dart'>
      import 'package:web_ui/web_ui.dart';
       
      @observable
      bool someBool = true;
      
      void main() {}
   
    </script>
    <script src='packages/browser/dart.js'></script>
  </body>
</html>
{% endraw %}
{% endprettify %}


#### Example

The code below demonstrates the use of checkboxes to toggle the boolean
attributes of an object:

{% prettify dart %}
{% raw %}
<!DOCTYPE html>
<html>
  <head>
    <style>
      th, td {border: 1px solid black; padding: 20px}  
    </style>
  </head>
  <body>
    <div>
      Edit record for student <em>{{student.studentId}}:</em><br>
      <input type='checkbox' bind-checked='student.isGraduating' />
          Graduating?<br>
      <input type='checkbox' bind-checked='student.isHonorStudent' />
          Honor Student?<br>
    </div> 
    
    <br>
    
    <table>
      <tr><th>Student Id</th><th>Graduating?</th><th>Honor Student?</th></tr>
      <tr>
        <td>{{student.studentId}}</td>
        <td>{{student.isGraduating ?   'Yes' : 'No'}}</td>
        <td>{{student.isHonorStudent ? 'Yes' : 'No'}}</td>
      </tr>
    </table>  
    
    <script type='application/dart'>
      import 'package:web_ui/web_ui.dart';

      class Student {
        final String studentId;
        
        @observable
        bool isGraduating;
        
        @observable
        bool isHonorStudent;
        
        Student(this.studentId, this.isGraduating, this.isHonorStudent);
      }
      
      Student student;
      
      void main() {
        student = new Student('12345678', false, true);
      }
      
    </script>

    <script src='packages/browser/dart.js'></script>
  </body>
</html>
{% endraw %}
{% endprettify %}

Note that we mark the boolean instance variables of the `Student` class as
@observable:

{% prettify dart %}
{% raw %}
class Student {
  final String studentId;
  
  @observable
  bool isGraduating;
  
  @observable
  bool isHonorStudent;
  
  Student(this.studentId, this.isGraduating, this.isHonorStudent);
}
{% endraw %}
{% endprettify %}

This creates a one-way binding between the values stored within the observable
attributes of any `Student` object and the UI:

{% prettify dart %}
{% raw %}
<td>{{student.isGraduating ?   'Yes' : 'No'}}</td>
<td>{{student.isHonorStudent ? 'Yes' : 'No'}}</td>
{% endraw %}
{% endprettify %}

We make the binding bidirectional using `bind-checked=` syntax. This allows us
to modify the observable instance variables using the bound checkboxes:

{% prettify dart %}
{% raw %}
Edit record for student <em>{{student.studentId}}:</em><br>
<input type='checkbox' bind-checked='student.isGraduating' />
    Graduating?<br>
<input type='checkbox' bind-checked='student.isHonorStudent' />
    Honor Student?<br>
{% endraw %}
{% endprettify %}

Note that setting one of the instance variables to `true` automatically checks
the corresponding checkbox when the page loads:

{% prettify dart %}
new Student('12345678', false, true);
{% endprettify %}


### Selecting multiple items from a list of checkboxes using data binding

#### Problem

You want to use checkboxes to allow a user to select multiple values from a
set of choices. You want to keep track of the checkboxes that are checked
by the user, and want live updates in the UI every time the user checks or
unchecks a checkbox.

#### Solution

Create a map to keep track of the checked state of the checkboxes. Make the
checkbox values the map keys, and assign each key a boolean value. Assign `true`
for a checked checkbox, and `false` for an unchecked one. 

Now, sync the checkboxes and the map by creating a bidirectional binding
between them.

First, make the map observable. You can do this by using the top-level
`toObservable()` function:

{% prettify dart %}
Map<String, bool> myMap = toObservable({'value1': true, 'value2': false});
{% endprettify %}

Then, bind each checkbox to the corresponding map key using `bind-checked=`
syntax:

{% prettify dart %}
{% raw %}
<input type='checkbox' bind-checked='myMap["value1"]'>{{value1}}
<input type='checkbox' bind-checked='myMap["value2"]'>{{value2}}
{% endraw %}
{% endprettify %}

When the page loads, checkboxes corresponding to map keys with `true` values
are checked.  As the user checks and unchecks checkboxes, the map values update
accordingly.

To know which checkboxes were checked by the user, select the map keys with
`true` values.

#### Example

Here is a short example that you can build and run:

{% prettify dart %}
{% raw %}
<!DOCTYPE html>
<html>
  <body>
    Pick your favorite colors:<br>

    <template repeat ='key in colors.keys'>
      <input type='checkbox' bind-checked='colors[key]'>{{key}}<br>
    </template>

    <template if='!selectedColors.isEmpty'>
      <br>
      You picked:
      <ul>
        <li template repeat='color in selectedColors'>{{color}}</li>
      </ul>
    </template> 
 
    <script type='application/dart'>
      import 'package:web_ui/web_ui.dart';
       
      final Map<String, bool> colors = toObservable(
        {'red': false, 'blue': false, 'green': false}
      );
      
      List<String> get selectedColors {
        return colors.keys.where((c) => colors[c]).toList();
      }
      
      void main() {}
   
    </script>
    <script src='packages/browser/dart.js'></script>
  </body>
</html>
{% endraw %}
{% endprettify %}

We bind the checkbox values to a map as described earlier in this recipes. We
implement a getter to keep track of the checked values. 

Note that getters and setters do not have to be marked as observable: you just
need to make sure that all fields they depend on are observable. In our example,
the `selectedColors` getter relies only on the `colors` map. Since we have
made `colors` observable, `selectedColors` executes when the values in
`colors` change. As a result, the parts of the UI responsible for displaying
the values of the checked checkboxes gets updated in real time:

{% prettify dart %}
{% raw %}
<ul>
  <li template repeat='color in selectedColors'>{{color}}</li>
</ul>
{% endraw %}
{% endprettify %}

{::options parse_block_html="true" /}
</div> <!-- End of "col-md-7" -->
</div> <!-- End of "row" -->
{::options parse_block_html="false" /}  
