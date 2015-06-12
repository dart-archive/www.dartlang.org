---
layout: default
title: "Heap Map"
description: "Observatory's heap map feature helps to identify and debug memory fragmentation in your Dart application."
header:
  css: ["observatory.css"]
---

{% include breadcrumbs.html %}

# {{ page.title }}

<h4>Contents</h4>
<ol class="toc">
  <li> <a href="#how-to-use">How to use this screen</a> </li>
  <li> <a href="#looking-at-individual-objects">Looking at individual
                objects</a> </li>
</ol>

Observatory's _heap map_ allows you to peek into the 
[old generation](glossary.html#old-generation) portion of the memory heap
at a single moment in time for a particular isolate.

The heap map displays blocks of memory in colors. A page of memory
is 256 KB and each page is separated by a horizontal black line. 
Each pixel in the map represents two words of memory.
The color of a pixel represents the class ID of the
object&mdash;for example, blue for strings and green for doubles.
Free space is white, and instructions (code) are purple.

If you initiate garbage collection (using the **GC** button
in the [Allocation Profile](allocation-profile.html) screen)
more white space (free space) appears in the heap map.

The following screenshot shows a sample heap map.

<img src="images/HeapMap.png" alt="Heap map">

As you hover the cursor over the map, the status bar at the top displays
information about the object represented by the pixel under the cursor.
The displayed information includes the type, size, and address of that object.
In the previous example, the cursor
hovers over a `_List` object using 112 bytes of old generation, and located at
address `0x1c26cc58`.

## How to use this screen {#how-to-use}

The primary purpose of this screen is to get a general idea of
whether your app is suffering from
[memory fragmentation](glossary.html#memory-fragmentation).
If you see a block of free (white) space, with lots of little
allocated areas scattered through out, this suggests memory
fragmentation&mdash; perhaps those blocks are actually 
[leaked](glossary.html#memory-leak) objects.

## Looking at individual objects {#looking-at-individual-objects}

It is difficult (maybe impossible) to find a specific object
in the heap. The most direct way to examine fields defined at
the class level (or any non-local field), is to use the
[library](screens.html#library-screen) or
[class](screens.html#class-screen) screen, as appropriate.

However, local variables can't be accessed from those screens.
If you want to try and locate a particular object,
you can use the browser's zoom feature to increase your chances.

Clicking a pixel takes you to an [instance](screens.html#instance-screen)
screen describing that object.  For example:

<img src="images/EvaluateObject.png" alt="evaluate object">

You can then enter Dart code in the text field to query or control
the instance. For information on how to use this text field,
see [Evaluating Expressions](evaluate.html).

{% include observatory_new_fyi.html %}

{% include observatory_footer.html %}
