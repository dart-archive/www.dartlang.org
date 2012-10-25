---
layout: default
title: "Target 3: Element Basics"
description: You have an Element object, now what?
has-permalinks: true
tutorial:
  id: add-elems
---

{% capture whats_the_point %}

* Element
* Document

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
(thus an Element can be placed in the DOM tree),
that implements the behavior common to all HTML page elements.
Element has many subclasses that
implement specialized behavior
for different kinds of page elements.
For example, ParagraphElement and TitleElement are both
subclasses of Element.

At a basic level,
in a Dart web app,
the type of nodes you care about most are Elements.
So this target focuses on Elements,
rather than on Nodes.

* [About Elements in the DOM](#tree-structure)
* [Run ToDo app in Dart Editor](#copy-app)
* [Setting up the page in HTML](#html-code)
* [Getting an Element from the DOM](#dart-code)
* [Registering an Event Handler](#event-handler)
* [Adding an Element to the DOM Tree](#add-elem)

##About Elements in the DOM {#tree-structure}

Each Element in the DOM has at most one parent
and can have many child Elements.
The root element, the one at the top of the tree,
has no parent.
In Dart, the root element is of type Document,
which is a subclass of Element.

![Basic tree of Dart elements](images/basic-tree.png)

An Element maintains its own position in the tree by
keeping a reference to its parent, the `parent` variable,
and a list of its children, the `elements` variable:

![An element with children and parent](images/an-element.png)

You can change the tree structure by adding children to
and removing children from an Element's list of children.
The `parent` reference is final and cannot be changed.
So you cannot move an ELement by changing its parent.

Let's take a look at a simplistic app
that dynamically adds an Element to the DOM tree.

##Run ToDo app in Dart Editor {#copy-app}

Using the links in the pink box to the left
copy the HTML, Dart, and CSS code
into a new web app in Dart Editor.
Name the app `todo` and make sure you keep the filenames as listed.
Then run the app.

Enter `sing` into the textfield.

![ToDo app running](images/type-sing.png)

The ToDo app adds _sing_ to the page just below _dance_.

The HTML code for this app sets up the page
and therefore the initial elements in the DOM.
When the user enters text,
the Dart code dynamically modifies the DOM 
and therefore the appearance of the page.

This is the beginning of an app to manage a To Do list.
Right now, the program only lets you add items to your To Do list
but not remove them.
(Because nothing ever gets done, right?)

##Setting up the page in HTML {#html-code}

The HTML code for the ToDo app sets up the initial
HTML page and thereby the initial DOM tree.
You could get the same results using Dart code,
but you need an HTML file to host the Dart app anyway,
so it makes sense (in this example at least),
to create the static page elements
on the HTML-side of things.

(The two ellipses in the diagram below indicate
that some HTML code is not shown.)

![ToDo app HTML](images/todo-html.png)

Of interest to us are the two page elements that have IDs.
The input element into which the user types
has the ID `to-do-input`.
The unnumbered list element
has the ID `to-do-list`.
The list element starts with one item in it,
namely _dance_.
When the user types into the input element
the Dart code adds an element to the list element.

##Getting an Element from the DOM {#dart-code}

The diagram below shows
the entire Dart code for the little ToDo app.
The code queries the DOM for the two elements
from the HTML code that had IDs.

![ToDo app HTML](images/todo-dart.png)

The main program has three lines of code.
As you saw in the previous target,
a Dart app can get an element by its ID from the DOM
using the `query()` function.
There is a performance cost to the `query()` function,
so if a program refers to an element more than once,
it should stash a reference to the element
rather than calling `query()` multiple times.

The first line in the `main()` function
gets the element whose ID is `to-do-input`,
which is the input element in the HTML file,
and stashes the reference
in a top-level variable called `toDoInput`.
Note that the type of the variable is InputElement.
In Dart,
input elements are implemented by the InputElement class,
which is a subclass of Element.

The code then gets the unnumbered list element by its ID `to-do-list`.
Unnumbered lists are implemented in Dart by the UListElement class,
another handy subclass of Element.

Now that the code has each of the two interesting elements,
receive user-generated events on one element
and add child elements to the other in response.

##Registering an Event Handler {#event-handler}

The third and final line of code in main
registers an event handler with the input element.

`toDoInput.on.change.add((e) => addToDoItem());`

When the user enters text
(types text followed by \<return>)
the input element
[xxx]

##Adding an Element to the DOM Tree {#add-elem}

[xxx]


{% endcapture %}

{% include tutorial.html %}
