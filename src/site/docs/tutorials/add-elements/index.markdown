---
layout: default
title: "Target 3: Add an Element to the DOM"
description: "You have an Element object, now what?"
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

{% capture content %}

As you learned in the previous target,
the DOM represents the structure
of a web page document using a simple tree structure.
Each node in the tree represents an item on the page.
Each node in the tree keeps track of both
its parent and its children.
In Dart, the
<a href="http://api.dartlang.org/dart_html/Node.html" target="_blank">Node</a>
class contains the methods and properties
that implement node's tree functionality.

HTML page elements are one kind of node that can be in the DOM tree.
They have a rectangular area on the page and can receive events.
Examples of elements include
heading elements, paragraph elements, table elements,
button elements, and so on.

In Dart,
elements are implemented by the
<a href="http://api.dartlang.org/dart_html/Element.html" target="_blank">Element</a>
class, which is a subclass of Node.
Because the nodes you care about most are usually elements,
this target focuses on Element,
rather than on Node.

* [Copy and run the todo web app](#copy-app)
* [About parent and child Elements in Dart](#tree-structure)
* [Setting up the page in HTML](#html-code)
* [Getting an element from the DOM](#dart-code)
* [Registering an event handler](#event-handler)
* [Adding an element to the DOM tree](#add-elem)

##Copy and run the todo web app {#copy-app}

In this target, you will be working with a sample web app
that is a partial implementation of a todo list.
This program dynamically changes the DOM,
and therefore the web page,
by adding elements to the DOM tree.

Use the following links to
copy the HTML, Dart, and CSS code
into a new web app in Dart Editor.
Name the app todo and make sure the filenames
are the same as those listed here.

<ul>
  <li>
<a href="http://raw.github.com/dart-lang/dart-tutorials-samples/master/web/target03/todo/todo.dart"
   target="_blank">todo.dart</a>
 </li>
  <li>
<a href="http://raw.github.com/dart-lang/dart-tutorials-samples/master/web/target03/todo/todo.html"
   target="_blank">todo.html</a>
 </li>
  <li>
<a href="http://raw.github.com/dart-lang/dart-tutorials-samples/master/web/target03/todo/todo.css"
   target="_blank">todo.css</a>
 </li>
 </ul>

Then run the app.
Enter _dance_ into the input field.

![todo app running in Dartium](images/type-dance.png)

The todo app adds _dance_ to the page just below _My list:_.

![todo app after dance is added to the list](images/adds-dance.png)

This is the beginning of an app to manage a list of things to do.
Right now, this app is for procrastinators only
because the program can only add items to your to do list
but not remove them.

##About parent and child Elements in Dart {#tree-structure}

The Node class in Dart implements the basic treeing behavior
for nodes in the Dart DOM.
The Element class is a subclass of Node that implements
the behavior specific to page element nodes.
For example,
an element knows the width and height of
its enclosing rectangle on the page
and it can receive events.

You can manipulate the DOM tree by adding and deleting nodes.
However, many Dart apps are concerned only with page elements.
So for convenience and code simplicity,
the Element class implements API
for interacting with
a subset of the DOM that includes
only the nodes that are Elements.
You can work with a virtual tree of Elements
rather than the more complex tree of Nodes.
This target shows you how to manipulate the
DOM through the Element class.

An Element has a parent Element
and maintains references to its child Elements in a list.

![An element with multiple child elements and a parent element](images/relationships.png)

An Element has at most one parent Element.
An Element's parent is final and cannot be changed.
So you cannot move an Element by changing its parent.
Get an Element's parent with the getter `parent`.
For example, if you have an Element with the name `anElement`
you would refer to its parent element with `anElement.parent`.

![Dart code reference to anElement's parent](images/parent-reference.png)

An Element maintains references to its child elements in a list.
List is a class in the dart:core library
that implements an indexable collection with a length.
A list can be of fixed size or extendable.

List is an example of a _generic_ (or _parameterized_) type&mdash;a type
that can declare formal type parameters.
This means that a list can be declared
to contain only objects of a particular type.
For example:

| List declaration | List description|
|---|---|
| List\<String> | list of strings |
| List\<int> | list of integers |
| List\<Element> | list of elements|
{: .table}

An Element maintains references to its child element in a List\<Element>,
which your Dart code can refer to with the getter `elements`.
The List class has various functions and operators
whereby you can refer to each child Element individually,
iterate over the list, and add and remove elements.

![Dart code references to anElement's list of children and individual child Elements](images/child-references.png)

You can change the tree structure by adding children to
and removing children from an Element's list of children.

![Add a child element](images/add-element.png)

When you change an Element or its child Elements in your Dart program,
you change the DOM and therefore the web page.
The browser re-renders the page automatically.

##Setting up the page in HTML {#html-code}

Let's take a look at the todo app
to see how it dynamically
adds an element to the DOM
and displays a new item in the list of things to do.

The HTML code for the todo app sets up the initial HTML page,
and thereby the initial DOM tree.
You could get the same results using Dart code,
but it's usually better to define the primary page elements
in HTML code (easier to read, quicker to load).

![todo app and its corresponding HTML code](images/todo-html.png)

The following diagram shows a partial DOM tree for the todo app.

![The todo app and part of its DOM tree](images/todo-dom.png)

Of interest are the two page elements that have IDs:
`to-do-input` and `to-do-list`.
The first identifies the \<input> element into which the user types.
The second identifies the \<ul> (unordered list) element
containing the task items.
Dart code adds elements to this list
whenver the user enters text into the input element.

##Getting an element from the DOM {#dart-code}

The following diagram shows
the Dart code for the todo app.

![todo app and its corresponding Dart code](images/todo-dart.png)

The main() function uses dart:html's top-level query()
function to get the interesting elements from the DOM.
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

| HTML tag | Dart class |
|---|---|
| \<input> | <a href="http://api.dartlang.org/dart_html/InputElement.html" target="_blank">InputElement</a> |
| \<ul> | <a href="http://api.dartlang.org/dart_html/UListElement.html" target="_blank">UListElement</a> |
| \<li> | <a href="http://api.dartlang.org/dart_html/LIElement.html" target="_blank">LIElement</a> |
{: .table}

## Registering an event handler {#event-handler}

When a user enters text into the input field,
a _change_ event fires.
The todo app has a function named addToDoItem()
that can handle these change events.
The following code connects addToDoItem to the input field:

![Add an event handler to the toDoInput element](images/event-handler-todo.png)

Rather than dissect this busy line of code,
think of it as a Dart idiom
for adding an event handler to an Element.

![Dart idiom: Add an event handler to an Element](images/event-handler-idiom.png)

A change event is just one of many different types of events
that an element can generate.
For example, you can use `click` to handle mouse clicks,
or `keyDown` for when someone types a key on the keyboard.

##Adding an element to the DOM tree {#add-elem}

The change event handler has the following code:

![The addToDoItem function explained](images/add-element-code.png)

The final line of code is where the DOM gets changed.
The add() function is defined in the List class in the dart:core library.

An Element keeps references to all of its children in a list called `elements`.
By adding and removing elements to and from this list,
your code changes the DOM.
When the DOM changes, the browser re-renders the browser page.
The effect, in our todo app, is that a new bullet item appears 
in the to do list.

<div class="row">
  <div class="span3">
  <a href="/docs/tutorials/connect-dart-html/"><i class="icon-chevron-left"> </i> Connect Dart &amp; HTML</a>
  </div>
  <div class="span3">
<a href="http://code.google.com/p/dart/issues/entry?template=Tutorial%20feedback"
 target="_blank">
<i class="icon-comment"> </i>
Send feedback
</a>
  </div>
  <div class="span3">
  <a href="/docs/tutorials/" class="pull-right">Home <i class="icon-chevron-right"> </i> </a>
  </div>
</div>

{% endcapture %}

{% include tutorial.html %}
