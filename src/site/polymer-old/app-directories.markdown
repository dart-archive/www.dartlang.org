---
layout: default
title: Imports and Your App's Directory Structure 
subsite: "Polymer.dart"
description: "How your Polymer app or element should arrange and import files."
has-permalinks: true
---

{% include toc.html %}
{% include breadcrumbs.html %}

# {{ page.title }}

You have some flexibility about how you structure your polymer.dart app,
as long as you adhere to
[pub package layout conventions](/tools/pub/package-layout.html).

The structure of your app's directories affects how your app's code
imports other code,
whether from your own app or from a different package.

<aside class="alert alert-warning" markdown="1">
**Important:**
Bad import syntax can make your imports break just when
you're ready to deploy your app.
Use proper import syntax from the beginning!
</aside>


## Possible app structures

As the following figure shows,
a very simple polymer.dart app might have only a single HTML file
under `web`, plus a `pubspec.yaml` file.

![app/pubspec.yaml, app/web/index.html](images/dir-simplest-structure.png)

<aside class="alert alert-warning" markdown="1">
**Important:**
Use underscores (`_`)—not dashes or capitalization—to
separate words in your app's directory names and filenames.
For example, never name your package my-app or myApp.
Instead, you can name it `my_app`.
</aside>

By default, each HTML file under `web` is an _entry point_—a
page that the user can navigate to.

![web/index.html, web/settings/user.html, and web/settings/system.html are all entry points](images/dir-entry-points.png)

Apps often have additional files under `lib`.

![Shows a lib directory with two subdirectories (utils and components), containing various .dart and .html files](images/dir-lib.png)

Both the `web` and `lib` directories can contain HTML, CSS, Dart,
image, and other files.
Generally, the assets (such as images)
that an HTML or Dart files uses
are near that file in the directory structure.


## Importing assets

Dart, HTML, and CSS files often import assets,
such as other Dart files, HTML files, CSS files, and images.

The syntax for importing assets depends on the following:

* Whether the importing file is a Dart file
* Whether the importing file is an entry point
* Whether the importing file is under `web` or under `lib`
* Whether the imported file is under the same top-level directory
  (`web` or `lib`) or in another package

Within a package, files under `web` can import files under
either `web` or `lib`.
However, files under `lib` can import only files under `lib`.
Both `web` and `lib` files can import files from
other packages.

The examples in the following sections use
a package named `a` that depends on the `polymer` package
and a package named `b`.
The `a` and `b` packages have
this directory structure:

![A graphic summarizing the hierarchy; all this information is also in the comments for the following code snippets](images/dir-packages-ab.png)


### Into web/ from web/

Within `web`, both Dart and non-Dart files use relative paths when
importing other files under `web`.

#### Into a Dart file

{% prettify dart %}
// web/a1.dart imports web/a3/a3.dart
import 'a3/a3.dart';
{% endprettify %}


#### Into a non-Dart file

{% prettify html %}
<!-- web/a1_ep.html imports web/a3/a3.html -->
<link rel="import" href="a3/a3.html">
{% endprettify %}


### Into web/ from lib/

Within `web`, both Dart and non-Dart files use package paths
when importing from `lib`—even
when those files are in the same package.

Dart package paths start with
<code>package:<em>package_name</em>/</code>,
while non-Dart package paths start with
<code>[<em>path_to_entry_point</em>/]packages/<em>package_name</em>/</code>.
For <code><em>package_name</em></code> use the value of the
`name` field in `pubspec.yaml`.

<aside class="alert alert-warning" markdown="1">
  **Never put `lib` in an import path.**
</aside>


#### Into a Dart file

The Dart code is always the same,
no matter how deeply under `web` the Dart file is nested.

{% prettify dart %}
// web/a1.dart imports lib/a4.dart
import 'package:a/a4.dart';
{% endprettify %}

#### Into an entry point

Entry points import `lib` files using a path
that starts with `packages/`:

{% prettify html %}
<!-- web/a1_ep.html imports lib/a4.html -->
<link rel="import" href="packages/a/a4.html">

<!-- web/a2/a2_ep.html imports lib/a4.html -->
<link rel="import" href="packages/a/a4.html">
{% endprettify %}

#### Into a non-Dart, non-entry point

Non-entry points must walk out to the entry point that imports them,
and then use the path (starting with `packages/`)
that the entry point would use to import the file.

{% prettify html %}
<!-- web/a3/a3.html
     (imported by the entry point web/a1_ep.html)
     imports lib/a5/a5.html -->
<link rel="import" href="../packages/a/a5/a5.html">
{% endprettify %}

<aside class="alert alert-info" markdown="1">
  **Note:**
  If you specify `entry_point` fields in the
  `polymer` transformer section,
  then every HTML file under `web` that you _don't_ specify
  is a non-entry point.
  If you don't specify `entry_point` at all,
  then every HTML file under `web` is an entry point.
</aside>


### Into lib/ from lib/

Within `lib`, both Dart and non-Dart files can use relative paths
to import assets that are also under `lib`.
Dart files can also use `package:` paths.

#### Into a Dart file

Dart files under `lib`
often use `package:` paths to import assets under `lib`:

{% prettify dart %}
// lib/a5/a6/a6.dart imports lib/a4.dart
import 'package:a/a4.dart';
{% endprettify %}

Relative paths are another option:

{% prettify dart %}
// lib/a5/a5.dart imports lib/a5/a6/a6.dart
import 'a6/a6.dart';
{% endprettify %}

<aside class="alert alert-info" markdown="1">
  **Style note:**
  In Dart files, avoid relative paths that contain `../`.
</aside>


#### Into a non-Dart file

Non-Dart files under `lib` must use relative paths
to import assets under `lib`:

{% prettify html %}
<!-- lib/a5/a6/a6.html imports lib/a4.html -->
<link rel="import" href="../../a4.html">
{% endprettify %}


### From another package

Importing files from another package is easy for Dart files,
and a little more complicated for non-Dart files.

Within the other package,
only the files under `lib` are available for import.
Just like for paths within your own package,
`lib` isn't part of the import path.


#### Into a Dart file

Dart files import assets from other packages like this:

{% prettify dart %}
// Any .dart file in package a imports lib/b.dart from package b
import 'package:b/b.dart';
{% endprettify %}

A common example is importing `polymer.dart`
from the `polymer` package:

{% prettify dart %}
import 'package:polymer/polymer.dart';
{% endprettify %}


#### Into a non-Dart file under web/

The rules are exactly the same
as the rules for importing from the same package's `lib` directory.

Entry points use a path
that starts with `packages/`:

{% prettify html %}
<!-- web/a1_ep.html imports lib/b.html from package b -->
<link rel="import" href="packages/b/b.html">
{% endprettify %}

Non-Dart, non-entry points under `web` must first walk out
to the entry point's directory.

{% prettify html %}
<!-- web/a3/a3.html
     (imported by the entry point web/a1_ep.html)
     imports polymer's polymer.html -->
<link rel="import" href="../packages/polymer/polymer.html">
{% endprettify %}


#### Into a non-Dart file under lib/

Non-Dart files under `lib` must walk **up**
to the top of the package **plus one**.
The extra `../` is necessary because code in
<code>lib/<em>path</em></code>
appears in the importing package as
<code>packages/<em>package_name</em>/<em>path</em></code>.

{% prettify html %}
<!-- lib/a4.html imports lib/b.html from package b -->
<link rel="import" href="../../packages/b/b.html">

<!-- lib/a5/a5.html imports lib/b.html from package b -->
<link rel="import" href="../../../packages/b/b.html">

<!-- lib/a5/a6/a6.html imports polymer's polymer.html -->
<link rel="import" href="../../../../packages/polymer/polymer.html">
{% endprettify %}

<aside class="alert alert-info" markdown="1">
  **Note:**
  IDEs that don't use the polymer.dart linter
  are likely to complain about the extra `../` in the path.
  See [Generating warnings](/polymer-old/#generating-warnings)
  for details on using a `build.dart` file to set up the linter.
</aside>


## Testing your imports

Bad import syntax sometimes works—at least
until you deploy your app.
A good, quick test of your imports
is whether your untransformed Polymer code works in Dartium.

To test your import syntax, run your app in Dartium
using either of these approaches:

<ul>
  <li> 
    <p>
      Use a file URL in Dartium.
      Start Dartium from the command line,
      specifying <code>--allow-file-access-from-files</code>
      and the file URL for an entry point:
    </p>

{% prettify sh %}
/path/to/dartium/chromium --allow-file-access-from-files file:///path/to/web/path-to-entry-point
{% endprettify %}

    <p>
      For example, on a Mac:
    </p>

{% prettify sh %}
~/dart/chromium/Chromium.app/Contents/MacOS/Chromium --allow-file-access-from-files file:///Users/me/a/web/index.html
{% endprettify %}
  </li>

  <li>
    <p>
      Use a simple HTTP server.
      You can run the server in the top directory of your app,
      and point Dartium to the URL of an entry point.
      For example:
    </p>

    <ol>
      <li> <code>cd &lt;top directory of app></code> </li>
      <li> <code>python -m SimpleHTTPServer</code> </li>
      <li> In Dartium, browse to 
        <code>http://localhost:<em>port</em>/web/<em>path-to-entry-point</em></code>.
        <br>
        Example: http://localhost:8000/web/index.html
      </li>
    </ol>
  </li>
</ul>

{% comment %}
{PENDING: Add section about warning/error messages you might see,
and the most common fixes?}
{% endcomment %}


## The rules behind the import syntax

The import syntax is the result of some rules that polymer.dart defines,
in addition to what pub stipulates:

* Every entry point has a `packages` directory,
  which is why its package import paths start with `packages/`.

* Non-entry-point files under `web` use the `packages` directory
  of the entry point that imports them.

* Two entry points in different directories
  can't import the same non-entry-point `web` file.
  (Instead, you can move the non-entry-point file to `lib`.)

The rules are easier to follow if
you know how `pub get` places files. 


### How the directory structure changes

Recall the directory structure from before:

![Directory hierarchy for the a and b packages](images/dir-packages-ab.png)

When you run `pub get` at the top of package `a`,
a `packages` directory appears under each directory in `web`.

![Directory hierarchy after pub get; web and a2 have local copies of (or links to) the packages directory; a3 has a more tenuous link to the packages directory](images/dir-packages-ab-after-pub-get.png)

<aside class="alert alert-warning" markdown="1">
**Important:**
When you run `pub build` or `pub serve`,
Pub runs the `polymer` transformer and
creates **only one `packages` directory**,
which might not be next to your entry points.
The `polymer` transformer adjusts your imports to use
the new `packages` directory location,
warning you if it finds an invalid import.
</aside>

Note that no `lib` directory is under the `packages` directory.
When you launch `web/a1_ep.html` in Dartium,
Dartium loads package imports from `web/packages/`.
When you launch `web/a2/a2_ep.html` in Dartium,
the package imports come from `web/a2/packages/`.

However, when `web/a3/a3.html` imports `lib/a5/a5.html`,
as a non-entry point `a3.html` must
walk up to the `packages` directory that
lives next to its entry point (`a1_ep.html`)
and then load the file from there:
`../packages/a/a5/a5.html`.
Because pub generates symlinks to the packages directory under `a3`,
you might be tempted to write `packages/a/a5/a5.html`,
but that's incorrect.

When `a5/a5.html` (originally under `lib`)
imports `b.html`
(also originally under `lib`, but in the `b` package),
`a5.html` must first walk out to be just above
the top-level `packages` directory.
It's under `packages/a/a5`, so it must walk up 3 directories
before it can continue the path with `packages`:
`../../../packages/polymer/polymer.html`

Using correct import syntax
allows the code in `lib` to be used by your package,
as well as by code outside your package,
without changes.


### Why the rules exist

The motivation behind polymer.dart's import rules is that
URLs must work under many scenarios at once:

* URLs must work in Dartium without any code transformation:
  resolving the path in the context of a simple HTTP server,
  or using `file:///` URLs, should yield a valid path to assets.
  The `packages` directory is safe to use because
  pub already creates it next to the entry points of your application.

* URLs must be canonical.
  Multiple URLs reaching the same asset must
  resolve to the same absolute URL,
  whether the URL comes from a Dart file or an HTML file.
  If you use the correct import syntax,
  then the `polymer` transformer ensures
  that the URLs are canonical.

  For example, say you have an import like this:

  {% prettify html %}
  <link rel="import" href="packages/c/c.html">
  {% endprettify %}

  Also say that `c.html` has this:

  {% prettify html %}
  <script type="application/dart" src="c.dart">
  {% endprettify %}

  If a Dart file also loads `"package:c/c.dart"`,
  then a tool needs to make sure that both versions of `c.dart` are
  loaded from the same URL.
  Otherwise,
  you may see errors at runtime like
  "A is not a subtype of A."

  When you use the correct import syntax,
  polymer.dart can detect the pattern in
  the HTML-import URL that contains `packages/`
  and canonicalize the import
  by converting `packages/c/c.dart` into `package:c/c.dart` under the hood.

* URLs must continue to be valid after applications are built.
  Technically a pub transformer could do this automatically.
  However, to make sure that code works also in Dartium
  with a simple HTTP server,
  the `polymer` transformer doesn't fix URLs;
  it just detects inconsistencies and
  produces an error message.

For more information, see
[Pub Package Layout Conventions](/tools/pub/package-layout.html) and
[Pub Assets and Transformers](/tools/pub/assets-and-transformers.html).

