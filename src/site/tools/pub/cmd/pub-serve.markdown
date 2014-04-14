---
layout: default
title: "pub serve"
---

# {{ page.title }}

_Serve_ is one of the commands of the _pub_ tool.
[Learn more about pub](/tools/pub/).

{% prettify lang-sh %}
$ pub serve [--hostname=<host>] [--port=<number>] [--mode=<mode>] [<directories>]
$ pub serve [--hostname=<host>] [--port=<number>] [--mode=<mode>] [--all]
{% endprettify %}

This command starts up a _development server_, or _dev server_,
for your Dart web app. The dev server is an HTTP server on localhost
that serves up your web app's [assets](/tools/pub/glossary.html#asset).

Start the dev server from the directory that contains your web app's
`pubspec.yaml` file:

{% prettify lang-sh %}
$ cd ~/dart/helloworld
$ pub serve
Serving helloworld on http://localhost:8080
{% endprettify %}

The dev server doesn't just serve up assets, it produces them by running
[transformers](/tools/pub/glossary.html#transformer). A transformer converts
input assets (such as Dart files or Polymer-formatted HTML) into output assets
(such as JavaScript and HTML).

These output assets aren't in the file system; they exist only in the dev
server. When you're ready to deploy, generate output files by running
[`pub build`](pub-build.html).

Pub automatically includes a dart2js transformer that compiles your Dart code
to JavaScript. With this, you can change some Dart code, refresh your
non-Dartium browser, and immediately see the changes.

See
[Configuring the Built-in dart2js Transformer](/tools/pub/dart2js-transformer.html)
for information on how to configure the dart2js options in your pubspec.

See [Pub Assets and Transformers](/tools/pub/assets-and-transformers.html) for
information on:

* Where in your package to put assets.
* What URLs to use when referring to assets.
* How to use `pubspec.yaml` to specify which transformers run, and in
  what order.

## Options {#options}

For options that apply to all pub commands, see
[Global options](index.html#global-options).

<dl>
<dt><tt>&lt;directories&gt;</tt></dt>
<dd>Optional. Use this option to specify the directories to use
as input for the serve command, in addition to <tt>lib</tt>
(which is always processed).
The default values are <tt>web</tt> and <tt>test</tt>.
Directories you might specify typically include the following:

<ul>
<li>benchmark</li>
<li>bin</li>
<li>example</li>
<li>test</li>
<li>web</li>
</ul>

For example, you might specify:

<pre>
pub serve test benchmark example/foo bar
</pre>

In the preceding example, the <tt>test</tt>, <tt>benchmark</tt>,
<tt>example/foo</tt>, and <tt>bar</tt> directories are processed,
as is the <tt>lib</tt> directory.
The <tt>web</tt> directory is not served because it isn't specified.</dd>

<dt><tt>--all</tt></dt>
<dd>Optional. Serves all of the buildable directories (benchmark, bin, example,
test, and web) that are present.</dd>

<dt><tt>--hostname=&lt;host&gt;</tt></dt>
<dd>Optional. By default, the dev server listens on <tt>localhost</tt>.
You can specify another host using the <tt>--hostname</tt> option. 
For example:
<pre>
$ pub serve --hostname=127.0.0.1
Loading source assets... 
Loading markdown_converter transformers... (1.3s)
Serving markdown_converter web on http://127.0.0.1:8080
Build completed successfully
</pre>
</dd>

<dt><tt>--port=&lt;number&gt;</tt></dt>
<dd>Optional. By default, the dev server uses <tt>http://localhost:8080</tt>.
To change the port number, use the <tt>--port</tt> option:
<pre>
$ pub serve --port=9080
Serving helloworld web on http://localhost:9080
</pre>
</dd>

<dt><tt>--mode=&lt;mode&gt;</tt></dt>
<dd>Optional. Specifies a transformation mode. Typical values are
"debug" and "release", but any word is allowed.
Transformers may use this to change how they behave.<br><br>

If set to "release" pub generates minified JavaScript using dart2js.
Otherwise, it generates unminified JavaScript.
Also, in release mode, Pub does not include any source .dart
files in the resulting build output since they have
been compiled to JavaScript. In any other mode, the raw Dart files are
included.<br><br>
If omitted, it defaults to "debug".</dd>

</dl>

## What about Dart Editor's server?

Dart Editor has its own dev server. We plan to unify it with the
pub dev server soon.
