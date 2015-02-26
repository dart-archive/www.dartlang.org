---
layout: default
title: "Download Dart"
description: "The download bundles that support the Dart language."
has-permalinks: false
js:
- url: /js/download-info.js
  defer: true
---

# Getting Dart Is Easy!

<div class="btn-group-responsive btn-group hero-hldr btn-group-justified os-choices" style="display: table;">
  <div class="btn-group">
    <button type="button" class="btn btn-default btn-lg" id="windows">Windows (Vista, 7, 8)</button>
  </div>
  <div class="btn-group">
    <button type="button" class="btn btn-default btn-lg" id="linux">Linux</button>
  </div>
  <div class="btn-group">
    <button type="button" class="btn btn-default btn-lg" id="macos">Mac OS X</button>
  </div>
</div>

## Download Dart

{% for platform in site.custom.downloads.binaries %}
<div class="{{platform.os}}" markdown="1">
{% include downloads/_get_dart_editor.html %}

## Or download just what you need {#dont-download-editor}

{% capture partial %}downloads/_{{platform.os}}_section.html{% endcapture %}{% include {{partial}} %}
</div>


{% endfor %}

<aside class="alert-info alert" markdown="1">
**Want another Dart version?**
Use the [download archive.](/tools/download-archive)
It lets you choose specific versions
of the Dart downloads.
It also has the latest **dev channel** builds,
which let you try new features a few weeks earlier than the stable channel.
</aside>

<div class="windows" markdown="1">
### Pick an editor
</div>

<div class="linux" markdown="1">
### Step 2: Pick an editor {#step-2-pick-an-editor-linux}
</div>

<div class="macos" markdown="1">
### Step 2: Pick an editor {#step-2-pick-an-editor-mac}
</div>

[Dart Editor](/tools/editor/) isn't your only choice.
The following plugins add Dart smarts to popular code editors.

{% include downloads/_other_editors.markdown %}
