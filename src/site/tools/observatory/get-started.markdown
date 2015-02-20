---
layout: default
title: "Getting Started with Observatory"
description: "How to use Observatory to profile and debug your Dart application."
snippet_img: "images/AllocationProfileScreen.png"
header:
  css: ["observatory.css"]
---

{% include breadcrumbs.html %}

# {{ page.title }}

<h4>Contents</h4>
<ol class="toc">
  <li> <a href="#get-observatory">Get Observatory</a> </li>
  <li> <a href="#start-observatory">Start Observatory</a>
  <ol class="toc">
    <li> <a href="#standalone-Dart-Editor">Standalone apps from Dart Editor</a> </li>
    <li> <a href="#standalone-command-line">Standalone apps from the command line</a> </li>
    <li> <a href="#web-launch">Web apps</a> </li>
  </ol> </li>
  <li> <a href="#observatory-ui">Observatory UI</a> </li>
  <li> <a href="#vm-screen">VM screen</a> </li>
  <li> <a href="#what-next">What next?</a> </li>
</ol>

{% include observatory_new_fyi.html %}

## Get Observatory {#get-observatory}

To get Observatory, just download 
[Dart SDK](/tools/download.html#a_la_carte) or
[Dart Editor](/tools/download.html#whole_enchilada).
Both of those downloads include the Observatory tool.

You can use Dart to create two kinds of applications: standalone
applications (including servers), and web applications
(which run in a browser).
For standalone apps, Observatory can be enabled either at the command
line or from Dart Editor. For browser-based apps, Observatory
can be opened in any browser using information obtained when launching
your app in Dartium from the command line.
So you can use Observatory to profile and debug any Dart application.

## Start Observatory {#start-observatory}

How you enable Observatory depends on whether you are writing a
standalone app or a web app, and how you prefer to work.
No matter how you launch Observatory, its UI is exactly the same.

<aside class="alert alert-info" markdown="1">
**For Windows users:** Observatory's [CPU Profile](cpu-profile.html)
screen is disabled by default.  Specify the
[<code>--profile</code>](/tools/dart-vm/#observatory) option when
you launch your app to enable it.
</aside>

### Standalone apps from Dart Editor {#standalone-Dart-Editor}

You can open Observatory once you launch your app.

When you launch a standalone app in Dart Editor, it opens a console
window to display the output.  An "Open Observatory" icon is available
in the tool bar for the console window:

<img src="images/OpenObservatoryButton.png" alt="The Observatory navigation bar">

Clicking the icon opens a new tab in your default browser and displays
Observatory's VM screen.

To customize the launch configuration for your app, select
**Run > Manage Launches** to bring up the **Manage Launches** dialog.

<img src="images/DartEditorEnable.png" alt="The managed launches dialog in Dart Editor">

Check the **Pause isolate on start** box if you want the root isolate
to pause before executing&mdash;this is equivalent to specifying the
`--pause-isolates-on-start` flag and is useful if you want to connect
to Observatory before the isolate begins running.

Check the **Pause isolate on exit** box if you want the root isolate
to remain alive when execution has completed&mdash;this is
equivalent to specifying the `--pause-isolates-on-exit` flag and
is useful for an application that might otherwise finish executing
before you can connect it to Observatory.

By default, neither of these boxes are checked.

You can also enter any other flags into the **VM arguments** text
field&mdash;see the [dart](/tools/dart-vm/#observatory) reference page
for a complete list.

The next time you launch the app, it uses the specified configuration.

### Standalone apps from the command line {#standalone-command-line}

To enable Observatory from the command line, specify one or more 
Observatory options when launching the dart VM. See the
[dart](/tools/dart-vm/#observatory) reference page for a complete list.

For example:

{% prettify sh %}
$ dart --enable-vm-service --pause-isolates-on-start <script>.dart
{% endprettify %}

Open a browser to `localhost:8181` to see the Observatory UI.

### Web apps {#web-launch}

<aside class="alert alert-info" markdown="1">
Prior to 1.9, you launched Observatory from DevTools within Dartium.
As of 1.9, you launch Observatory in any browser using the URL
obtained when launching Dartium from the command line.

Launching Observatory for web apps will be more streamlined in
a future release.
</aside>

From the command-line, launch your app in Dartium. For example,
the following command launches a local copy of the Sunflower demo:

Mac OS:

{% prettify sh %}
$ cd <path-to-demo>/sunflower/web
$ <path-to-Dartium>/Chromium.app/Contents/MacOS/Chromium sunflower.html
{% endprettify %}

Windows:

{% prettify sh %}
> cd <path-to-demo>\sunflower\web
> <path-to-Dartium>\Chromium\Application\chromium.exe sunflower.html
{% endprettify %}

Linux:

{% prettify sh %}
$ cd <path-to-demo>/sunflower/web
$ <path-to-Dartium>/chromium-browser sunflower.html
{% endprettify %}

The command-line output includes a line similar to the following:

{% prettify sh %}
Observatory listening on http://127.0.0.1:49621
{% endprettify %}

Open this URL in any browser to bring up Observatory.

## Observatory UI {#observatory-ui}

Observatory uses a browser-based UI&mdash;the UI is the same no
matter how it is launched.

A solid blue bar appears at the top of most screens. The word
**Observatory** is on the left and a **Refresh** button is on the right.
You can resample the information in any screens, at any time,
using the Refresh button. (Some screens in Observatory
provide additional buttons next to the Refresh button.)

<img src="images/ObservatoryBar.png" alt="The Observatory navigation bar">

A breadcrumb trail, inside the blue bar, shows where you are in the 
Observatory UI.  You can click items in the breadcrumb trail to
navigate to other parts of the UI.

If you hover over the items in the breadcrumb bar, drop-down menus
provide additional functionality for each screens. As shown in the
following screenshot, hovering over **root** brings up a menu that includes
_stack trace_, _cpu profile_, and _heap map_.

<img src="images/ObservatoryBreadCrumb.png" alt="A sample Observatory breadcrumb trail">

You can return to the [VM screen](screens.html#vm-screen) at any time by
clicking **Observatory** in the breadcrumb bar.

The next section describes the VM screen, Observatory's landing page.
For a comprehensive list of all screens,
see [Screens in Observatory](screens.html).

## VM screen {#vm-screen}

When you first connect to Observatory, it opens the VM screen,
which reflects information available at the moment the app was sampled.
For example:

<img src="images/ObservatoryVM.png" alt="A sample VM screen for Observatory">

To update the information, click the **Refresh** button in the upper
right corner.

The displayed information includes:

version
: When the VM was built and for which architecture.

uptime
: How long the VM has been running.

type checks enabled
: True if the VM is checking for type errors.

asserts enabled
: True if assertion statements are evaluated by the VM.

Below the VM information is a list of isolates.
Every app has an initial isolate named _root_.

<img src="images/VM-IsolateList.png" alt="List of isolates on the VM screen">

For each isolate, a pie chart shows the breakdown of the activities of the
VM. For more information on the meaning of these activities,
see [User and VM Tags](tags.html).

A list of links take you to various Observatory screens. For more
information, see [Screens in Observatory](screens.html).

Clicking the isolate's name (for example, "root") brings up an isolate screen,
with detailed information about that isolate. 
For more information, see [Isolate](isolate.html).

## What next? {#what-next}

Where you should go next depends on what questions you'd like to answer.

Unfamiliar with the terminology?
: [Glossary of VM Terms](glossary.html)

Want to find screens and features in the UI?
: [Screens in Observatory](screens.html)

Want to see where your app is spending its time?
: [CPU Profile](cpu-profile.html)

And dive into "power" profiling?
: [User and VM Tags](tags.html)

Curious about memory allocation?
: [Allocation Profile](allocation-profile.html)<br>

And possible memory fragmentation?
: [Heap Map](heap-map.html)

Want to query (or modify) Dart code?
: [Evaluating Expressions](evaluate.html)

Want to see if your code has executed?
: [Code Coverage](code-coverage.html)

Want a stack trace?
: [Stack Trace](stack-trace.html)

Want to know the state of the root isolate or another isolate?
: [Isolate](isolate.html)

{% include observatory_footer.html %}

