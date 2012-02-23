Here's an example of creating a variable and assigning a value to it.

{% pretty_code dart 0 %}
var name = 'Bob';
{% endpretty_code %}

Variables are references. The variable named `name` contains a reference
to a String object with a value of "Bob".

#### Default value

Uninitialized variables have an initial value of `null`. This includes numbers,
which are also objects.

{% pretty_code dart 0 %}
num lineCount;
lineCount == null; // true
{% endpretty_code %}

#### Optional types

You have the optional of adding static types to your variable declarations.

{% pretty_code dart 0 %}
String name = 'Bob';
{% endpretty_code %}

Adding types is a good way to clearly express your intent.
Tools like compilers and editors can use these types to
help you, by providing early warnings for bugs and code completion.

#### final

If you never intend to change a variable, use `final` instead of var or in
addition to a type. Once a `final` variable is set, it can't be changed.

{% pretty_code dart 0 %}
final String name = 'Bob';
<span class="code-error">name = 'Alice'; // Compile ERROR (VM or to JavaScript)</span>
{% endpretty_code %}

#### Summary

Dart variables are optionally typed, though we generally recommend using types.
Variables can be marked as `final`, locking the value. Unitialized variables
have an initial value of `null`.