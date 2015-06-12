---
layout: default
title: "Code Coverage"
description: "Observatory's code coverage feature tells you whether code in your Dart application has executed and whether it is executable."
header:
  css: ["observatory.css"]
---

{% include breadcrumbs.html %}

# {{ page.title }}

The code coverage feature gives you visual feedback on whether code
has executed. For example:

<img src="images/CodeCoverageExample.png" alt="An example of the Dart code coverage feature in Observatory">

Lines marked with green have executed. Lines marked with red are
executable but have not yet executed. Lines with no color are
not executable.

<aside class="alert alert-info" markdown="1">
**Note:** Observatory does not evaluate whether it is _possible_
to execute a piece of code. It tells you if code has, or has not, executed.
</aside>

The code coverage feature is available from every
[_Script_](screens.html#script-screen) screen.

To see, or refresh, the code coverage data at any time, click
the **Refresh Coverage** button in the blue bar:

<img src="images/RefreshCoverageButton.png" alt="Button for refreshing code coverage data">

---

{% include observatory_new_fyi.html %}

{% include observatory_footer.html %}

