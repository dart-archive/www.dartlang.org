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
in which each HTML page element
(a title or paragraph, for example)
is a node in the tree.
Each node in the tree
keeps track of both its parent and its children.
In Dart, the Node class contains the methods
and properties that implement a node's tree functionality.

HTML page elements are one kind of node 
that can be in the DOM tree.
In Dart, the Element class is a subclass of Node;
thus, an Element can be placed in the DOM tree.
Element implements the behavior common to all HTML page elements,
such as maintaining information about its enclosing rectangle.

Element has many subclasses that
implement specialized behavior
for different kinds of page elements.
For example, ParagraphElement and TitleElement are both
subclasses of Element that implement
behavior specific to paragraphs and titles.

Because the nodes you care about most are usually elements,
this target focuses on Element,
rather than on Node.
This target uses an app called ToDo
to show how to add an element to the DOM.

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
Because the `parent` variable is final,
you cannot move an Element by changing its parent variable.

Let's take a look at ToDo, a simple app
that dynamically adds an Element to the DOM tree.

##Create and run ToDo app in Dart Editor {#copy-app}

Using the links in the pink box to the left,
copy the ToDo app's Dart, HTML, and CSS code
into a new web app in Dart Editor.

Name the app `todo` and make sure the filenames are
the same as those listed in the pink box.
Then run the app.

Enter `sing` into the input field.

![ToDo app running](images/type-sing.png)

The ToDo app adds _sing_ to the page just below _dance_.

![ToDo app running](images/adds-sing.png)

The HTML code for this app sets up the page,
and therefore the initial elements in the DOM.
When the user enters text,
the Dart code dynamically modifies the DOM,
thus changing the appearance of the page.

This is the beginning of an app to manage a list of things to do.
Right now, the outlook is rather pessimistic
as the program only lets you add items to your to do list
but not remove them.

##Setting up the page in HTML {#html-code}

The HTML code for the ToDo app sets up the initial
HTML page, and thereby the initial DOM tree.
You could get the same results using Dart code,
but it's usually better
to define the primary page elements in HTML code
(easier to read, quicker to load).

![ToDo app HTML](images/todo-html.png)

Of interest are the two page elements that have IDs:
`to-do-input` and `to-do-list`.
The first identifies the \<input> element into which the user types.
The second identifies the \<ul> (unordered list) element
containing the task items.
The HTML code puts one item, _dance_,
in the list to start.
Dart code adds more elements to this list dynamically
whenever the user enters text into the input element.

##Getting an element from the DOM {#dart-code}

The following diagram shows
the Dart code for the ToDo app.

![ToDo app HTML](images/todo-dart.png)

The main() function uses dart:html's top-level query() function
to get the interesting elements from the DOM.
Because calling query() isn't free,
if a program refers to an element more than once
it should stash a reference to the element.

This program stashes a reference
to the input element
in a top-level variable called `toDoInput`
The unordered list
is in the top-level variable `toDoList`.

Note the types of these variables: InputElement and UListElement.
These are both subclasses of Element.
The dart:html library has dozens of Element subclasses,
many of which correspond to certain HTML tags.
This program uses three:

| **HTML tag** | **Dart class** |
| \<input> | InputElement |
| \<ul> | UListElement |
| \<li> | LIElement |
{: .table}

## Registering an event handler {#event-handler}

When a user enters text into the input field,
a _change event_ fires.
The ToDo app has a function named `addToDoItem()`
that can handle these change events.
The following code
connects addToDoItem() to the input field:

![Add an event handler to the ToDo input element](images/event-handler-todo.png)

Rather than dissect this busy line of code,
think of it as a Dart idiom
for adding an event handler to an Element.

![Dart idiom: Add an event handler to an Element](images/event-handler-idiom.png)

A change event is just one of many different types of events
that an element can generate.
For example, you can use `click` to handle mouse clicks,
or `keyDown` for when someone types a key on the keyboard.

##Adding an element to the DOM tree {#add-elem}

The change event handler 
has the following code:

![The add todo item function](images/add-element-code.png)

The final line is where the DOM gets changed.

![The add todo item line of code](images/add-element-line.png)

An Element keeps references to all of its children
in a list called `elements`.
The Element class declares `elements` as a List\<Element>,
which you can read as "list of element".
By adding and removing elements to and from this list,
your code changes the DOM
and thus the appearance of the web page.

{% endcapture %}

{% include tutorial.html %}
