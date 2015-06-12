---
layout: default
title: "CPU Profile"
description: "Observatory's CPU profile feature shows where the VM is spending its time so you can find bottlenecks in your Dart code."
header:
  css: ["observatory.css"]
---

{% include breadcrumbs.html %}

# {{ page.title }}

#### Contents
{:.no_toc}

1. ToC
{:toc}

The CPU profile tells you how the virtual
machine (VM) has been spending its time when executing an isolate.
The following video gives a brief overview of Observatory with some
specific tips on how to use the profiling feature.

<iframe style="display:block;margin: 0 auto;" width="560" height="315" src="//www.youtube.com/embed/Ww8ISWzZGRE" frameborder="0" allowfullscreen></iframe><br>

Observatory profiles an app by _sampling_ the isolate at regular intervals.
The sampled data is aggregated and displayed in a _profile tree_.

When Observatory samples the isolate, it saves the sampled data
in a ring buffer, called the _profile_, which can hold up to 
two minutes worth of data.  Once the buffer becomes full,
the oldest samples are replaced with new samples.

At the top of the screen, a summary tells you a bit about
how the data was gathered:

<img src="images/CPU-profile.png" alt="CPU profile screen">

Refreshed at
: The time of the last profile refresh.

Profile contains
: The number of samples in the profile in the specified time span.
  The profile buffer holds a maximum of two minutes worth of samples.

Sampling
: How often the isolate is sampled. The default, 1000 Hz, samples the
  isolate once per millisecond.

Mode
: Presents the data by `Function` (default) or by `Code`.

Tag Order
: Tags represent the different activities of the VM.
  This pulldown lets you control whether you want to see tags and
  how they should be displayed. For more information, see
  [Displaying tags](#displaying-tags).

## Profile tree {#profile-tree}

Below the summary is a two-column profile tree that reflects the
activity of the sampled isolate.
Each row in the tree is a [VM tag](#vm-tags),
a [user tag](#user-tags), or a function.
A function can be native (C/C++) code or Dart code.
You can expand or collapse nodes in the tree by clicking the
arrows to the left.

The percentages on the left are the percent of calls to the parent.
These percentages add up to 100%.
The percentages on the right show the percentage of samples where
the tag was active, or where the function was executing.

The following screenshot shows a sample profile tree with tags suppressed
so that only function calls are displayed.

<img src="images/ProfileTree-NoTags.png" alt="A profile tree with tags suppressed">

Clicking the information button,
<img style="border:0px" src="images/InformationButton.png" alt="the letter I inside a circle">,
to the right of an entry brings up detailed information about that entry.

The letter code, or codes, following each entry in the profile tree
indicates how the processing work for that entry is categorized:

`D`
: Dart code

`I`
: inlined code

`N`
: native code

`O`
: optimized code

`S`
: stub code

{% comment %}
`T`
: xxx - can't figure it out, so leave it off for now
{% endcomment %}

`U`
: unoptimized code

Because tags are hidden in the previous screenshot,
each row lists a function. The functions
are listed in order from most CPU intensive to least.

The selected row in the previous screenshot shows the
`DynamicTree.query` function.
The percentage on the left shows that
this function used .49% of the root isolate's CPU time.
The percentage on the right shows that .49% of the samples
were taken while this function was active.

Note that, for the topmost level of the tree, the percentages
in the right column are the same as those in the left column.

Clicking an arrow to the left of a function expands the tree to show
the calling function.
You can drill down the stack 8 levels deep, or until you reach the
`main` function, whichever comes first.

While this information is useful, it is difficult to understand,
at a high level, what is really going on.  To help make sense of this
information, tags are used to impose structure on the data
so that you can more easily interpret where the VM is spending its time.

## Tags {#tags}

Tags help you understand the big picture of what is going on in
an isolate.  Observatory supports two kinds of tags.
_VM tags_ are predefined by Observatory, and _user tags_
are custom tags that you create in your Dart code.

### Inspecting VM tags {#inspecting-vm-tags}

Observatory sorts the VM's activities into categories of
execution by labeling each activity with a predefined tag,
called a VM tag.

The only VM tag that you have direct control over is the Dart tag,
which indicates time spent executing your Dart code.  The other categories
(Native, Compile, VM, Runtime, GCNewSpace, and GCOldSpace)
are activities performed by the VM on behalf of your application,
such as compilation. For more information on these tags,
see [User and VM Tags](tags.html).

The following screenshot shows a sample profile tree with the
Default node expanded to show the activity of the VM tags:

<img src="images/VM-tags.png" alt="A list of the default VM tags">

In the previous screenshot, the VM has spent 99.73% of its time executing
the application's Dart code. If you expand the Dart node,
the functions labeled with the Dart tag are displayed, 
listed from most CPU intensive to least. The following screenshot
shows the the Script subtree:

<img src="images/VM-tags-detail.png" alt="A list of the default VM tags, with the Script tag expanded">

The first function listed under the Dart tag,
`unitOfWork`, used 97.05% of the entire Dart category.
Also, 96.79% of all samples were made while this function was executing.

### Defining user tags {#defining-user-tags}

You can also label your code with custom tags, called _user tags_, using the
[dart:developer](https://api.dartlang.org/apidocs/channels/be/dartdoc-viewer/dart-developer) library.

For more information, see [User and VM tags](tags.html).

### Configuring tag display {#configuring-tag-display}

Use the **Tags** pulldown to configure how the profile tree displays tags.

User > VM
: The default. User-defined tags are displayed at
the top level of the profile tree, as siblings to the Default category.
The tags are listed from most CPU intensive to least.
When you expand a top-level tag, you see the VM tags underneath.

User
: The top level is the same as for **User > VM**, with the user-defined
tabs listed as siblings to the Default category. However, when you
expand a top-level tag, you see function calls listed, from most CPU
intensive to least.

VM > User
: Lists the VM tags only at the top level. When you expand a VM tag,
you see user tags listed.

VM
: Lists the VM tags only. User tags are hidden.

None
: Hides all tags. The functions are displayed from most CPU intensive to least.

## Stub code

Stubs are shared pieces of code used to implement common operations that are
higher level than machine code operations, such as method lookup or allocation,
or for transitioning between compiled Dart code and the C++ runtime. We
expect a well-behaved Dart program we expect to spend most of its time
in compiled Dart code or GC. If stubs are high in a profile,
the program is likely spending a lot
of time in unoptimized code or the runtime.

### InlineCacheStub / SubtypeTestCacheStub

The first time a function is run, it is compiled without optimizations.
Each call site or type test has a cache that remembers the results of
method lookup or type tests for the concrete classes actually encountered.
This avoids repeated lookups and collects type feedback for the optimizing
compiler. If these stubs are high on your profile,
your program is spending a lot of time in unoptimized code.
This could be because your program executes a lot of different code
with a low frequency that doesn’t trigger optimization.

{% include observatory_new_fyi.html %}

{% include observatory_footer.html %}

