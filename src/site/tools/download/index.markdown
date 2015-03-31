---
layout: default
title: "Download Dart"
description: "The download bundles that support the Dart language."
has-permalinks: false
js:
- url: /js/download-info.js
  defer: true
- url: /js/download-chooser.js
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

## Choose your download

<div class="row" markdown="1">
  <div class="col-md-6" markdown="1">

  <p align="center">
  <button id="editor" class="btn btn-lg btn-primary download-choices" style="width:100%">
  Editor + SDK
  </button>
  </p>

  <p>
  When you download Dart Editor, you also get the SDK,
  Dartium, and the ability to auto-update.
  </p>

  </div>

  <div class="col-md-6" markdown="1">
  <p align="center">
  <button id="sdk" class="btn btn-lg btn-primary download-choices" style="width:100%">
  SDK only
  </button>
  </p>

  If you already have a favorite editor—WebStorm or Sublime,
  for example—all you need is the SDK.

  </div>
</div>

<div class="editor" style="display:none" markdown="1">

## Download Dart Editor

{% for platform in site.custom.downloads.binaries %}
<div class="{{platform.os}}" markdown="1">
{% include downloads/_get_dart_editor.html %}
</div>
{% endfor %}

</div>

<div class="sdk" style="display:none" markdown="1">

## Download the SDK

{% for platform in site.custom.downloads.binaries %}
<div class="{{platform.os}}" markdown="1">
{% capture partial %}downloads/_{{platform.os}}_section.html{% endcapture %}{% include {{partial}} %}
</div>
{% endfor %}

</div>


{% comment %}
TODO:
* Make choosing a download trigger an analytics event.
* Change styling to be closer to platform buttons when you choose a download
  (bold, larger font, maybe green like Mac OS X).
{% endcomment %}
