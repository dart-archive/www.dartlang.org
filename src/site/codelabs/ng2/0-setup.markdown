---
layout: codelab
title: "Step 0: Set up"
codelab-name: "Avast, Ye Pirates: Write a Web App"
description: "Take your first step to learning Dart fast."
snippet_img: images/piratemap.jpg
prev: index.html
prev-title: "Get Started"
next: 1-skeleton.html
next-title: "Step 1: Create a Basic Web App"
header:
  css: ["/codelabs/ng2/darrrt.css"]
---

{% include codelab-nav.html %}

# {{ page.title }}

In this step, you download any software that you need,
and learn where to find the sample code.

## <i class="fa fa-anchor"> </i> Get Dart and Dartium.

<div class="trydart-step-details" markdown="1">

If you haven't already done so, get the [Dart SDK](/downloads/)
and [Dartium](/tools/dartium/#getting-dartium).

The Dart SDK download includes several Dart tools that you'll need.
If you wish to run the Dart tools from the command line, add
`<path-to-the-SDK>/dart-sdk/bin` to your path.

You will need Dartium to test your app during development.
</div>

## <i class="fa fa-anchor"> </i> Get WebStorm or a plugin.

<div class="trydart-step-details" markdown="1">

If you don't have a favorite editor already, try
[WebStorm](https://confluence.jetbrains.com/display/WI/Getting+started+with+Dart),
which comes with a Dart plugin. You can also download
[Dart plugins for other IDEs and editors](/tools/).

If this is the first time you've used your IDE with Dart, you'll
need to configure the plugin with the location of the Dart SDK and
Dartium. See
[Configuring Dart support](/tools/webstorm/#configuring-dart-support)
for instructions on configuring WebStorm. The
[Dart Tools](/tools/) page has links where you can find more information
about other plugins.

<aside class="alert alert-info" markdown="1">
**Note:**
While you can use any IDE or editor for Dart development,
these instructions assume that you're using WebStorm.
Alternate instructions are provided for some of the steps.
</aside>

</div>

## <i class="fa fa-anchor"> </i> Look at the one-hour-codelab sample.

<div class="trydart-step-details" markdown="1">
The [one-hour-codelab](https://github.com/dart-lang/one-hour-codelab/tree/ng2/ng2)
repo on GitHub contains several examples.
Each example corresponds to a completed step in this code lab:

[1-skeleton](https://github.com/dart-lang/one-hour-codelab/tree/ng2/ng2/1-skeleton)
: Displays some text&mdash;a basic Angular 2 app.

[2-blankbadge](https://github.com/dart-lang/one-hour-codelab/tree/ng2/ng2/2-blankbadge)
: Displays a pirate name badge.

[3-inputnamebadge](https://github.com/dart-lang/one-hour-codelab/tree/ng2/ng2/3-inputnamebadge)
: As you type into the input field,
  the text displays on the name badge.

[4-buttonbadge](https://github.com/dart-lang/one-hour-codelab/tree/ng2/ng2/4-buttonbadge)
: An empty input field enables the button;
  clicking the button displays "Anne Bonney" on the name badge.

[5-piratenameservice](https://github.com/dart-lang/one-hour-codelab/tree/ng2/ng2/5-piratenameservice)
: Clicking the button displays a pirate name chosen at random from a list.

[6-readjsonfile](https://github.com/dart-lang/one-hour-codelab/tree/ng2/ng2/6-readjsonfile)
: Loads the pirate names from a JSON file on the web.

<aside class="alert alert-success" markdown="1">
<i class="fa fa-lightbulb-o"> </i> **Tip** <br>
As you work through this code lab,
you can use the files in the numbered directories to compare to your code
or to recover if you get off track.
</aside>

</div>

<hr>

{% include codelab-nav.html %}
