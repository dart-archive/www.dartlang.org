---
layout: default
title: "Isolate"
description: "Observatory's Isolate screen provides information about an isolate running in your Dart application."
header:
  css: ["observatory.css"]
---

{% include breadcrumbs.html %}

# {{ page.title }}

When you bring up an [_isolate_](glossary.html#isolates)
screen&mdash;for example, by clicking the name
of the isolate on the VM screen&mdash;you see
information about that isolate. 

The following screenshot shows the top of an isolate screen for a
root isolate, `profile.dart$main`:

<img src="images/VM-IsolateList.png" alt="List of isolates on the VM screen">


This summary tells you whether the isolate is running (and what expression,
if any, was being executed at the moment of sampling)  and provides 
links to screens for browsing aspects of the isolate,
such as the debugger and the CPU profiler.

A pie chart shows the breakdown of the activities of the
VM. For more information on the meaning of these activities,
see [User and VM Tags](tags.html).

If you have paused the isolate&mdash;by specifying the `--observe`,
`--pause-isolates-on-start`, or `--pause-isolates-on-exit` flag&mdash;
you can continue the process by going to the
[debugger](debugger.html) and typing `resume`.

<img src="images/ResumeIsolateButton.png" alt="The link for resuming the isolate">

After the list of libraries used by the isolate is a graph that
is updated approximately every two seconds. The graph, which shows
where the CPU is spending its time at the moment of each sample,
looks something like this:

<img src="images/IsolateStats.png" alt="A sample root isolate screen showing the stats">

As you can see in the screenshot, this isolate is primarily processing
Dart code.

Below the graph is an expression evaluator field.

<img src="images/IsolateEval.png" alt="The Evaluate text field for an isolate">

For more information on how to use this field,
see [Evaluating Expressions](evaluate.html).

{% include observatory_new_fyi.html %}

{% include observatory_footer.html %}
