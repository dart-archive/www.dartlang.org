<p>
Here's some code
that uses some of Dart's most basic features.
</p>

{% pretty_code dart 0 %}{% include language-tour/1-main-print/start.dart %}{% endpretty_code %}

<p>
Here's what this program uses
that applies to all (or almost all) Dart apps:
</p>

<dl>
  <dt> main() </dt>
  <dd>
    The special, <b>required</b>,
   top-level function where app execution starts.
  </dd>
  <dt> // </dt>
  <dd>
    How you indicate that the rest of the line is a
    <a href="#comments">comment</a>.
    Alternatively:
    {% pretty_code dart 0 %}/* comment that might span many lines */{% endpretty_code %}
  </dd>
  <dt> int, String </dt>
  <dd>
    Declare a variable with static type annotations.
  </dd>
{% comment %}
PENDING: add URL when variable section is written.
variable.html?
{% endcomment %}
  <dt> "..." (or '...')</dt>
  <dd>
    A string.
  </dd>
{% comment %}
PENDING: add URL when string section is written.
builtin.html#string?
{% endcomment %}
  <dt> $text </dt>
  <dd>
    String interpolation, including a variable's toString() value inside of a string literal.
  </dd>
  <dt> print() </dt>
  <dd>
    A handy way to display output.
  </dd>
</dl>

### Style

Our code follows the conventions in the
<a href="/articles/style-guide/">Dart Style Guide</a>.
For example,
we indent two spaces by convention.

### Runtime modes

Dart programs can run in either production mode or checked mode.

_Production mode_ is the default runtime mode of a Dart
program, optimized for speed.
In production mode, the optional static types are ignored.

_Checked mode_ is a developer friendly mode
that helps you catch some type errors during runtime.
For example, if you assign a non-string to a variable declared as a String,
an exception will be thrown.

We recommend that you develop and debug in checked mode,
and deploy to production mode.