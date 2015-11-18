---
layout: default
title: Frequently Asked Questions (FAQ)
description: You have questions about Dart, we have answers.
has-permalinks: true
---

{% include toc.html %}

# {{ page.title }}

_Updated April 2015_

This page collects some of the top questions we've heard from the community
since Dart was open sourced. For more details, read the
[Dart language tour][lang] and [Dart libraries tour][libs].

## Motivation

### Q. Why Dart?

At Google we've written our share of web apps, and we've tried in many ways to
make improvements to that development process, short of introducing a new
language.  Now we think it's time to take that leap.  We designed Dart to be
easy to write development tools for, well-suited to modern app development, and
capable of high-performance implementations.

### Q. Is the language really what needs to be fixed in web development?

We want to [fix ALL the things][fixallthethings].  There's "Dart" the language,
and then there's "Dart" the overall project.  The Dart _project_ is
betting that the language needs some changes, but we also want to
[improve the DOM][improvethedom] and other libraries, and
to improve the tools we use.

At the same time, Google is also placing bets that JavaScript _can_ be
evolved as needed, and contributing to that work.  Google wants web development
to be great, and if that happens with JavaScript, we're happy.

### Q. Is Dart going to divert community effort from JavaScript-based web development?

If people like Dart and use it, then to a certain extent, yes, but isn't this
true of any improvement to existing web development?  Nothing is zero-effort to
learn or 100% back-compatible to legacy browsers, so people use both new and
old.  You might look at it this way: Google is putting significant effort behind
both Dart and JavaScript, choosing to develop Dart while at the same time using
JavaScript extensively, and working on JavaScript tools, implementation, and
language spec.  We're doing both because we think Dart is worth it.

Server-side web programming finds room for many languages: does Python divert
effort from Perl, and does Java undercut C++?  Again, to a certain extent, yes
they do, but people generally consider that a healthy situation, better than if
we all used a single programming language.  Multiple languages have allowed for
faster change than any single language has achieved through a standards process.
Furthermore, languages coexist in different niches: does Groovy really compete
directly with C++?  People face different engineering tradeoffs and choose
different languages to meet them.  Ultimately, we think client-side developers
should have this kind of flexibility.

### Q. Is Dart under the control of a standards body?

Yes. As of December 2013, [Ecma TC52][tc52] has been put in charge to own,
evolve, and publish the [standard specification][spec] of the Dart language.
In addition to TC52, we have also introduced a process for submitting
Dart enhancement proposals ([DEP][DEP]), because we wanted to make it easier
to contribute to and follow the evolvement of Dart.

### Q. How are you taking input on changes to the Dart repository?

We listen to feedback and issues, and we review patches from contributors.
A contributor with a good track record can become a committer to the repository.
Google engineers will also be working in the public repository, making visible
changes. The project is lucky to have received many external patches and has
welcomed distributed committers.

### Q. Why didn't Google make Dart an open standard right from the start?

We're taking the usual route to get to an open-standard programming language:
someone creates a coherent first version, people experiment with it, and we
standardize later.  The open standard web platform has been known to add other
pieces this way, where standardization follows after a vendor experiment:
canvas, for example.  We understand that this route raises concerns, but we
think it is sometimes useful, and in particular that it is useful for
programming languages, where design by committee is risky.

The most recent successful language designed by an open committee was Haskell,
starting in 1990.  The most widely used was COBOL, followed by Ada.  It's not a
common way to do language design.  Among dozens and dozens of major languages,
six (give or take a couple of debatables) were designed this way.  (And one of
those six was ALGOL-68.)

### Q. Why didn't Google build a bytecode VM targetable by multiple languages including Dart?

Each approach has advantages and disadvantages, but we feel that in the
context of Dart it made sense to build a language-specific VM for the following
reasons:

* Google already works on a multi-language bytecode:
[LLVM bitcode in PNaCl][pnacl].

* Even if a bytecode VM is specialized for Dart, a language VM will be simpler
and faster because it can work under stronger assumptions&mdash;for instance,
a structured control flow.  These assumptions make the implementation cleaner
and optimizations easier.

* A general-purpose bytecode VM would be even larger and slower, as it
generalizes assumptions and adds functionality that for Dart is dead code:
for example, multithreading with a shared heap.

* No bytecode VM is truly general-purpose; they all make assumptions that
privilege some class of languages.  A language VM leaves more room to improve
the VM and make deep changes to optimization of the language. Some Dart
engineers wrote [an article][whynotbytecode] talking
about the VM question in more detail.

### Q. Does Google want to replace JavaScript with Dart?

We believe developers should have a choice when they build for the web.
Adding a new option, such as Dart, does not imply replacing an existing
option.


## Language

### Q. Isn't Dart a lot like JavaScript?

Yes and no.  The Dart project thinks that JavaScript can use some changes for
more productive software engineering, smarter editors and development
environments, and web apps that are as beautiful and pleasing as the best client
apps can be.  On the other hand, we don't think everything needs to change, and
why change what isn't broken?

Dart, like JavaScript, is a dynamically typed language.  It adds optional
type annotations to help you catch errors earlier.  It takes out a
few features of JavaScript, such as prototypes and the global object: this
streamlines the VM, enables faster execution, and makes it easier to do code
completion and refactoring.  And Dart adds some goodies.  To name a few:

* User-defined operator methods.  We like the lightweight, readable code
these give for <a href="/articles/improving-the-dom/">our DOM interface</a>.

* Lightweight syntax for anonymous functions.  You use them a lot in
web programming; now they look great.  And they come with correct
binding of <code>this</code> and full block-level lexical scoping, no gotchas.

Dart is more than a new syntax, it's a full language with its own semantics.
Dart differs from JavaScript in many ways, including:

* Only `true` is true.
* No `undefined`, only `null`.
* No automatic type coercion with `==`, `+`, and other operators.

When compared to JavaScript, Dart aims to be faster, more regular, and more
scalable to large programs.


### Q. Isn't Dart a lot like Java?

Well, Java is statically typed, and Dart is dynamically typed.  Dart has
optional static type annotations, where in Java they are required.  To us these
are big differences in the nature of the two languages.  But Dart is a
curly-brace language, and it shares some keywords with Java, such as
`extends` and `final`, so we can see why people make the
comparison.  Honestly, we like having a straightforward and familiar syntax
that's easy to pick up, even if that means it's less exciting.

A few of the many other [examples of how Dart differs from Java][dartisnotjava]
include:

* The JVM is a bytecode VM, requiring source to be compiled first. The Dart VM
runs source code.

* The Dart language supports collection literals for a terse way to create
lists and maps.

* Java supports public, protected, package protected, and private. Dart supports
public and library-private.

* Dart is purely object oriented. Java has objects and primitives.

* The Dart language has mixins, optional static types, named parameters, and
more.

### Q. How does Dart compare with using the Closure compiler on JavaScript?

The idea of optional type annotations is similar.  Dart's are nicer
syntactically.

Compare the following Closure compiler code:

{% prettify dart %}
// Closure compiler code

/**
 * @param {String} name
 * @return {String}
 */
makeGreeting = function(name) {
  /** @type {String} */
  var greeting = 'hello ' + name;
  return greeting;
}
{% endprettify %}

With the following Dart code:

{% prettify dart %}
// Dart code

String makeGreeting(String name) {
  String greeting = 'hello $name';
  return greeting;
}
{% endprettify %}

### Q. How does Dart compare with CoffeeScript?

Both Dart and CoffeeScript are inspired by JavaScript, and both can be
translated back to it.  They make different choices, particularly in the flavor
of their syntax.  As a language we think it's fair to say that Dart differs
semantically from JavaScript more than CoffeeScript does; that may result in a
less line-for-line translation, but we believe Dart-generated JavaScript can
have excellent size and speed.

Dart introduces new semantics, while CoffeeScript retains the semantics
of JavaScript.

If you like CoffeeScript for its more structured feel than raw JavaScript, you
may like Dart's optional static type annotations.

### Q. What does Google think of TypeScript?

TypeScript and Dart have similar goals; they make building large-scale web
applications easier. However, their approaches are fairly different. TypeScript
maintains backwards compatability with JavaScript, whereas Dart purposely made a
break from certain parts of JavaScript’s syntax and semantics in order to
eradicate large classes of bugs and to improve performance. The web has suffered
from too little choice for too long, and we think that both Dart and TypeScript
are pointing to a brighter future for web developers. You can read a
[more complete response][typescript] on our blog.

### Q. How does Dart relate to Go?

Dart and Go are both language projects started at Google, but they are
independent and have different goals.  As a result, they make different choices,
and the languages have very different natures, even while we all try to learn
from each others' work.

### Q. Why isn't Dart more like Haskell / Smalltalk / Python / Scala / other language?

Various reasons, depending on the language being asked about.

For languages that are quite different from JavaScript: it's important for Dart
to compile to efficient JavaScript.  Our experience in GWT is that if the source
language is too different from JavaScript, it creates some cases where complex
output code is needed to emulate the source language's behavior.  This can cause
performance to vary in ways that are not transparent to the programmer.

For languages that are less mainstream: we expect that modeling Dart on these
would, on the whole, hurt our adoption.  Our team includes fans of these
languages, and if we thought Dart could take up our favorite cool language
features and push them to widespread adoption we might be tempted, but really we
think we've got our hands full introducing a new language at all.

For languages that are "more dynamic" than Dart: Dart deliberately trades off
some of this arbitrary runtime modification for the goal of better performance
and tools.

### Q. Why isn't Dart syntax more exciting?

We did throw in some nice syntactic features such as `this.`
constructor args and `=>` for one-line functions,
but we'd agree that Dart chooses familiarity over excitement.
One team member's personal testimonial: "I wish it had a little more razzle
dazzle but I can't deny that literally on my first day of writing Dart code, I
was productive in it."

### Q. Is it really a dynamic language if it doesn't have eval() or adding fields to a value at run time?

Dart as initially released didn't have anything like these, but future versions
of Dart may look at adding dynamic features of this sort.  The feature set
won't match up exactly with the features in your question, but we hope to serve
very much the same purposes.  When we see what gets added, then everyone can
decide how they classify the language.

What's important to us is that what you want to do with a dynamic language, you
can do with Dart and not feel cramped.  You should be able to design your system
without interference from static rules, and to modify the live system during
development and sometimes at run time.

So, for example, Dart isn't likely to support evaluating a string as code in the
current context, but it may support loading that code dynamically into a new
isolate.  Dart isn't likely to support adding fields to a value, but it may
(through a mirror system) support adding fields to a class, and you can
effectively add methods using `noSuchMethod()`.  Using these features
will have a runtime cost; it's important to us to minimize the cost for programs
that don't use them.

This area is still under development, so we welcome your thoughts on what you
need from runtime dynamism.

### Q. Does Dart have reflection capabilities?

We have reflection support from
the <a href="/articles/reflection-with-mirrors/">mirrors API</a>.

### Q. Can Dart add tuples, pattern matching, non-nullable types, partial evaluation, optional semicolons, ...?

The language is now at 1.0, but we anticipate further language evolution
to occur in a standards group.  It might be able to include your feature,
although it can't include everything.  Some features don't fit the basic nature
of the language, and some don't play well with other features.  Simplicity is
the single most important gift we all can give to future programmers.

Please look at the [list of Dart issues][issues] to see if your request is
already there, and add a new issue if not.  Make a thoughtful argument for your
feature.  Sample code with and without your feature is good evidence; a sizeable
codebase that shows the need is even better evidence.

Please don't be surprised if the Dart designers say "no" by default, especially
for now.  It's far more painful to remove a language feature than to add it, so
Dart is likely to add the most obvious features first, and then revisit the next
tier later.  And there simply are more possible language features in the world
that can fit into any single language without making a total hash of it.   But
we do very much appreciate suggestions and evidence.  We hope you'll see our
appreciation through careful design choices and fair communication about them.

## Types

### Q. Does Dart have type inference?

Type inferencing is not something specified by the language specification, but
it is something that implementations are free to do. It's important to remember
that Dart has a dynamic type system, so type inferencing doesn't play the same
role as it does in languages such as Haskell. However, IDEs might do some
type inferencing, such as when you use var for local variables.

### Q. Why are type annotations optional?

We want to maintain the feel of a dynamically typed language, which is familiar
to web developers. Mandatory types don't fit with that goal. Experience
has also shown that full statically typed languages are sometimes too rigid,
and we wanted Dart development to be more flexible for a wide range of
developers.

### Q. Why is the type system designed to be unsound?

Rather than using a full, static type system, Dart has a dynamic type system
with optional static type annotations. Our main goals for the types are to
support tooling and documentation. We want to build a pragmatic tool that helps
web programmers without getting in their way.  In particular, we want our static
warnings to be optimistic rather than to complain about dynamically typed code
that may be valid and correctly written, such as "downcast" assignments.
Because Dart _execution_ is always type-safe, we can let some unsound cases
get through the static warnings and be caught at run time instead.

Typical object-oriented languages let you downcast, which also introduces
unsoundness into the type system and may result in a runtime type error.  In
Dart, we choose to allow downcasts without a syntax to mark them.

### Q. But don't you need sound typing information to get high performance?

Sound types can help with performance but aren't essential. What we need are
uniform, simple semantics. Modern VMs can use actual runtime behavior as a
valuable signal for optimizations.

### Q. Why do type annotations have no effect on the runtime behavior?

If type annotations affect the runtime, programs will change their behavior as
programmers add type information, even though the logic remains unchanged. The
normal mode of development is to gradually add types for documentation and
validation, and if that changes what the program does, programmers have no
stable foundation to work on. This is especially true given that types could be
inaccurate.

In addition, this policy helps us and others add additional type-checking tools
that implement different policies without unforeseen interactions with the
runtime.

### Q. Why are generics covariant?

Covariant generics fit a common intuition that programmers have, and very often
this intuition is correct, such as in the common "read-only" use of a generic.
Although this intuition isn't always correct, Dart doesn't need it to be.  Dart
has already chosen optimistic static checking, so why not continue down that
path and allow covariant uses of generics to pass static type checking?

Where covariant generics are too optimistic, Dart's type-safe execution allows
the static warnings to be optimistic without being dangerous.  Although
covariance can be pessimistic too, we think it will be rare that people run into
that, and and there's a simple workaround for any pessimism.

We are familiar with a variety of ways that languages try to mark or infer
variance.  We don't think any of them are suitable for Dart, where we want type
annotations to be optional and unobtrusive: it wouldn't fit to _require_
marking, and we feel that variance inference systems add too much complexity for
their benefit in Dart.

Again, we're trying to be pragmatic, and we think the outcome is reasonable.

## Browsers and compiling to JavaScript

### Q. What browsers do you support as JavaScript compilation targets?

We support the following browsers:

* Internet Explorer, versions 9, 10, and 11.
  * Dart v1.5 was the last release to support Internet Explorer 9.
* Firefox, latest version.
* Chrome, latest version.
* Safari for desktop, version 6.
* Safari for mobile, version 6.

{% comment %}
[TODO: check version #s every time we update this file]
{% endcomment %}

### Q. Why doesn't Dart support IE9 or earlier?

Supporting legacy browsers takes a lot
of engineering resources and testing infrastructure.
Dart is a bet for the future, and the project can't push forward if it needs
to spend valuable resources on supporting browsers that are dying or dead.
Also, dart2js can emit efficient code if it assumes a modern browser with
ECMAScript5 or greater features.

### Q. Is Dart supported by my browser?

Although no production browsers can execute Dart code directly,
all modern browsers can execute Dart code that's been compiled to JavaScript.
For convenience while you're developing Dart code,
you can use a version of Chromium (nicknamed [Dartium])
has the Dart VM integrated into it.

### Q. Will the Dart VM get into Chrome?

[No.](http://news.dartlang.org/2015/03/dart-for-entire-web.html)
Dart is designed to compile to JavaScript to run across the modern web, and the
dart2js compiler is a top priority for the team.

### Q. Why is the code for "Hello, World" so big, compared to the original Dart code, after compilation to JavaScript?

We believe that it's important to create small and efficient JavaScript
from Dart, but most developers don't write "Hello, World" apps. It's all
relative, and with tree shaking (dead code elimination), minification, and
compression, Dart apps can be compiled to JavaScript fairly efficiently.

Kevin Moore [saw improvements][ppwsize] in the size of the generated
JavaScript from his real-world HTML5 game.

The dart2js team strives to generate smaller output, but is more focused on
real-world apps instead of trivial examples.

### Q. How do I debug Dart code after it's been compiled to JavaScript?

dart2js generates [source maps][sourcemaps],
so you can debug Dart code in browsers that don't support the Dart VM.
However, even in rare cases where you must inspect the raw JavaScript, it's
fairly debuggable using the browser's normal JavaScript development tools.

### Q. Will any valid Dart code compile to JavaScript, or are there limitations?

We intend for any valid Dart code to compile to JavaScript.  Of course, there
are some libraries that will only run on the server because they
don't make sense in a browser context. For example, the `dart:io` library
provides access to operating system files and directories with APIs not
available to the browser.

### Q. How can dart2js produce JavaScript that runs faster than handwritten JavaScript?

You are probably referring to these [performance charts][perf]. Think of dart2js
as a real compiler, which can analyze your entire program and make optimizations
that you probably can't or won't do. Just like gcc can output efficient code
by moving code around, dart2js can take advantage of Dart's structured nature
to implement global optimizations.

We don't claim that all Dart code will run faster
than handwritten JavaScript, when compiled to JavaScript. But we're working
to make the common cases fast.

### Q. Why not compile Dart to asm.js instead of building a specialized VM?

Dart could have used asm.js in two ways; compiling Dart applications to asm.js,
or compile the Dart VM to asm.js.

However, after careful consideration it becomes clear that both ways incur non-
acceptable overhead which nullifies some of Dart’s value proposition: its fast
start-up and better performance.

#### Compilation of a Dart application to asm.js

Asm.js is a very restricted subset of JavaScript best suited as a compilation
target for C compilers. It does not include JavaScript objects, or direct
access to the DOM. Essentially, it only allows arithmetic operations and
manipulations on typed arrays.

While it is possible to implement the dynamic features that are required by
Dart, they would incur a large overhead in both speed and size, compared to
relying on the already existing features provided by the underlying JS engine.
For example, any JS machine comes with a garbage collector (henceforth GC), and
implementing another one in asm.js would increase the output size, and be
noticeably slower than the well-tuned GCs of modern JS VMs.

Similarly, JS VMs have spent significant effort in making dynamic dispatch
efficient, using a combination of dynamic code generation and self-modifying
code.

#### Compilation of the Dart VM to asm.js (for example via emscripten)

Arguments in the preceding section also apply here. A Dart VM in asm.js would
need to reimplement, on top of asm.js, many facilities that are already provided
by the JS VMs. Furthermore, asm.js doesn’t allow direct access to all machine
capabilities, like threading and specialized instruction sets.

Shipping the Dart VM (compiled to asm.js) with every program would also add
significant download size to every Dart program. Even cached, it would still
take a long time to compile the Dart VM (as asm.js) program on the client,
yielding significant start-up times.

Furthermore you would have to rewrite the Dart VM backend to generate asm.js
code, as the Dart VM relies on dynamic code generation to achieve peak
performance. (In an additional step, the JS VM would then need to compile that
code into assembly, adding to the latency.)

The generated code would be restricted to the instruction set that is provided
by asm.js, whereas a native VM can emit specialized instructions for the
platform.

That said, it would be amazing to see the Dart VM compiled to asm.js. This
experiment would have little practical value, but it would be a nice
achievement.

## Usage and tools

### Q. Is Dart stable?

Dart is, at the time of this writing, at version 1.0. The core language and
core libraries are considered stable for production use.

### Q. How does Dart code interoperate with JavaScript libraries?

Although Dart and JavaScript are completely separate languages with
separate VMs, they can interoperate. For more information, read the
[article on Dart-JavaScript][jsinterop].

### Q. I have a large JavaScript codebase.  How can I migrate it to Dart?

Try migrating one major feature at a time, and use the
[JavaScript interoperability library][jsinterop]
only when necessary.

### Q. I have a large application written in GWT. How do I port it to Dart?

Java and Dart are syntactically similar, so this might be easier than you think.
You can rely on the [Dart analyzer][dartanalyzer]
to flag any syntax problems. Alternatively, you may
consider porting one feature at a time to Dart and using the
[JavaScript interoperability library][jsinterop] as the common middle
ground. Be sure to watch our Google I/O 2012 talk <a
href="http://www.youtube.com/watch?v=EvACKPBo_R8">Migrating Code from GWT to
Dart</a>, but keep in mind that it predates our JavaScript interoperability
library.

### Q. Does Dart support JSON?

Yes.  See the [JSON] converters in the dart:convert library.

### Q. Can Dart run on the server?

Yes. See [Dart on the Server] for details.

### Q. How do I use third party code, or share code?

You can find many packages on [pub.dartlang.org][pub], a service for hosting
packages of Dart code. Use the `pub` command to package your code and upload
to pub.dartlang.org.

### Q. Can I use Angular with Dart?

Yes! [AngularDart][] is a port of Angular to Dart.

### Q. Can I use web components with Dart?

Yes! [Polymer.dart] is a port of polymer to Dart. Polymer is a set of
polyfills and usability enhancements for web components.

### Q. Should I use Angular or polymer?

Both. Or either. It's really up to you. We envision a world where polymer
lets you create and use custom elements. You should be able to use custom
elements in any web app.

### Q. Do I need to use a particular editor or IDE to write Dart code?

Nope.
You can try out Dart code with [DartPad],
and then use your favorite editor or IDE for real development.
Some full-featured IDEs such as IntelliJ IDEA
and WebStorm have Dart plugins.
Dart plugins also exist for Sublime, VIM, Emacs, and other editors.
We used to provide a Dart-specific editor called Dart Editor,
but as of 1.11 Dart Editor is no longer available.
For more information, see [Dart Tools].

### Q. Can I build an Android app with Dart?

We think that would be pretty cool, but you'd have to ask the Android team.
Both Dart and Android are open source, so maybe the community can make it
happen.

### Q. Can I build a Chrome App with Dart?

You can use the [chrome.dart] libraries, but as of December 2014 you
still need to compile to JavaScript. But otherwise, yes, you can build
a Chrome App with Dart.

### Q. Can I use Dart on App Engine?

Yes! See
[Dart and Google Cloud Platform]
for details.

### Q. What CPU architectures does the Dart VM support?

The Dart VM works on IA-32, x64, MIPS, ARMv5TE, ARMv6, ARMv7, and
ARM64 processors.

### Q. What are some real-world production deployments of Dart?

The [Dart 1.0 announcement][announcement] lists a few, like
internal Google apps, external Google apps,
Mixbook, blossom.io, Soundtrap, Mandrill, and more.
Many more have been released or are in development.
See [Who Uses Dart] for more.

[dartisnotjava]: http://programming.oreilly.com/2013/05/dart-is-not-the-language-you-think-it-is.html
[fixallthethings]: http://hyperboleandahalf.blogspot.com/2010/06/this-is-why-ill-never-be-adult.html
[improvethedom]: /articles/improving-the-dom/
[pnacl]: https://developers.google.com/native-client/overview#distributing-an-application
[whynotbytecode]: /articles/why-not-bytecode/
[typescript]: http://news.dartlang.org/2012/10/the-dart-team-welcomes-typescript.html
[issues]: http://dartbug.com/
[jsinterop]: /articles/js-dart-interop/
[sourcemaps]: http://www.html5rocks.com/en/tutorials/developertools/sourcemaps/
[io]: /articles/io/
[pub]: https://pub.dartlang.org
[AngularDart]: https://angulardart.org
[Polymer.dart]: /polymer/
[ppwsize]: http://work.j832.com/2012/11/excited-to-see-dart2js-minified-output.html
[perf]: /performance/
[chrome.dart]: https://github.com/dart-gde/chrome.dart
[announcement]: http://blog.chromium.org/2013/11/dart-10-stable-sdk-for-structured-web.html
[lang]: /docs/dart-up-and-running/ch02.html
[libs]: /docs/dart-up-and-running/ch03.html
[Oilpan]: https://docs.google.com/a/google.com/document/d/1y7_0ni0E_kxvrah-QtnreMlzCDKN3QP4BN1Aw7eSLfY
[Dartium]: /tools/dartium/
[JSON]: http://api.dartlang.org/docs/channels/stable/latest/dart_convert.html#JSON
[tc52]: http://news.dartlang.org/2013/12/ecma-forms-tc52-for-dart-standardization.html
[Dart on the Server]: https://dart-lang.github.io/server/
[Dart Tools]: /tools/
[Dart and Google Cloud Platform]: https://dart-lang.github.io/server/google-cloud-platform/
[Who Uses Dart]: /community/who-uses-dart.html
[spec]: http://www.ecma-international.org/publications/standards/Ecma-408.htm
[DEP]: https://github.com/dart-lang/dart_enhancement_proposals
[dartanalyzer]: https://github.com/dart-lang/analyzer_cli#dartanalyzer
[DartPad]: {{site.custom.dartpad.direct-link}}
