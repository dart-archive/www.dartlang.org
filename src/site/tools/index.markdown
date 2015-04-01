---
layout: default
title: "Dart Tools"
description: "The tools that support the Dart language."
has-permalinks: false
---


# {{ page.title }}

A variety of tools are available for Dart development.

---

<a name="tools"></a>
<h2>Tools</h2>

You can get Dart Editor and the Dart SDK,
both of which include Observatory,
from the [download page](/downloads/).

<br>

<div class="row">
  <div class="col-md-4">
    <div class="media">
      <a class="pull-left" href="editor/">
        <img class="media-object"
             src="images/dart-logo-48.png"
             alt="Dart logo">
      </a>
      <div class="media-body">
        <a href="editor/"><b>Dart Editor</b></a>
      </div>
    </div>
  </div>

  <div class="col-md-4">
    <div class="media">
      <a class="pull-left" href="dartium/">
        <img class="media-object"
             src="images/dartium-logo-48.jpg"
             alt="Dart logo" />
      </a>
      <div class="media-body">
        <a href="dartium/"><b>Dartium</b></a>
      </div>
    </div>
  </div>

  <div class="col-md-4">
    <div class="media">
      <a class="pull-left" href="observatory/">
        <img class="media-object"
             src="images/dart-logo-48.png"
             alt="Dart logo" />
      </a>
      <div class="media-body">
        <a href="observatory/"><b>Observatory</b></a>
      </div>
    </div>
  </div>
</div>

---

<a name="plugins"></a>
<h2>Plugins</h2>

Download the plugin for your favorite IDE or editor.

<div class="row">
  <div class="col-md-6">

    <h3>IDE plugins</h3>

    <div class="media">
      <a class="pull-left" href="webstorm/">
        <img class="media-object"
             src="images/IntellIJ-IDEA.png"
             alt="IntelliJ logo">
      </a>
      <div class="media-body">
        <a href="webstorm/"><b>IntelliJ IDEA and WebStorm</b></a>
      </div>
    </div>

    <div class="media">
      <a class="pull-left" href="eclipse-plugin/">
        <img class="media-object"
             src="images/eclipse.png"
             alt="Eclipse logo">
      </a>
      <div class="media-body">
        <a href="eclipse-plugin/"><b>Eclipse</b></a>
      </div>
    </div>
  </div>

  <div class="col-md-6">

    <h3>Text editor plugins<sup>*</sup></h3>

    <div class="media">
      <a class="pull-left" href="https://github.com/dart-lang/dart-sublime-bundle#readme">
        <img class="media-object"
             src="images/sublime.png"
             alt="Sublime logo">
      </a>
      <div class="media-body">
         <a href="https://github.com/dart-lang/dart-sublime-bundle#readme"><b>Sublime Text 3</b></a>
      </div>
    </div>

    <div class="media">
      <a class="pull-left" href="https://github.com/nex3/dart-mode">
        <img class="media-object"
             src="images/emacs.png"
             alt="Emacs logo">
      </a>
      <div class="media-body">
        <a href="https://github.com/nex3/dart-mode"><b>Emacs</b></a>
      </div>
    </div>

    <div class="media">
      <a class="pull-left" href="https://github.com/dart-lang/dart-vim-plugin">
        <img class="media-object"
             src="images/vim.png"
             alt="Vim logo">
      </a>
      <div class="media-body">
        <a href="https://github.com/dart-lang/dart-vim-plugin"><b>Vim</b></a>
      </div>

<p>
  <sup>*</sup> These plugins are unsupported and available as open source.
</p>

    </div>

  </div>
</div>


---

<a name="other-tools"></a>
<h2>Command-line tools</h2>

These tools are available in the [Dart SDK](/tools/sdk).

<div class="row">
  <div class="col-md-4">
    <dt> <a href="/tools/dart-vm">dart</a> </dt>
      <dd>The standalone VM </dd>
    <dt> <a href="/tools/dart2js/">dart2js</a> </dt>
      <dd>The Dart-to-JavaScript compiler </dd>
  </div>
  <div class="col-md-4">
    <dt> <a href="/tools/analyzer">dartanalyzer</a> </dt>
      <dd>The static analyzer </dd>
    <dt> <a href="/tools/dartdocgen/">dartdocgen</a> </dt>
      <dd>The API documentation generator </dd>
  </div>
  <div class="col-md-4">
    <dt> <a href="/tools/pub/">pub</a> </dt>
      <dd>The Dart package and asset manager </dd>
    <dt> <a href="/tools/dartfmt/">dartfmt</a> </dt>
      <dd>The Dart code formatter (<em>early access</em>)</dd>
  </div>
</div>

---

This is not an exhaustive list of tools available
for Dart development and does not reflect many fine tools developed
by the Dart community.

Also see the <a href="/tools/faq.html">Tools FAQ</a>.

---

<a name="dump-info-visualizer"></a>
<h2>Curious about your generated JavaScript?</h2>
<p>
If you are compiling your Dart code to JavaScript with dart2js, the Dump-Info
Visualizer can give you insight into what is going on behind the scenes.
Use it to analyze the generated code and see why that code is included in
your build.

<div class="media">
  <a class="pull-left" href="https://github.com/dart-lang/dump-info-visualizer">
    <img class="media-object"
         src="images/dump-info-viewer.png"
         alt="sample Dump-info visualizer output">
  </a>
  <div class="media-body">
    <a href="https://github.com/dart-lang/dump-info-visualizer"><b>Dump-Info Visualizer</b></a>
  </div>
</div>
