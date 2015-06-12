---
layout: default
title: "User and VM Tags"
description: "Both user and VM tags identify categories of execution in a Dart application."
header:
  css: ["observatory.css"]
---

{% include toc.html %}
{% include breadcrumbs.html %}

# {{ page.title }}

Observatory uses tags to identify categories of execution.
Most of the predefined (default) tags identify VM activities that you don't
have direct control over, such as garbage collection.
An exception is the Dart tag, which identifies the execution of Dart code,
including your Dart code and the Dart code in libraries that you use.
The predefined tags are explained in [VM tags](#vm-tags).

If you'd like to add custom tags, you can define user tags, which appear only
when using the [CPU Profile](cpu-profile.html) screen.

## User tags {#user-tags}

Observatory samples a running application and, when Dart code is executing,
labels those samples with the Dart tag.
When you view the resulting data in the
[profile tree](cpu-profile.html#profile-tree), the Dart percentage tells
you how your code has performed compared to other VM tasks.

This information is somewhat useful,
but it does not tell you about the performance of the code inside your app.

For example, are there any bottlenecks? Does initialization take too
long? What are the slowest activities? Maybe those can be deferred,
or moved to another isolate.
Is there a more efficient sorting algorithm for your data?
Would caching calculated values improve performance enough
to make the effort worthwhile?

This sort of performance tuning requires more finely grained reporting.
You can achieve this when you label your code with
custom tags, called _user tags_, using the
[dart:developer](https://api.dartlang.org/apidocs/channels/be/dartdoc-viewer/dart-developer) library.

### Defining user tags {#defining-user-tags}

You can bracket any piece of code with a user tag. Only one tag can
be currently active&mdash;when you install a new current tag,
you must stash the previous tag, and restore it when your code has completed.

The following snippet shows how to mark a piece of code with a tag
named `MyTag`:

{% prettify dart %}
import 'dart:developer';

var customTag = new UserTag('MyTag');

// Save the previous tag when installing the custom tag.
var previousTag = customTag.makeCurrent();

// your code here

// Restore the previous tag.
previousTag.makeCurrent();
{% endprettify %}

When you now run your app, the `MyTag` label appears in the CPU profile for
the corresponding isolate. The following example shows an `InitCircle`
tag added to code that initializes a circle stress demo and a `MainApp`
tag added in the `main()` method:

<img src="images/UserDefinedTags.png" alt="example showing user defined tags">

## VM tags {#vm-tags}

Observatory defines the following, default VM tags, which are used 
throughout the UI:

### CompileOptimized, CompileScanner, CompileTopLevel, CompileUnoptimized {#compile}
Compiling Dart code. 

### GCNewSpace {#gcnewspace}
Garbage collecting [new generation](glossary.html#new-generation).

### GCOldSpace {#gcoldspace}
Garbage collecting [old generation](glossary.html#old-generation).

### Idle {#idle}
Not a VM tag, per se, the **Idle** label often appears alongside
the VM tags (on the [VM](screens.html#vm-screen) and 
[isolate](screens.html#isolate-screen) screens, for example)
to indicate the percentage of samples where the isolate was not 
scheduled. (Perhaps it was waiting for asynchronous I/O or
maybe it had finished executing but was idling until released.)

### Native {#native}
Executing native (platform specific) code&mdash;for
example, the C++ code used by the dart:io library.

### Runtime {#runtime}
Executing runtime code.

### Dart {#script}
Executing your Dart code.

### VM {#vm}
Starting an isolate. This category also includes VM activity not covered
by the other tags.

{% include observatory_new_fyi.html %}

{% include observatory_footer.html %}
