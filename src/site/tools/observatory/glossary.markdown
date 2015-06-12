---
layout: default
title: "Glossary of VM Terms"
description: "Glossary of VM Terms used by Observatory and in the Dart VM."
header:
  css: ["observatory.css"]
---

{% include toc.html %}
{% include breadcrumbs.html %}

# {{ page.title }}

To truly understand how Observatory works, you need to understand
computer science concepts such as memory allocation, the heap,
garbage collection, and memory leaks. This glossary contains brief
definitions of some of the terms used by Observatory.

### Garbage collection (GC) {#garbage-collection}
_Garbage collection_ is the process of searching the heap to locate,
and reclaim, regions of "dead" memory&mdash;memory that is no longer
being used by an application. This process allows the memory to be
re-used and minimizes the risk of an application running out of memory,
causing it to crash.

Garbage collection is performed automatically by the Dart VM.
In Observatory, you can perform garbage collection on demand
by clicking the **GC** button in the
[Allocation Profile](screens.html#allocation-profile-screen) screen.

### Heap {#heap}
Dart objects that are dynamically allocated live in a portion of
memory called the _heap_. An object allocated from the heap is _freed_
(eligible for garbage collection) when nothing points to it,
or when the application terminates.
When nothing points to an object, it is considered to be _dead_.
When an object is pointed to by another object, it is _live_.

See the [dart](/tools/dart-vm/#options) reference page for information
on how to increase the size of old generation.

### Isolates {#isolates}
Dart supports concurrent execution by way of _isolates_,
which you can think of as processes without the overhead.
Each isolate has its own memory and code, which can't be affected
by any other isolate. For more information, see
[The Event Loop and Dart](/articles/event-loop/).

Each Dart app contains at least one isolate, named **root**.
When you launch Observatory, the [VM screen](get-started.html#vm-screen)
lists all isolates for the application. You can browse
and interact with each isolate, separately, by clicking that
isolate's name.

### Memory fragmentation {#memory-fragmentation}
_Memory fragmentation_ occurs when free memory is splintered into
small blocks that are scattered throughout allocated memory.
This phenomenon can negatively affect an application's performance
and can lead to an out of memory exception.

You can find memory fragmentation using Observatory's **Heap map**.
This feature displays an image where free space is indicated
by white blocks.
Many small white areas sprinkled throughout the colored areas
suggest that the application is experiencing memory
fragmentation. For more information, see [Heap Map](heap-map.html).

### Memory leak {#memory-leak}
A _memory leak_ occurs when an object is live (meaning that another
object points to it) but it is not being used (so it shouldn't have
any references from other objects).
Such an object can't be garbage collected,
so it takes up space in the heap and contributes to 
<a href="#memory-fragmentation">memory fragmentation</a>.
Memory leaks put unnecessary pressure on the VM
and can be difficult to debug.

### New generation {#new-generation}
Most newly created objects (unless they are very large) are allocated in
a part of the heap named _new generation_.
New generation is particularly suited for
objects that are temporary and short lived&mdash;it is small and
is designed to be garbage collected quickly.

### Old generation {#old-generation}
When an object has been around awhile and has survived a
garbage collection cycle, it is typically promoted to a part of the heap
named _old generation_, freeing up _new generation_ for newly created objects.

The heap map feature of Observatory gives you a way to visually browse
old generation. For more information, see [Heap Map](heap-map.html).

### Virtual machine (VM) {#virtual-machine}
The Dart _virtual machine_ is a piece of software that can directly execute
Dart code. The [Dartium](/tools/dartium/) browser,
a special version of Chromium that includes the Dart VM,
can run Dart code without having to first compile it to JavaScript.

When you compile a Dart web app to JavaScript, you can run it in any
modern browser.

{% include observatory_new_fyi.html %}

{% include observatory_footer.html %}

