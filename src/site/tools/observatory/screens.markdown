---
layout: default
title: "Screens in Observatory"
description: "A list of screens and features available in Observatory's UI."
header:
  css: ["observatory.css"]
---

{% include toc.html %}
{% include breadcrumbs.html %}

# {{ page.title }}

Observatory's UI is fluid&mdash;many paths can lead to the same screen.

Here is a list of screens and features in Observatory with the most direct
route to each one.

### Allocation Profile {#allocation-profile-screen}

Shows an isolate's allocated memory and gives an overview
of the state of [old generation](glossary.html#old-generation)
and [new generation](glossary.html#new-generation) at the time of the
last sample.

Most direct route
: Choose the **allocation profile** link in an isolate screen, or from the
  isolate's pulldown menu in the blue bar.

More information
: [Allocation Profile](allocation-profile.html)

---

### Class {#class-screen}

Shows details about a specific class, including the library it belongs
to, the corresponding script file, and lists of its class variables,
fields, and functions.

Most direct route
: Click a class name from the list in a [library](#library-screen) screen.

---

### Class hierarchy {#class-hierarchy-feature}

Shows the class hierarchy for the app.

Most direct route:
: Choose the **class hierarchy** link on the [VM](#vm-screen) screen,
  or from an [isolate](#isolate-screen) screen.

---

### Code {#code-screen}

Shows the disassembly code for a Dart function.
Most developers never need to use this screen.

Most direct route
: Click a function name in the profile tree on
  the [CPU Profile](cpu-profile.html) screen.

---

### Code coverage {#code-coverage-feature}

Shows which lines of your Dart code have executed.

Most direct route
: Use this feature in any [script](#script-screen) screen.

More information
: [Code Coverage](code-coverage.html)

---

### CPU profile {#cpu-profile-screen}

Displays a sampled profile of an isolate.

Most direct route
: Choose the **cpu profile** link on the [VM](#vm-screen) screen,
  or from an [isolate](#isolate-screen) screen.

More information
: [CPU Profile](cpu-profile.html)

---

### Debugger {#debugger-screen}

Set breakpoints and debug your app.

Most direct route
: Choose the **debugger** link in the VM or isolate screen, or from the
  isolate's pulldown menu in the blue bar.

More information
: [Debugger](debugger.html)

---

### Evaluating Expressions {#evaluate-expressions-feature}

Query or modify your application by entering a valid Dart expression.

Most direct route
: Enter a Dart expression on one of the following screens:
  [isolate](#isolate-screen), [library](#library-screen),
  [class](#class-screen), or [instance](#instance-screen).

More information
: [Evaluating Expressions](evaluate.html)

---

### Function {#function-screen}

Shows details about a specific function, including its code.
Most developers never need to use this screen.

Most direct route
: Click a function name from the list on a
  [library](#library-screen) or [class](#class-screen) screen.

---

### Heap map {#heap-map-screen}

Displays allocated memory as a color blocked image.

Most direct route
: Choose the **heap map** link on the [VM](#vm-screen) screen,
  or from an [isolate](#isolate-screen) screen.
---

### Instance {#instance-screen}

Shows the state of an allocated object.

Most direct route
: Click a variable name from the list on a [library](#library-screen),
  [class](#class-screen), or [isolate](#isolate-screen) screen.
  
---

### Isolate {#isolate-screen}

Shows the current state of the isolate at the time of the last sample.

Most direct route
: If you're already looking at an aspect of the isolate, click the
  isolate's name (for example, **root**) in the blue bar.
  Otherwise, go to the [VM](#vm-screen) screen, which contains a 
  clickable list of all available isolates.

More information
: [Isolate](isolate.html)

---

### Library {#library-screen}

Contains clickable lists of imports, scripts, classes,
class variables, and functions. You can drill down through these links
into most aspects of your application.

Most direct route
: Expand the **library** link on the [isolate](#isolate-screen) screen.

---

### Metrics {#metrics}

Contains the metrics being collected on your app.

Most direct route
: Choose the **metrics** link on the [VM](#vm-screen) screen.

More information
: [Metrics](metrics.html)

---

### Script {#script-screen}

Displays the code from a Dart file.

Most direct route
: Click a function name from the list on a [library](#library-screen) screen.

---

### VM {#vm-screen}

Displays information about the VM at the time of the last sample.

Most direct route
: This is the first screen you see on entering Observatory.
  Return to this screen at any time by clicking the **Observatory**
  link in the blue bar at the top of any screen.

More information
: [VM screen](get-started.html#vm-screen) in
  [Getting Started with Observatory](get-started.html)

{% include observatory_new_fyi.html %}

{% include observatory_footer.html %}
