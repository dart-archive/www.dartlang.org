---
layout: default
title: "Debugger"
description: "Observatory's debugger allows you to set breakpoints and to analyze what is going wrong in your code."
header:
  css: ["observatory.css"]
---

{% include breadcrumbs.html %}

# {{ page.title }}

Observatory's debugger displays stack frames and the isolate's event queue.
The debugger is controlled by text commands that support tab completion.
If you have used `gdb`, the debugger should feel familiar.

You can set and clear breakpoints in Observatory in one of three ways:

* Using text commands in the [debugger](screens.html#debugger-screen) screen.
* By clicking the `B` on a line of code in a
  [script](screens.html#script-screen) screen.
* Programmatically using the
  [dart:developer](https://api.dartlang.org/apidocs/channels/be/dartdoc-viewer/dart:developer)
  library.

<aside class="alert alert-info" markdown="1">
**Tip:**
To use the debugger within Dartium, you must specify the
`DART_FLAGS="--steal_breakpoints"` environment variable
when launching the VM.
</aside>

The debugger is not fully documented,
but the following tips can help get you started:

<dl markdown="1">
<dt>How do I open the debugger?</dt>
<dd markdown="1">When you
    [open Observatory](get-started.html#start-observatory)
    a `debugger` link appears on the main VM page for each
    running isolate.
    Clicking one of these links opens the debugger for the
    corresponding isolate.
    Enter `h` or `help` into the text box for a list of available commands.
</dd>

<dt markdown="1">How can I start debugging my program before `main()`
    executes?</dt>
<dd markdown="1">You have two choices:

<ul>
<li markdown="1">Launch the app by specifying the
    `--pause-isolates-on-start` flag. Bring up the debugger.
    You can step through execution, or set breakpoints, as you choose.
</li>

<li markdown="1">Import the **dart:developer** package and add a
    `debugger();` call to the beginning of main.
</li>
</ul>

</dd>

<dt>How do I set a breakpoint?</dt>
<dd markdown="1">You have two choices:
<ul>
<li markdown="1">Set a breakpoint in the text box using `break`.
    You can use tab completion, for example, typing
    `break m<tab>` completes to `break main` if there is only
    one method beginning with `m`, otherwise it brings up a list
    of possible methods.
</li>

<li markdown="1">Set breakpoints programmatically using the
[dart:developer](https://api.dartlang.org/apidocs/channels/be/dartdoc-viewer/dart:developer)
library. Import the **dart:developer** package and add a
    `debugger();` call wherever you want to break.
</li>
</ul>
</dd>

<dt>How do I resume a paused isolate?</dt>
<dd markdown="1">Enter `c` or `continue` into the text box.
</dd>

<dt>How do I get a list of all breakpoints?</dt>
<dd markdown="1">Enter `info breakpoints`.
</dd>

<dt>How do I clear a breakpoint?</dt>
<dd markdown="1">You can clear a breakpoint using the `clear` command,
    specifying the source location or function name.
    Enter `help clear` for more information.
</dd>

</dl>


{% include observatory_new_fyi.html %}

{% include observatory_footer.html %}

