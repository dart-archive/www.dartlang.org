Dart supports single-line comments, multi-line comments,
and documentation comments.

### Single-line comments

A single-line comment begins with `//`.
Everything between `//` and the end of line
is ignored by the Dart compiler.

{% pc dart 0 %}
main() {
  // TODO: refactor into an AbstractLlamaGreetingFactory ?
  print("Welcome to my Llama farm!");
}
{% endpc %}

### Multi-line comments

A multi-line comment begins with `/*` and ends with `*/`.
Everything between `/*` and `*/` is ignored by the
Dart compiler (unless the comment is a documentation comment, see below).
Multi-line comments can nest.

{% pc dart 0 %}
main() {
  /*
   * This is a lot of work. Consider raising chickens.

  Llama larry = new Llama();
  larry.feed();
  larry.exercise();
  larry.clean();
   */
}
{% endpc %}

### Documentation comments

Documentation comments are multi-line comments that begin
with `/**`. Inside a documentation comment, the Dart
compiler ignores all text unless it is enclosed in brackets.
Using brackets, you can embed links to classes, methods,
and fields into your comments. The names in brackets are resolved to the
lexical scope of the documented program element.

Here is an example of documentation comments with references
to other classes and arguments:

{% pc dart 0 %}
/**
 * The llama (Lama glama) is a domesticated South American
 * camelid, widely used as a meat and pack animal by Andean
 * cultures since pre-Hispanic times.
 */
class Llama {
  String name;

  /**
   * Feed your llama [Food]. Typically, one bale of hay per week.
   */
  feed(Food food) {
    ...
  }

  /**
   * Exercise your llama with an [activity] for [timeLimit] minutes.
   */
  exercise(Activity activity, int timeLimit) {
    ...
  }
}
{% endpc %}

You can use the dartdoc utility, bundled in the SDK, to parse
Dart code and generate HTML. An example of dartdoc output
follows.

{% pc html 0 %}
&lt;div class="doc">
&lt;p>Feed your llama &lt;a class="crossref" href="../llama/Food.html">Food&lt;/a>. Typically, one bale of hay per week.&lt;/p>
&lt;pre class="source">
feed(Food food) {
  // ...
}
&lt;/pre>
&lt;/div>
{% endpc %}

Notice how `[Food]` from the documentation comments
is converted to an HTML link to the API docs for the Food class.