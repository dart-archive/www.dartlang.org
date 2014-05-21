---
layout: default
title: "Code Coverage"
description: "Observatory's code coverage feature tells you whether code in your Dart application has executed and whether it is executable."
header:
  css: ["observatory.css"]
---

{% include breadcrumbs.html %}

# {{ page.title }}

<h4>Contents</h4>
<ol class="toc">
  <li> <a href="#enable-code-coverage">Enabling code coverage</a> </li>
  <li> <a href="#refresh-code-coverage">Refreshing code coverage</a> </li>
</ol>

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

## Enabling code coverage {#enable-code-coverage}

Code coverage is disabled by default. To enable it, hover your cursor
over the name of the Dart file in the breadcrumb trail. This brings
up the **Show Coverage Data** checkbox.

<img src="images/CodeCoverageCheckBox.png" alt="Check box for enabling code coverage">

Check the box to immediately display the code coverage.

## Refreshing code coverage {#refresh-code-coverage}

You can refresh the code coverage data at any time by clicking
the **Refresh Coverage** button in the blue bar:

<img src="images/RefreshCoverageButton.png" alt="Button for refreshing code coverage data">

---

{% include observatory_new_fyi.html %}
