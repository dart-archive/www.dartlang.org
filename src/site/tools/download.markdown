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

Confirm your platform:

<div class="btn-group hero-hldr btn-group-justified os-choices" style="display: table;">
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

{% for platform in site.custom.downloads.binaries %}
{% capture partial %}downloads/_{{platform.os}}_section.html{% endcapture %}
<div class="{{platform.os}}" markdown="1">
{% include {{partial}} %}
</div>
{% endfor %}

### Early adopter?

To get new features a few weeks earlier than the stable release, you can
download the latest **Dev Channel** builds of the Dart SDK and Dartium at the
[download archive](/tools/download_archive).

### Looking for previous versions?

Previous versions of the Dart SDK, Dartium, and the Dart Editor are available
at the [download archive](/tools/download_archive).

<div class="windows" markdown="1">
## Other editor solutions

{% include downloads/_other_editors.markdown %}
</div>

<div class="linux" markdown="1">
## Pick an editor solution

{% include downloads/_pick_an_editor.markdown %}
</div>

<div class="macos" markdown="1">
## Step 2: Pick an editor solution

{% include downloads/_pick_an_editor.markdown %}
</div>
