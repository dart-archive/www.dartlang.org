### Manipulating the DOM {#html-dom}

To use the DOM,
you need to know about _windows_, _documents_, _elements_,
and _nodes_.

A [Window](http://api.dartlang.org/html/Window.html) object
represents the actual window of the web browser. Each Window has
a `document` property, which points to the document currently loaded.
In tabbed browsers, Window objects are not shared between tabs; each
tab has its own Window object.
Each window can contain embedded windows (_frames_).

With the [Document](http://api.dartlang.org/html/Document.html)
object, you can create and manipulate elements
([Element](http://api.dartlang.org/html/Element.html))
within the document. Note that the document itself is an
element and can be manipulated.

The DOM models a tree of nodes
([Node](http://api.dartlang.org/html/Node.html)).
These nodes are often elements, but they can also be
attributes, text, comments, and other DOM types.
Except for the root node,
which has no parent,
each node in the DOM has one parent and might have many children.

{% comment %}
{PENDING: picture should go here}
{% endcomment %}


#### Finding elements
To manipulate an element,
you first need to have an object that represents it.
You can get this object using a query.

Find one or more elements
using the top-level methods `query()` and `queryAll()`.
You can query by ID, class, tag, name,
or any combination of these.

{% highlight dart %}
#import('dart:html');

var elem1 = query('#id');               // Find an element by id.
var elem2 = query('.class');            // Find an element by class.
var elems1 = queryAll('div');           // Find all elements by tag.
var elems2 = queryAll('[data-role="button"]'); // Find button widgets.

// Find all elements with the CSS class 'class' inside of a <p>
// that is inside an element with the ID 'id'.
var elems3 = queryAll('#id p .class');
{% endhighlight %}


#### Manipulating elements

You can use properties to change the state of an element.
[Node](http://api.dartlang.org/html/Node.html) and its subtype
[Element](http://api.dartlang.org/html/Element.html)
define the properties that all elements have.
For example, all elements have
`classNames`, `hidden`, `id`, `innerHTML`,
`style`, `text`, and `title` properties.
Subclasses of Element define additional properties,
such as the `href` property of
[AnchorElement](http://api.dartlang.org/html/AnchorElement.html).

Consider this example of specifying an anchor element in HTML:

{% highlight dart %}
<a id='example' href='http://example.com'>linktext</a>
{% endhighlight %}

This &lt;a> tag specifies an element
with an `href` attribute
and a text node
(accessible via a `text` property)
that contains the string "linktext".
To change the URL
that the link goes to,
you can use AnchorElement's `href` property:

{% highlight dart %}
query('#example').href = 'http://google.com';
{% endhighlight %}

Often you need to set properties on multiple elements.
For example, the following code sets the `hidden` property
of all elements
that have a class of "mac", "win", or "linux".
Setting the `hidden` property to true
has the same effect as adding `display:none` to the CSS.

{% highlight dart %}
final osList = const ['mac', 'win', 'linux'];

osList.forEach((os) {               // For each possible OS...
  bool shouldShow = (os == userOs); // Does this OS match the user's OS?
  queryAll('.$os').forEach((elem) { // Find all elements for this OS.
    elem.hidden = !shouldShow;      // Show or hide each element.
  });
});
{% endhighlight %}

When the right property isn't available or convenient,
you can use Element's `attributes` property.
This property has the type 
[AttributeMap](http://api.dartlang.org/html/AttributeMap.html),
which implements a [map](#maps-aka-dictionaries-or-hashes)
with keys that are strings
(attribute names)
and values that it automatically converts to strings.
For a list of attribute names and their meanings, see the
[MDN Attributes page](https://developer.mozilla.org/en/HTML/Attributes).
Here's an example of setting an attribute's value.

{% highlight dart %}
elem.attributes['someAttribute'] = 'someValue';
{% endhighlight %}


#### Creating elements
You can add to existing HTML pages
by creating new elements and
attaching them to the DOM.

{% highlight dart %}
var elem = new ParagraphElement();
elem.text = 'Creating is easy!';
{% endhighlight %}

Or parse HTML text into an element.
Any child elements are also parsed and created.

{% highlight dart %}
var elem = new Element.html('<p>Creating <em>is</em> easy!</p>');
{% endhighlight %}

{% comment %}
{PENDING: deleted because we apparently don't want to encourage this.}
When an element has no specialized class,
you can use the Element.tag() constructor.

{% highlight dart %}
var elem = new Element.tag('p'); // Create a new <p> element.
elem.text = 'Creating is easy?'; // Set the text of the element.
{% endhighlight %}
{% endcomment %}

#### Adding, replacing, and removing nodes

Recall that elements are just a kind of node.
You can find all the children of a node
using the `nodes` getter of Node,
which returns a
[NodeList](http://api.dartlang.org/html/NodeList.html)
(a specialized List&lt;Node>).
Once you have this list,
you can use the usual List methods and operators
to manipulate the children of the node.

To add a node as the last child of its parent,
use the List add() method.

{% highlight dart %}
// Find the parent by ID, and add elem as its final child.
query('#inputs').nodes.add(elem);
{% endhighlight %}

To replace a node, use the Node replaceWith() method.

{% highlight dart %}
// Find a node by ID, and replace it in the DOM.
query('#status').replaceWith(elem);
{% endhighlight %}

To remove a node, use the Node remove() method.

{% highlight dart %}
// Find a node by ID, and remove it from the DOM.
query('#example').remove();
{% endhighlight %}

{% comment %}
If we change the way nodes and elements work
(see https://code.google.com/p/dart/issues/detail?id=3584)
we'll need to change this whole discussion
(to use Element.elements, e.g.).
{% endcomment %}


#### Handling events
To respond to external events
such as clicks, changes of focus, and selections,
add an event listener.

<pre class="indented">
<em>element</em>.on.<em>event</em>.add(<em>function</em>);
</pre>

For example, here's how you can handle clicks on a button.

{% highlight dart %}
// Find a button by ID and add an event handler.
query('#submitInfo').on.click.add((e) {
  // When the button is clicked, it runs this code.
  submitData();
});
{% endhighlight %}

To see all the events for which you can register an event listener,
consult the API docs for
[ElementEvents](http://api.dartlang.org/html/ElementEvents.html)
and its subclasses.
