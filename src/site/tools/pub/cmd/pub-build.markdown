---
layout: default
title: "pub build"
---

# {{ page.title }}

_Build_ is one of the commands of the _pub_ tool.
[Learn more about pub](/tools/pub/).

{% prettify lang-sh %}
$ pub build [--mode=<mode>] [<directories>] [--output=<directory>]
$ pub build [--mode=<mode>] [--all] [--output=<directory>]
{% endprettify %}

Use `pub build` when you're ready to deploy your web app. When you run
`pub build`, it generates the [assets](/tools/pub/glossary.html#asset)
for the current package and all of its dependencies, putting them into
new directory named `build`.

To use `pub build`, just run it in your package's root directory. For example:

{% prettify lang-sh %}
$ cd ~/dart/helloworld
$ pub build
Building helloworld......
Built 5 files!
{% endprettify %}

If the build directory already exists, `pub build` deletes it and then creates
it again.

To generate assets, `pub build` uses
[transformers](/tools/pub/glossary.html#transformer). Any source assets
that aren't transformed are copied, as is, into the build directory
or one of its subdirectories. Pub also automatically compiles your
Dart application to JavaScript using dart2js.

See
[Configuring the Built-in dart2js Transformer](/tools/pub/dart2js-transformer.html)
for information on how to configure the dart2js options in your pubspec.

See [Pub Assets and Transformers](/tools/pub/assets-and-transformers.html)
for information on:

* Where in your package to put assets.
* What URLs to use when referring to assets.
* How to use `pubspec.yaml` to specify which transformers run, and in
  what order.

Also see [`pub serve`](pub-serve.html). With `pub serve`, you can run a
development server that continuously generates and serves assets.

<aside class="alert alert-info" markdown="1">
**Note:** In earlier releases of Dart, _pub build_ was called _pub deploy_.
</aside>

## Options {#options}

For options that apply to all pub commands, see
[Global options](index.html#global-options).

<dl>

<dt><tt>&lt;directories&gt;</tt></dt>
<dd>Optional. Use this option to specify directories to build,
in addition to the <tt>lib</tt> and <tt>asset</tt> directories
(which are always built). The default value is <tt>web</tt>.
Directories you might typically specify include the following:

<ul>
<li>benchmark</li>
<li>bin</li>
<li>example</li>
<li>test</li>
<li>web</li>
</ul>

For example, you might specify:

<pre>
pub build test benchmark example/foo bar
</pre>

In the preceding example, the <tt>test</tt>, <tt>benchmark</tt>,
<tt>example/foo</tt>, and <tt>bar</tt> directories are built,
as are the <tt>lib</tt> and <tt>asset</tt> directories.
The <tt>web</tt> directory is not built because it isn't
specified.</dd>

<dt><tt>--all</tt></dt>
<dd>Optional. Builds all of the buildable directories (benchmark, bin, example,
test, and web) that are present.</dd>

<dt><tt>--mode=&lt;mode&gt;</tt></dt>
<dd>Optional. Specifies a transformation mode. Typical values are "debug"
and "release", but any word is allowed.
Transformers may use this to change how they behave.<br><br>

If set to "release" pub generates minified JavaScript using dart2js.
Otherwise, it generates it unminified. Also, in release mode, pub does not
include any source .dart files in the resulting build output since they have
been compiled to JavaScript. In any other mode, the raw Dart files are
included.<br><br>

If omitted, it defaults to "release".</dd>

<dt><tt>--output=&lt;directory&gt;</tt> or <tt>-o &lt;directory&gt;</tt></dt>
<dd>Optional. Specifies where to put the build output. The default is the
top-level <tt>build</tt> directory. (This option will be available in
the Dart 1.4 stable channel, and is now available in the bleeding edge
channel.)</dd>

</dl>

<aside class="alert alert-info" markdown="1">
*Problems?*
See [Troubleshooting Pub](../troubleshoot.html).
</aside>

