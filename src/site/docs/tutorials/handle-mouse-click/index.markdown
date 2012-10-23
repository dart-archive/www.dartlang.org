---
layout: default
title: Handle a Mouse Click
description: How to handle a mouse click
tutorial:
  id: handle-mouse-click
---

{% capture whats_the_point %}

* Register an event handler using ... XX

{% endcapture %}

{% capture code_links %}
<ul>
<li>
   <a href="examples/clickme/clickme.dart">clickme.dart</a>
</li>
<li>
   <a href="examples/clickme/clickme.html">clickme.html</a>
</li>
<li>
   <a href="examples/clickme/clickme.css">clickme.css</a>
</li>
</ul>
{% endcapture %}

{% capture content %}

The Mini app in the previous target isn't a very interesting app.
It just puts text on the page,
which is more simply accomplished through pure HTML.
A true web app is more dynamic,
able to interact with the user via input devices
such as a mouse and a keyboard
and respond to that input with action.

Let's modify the Mini app to
respond to a mouse click.
Begin with the final version of the Mini app
that uses CSS.

* [Rename mini to miniclick](#refactoring)
* [Registering a Mouse Click Handler](#mouse-click)
* [TextElement Style property/attribute](#style-property)

##Rename mini to miniclick {#refactoring}

DartEditor supports refactoring.

##Register a Mouse Click Handler {#mouse-click}

Modify the 

.on.click.add();

##TextElement Style property/attribute {#style-property}


{% endcapture %}

{% include tutorial.html %}
