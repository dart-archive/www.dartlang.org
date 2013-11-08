---
layout: default
title: "Build.dart and the Dart Editor Build System"
description: "Customize your Dart Editor build with build.dart."
has-permalinks: false
---

# {{page.title}} 

Build.dart is a simple build script convention
that lets you add behavior to the Dart Editor build system.
If the root of a Dart Editor project has a script named `build.dart`,
that script is invoked during a build
with information about the changed files.
You can use build.dart to post-process changed files,
generate other files,
or drive other aspects of the build system.  

{% include toc.html %}


## Flags

Dart Editor can invoke build.dart with
any of the following command-line flags:

`--changed=<filename>`
: Specifies a file that changed and should be rebuilt.
  One instance of the `--changed` flag is passed in for every changed file.

`--removed=<filename>`
: Specifies a file that was removed and might affect the build.
  One instance of the `--removed` flag is passed in for every deleted file.

`--clean`
: Requests that the build.dart script delete all generated files
  and reset any saved state.
  No other flags are passed in,
  except for `--machine`.

`--full`
: Requests a full build;
  no incremental information is available.

`--machine`
: Requests the build.dart script
  to print rich JSON error messages to the standard output (stdout),
  so that Dart Editor can interpret the messages.

`--deploy`
: Creates a directory containing the files needed to deploy this
  application to a server.
  Used only for the <a href="/polymer-dart">Polymer.dart</a>
  linter and build tool.
  You can find more information in the polymer library file
  [builder.dart](https://code.google.com/p/dart/source/browse/trunk/dart/pkg/polymer/lib/builder.dart).

Currently, the editor always passes the `--machine` flag
into the build script.
The other flags include either a single `--full` flag,
a single `--clean` flag,
or one or more `--changed` and `--removed` flags.

If a build script returns a non-zero exit code,
all the stdout and stderr produced by the script
is displayed in the Console view.
Zero exit codes do _not_ display any output;
build.dart is usually called many times a minute,
and having the Console view always scrolling output
would be distracting to the user.

Any changes that build.dart makes within a directory named `out`
are _not_ fed back into build.dart using `--changed` flags.
Any other changed or created files _are_ fed back.


## An example

Here is a sample build.dart file
that processes all .foo files into .foobar files.
{% comment %}
NOTE: This sample is based on
https://code.google.com/p/dart/source/browse/trunk/dart/samples/build_dart_simple/build.dart
{% endcomment %}

{% prettify dart %}
{% insert code/build.dart %}
{% endprettify %}


## The machine interface

Sometimes the build.dart script needs to
get information back to the editor.
The general mechanism for doing this is
for the editor to scrape the stdout from build.dart,
looking for well-formed messages.
When Dart Editor starts build.dart,
it passes in a `--machine` flag
indicating that the editor is looking for
well-formed messages.

Well-formed messages follow these rules:

* Each message is on its own line.
* Each message is formed as a JSON RPC command/method call.
* Each message is wrapped in square brackets.

The next sections give examples of two kinds of messages:

* Errors, warnings, and informational messages
* File mappings

### Errors, warnings, and informational messages

As build.dart processes input files,
it might call out some input files as badly formed,
using **error** or **warning** messages.
You can also generate informational (**info**) messages—for
example, scraping TODO messages from user code.
The editor uses these messages
to create markers for the given file and line combination,
and it displays the messages in the Problems view.

Here is an example of stdout
that contains error and warning messages:

{% prettify json %}
[{"method":"error","params":{"file":"foo.html","line":23,"message":"no ID found"}}]

[{"method":"warning","params":{"file":"foo.html","line":23,"message":"no ID found"}}]

[{"method":"error","params":{"file":"foo.html","line":23,"message":"no ID found","charStart"=123,"charEnd"=130}}]
{% endprettify %}

The JSON RPC method name for these messages
can be **error**, **warning**, or **info**.
The parameters are:

file
: An absolute or script relative file path

line
: The line with the error or warning (1-based)

message
: A message to display to the user

charStart
: The starting position of the error from the beginning of the file (0-based)

charEnd
: The ending position of the error from the beginning of the file (0-based)

The charStart and charEnd parameters are optional but encouraged.
Including them allows the editor to provide
nice tooltip help for the error or warning.


### File mappings

When a build.dart script generates an output file from an input file,
the script can tell the editor about this mapping.

<aside class="alert alert-info" markdown="1">
**Note:**
Not all mappings need to be reported to the editor—just
the ones where the mapping is semantically important to the user
and special editor behavior is desired.
</aside>

When you specify a file mapping,
Dart Editor redirects HTTP requests
and replaces launch attempts
so that they use the mapped-to file.
For example,
if you map `index.html` to `out/index.html`,
Dart Editor redirects HTTP requests from `index.html` to `out/index.html`,
and it replaces the user’s attempt to launch `index.html`
with a launch of `out/index.html`.

Here's an example of mapping foo.html to out/foo.html:

{% prettify json %}
[{"method":"mapping","params":{"from":"foo.html","to":"out/foo.html"}}]
{% endprettify %}

The JSON RPC method name for a file mapping is **mapping**.
The parameters are:

from
: An absolute or script relative file path

to
: An absolute or script relative file path


## More examples

You might find the following examples of build files helpful:

* [dart/samples/build_dart/build.dart](https://code.google.com/p/dart/source/browse/trunk/dart/samples/build_dart/build.dart)
* Web UI: 
   * [build.dart](https://github.com/dart-lang/web-ui/blob/master/build.dart)
   * [component_build.dart](https://github.com/dart-lang/web-ui/blob/master/lib/component_build.dart)
