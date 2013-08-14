---
layout: default
title: "Remove DOM Elements"
description: "Remove a child element from the DOM"
has-permalinks: true
tutorial:
  id: remove-elements
next: shared-pkgs/
next-title: "Install Shared Packages"
prev: add-elements/
prev-title: "Add Elements to the DOM"
---

{% capture whats_the_point %}

* Use _element_.remove() to remove an element from the DOM.
* Remove all children from an element with _element_.children.clear().
* Function expressions are a convenient way to define single-use functions.
* => is a shorthand syntax for defining functions that contain just one
expression.
* dart:html defines many event-related classes.

{% endcapture %}

{% capture sample_links %}

<p>
Get the source code for the sample featured in this target:</p>

<ul>
  <li>
    <a href="https://github.com/dart-lang/dart-tutorials-samples/tree/master/web/target04/todo_with_delete"
       target="_blank">todo_with_delete</a>
  </li>
</ul>

{% endcapture %}

{% capture content %}

<div class="tute-target-title">
<h1>{{page.title}}</h1>
<h3>Dynamically delete items from the browser page.</h3>
</div>

This target shows you how to delete elements from the DOM.
A new and improved version of the todo app from
[the previous target](/docs/tutorials/add-elements/)
now allows the user to delete items from the list
either one at a time, or all at once.

* [Try the app](#try-app)
* [Changing the appearance when cursor is over an element](#css-hover)
* [Removing an element from the DOM tree](#remove-elem)
* [Removing all child elements from an element](#remove-all-elem)
* [About function expressions and =>](#about-function-expressions)
* [Other resources](#other-resources)

##Try the app {#try-app}

Below is a revised version
of the todo app from the previous target
that allows you to delete items.
Stop procrastinating and remove items from your todo list.

**Try it!**
Type in the input field and press the return key;
a new item appears in the list.
Enter a few more items.
Point the mouse cursor at one of the items in the list;
the item turns red and gets slightly larger.
Click it and it disappears from the list.
Use the **Delete All** button in the lower right corner of the app
to remove all of the items in the list at once.

<iframe class="running-app-frame"
        style="height:250px;width:300px;"
        src="http://dart-lang.github.io/dart-tutorials-samples/web/target04/todo_with_delete/web/todo_with_delete.html">
</iframe>

You can find the complete source code for this sample on github at
<a href="https://github.com/dart-lang/dart-tutorials-samples/tree/master/web/target04/todo_with_delete"
target="_blank">todo_with_delete</a>.

The remaining sections describe
key aspects of the code 
added to the todo app for this target.
Specifically, they look at
the Dart code that removes one or more elements from the DOM
and the CSS code that makes the text red and larger.

##Changing the appearance when cursor is over an element {#css-hover}

As you saw, an item in the list turns red and gets bigger
when the user points at it.
The mouse cursor also changes shape.
These visual clues are an important part of the user interface
in this example because they are the only indication to the user
that something will happen when the item is clicked.

This behavior is coded in the todo_with_delete app's CSS file with this rule:

{% prettify dart %}
#to-do-list li:hover {
  color: red;
  font-size: 18px;
  cursor:pointer;
}
{% endprettify %}

We've used this CSS trick
instead of providing a familiar user interface,
such as a button with an 'X' on it,
to keep the code simpler.

##Removing an element from the DOM tree {#remove-elem}

An element is removed from
the DOM when it is removed from its parent's list of children.
The List class provides functions for finding an item in the list
and removing it.
But, in this case,
using the element's remove() function
is shorter and more concise than
using functions from the List class.

![Use element.remove() to remove an element from the DOM](images/remove-element.png)

In the todo_with_delete app,
the user clicks an item to delete it.
This is achieved with one line of Dart code.
When a new to do item is created,
the code registers a mouse click handler on the new element.
The event handler causes the element to remove itself from the DOM
with remove().

![Registering an event handler to delete an item](images/remove-element-code.png)

When the element removes itself from the DOM,
the browser re-renders the page,
and the item disappears from the to do list.

##Removing all child elements from an element {#remove-all-elem}

When the user clicks the **Delete All** button,
all elements are removed from the list.

![Use element.children.clear() to remove all of an element's children](images/remove-all-elements.png)

In this case, using the List class's clear() function
yields the most concise code.
Here's the code from the todo_with_delete app
that implements the **Delete All** button.

<ol>
<li markdown="1">
The HTML code creates a button with the ID delete-all.
(The CSS styles it.)

{% prettify dart %}
<button id="delete-all" type="button" style="float:right"> Delete All </button>
{% endprettify %}

</li>

<li markdown="1">
The Dart code gets the button element from the DOM
using query() and the button's ID, #delete-all.
The code registers a mouse click handler on the button;
the handler removes all of the child elements from the to do list.
Here is all of the Dart code related to the **Delete All** button.

![Remove all child elements from an Element](images/remove-all-code.png)

</li>
</ol>

##About function expressions and => {#about-function-expressions}

The todo_with_delete app uses
some interesting Dart syntax
when adding an event listener to the **Delete All** button.
The argument passed into the listen() function
is an example of a _function expression_,
which is a shorthand way of defining functions
and it uses the => syntax to define the function concisely.

![A one-line function definition](images/event-listener-exp.png)

It is equivalent to writing this:

{% prettify dart %}
deleteAll.onClick.listen((e) {
  toDoList.children.clear();
});
{% endprettify %}

or even this:

{% prettify dart %}
...
void main() {
  ...
  deleteAll.onClick.listen(deleteAllElements);
}

void deleteAllElements(Event e) {
  toDoList.children.clear();
}
...
{% endprettify %}

Function expressions are often used
when registering event handlers on an element
and can extend over multiple lines.
When registering event handlers,
the function must be an EventListener.
That is,
it returns no value and takes an Event object as a parameter.

##Other resources

<ul>
  <li>
    Check out
    <a href="/docs/cookbook/">
    <i class="icon-food"> </i> Dart Cookbook</a>,
    where you'll find many recipes about manipulating the DOM
    and using CSS.
    The cookbook also has recipes about basic Dart data types,
    such strings, lists, maps, and numbers.
  </li>

  <li>
    You can find more information about the DOM and CSS in
    <a href="/docs/dart-up-and-running/">Dart Up and Running</a>,
    which also provides thorough coverage of the Dart language, 
    libraries, and tools.
  </li>
</ul>

{% endcapture %}

{% include tutorial.html %}
