---
layout: default
title: "Target 3: Add an Element to the DOM"
description: You have an Element object, now what?
has-permalinks: true
tutorial:
  id: add-elems
---

{% capture whats_the_point %}

* In Dart, elements are of type Element.
* An Element knows its parent.
* An Element keeps its children in a List\<Element>.
* Change the DOM by adding or removing children of elements.

{% endcapture %}

{% capture code_links %}
<ul>
<li>
   <a href="examples/todo/todo.dart.txt">todo.dart</a>
</li>
<li>
   <a href="examples/todo/todo.html.txt">todo.html</a>
</li>
<li>
   <a href="examples/todo/todo.css.txt">todo.css</a>
</li>
</ul>
{% endcapture %}

{% capture content %}

As you learned in the previous target,
the DOM models a web page using a simple tree structure,
in which each HTML page element,
a title or paragraph for example,
is a node in the tree.
The tree structure is a result of each node
keeping track of its parent and its children.
In Dart, the Node class contains the functions
and properties that implement the treeing behavior of a node.

HTML page elements are one kind of node 
that can be in the DOM tree.
In Dart, the Element class is a subclass of Node
thus an Element can be placed in the DOM tree.
Element implements the behavior common to all HTML page elements,
such as maintaing information about its enclosing rectangle.
Element has many subclasses that
implement specialized behavior
for different kinds of page elements.
For example, ParagraphElement and TitleElement are both
subclasses of Element that implement
behavior specifc to paragraphs and titles..

At a basic level,
in a Dart web app,
the type of nodes you care about most are Elements.
So this target focuses on Elements,
rather than on Nodes.

* [About elements in the DOM](#tree-structure)
* [Create and run ToDo app in Dart Editor](#copy-app)
* [Setting up the page in HTML](#html-code)
* [Getting an element from the DOM](#dart-code)
* [Registering an event handler](#event-handler)
* [Adding an element to the DOM tree](#add-elem)

##About elements in the DOM {#tree-structure}

Each Element in the DOM has at most one parent
and can have many children.
The root element, the one at the top of the tree,
has no parent.
In Dart, the root element is of type Document,
which is a subclass of Element.

![Basic tree of Dart elements](images/basic-tree.png)

An Element maintains its own position in the tree by
keeping a reference to its parent in its `parent` variable,
and a list of its children in the `elements` variable:

![An element with children and parent](images/an-element.png)

You can change the tree structure by adding children to
and removing children from an Element's list of children.
The `parent` reference is final and cannot be changed.
So you cannot move an Element by changing its parent.

Let's take a look at a simplistic app
that dynamically adds an Element to the DOM tree.

##Create and run ToDo app in Dart Editor {#copy-app}

Using the links in the pink box to the left
copy the HTML, Dart, and CSS code
into a new web app in Dart Editor.

Name the app `todo` and make sure you keep the filenames as listed.
Then run the app.

Enter `sing` into the input field.

![ToDo app running](images/type-sing.png)

The ToDo app adds _sing_ to the page just below _dance_.

![ToDo app running](images/adds-sing.png)

The HTML code for this app sets up the page
and therefore the initial elements in the DOM.
When the user enters text,
the Dart code dynamically modifies the DOM 
and therefore the appearance of the page.

This is the beginning of an app to manage a list of things to do.
Right now, the outlook is rather pessimistic
as the program only lets you add items to your to do list
but not remove them.

##Setting up the page in HTML {#html-code}

The HTML code for the ToDo app sets up the initial
HTML page and thereby the initial DOM tree.
You could get the same results using Dart code,
but you need an HTML file to host the Dart app anyway,
so it makes sense (in this example at least),
to create the primary page elements
on the HTML-side of things.

![ToDo app HTML](images/todo-html.png)

Of interest to us are the two page elements that have IDs.
`to-do-input` identifies the input element into which the user types.
`to-do-list` identifies the unnumbered list element
to which tasks are added.
The HTML code puts one item, _dance_.
in the list to start.
Additional elements are added to this list dynamically
on the Dart-side
when the user enters text into the input element.

##Getting an element from the DOM {#dart-code}

The diagram below shows
the entire Dart code for the little ToDo app.
The code queries the DOM for the two elements
from the HTML code that had IDs.

![ToDo app HTML](images/todo-dart.png)

The main() function uses query() twice
to get each of the interesting elements.
There is a performance cost to the query() function,
so if a program refers to an element more than once,
it should stash a reference to the element
rather than calling query() multiple times.

This program stashes the reference
to the input element
in a top-level variable called `toDoInput`
and the reference to unnumbered list element
in a top-level variable called `toDoList`.

Note the types of these variables: InputElement and UListElement.
These are both subclasses of Element.
The Dart HTML has dozens of Element subclasses,
many of which correspond to certain HTML tags.
This program uses three, as follows:

| HTML Tag | Dart Class |
| \<input> | InputElement |
| \<ul> | UListElement |
| \<li> | LIElement |
{: .table}

## Registering an event handler {#event-handler}

When a user enters text into the input field
the input field generates a _change_ event.
The ToDo app is interested in these events
so it adds an event handler,
`addToDoItem()`,
to the input element:

![Add an event handler to the ToDo input element](images/event-handler-todo.png)

Rather than dissect this busy line of code,
think of it instead as a Dart idiom
for adding an event handler to an Element.

![Dart Idiom: Add an event handler to an Element](images/event-handler-idiom.png)

A change event is just one of many different types of events
that an element can generate.
For example, you can use `click` to handle mouse clicks,
or `keyDown` for when someone types a key on the keyboard.

##Adding an element to the DOM Tree {#add-elem}

This is the change event handler in the ToDo app.

![The add todo item function](images/add-element-code.png)

The final line of code is where the DOM gets changed.

![The add todo item line of code](images/add-element-line.png)

A Dart Element keeps references to all of its children
in a list called `elements`.
The Element class declares `elements` as a List\<Element>,
which you can read as "list of element".
By adding and removing elements to this list,
your code changes the DOM
and thus the appearance of the web page.

{% endcapture %}

{% include tutorial.html %}
