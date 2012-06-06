Dart does operators.
Not only does it define them,
but it lets you redefine many of them.

The following table shows all of Dart's operators,
in order of precedence.

{% include language-tour/operators/_table.html %}

For example, the <b>%</b> operator
has higher precedence than
(and thus executes before) the <b>==</b> operator,
which has higher precedence than the <b>&&</b> operator.
That precedence means that
the following two lines of code execute the same way:

{% pretty_code dart 0 %}
if ((n % i == 0) && (d % i == 0)) // Parens improve readability.
if (n % i == 0 && d % i == 0)     // Harder to read, but equivalent.
{% endpretty_code %}

This section covers the following topics:

<ul>
  <li> <a href="#op-arithmetic">arithmetic operators</a> </li>
  <li> <a href="#op-equality">equality and relational operators</a> </li>
  <li> <a href="#op-assign">assignment operators</a> </li>
  <li> <a href="#op-logical">logical operators</a> </li>
  <li> <a href="#op-bit">bitwise and shift operators</a> </li>
  <li> <a href="#op-other">other operators</a> </li>
  <li> <a href="#op-methods">operators as methods</a> </li>
</ul>


<section id="op-arithmetic" markdown="1">
### Arithmetic operators

Dart supports the usual arithmetic operators.

<table class="operatorTable">
  <tr> <th> Operator </th> <th> Meaning </th> </tr>
  <tr>
    <td class="operator"> + </td>  <td> add </td>
  </tr><tr>
    <td class="operator"> &ndash; </td>  <td> subtract </td>
  </tr><tr>
    <td class="operator"> -<em>expr</em> </td>
    <td> unary negation (reverse the sign of the expression) </td>
  </tr><tr>
    <td class="operator"> * </td>  <td> multiply </td>
  </tr><tr>
    <td class="operator"> / </td>  <td> divide </td>
  </tr><tr>
    <td class="operator"> ~/ </td> <td> divide, returning an integer result </td>
  </tr><tr>
    <td class="operator"> % </td>  <td> get the remainder </td>
  </tr>
</table>

Example:

{% pretty_code dart 0 %}
var a = 2;
var b = 3;

assert(a + b == 5);
assert(a - b == -1);
assert(a * b == 6);
assert(a / b > 0.6 && a / b < 0.7);
assert(a ~/ b == 0);  // Quotient
assert(a % b == 2);   // Remainder
{% endpretty_code %}

Dart also supports both prefix and postfix
increment and decrement operators.

<table class="operatorTable">
  <tr> <th> Operator </th> <th> Meaning </th> </tr>
  <tr>
    <td class="operator"> ++<em>var</em> </td>
    <td> <em>var</em> = <em>var</em> + 1
      (expression value is <em>var</em> + 1)</em> </td>
  </tr><tr>
    <td class="operator"> <em>var</em>++ </td>
    <td> <em>var</em> = <em>var</em> + 1
      (expression value is <em>var</em>) </td>
  </tr><tr>
    <td class="operator"> --<em>var</em> </td>
    <td> <em>var</em> = <em>var</em> &ndash; 1
      (expression value is <em>var</em> &ndash; 1) </td>
  </tr><tr>
    <td class="operator"> <em>var</em>-- </td>
    <td> <em>var</em> = <em>var</em> &ndash; 1
      (expression value is <em>var</em>) </td>
  </tr>
</table>

Example:

{% pretty_code dart 0 %}
var a = 2;

assert(++a == 3);  // Increment before returning a value.
assert(a++ == 3);  // Increment after returning a value.
assert(a-- == 4);  // Decrement after returning a value.
assert(--a == 2);  // Decrement before returning a value.
{% endpretty_code %}
</section>


<section id="op-equality" markdown="1">
### Equality and relational operators

<table class="operatorTable">
  <tr> <th> Operator </th> <th> Meaning </th> </tr>
  <tr>
    <td class="operator"> == </td>
    <td> equal <em>(see discussion below)</em> </td>
    <td>
  </tr><tr>
    <td class="operator"> != </td>
    <td> not equal </td>
  </tr><tr>
    <td class="operator"> === </td>
    <td> same instance </td>
  </tr><tr>
    <td class="operator"> !== </td>
    <td> not the same instance </td>
  </tr><tr>
    <td class="operator"> > </td>
    <td> greater than </td>
  </tr><tr>
    <td class="operator"> &lt; </td>
    <td> less than </td>
  </tr><tr>
    <td class="operator"> >= </td>
    <td> greater than or equal to </td>
  </tr><tr>
    <td class="operator"> &lt;= </td>
    <td> less than or equal to </td>
  </tr><tr>
    <td class="operator"> is </td>
    <td> true if the object has the specified type
      <em>(see discussion below)</em> </td>
  </tr><tr>
    <td class="operator"> is! </td>
    <td> false if the object has the specified type </td>
  </tr>
</table>

<div markdown="1">
To test whether two objects x and y represent the same thing,
use the **==** operator.
You don't usually need to use the **===** operator,
which tests whether two objects are, in fact,
the exact same object.
Here's how the **==** operator will work:

1. If `x===y`, return true.
2. Otherwise, if either x or y is null, return false.
3. Otherwise, return the result of `x.equals(y)`.

The **is** and **is!** operators are handy for checking types.
The result of <code>obj <b>is</b> T</code>
is true if obj implements the interface specified by T.
For example, <code>obj <b>is</b> Object</code> is always true.

Here's an example of using each of the equality and relational operators:
</div>

{% pretty_code dart 0 %}
var a = 2;
var b = 3;
var c = a;

assert(a == 2);       // 2 and 2 are equal.
assert(a != b);       // 2 and 3 aren't equal.
assert(a === c);      // a and c are the same object.
assert(a !== b);      // 2 and 3 aren't the same object.
assert(b > a);        // 3 is more than 2.
assert(a < b);        // 2 is less then 3.
assert(b >= b);       // 3 is greater than or equal to 3.
assert(a <= b);       // 2 is less than or equal to 3.
assert(a is num);     // 2 is a number.
assert(a is! String); // 2 is an int, not a string.
{% endpretty_code %}
</section>


<section id="op-assign" markdown="1">
### Assignment operators

You assign values using the <b>=</b> operator.
You can also use compound assignment operators,
which combine an operation with an assignment.

<table>
  <tr>
    <th> </th>
    <th>Compound assignment</th>
    <th>Equivalent expression</th>
  </tr><tr>
    <th align="left"> For an operator <em>op</em>: </th>
    <td> <code>a <em>op</em>= b</code> </td>
    <td> <code>a = a <em>op</em> b</code> </td>
  </tr>
  <tr>
    <th align="left"> Example: </th>
    <td> <code>a += b</code> </td>
    <td> <code>a = a + b</code> </td>
  </tr>
</table>

Here's a full list of the assignment operators:

<p style="column-count:4; -webkit-column-count:4">
= <br>
+= <br>
&ndash;= <br>
*= <br>
/= <br>
~/= <br>
%= <br>
&lt;&lt;= <br>
>>= <br>
&amp;= <br>
^= <br>
|=
</p>

The following example uses both assignment
and compound assignment operators:

{% pretty_code dart 0 %}
var a = 2;           // Assign using =
a *= 3;              // Assign and multiply: a = a * 3
assert(a == 6);
{% endpretty_code %}
</section>


<section id="op-logical" markdown="1">
### Logical operators

You can invert or combine boolean expressions using the logical operators.

<table class="operatorTable">
  <tr> <th> Operator </th> <th> Meaning </th> </tr>
  <tr>
    <td class="operator"> !<em>expr</em> </td>
    <td> inverts the following expression
      (changes false to true, and vice versa) </td>
  </tr><tr>
    <td class="operator"> || </td>
    <td> logical OR </td>
  </tr><tr>
    <td class="operator"> &amp;&amp; </td>
    <td> logical AND </td>
  </tr>
</table>

{% pretty_code dart 0 %}
if (!done && (col == 0 || col == 3)) {
  // ...Do something...
}
{% endpretty_code %}
</section>


<section id="op-bit" markdown="1">
### Bitwise and shift operators

You can manipulate the individual bits of objects in Dart.
Usually, you'd use these operators with integers.

<table class="operatorTable">
  <tr> <th> Operator </th> <th> Meaning </th> </tr>
  <tr>
    <td class="operator"> &amp; </td>
    <td> AND </td>
  </tr><tr>
    <td class="operator"> | </td>
    <td> OR </td>
  </tr><tr>
    <td class="operator"> ^ </td>
    <td> XOR </td>
  </tr><tr>
    <td class="operator"> ~<em>expr</em> </td>
    <td> unary bitwise complement (0s become 1s; 1s become 0s) </td>
  </tr><tr>
    <td class="operator"> &lt;&lt; </td>  <td> shift left </td>
  </tr><tr>
    <td class="operator"> >> </td>  <td> shift right </td>
  <tr>
</table>

Here's an example of using bitwise and shift operators.

{% pretty_code dart 0 %}
final value = 0x22;
final bitmask = 0x0F;

assert((value & bitmask)  == 0x02);  // AND
assert((value & ~bitmask) == 0x20);  // AND NOT
assert((value | bitmask)  == 0x2f);  // OR
assert((value ^ bitmask)  == 0x2d);  // XOR
assert((value &lt;&lt; 4)       == 0x220);
assert((value >> 4)       == 0x02);
{% endpretty_code %}
</section>


<section id="op-other" markdown="1">
### Other operators

<table class="operatorTable">
  <tr> <th style="text-align:center"> Operator </th> <th> Name </th> <th> Meaning </th> </tr>
  <tr>
    <td class="operator"> () </td>
    <td> function application </td>
    <td> represents a function call </td>
  </tr><tr>
    <td class="operator"> [] </td>
    <td> list access </td>
    <td> refers to the value at the specified index in the list </td>
  </tr><tr>
    <td class="operator"> <em>expr1</em>&nbsp;?&nbsp;<em>expr2</em>&nbsp;:&nbsp;<em>expr3</em> </td>
    <td> conditional </td>
    <td> if <em>expr1</em> is true, executes <em>expr2</em>;
      otherwise, executes <em>expr3</em>
      (technically special syntax, not an operator)
      </td>
  </tr><tr>
    <td class="operator"> . </td>
    <td> member access </td>
    <td> refers to a property of an expression;
      example: <code>foo.bar</code> selects property <code>bar</code>
      from expression <code>foo</code> </td>
  </tr>
</table>


</section>

{% comment %}
NOTE: The following aren't operators; they're syntax:
=>
{}
;
?:
{% endcomment %}


<section id="op-methods" markdown="1">
### Operators are methods

Operators are just instance methods with special names.
For example, the expression <code>1 + 2</code>
invokes the + method on 1, with the argument 2&mdash;something
like <code>1.+(2)</code>.
This has a couple of consequences:

- Dart lets you override many operators.
  For example, if you define a Vector class,
  you might define a + method to add two vectors.
- For operators that work on two operands,
  the leftmost operand determines
  which version of the operator is used.
  For example, if you define a Vector class and a Point class,
  `aVector + aPoint` uses the Vector version of +.
</section>

The following operators can be overridden:

<p style="column-count:4; -webkit-column-count:4">
&lt; <br>
> <br>
&lt;= <br>
>= <br>
&ndash; <br>
+ <br>
/ <br>
~/ <br>
* <br>
% <br>
| <br>
^ <br>
&amp; <br>
&lt;&lt; <br>
>> <br>
[] <!-- (list access operator) --> <br>
[]= <em>(list assignment)</em> <br>
~ <br>
{% comment %}
WILLCHANGE
call() <em>(</em><code>()</code><em>)</em> <!-- (function application: ()) --> <br>
{% endcomment %}
equals() <em>(</em><code>==</code><em>)</em> <!-- (==) --> *
{% comment %}
<br>
negate <em>(<code>-expr</code>)</em> <!-- (unary minus: -) --> **
{% endcomment %}
</p>

<aside class="note" markdown="1">
{% comment %}
WILLCHANGE: will need to tweak the wording.
{% endcomment %}
\* The **==** operator can currently be overridden,
but not for long.
Soon the way to customize the behavior of **==**
will be by overriding the **equals()** method.
</aside>

<p markdown="1">
For an example of overriding operators,
see [Operators](#classes-operators) in the Classes section.
</p>

</section>


<section id="op-summary" markdown="1">
### Summary of operators

Dart operators should look and act familiar.
Behind the scenes, an operator is a specially named method
that's invoked on its first operand.
As a result, operand order can make a difference:
a+b might not give the same result as b+a.
You can override many operators.
</section>
