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

## Pick an editor solution

You want a first-class experience when developing in Dart, right? There are
many editor solutions that can make writing Dart apps an enjoyable experience
from the get-go.

### The Dart Editor

The Dart Editor is a powerful tool for editing, debugging, and running Dart
applications.

<div class="downloads">
<a class="btn download-link" href="somewhere">
  <button class="btn btn-primary btn-lg download-btn" style="text-transform: none;">
    <i class="sprite-icon-download-btn"> </i>
    Download Dart Editor
  </button>
</a>
</div>

The Dart Editor can automatically update itself whenever a new integration
build is available. To enable automatic updates, go to Preferences, choose
Update, and select Download updates automatically.

<div class="row">
  <div class="col-md-6" markdown="1">
### IDE Plugins

[![IntelliJ logo](images/IntellIJ-IDEA.png)](webstorm/)
[IntelliJ IDEA and WebStorm](webstorm/)

[![Eclipse logo](images/eclipse.png)](eclipse-plugin/)
[Eclipse](eclipse-plugin/)
  </div>

  <div class="col-md-6" markdown="1">
### Text Editor Plugins

[![Sublime logo](images/sublime.png)](https://github.com/dart-lang/dart-sublime-bundle#readme)
[Sublime Text 2](https://github.com/dart-lang/dart-sublime-bundle#readme)

[![Emacs logo](images/emacs.png)](https://github.com/nex3/dart-mode)
[Emacs](https://github.com/nex3/dart-mode)

[![Vim logo](images/vim.png)](https://github.com/dart-lang/dart-vim-plugin)
[Vim](https://github.com/dart-lang/dart-vim-plugin)
  </div>
</div>
