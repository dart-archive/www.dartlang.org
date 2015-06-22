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

## Choose your platform

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


## Download the SDK

{% for platform in site.custom.downloads.binaries %}
<div class="{{platform.os}}" markdown="1">
{% capture partial %}downloads/_{{platform.os}}_section.html{% endcapture %}{% include {{partial}} %}
</div>
{% endfor %}


--------------------
Need a specific version or another download?
See the [Index of Downloads](archive/).


{% comment %}
TODO:
* Change styling to be closer to platform buttons.
  Larger font.
  Selected state should use bold font and
  maybe a green bg like Mac OS X.
  Unselected state should perhaps have a lighter gray bg.
{% endcomment %}
