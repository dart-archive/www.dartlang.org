---
layout: default
title: "Pub Package Layout Conventions"
---

{% include toc.html %}

# {{ page.title }}

Part of a healthy code ecosystem is consistent conventions. When we all do the
same thing the same way, it makes it easier for us to learn our way around
each other's work. It also makes it easier to write tools that can
automatically do things for us.

When you build a [pub](/tools/pub/) package, we have a set of conventions we encourage you to
follow. They describe how you organize the files and directories within your
package, and how to name things. You don't have to have every single thing
these guidelines specify. If your package doesn't have binaries, it doesn't
need a directory for them. But if it does, you'll make everyone's life easier
if you call it `bin`.

To give you a picture of the whole enchilada, here's what a complete package
(conveniently named `enchilada`) that uses every corner of these guidelines
would look like:

    enchilada/
      pubspec.yaml
      pubspec.lock *
      README.md
      LICENSE
      asset/
        guacamole.css
      benchmark/
        make_lunch.dart
        packages/ **
      bin/
        enchilada
        packages/ **
      doc/
        getting_started.md
      example/
        lunch.dart
        packages/ **
      lib/
        enchilada.dart
        tortilla.dart
        src/
          beans.dart
          queso.dart
      packages/ **
      test/
        enchilada_test.dart
        tortilla_test.dart
        packages/ **
      tool/
        generate_docs.dart
      web/
        index.html
        main.dart
        style.css

\* The `pubspec.lock` will only be in source control if the package is an
[application package](glossary.html#application-package).

\** The `packages` directories will exist locally after you've run
`pub get`, but won't be checked into source control.

## The basics

    enchilada/
      pubspec.yaml
      pubspec.lock

Every package will have a [_pubspec_](pubspec.html), a file named
`pubspec.yaml`, in the root directory of the package. That's what *makes* it a
package.

Once you've run [`pub get`](cmd/pub-get.html) or [`pub
upgrade`](cmd/pub-upgrade.html) on the package, you will also have a
**lockfile**, named `pubspec.lock`. If your package is an [application
package](glossary.html#application-package), this will be checked into source
control. Otherwise, it won't be.

    enchilada/
      packages/
        ...

Running pub will also generate a `packages` directory. You will *not* check
this into source control, and you won't need to worry too much about its
contents. Consider it pub magic, but not scary magic.

The open source community has a few other files that commonly appear at the top
level of a project: `LICENSE`, `AUTHORS`, etc. If you use any of those, they can
go in the top level of the package too.

For more information, see [Pubspec Format](pubspec.html).

## README

    enchilada/
      README.md

One file that's very common in open source is a README file that
describes the project. This is especially important in pub. When you upload
to [pub.dartlang.org](http://pub.dartlang.org), your README will be shown on
the page for your package. This is the perfect place to introduce people to
your code.

If your README ends in `.md`, `.markdown`, or `.mdown`, it will be parsed as
[Markdown][].

[markdown]: http://daringfireball.net/projects/markdown/

## Public libraries

    enchilada/
      lib/
        enchilada.dart
        tortilla.dart

Many packages are [*library packages*](glossary.html#library-package): they
define Dart libraries that other packages can import and use. These public Dart
library files go inside a directory called `lib`.

Most packages define a single library that users can import. In that case,
its name should usually be the same as the name of the package, like
`enchilada.dart` in the example here. But you can also define other libraries
with whatever names make sense for your package.

When you do, users can import these libraries using the name of the package and
the library file, like so:

{% prettify dart %}
import "package:enchilada/enchilada.dart";
import "package:enchilada/tortilla.dart";
{% endprettify %}

If you want to organize your public libraries, you can also create
subdirectories inside `lib`. If you do that, users will specify that path when
they import it. Say you have the following file hierarchy:

    enchilada/
      lib/
        some/
          path/
            olives.dart

Users will import `olives.dart` as follows:

{% prettify dart %}
import "package:enchilada/some/path/olives.dart";
{% endprettify %}

Note that only *libraries* should be in `lib`. *Entrypoints*&mdash;Dart scripts
with a `main()` function&mdash;cannot go in `lib`. If you place a Dart script
inside `lib`, you will discover that any `package:` imports it contains don't
resolve. Instead, your entrypoints should go in the appropriate
[entrypoint directory](glossary.html#entrypoint-directory).

## Public assets

    enchilada/
      asset/
        guacamole.css

While most library packages exist to let you reuse Dart code, you can also
reuse other kinds of content. For example, a package for
[Bootstrap](http://getbootstrap.com/) might include a number of CSS files for
consumers of the package to use.

These go in a top-level directory named `asset`. You can put any kind of file
in there and organize it with subdirectories however you like. It's effectively
a `lib` directory for things that aren't Dart code.

Users can reference another package's assets using URLs that contain
`assets/<package>/<path>` where `<package>` is the name of the package
containing the asset and `<path>` is the relative path to the asset within that
package's `asset` directory.

<aside class="alert alert-warning">
<p>The mechanics of referencing assets are still being implemented. URLs that
contain <tt>assets/</tt> are handled by <a href="cmd/pub-serve.html"><tt>pub
serve</tt></a>.</p>

<p>The <a href="cmd/pub-build.html"><tt>pub build</tt></a> command also copies
assets to an <tt>assets</tt> directory, but this will <em>only</em> be in the
root directory of the output, so you must make sure that your <tt>assets/</tt>
URL correctly resolves to that directory and not a subdirectory.</p>

<p>We don't currently have a solution for referencing assets in command-line
Dart applications.</p>
</aside>

Note that `assets` is plural in the URL. This is a bit like the split between
`lib` and `packages`. The former is the name of the *directory in the package*,
the latter is the *name you use to reference it*.

For example, let's say your package wanted to use enchilada's `guacamole.css`
styles. In an HTML file in your package, you can add:

{% prettify html %}
<link href="assets/enchilada/guacamole.css" rel="stylesheet">
{% endprettify %}

When you run your application using [`pub serve`](cmd/pub-serve.html), or build
it to something deployable using [`pub build`](cmd/pub-build.html), Pub will
copy over any referenced assets that your package depends on.

## Implementation files

    enchilada/
      lib/
        src/
          beans.dart
          queso.dart

The libraries inside "lib" are publicly visible: other packages are free to
import them. But much of a package's code is internal implementation libraries
that should only be imported and used by the package itself. Those go inside a
subdirectory of `lib` called `src`. You can create subdirectories in there if
it helps you organize things.

You are free to import libraries that live in `lib/src` from within other Dart
code in the *same* package (like other libraries in `lib`, scripts in `bin`, and
tests) but you should never import from another package's `lib/src` directory.
Those files are not part of the package's public API, and they might change in
ways that could break your code.

When you use libraries from within your own package, even code in `src`, you
can (and should) still use `"package:"` to import them. This is perfectly
legit:

{% prettify dart %}
import "package:enchilada/src/beans.dart";
{% endprettify %}

The name you use here (in this case `enchilada`) is the name you specify for
your package in its [pubspec](pubspec.html).

## Web files

    enchilada/
      web/
        index.html
        main.dart
        style.css

Dart is a web language, so many pub packages will be doing web stuff. That
means HTML, CSS, images, and, heck, probably even some JavaScript. All of that
goes into your package's `web` directory. You're free to organize the contents
of that to your heart's content. Go crazy with subdirectories if that makes you
happy.

Also, and this is important, any Dart web entrypoints (in other words, Dart
scripts that are referred to in a `<script>` tag) go under `web` and not `lib`.
That ensures that a `packages` directory is created nearby so that `package:`
imports can be resolved correctly.

(You may be asking whether you should put your web-based example programs
in `example` or `web`?" Put those in `example`.)

## Command-line apps

    enchilada/
      bin/
        enchilada

Some packages define programs that can be run directly from the command line.
These can be shell scripts or any other scripting language, including Dart.
The `pub` application itself is one example: it's a simple shell script that
invokes `pub.dart`.

If your package defines code like this, put it in a directory named `bin`.

<aside class="alert alert-note">
At some point, pub will support automatically adding that directory to your
system path so that these scripts can be easily invoked.
</aside>

## Tests and benchmarks

    enchilada/
      test/
        enchilada_test.dart
        tortilla_test.dart

Every package should have tests. With pub, the convention is
that these go in a `test` directory (or some directory inside it if you like)
and have `_test` at the end of their file names.

Typically, these use the [unittest](http://api.dartlang.org/unittest.html)
package.

    enchilada/
      benchmark/
        make_lunch.dart

Packages that have performance critical code may also include *benchmarks*.
These test the API not for correctness but for speed (or memory use, or maybe
other empirical metrics).

## Documentation

    enchilada/
      doc/
        getting_started.md

If you've got code and tests, the next piece you might want
is good documentation. That goes inside a directory named `doc`. We don't
currently have any guidelines about format or organization within that. Use
whatever markup format that you prefer.

This directory should *not* just contain docs generated automatically
from your source code using [docgen](/tools/docgen/). Since that's
pulled directly from the code already in the package, putting those docs in
here would be redundant. Instead, this is for tutorials, guides, and other
hand-authored documentation *in addition to* generated API references.

## Examples

    enchilada/
      example/
        lunch.dart

Code, tests, docs, what else
could your users want? Standalone example programs that use your package, of
course! Those go inside the `example` directory. If the examples are complex
and use multiple files, consider making a directory for each example. Otherwise,
you can place each one right inside `example`.

This is an important place to consider using `package:` to import files from
your own package. That ensures the example code in your package looks exactly
like code outside of your package would look.

## Internal tools and scripts

    enchilada/
      tool/
        generate_docs.dart

Mature packages often have little helper scripts and programs that people
run while developing the package itself. Think things like test runners,
documentation generators, or other bits of automation.

Unlike the scripts in `bin`, these are *not* for external users of the package.
If you have any of these, place them in a directory called `tool`.
