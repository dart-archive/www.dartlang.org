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
of the isolate on the VM screen or from the breadcrumb trail at the top
of any screen&mdash;you see information about that isolate. 

The following screenshot shows the top of an isolate screen for a
root isolate:

<img src="images/IsolateLinks.png" alt="A sample root isolate screen showing the links">

This summary tells you whether the isolate is running (and what expression,
if any, was being executed at the moment of sampling)  and provides 
links to screens for browsing aspects of the isolate,
such as the state of the heap, the stack, and the CPU profile.

A pie chart shows the breakdown of the activities of the
VM. For more information on the meaning of these activities,
see [User and VM Tags](tags.html).

<aside class="alert alert-info" markdown="1">
**Note:** The **breakpoints** feature is not yet implemented.
For more information, see [Breakpoints](breakpoints.html).
</aside>

If you have paused the isolate&mdash;by specifying either the
`--pause-isolates-on-start` or `--pause-isolates-on-exit` flag&mdash;
a **resume** link appears in the isolate and
VM screens. Clicking this link resumes the process.

<img src="images/ResumeIsolateButton.png" alt="The link for resuming the isolate">

After the list of libraries used by the isolate is a graph that
is updated approximately every two seconds. The graph, which shows
where the CPU is spending its time at the moment of each sample,
looks something like this:

<img src="images/IsolateStats.png" alt="A sample root isolate screen showing the stats">

Below the graph is an expression evaluator field.

<img src="images/IsolateEval.png" alt="The Eval text field for an isolate">

For more information on how to use this field,
see [Evaluating Expressions](evaluate.html).

{% include observatory_new_fyi.html %}

