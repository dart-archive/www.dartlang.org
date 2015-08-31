---
layout: article
title: "Guidelines for Doc Comments"
rel:
  author: kathy-walrath
description: "How we write doc comments for the Dart APIs."
has-permalinks: true
article:
  written_on: 2012-11-01
  updated_on: 2014-09-22
  collection: everyday-dart
---

{% include toc.html %}
{% include breadcrumbs.html %}

# {{ page.title }}

<em>Written by Kathy Walrath<br />
<time pubdate date="2012-11-21">November 2012</time>
(updated September 2014)
</em>

This document describes the conventions the Dart team
has agreed upon for documentation comments.
If you have suggestions for improving the conventions,
[let us know](http://groups.google.com/a/dartlang.org).
To produce documentation from comments,
use the [dartdoc tool](https://github.com/dart-lang/dartdoc#dartdoc).

See also these related articles:

* [Dart Style Guide](/articles/style-guide/)
* [API Naming Guide](/articles/api-naming-guide/)


## Examples

Here's a typical comment for a function or method:

<!-- BEGIN(min) -->{% prettify dart %}
/// Returns the lesser of two numbers.
///
/// Returns NaN if either argument is NaN.
/// The lesser of -0.0 and 0.0 is -0.0.
/// If the arguments are otherwise equal
/// (including int and doubles with the same mathematical value)
/// then it is unspecified which of the two arguments is returned.
///
///     return min(100, value);
num min(num a, num b) {...}
{% endprettify %}<!-- END(min) -->

And one for a variable or property:

<!-- BEGIN(PI) -->{% prettify dart %}
/// The pi constant.
const double pi = 3.1415926535897932;
{% endprettify %}<!-- END(PI) -->

For an example of a library with doc comments, see the `path` library.
([generated doc](http://www.dartdocs.org/documentation/path/1.3.3/index.html#path/path),
[source code](https://github.com/dart-lang/path/blob/1.3.3/lib/path.dart)).

<aside class="alert alert-info" markdown="1">
<b>Style note:</b>
Dart supports two syntaxes for doc comments: `///` and `/**`.
This document follows the
[style guide recommendation](/articles/style-guide/#do-use-doc-comments-when-commenting-members-and-types)
of using `///`. Older source code tends to use `/**`.
</aside>

## Content

The first paragraph of a doc comment is special.
After that, the content is up to you,
although we strongly recommend including code samples.


### First paragraph: a "one-sentence" description

As the examples at the top of this document show,
the first paragraph of any doc comment
is a brief, user-oriented description ending with a period.
It is not a complete sentence.

The description should help the reader understand
whether this bit of API might be useful to them,
compared to similar sounding API.
Never just repeat the API name;
try to restate it to give more information
than the name alone provides.
Avoid links when possible.


#### Functions and methods
{:.no_toc}

Function/method descriptions begin with a **third-person verb**.

Examples:

* `Returns true if every element of this collection satisfies the predicate [f]. `
* `Starts the stopwatch.`


#### Variables, getters, and setters
{:.no_toc}

Static/instance variable and getter/setter descriptions are **noun phrases**.

If there’s both a setter and a getter, comment only the getter.
That way, it’ll be treated as a variable.
Don’t include the type, since that’s already in the signature.

Example:

* `The number of days in the current month.`


#### Classes
{:.no_toc}

Class descriptions are **noun phrases**.

Examples:

* Possible description for [List](http://api.dartlang.org/dart_core/List.html): <br>`An indexable collection with a length, also known as an array.`

* Possible description for [String](http://api.dartlang.org/dart_core/String.html): <br>`A basic string, implemented as an immutable sequence of UTF-16 code units.`


#### Libraries
{:.no_toc}

Library descriptions are **noun phrases**.

Examples:

* Possible description for [dart:core](http://api.dartlang.org/dart_core.html): <br>`Core functionality that's automatically imported into every Dart program.`

* Possible description for [dart:collection](http://api.dartlang.org/dart_collection.html): <br>`Data structures for managing collections of objects.`



### The rest of the doc comment

Subsequent paragraphs explain return values,
what arguments you can specify, side effects,
exceptions that users might want to catch, related APIs, and so on.

Be sure to provide **code examples** for the most common uses of the API,
and **links** to documents that provide more information.


## Markup

The [dartdoc](https://github.com/dart-lang/dartdoc#dartdoc)
tool currently recognizes markdown formatting,
as well as some dartdoc-specific markup.

**When in doubt, format less.**
You'll be less likely to break the docs,
and someone else can always add formatting.
In particular, **don't use HTML formatting**.
For details on markdown, see the
[markdown package](https://pub.dartlang.org/packages/markdown), which the
dartdoc tool currently uses to format documentation comments.

<aside class="alert alert-info" markdown="1">
**Note:**
A new version of the documentation generator is being developed.
For details, see the [dartdoc project](https://github.com/dart-lang/dartdoc).
</aside>

### Links

Normal URI hyperlinks are supported, as well as automatic links to Dart identifiers.

#### Identifier
{:.no_toc}

`[id]`

This generates a hyperlink to a Dart identifier. This identifier can be a class,
method, or property inside the current library. For example:

{% prettify none %}
Throws a [StateError] if ...
similar to [anotherMethod], but ...
{% endprettify %}


#### Constructor
{:.no_toc}

`[new c]`

This generates a hyperlink to the constructor for _c_.

#### Hyperlink
{:.no_toc}

`[text](uri)` _or_ `<uri>`

Both generate a hyperlink to `uri`. The first form uses _text_ as the link
text. The second form uses _uri_ as the link text.


### Block styles

#### Paragraph
{:.no_toc}

Use _a blank line_ to denote the end of a paragraph.

#### Code block
{:.no_toc}

Use four blank spaces _after the line's comment characters,_
which means **five spaces** after the * or /
(since they're always followed by a space).
Example:

{% prettify dart %}
/// ...
/// For example:
///
///     Future&lt;int> future = getFutureFromSomewhere();
///     future.then((value) {
///       print("I received the number $value");
///     });
/// ...
{% endprettify %}

#### Header
{:.no_toc}

{% prettify none %}
## header text until newline
{% endprettify %}

Lower level headers (such as `###`) also work.


#### Bulleted (unordered) list item
{:.no_toc}

{% prettify none %}
* item continues until next list item or blank line
{% endprettify %}

The line before the first bulleted list item must be blank.


#### Numbered (ordered) list item
{:.no_toc}

{% prettify none %}
1. item continues until next list item or blank line
2. next item
{% endprettify %}

Although items are currently autonumbered,
they might not always be.
Use `2.` for item #2, `3.` for item #3, and so on.


### Inline styles

#### Code font
{:.no_toc}

<code>`code`</code> _(note the backquotes)
or_
<code>[:code:]</code>

Avoid code font unless it’s (1) a big chunk of code or
(2) necessary to prevent confusion.

#### Italics
{:.no_toc}

`_single underscore_`
_or_
`*single asterisk*`


#### Boldface
{:.no_toc}

`**double asterisk**`
_or_
`__double underscore__`

Here's an example of a warning:

{% prettify dart %}
/// ...
///
/// **Warning:** This feature is not yet supported in all modern browsers.
/// See <http://caniuse.com/flexbox> for current status.
///
/// ...
{% endprettify %}


## Word choice, punctuation, and so on

* Keep it short, direct, and clear.
  Doc comments are for the API's users, not its implementers.
* Avoid abbreviations such as “i.e.” and “e.g.”
  (Many people don’t know what they mean.)
  Just say “that is” and “for example” if necessary.
* Use single quotes (') instead of double quotes (") in code samples
  unless you have a reason to do the opposite.
  (Just be consistent.)
* Use "this" instead of "the"
  when referring to an object created from the current class.
  Example:
  Adds an item to this list.


## Resources

* [Comments](/articles/style-guide/#comments)
  section of the Dart Style Guide
* dart:math API doc
  ([generated doc](http://api.dartlang.org/dart_math.html),
  [source code](https://github.com/dart-lang/sdk/blob/master/sdk/lib/math/math.dart))
* [dart-doc-testing](https://github.com/kwalrath/dart-doc-testing) project
  ([generated doc](http://kwalrath.github.com/dart-doc-testing/comment_test/CommentTester.html),
  [source code](https://github.com/kwalrath/dart-doc-testing/blob/master/CommentTest.dart))
