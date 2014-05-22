---
layout: default
title: "dart: The Standalone VM"
short-title: "dart"
---

{% include toc.html %}
{% include breadcrumbs.html %}

# {{ page.title }}

You can use the _dart_ tool (`bin/dart`) to run Dart command-line apps such as
server-side scripts, programs, and servers. During development, you also
have the option to run command-line apps using [Dart Editor](/tools/editor/).
    
### Basic usage {#basic-usage}

Here’s an example of running a Dart file on the command line:

{% prettify lang-sh %}
dart test.dart
{% endprettify %}

<aside class="alert alert-info" markdown="1">
**Note:** You can't use <tt>dart</tt> to run web apps&mdash;apps
that include <tt>dart:html</tt>, or that depend on libraries
that use the browser environment. For more information, see
[About Dart applications](/docs/tutorials/get-started/#what-is-app).
</aside>

#### Options {#options}

Common command-line options for dart include:

`-c` or `--checked`
: Enables _both_ assertions and type checks (checked mode).

`-p <path>` or `-package-root=<path>`
: Specifies where to find imported libraries.

`--old_gen_heap_size=<num>`
: Sets the upper limit of
  [old space](/tools/observatory/glossary.html#old-space) to `<num>` MB.

`--version`
: Displays VM version information.

`-h` or `--help`
: Displays help. (Add `-v` for information about all options.)

#### Observatory options {#observatory}

Observatory is a tool for profiling and debugging your apps.
You can use the following flags to enable Observatory and to
instruct the VM to delay the start up, or the exit, of an isolate:

`--enable-vm-service`
: Enables Observatory on localhost port 8181.

`--enable-vm-service=<port>`
: Enables Observatory on localhost for the specific port.

`--enable-vm-service=<port>/<IP address>`
: Enables Observatory on an external network using the specified
  IP address and port. For example:
  <code>--enable-vm-service=9999/0.0.0.0</code>

`--pause-isolates-on-exit`
: Causes the VM to pause each isolate that would otherwise exit.
  If your standalone app executes quickly,
  it might exit before you can open Observatory. To avoid this situation,
  specify this flag on startup.  You must explicitly release all isolates
  in the Observatory UI.

`--pause-isolates-on-start`
: Causes the VM to pause before starting any isolate.
  You must explicitly start each isolate in the Observatory UI. 

`--profile`
: On Windows, Observatory's
  [CPU Profiler](/tools/observatory/cpu-profile.html) screen
  is disabled by default. Use this option to enable it.

The following is an example Observatory run:

{% prettify lang-sh %}
$ dart --enable-vm-service --pause-isolates-on-exit <script>.dart
{% endprettify %}

For more information, see [Observatory](/tools/observatory/).

#### Snapshot option {#snapshots}

You can also generate snapshots:

`--snapshot=<filename>`
: Generates a snapshot in the specified file. For information
  on generating and running snapshots, see the article
  [Snapshots in Dart](/articles/snapshots/).
  
### Enabling checked mode {#enabling-checked-mode}
  
Dart programs run in one of two modes: checked or production. By default, the
Dart VM runs in production mode. We recommend that you enable checked mode for
development and testing.

In checked mode, assignments are dynamically checked, and certain violations of
the type system raise exceptions at runtime. In production mode, static type
annotations have no effect.

Assert statements are also enabled in checked mode. An
[assert statement](/docs/dart-up-and-running/contents/ch02.html#assert)
checks a boolean condition, raising an exception if the condition is false.
Assertions do not run in production mode.

You can run the VM in checked mode with the `--checked` command-line flag:

{% prettify lang-sh %}
dart --checked test.dart
{% endprettify %}
