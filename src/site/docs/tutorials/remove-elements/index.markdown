---
layout: default
title: "Target 4: Remove DOM Elements"
description: "Remove a child element from the DOM"
has-permalinks: true
tutorial:
  id: remove-elements
---

{% capture whats_the_point %}

* Use _element_.remove() to remove an element from the DOM.
* Remove all children from an element with _element_.children.clear().
* Function expressions are a convenient way to define single-use functions.
* => is a shorthand syntax for defining functions that contain just one
expression.
* dart:html defines many event-related classes.

{% endcapture %}

{% capture content %}

This target focuses on a modified version of the todo app
that allows the user to delete items from the list.
When the user points the mouse cursor at an item,
the item changes its appearance.
When the user clicks the item,
the Dart program removes the item from the list
(by removing it from the DOM).
Also, the program has a **Delete All** button
for removing all items from the list.

* [Copy and run the todo_with_delete app](#copy-app)
* [Changing the appearance when cursor is over an element](#css-hover)
* [Removing an element from the DOM tree](#remove-elem)
* [Removing all child elements from an element](#remove-all-elem)
* [About function expressions and =>](#about-function-expressions)
* [About Dart's event-related classes](#about-event-classes)

##Copy and run the todo_with_delete app {#copy-app}

Use the following links to
copy the HTML, Dart, and CSS code
into a new web app in Dart Editor.
Name the app todo_with_delete and make sure the filenames
are the same as those listed here.

<ul>
  <li>
<a href="http://raw.github.com/dart-lang/dart-tutorials-samples/master/web/target04/todo_with_delete/todo_with_delete.dart"
   target="_blank">todo_with_delete.dart</a>
 </li>
  <li>
<a href="http://raw.github.com/dart-lang/dart-tutorials-samples/master/web/target04/todo_with_delete/todo_with_delete.html"
   target="_blank">todo_with_delete.html</a>
 </li>
  <li>
<a href="http://raw.github.com/dart-lang/dart-tutorials-samples/master/web/target04/todo_with_delete/todo_with_delete.css"
   target="_blank">todo_with_delete.css</a>
 </li>
 </ul>

Then run the app.
Enter a few items into the input field.
The following diagram shows the app after
_dance_, _sing_, _walk the dog_, and _laugh_ have all been entered.

![Entering items into the todo_with_delete app](images/enter-items.png)

Point the mouse cursor at one of the items in the list.
Its appearance changes;
the text is now red and the font is slightly larger.
Also, the cursor changes to a pointer or a hand shape.
These visual clues signal to the user that something irreversible
will happen when they click on it.

Click the red item
and it disappears from the list.
The event handling and DOM manipulation is controlled on the Dart side.

![Point the cursor at an item, then click to delete it](images/remove-an-item.png)

Use the **Delete All** button in the lower right corner of the app
to remove all of the items in the list at once.

![Click the Delete All button to remove all the todo items](images/remove-all.png)

The remaining sections describe
key aspects of the code 
added to the todo app for this target.
Specifically, they look at
the Dart code that removes elements from the DOM
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
<button id="delete-all" type="button" float:right> Delete All </button>
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
The argument passed into the add() function
is an example of a _function expression_,
which is a shorthand way of defining functions
and it uses the => syntax to define the function concisely.

![A one-line function definition](images/event-listener-exp.png)

It is equivalent to writing this:

{% prettify dart %}
deleteAll.on.click.add((e) {
  toDoList.children.clear();
});
{% endprettify %}

or even this:

{% prettify dart %}
...
void main() {
  ...
  deleteAll.on.click.add(deleteAllElements);
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

##About Dart's event-related classes {#about-event-classes}

A Dart element can generate various kinds of events.
For each event type, an element maintains a list of event listeners.
Note that many listeners can be registered for each event type.

![Event listeners](images/listeners.png)

Various Dart classes, all defined in the dart:html library,
are involved in registering an event handler.
The following diagram shows a line of code from the todo_with_delete
app that registers a mouse click event listener on an element.

![Dart classes involved in event listener registration](images/event-classes.png)

The first identifier, newToDo, is a reference to the element in question.
It is followed by `on`, which is a reference to an EventElements object.
The
<a href="http://api.dartlang.org/dart_html/ElementEvents.html" target="_blank"> ElementEvents</a>
class defines the events common to all Dart Elements
and is defined in the dart:html library.
(InputElement has a larger set of events as defined in
<a href="http://api.dartlang.org/dart_html/InputElementEvents.html" target="_blank"> InputElementEvents</a>.)
`click` is a list of event listeners
(more specifically, an EventListenerList)
that can handle mouse click events.

| Dart type | Purpose |
|---|---|
| <a href="http://api.dartlang.org/dart_html/Element.html" target="_blank">Element</a> | Represents an element in the DOM |
| <a href="http://api.dartlang.org/dart_html/ElementEvents.html" target="_blank">ElementEvents</a>| Defines the event types common to all Elements |
| <a href="http://api.dartlang.org/dart_html/EventListenerList.html" target="_blank">EventListenerList</a> | A list of listeners for a particular event type |
| <a href="http://api.dartlang.org/dart_html/Event.html" target="_blank">Event</a> | An object that carries information about the event that occurred |
| <a href="http://api.dartlang.org/dart_html/EventListener.html" target="_blank">EventListener</a> | A function that can handle events |
{: .table}

<div class="row">
  <div class="span3">
  <a href="/docs/tutorials/add-elements/"><i class="icon-chevron-left"> </i> Add an Element to the DOM</a>
  </div>
  <div class="span3">
<a href="http://code.google.com/p/dart/issues/entry?template=Tutorial%20feedback"
 target="_blank">
<i class="icon-comment"> </i>
Send feedback
</a>
  </div>
  <div class="span3">
  <a href="/docs/tutorials/packages/" class="pull-right">Install Shared Packages <i class="icon-chevron-right"> </i> </a>
  </div>
</div>

{% endcapture %}

{% include tutorial.html %}
