---
layout: default
title: "Dart Code Samples"
description: Check out some Dart code in action with these samples, ranging
             from Hello, World to a solar system simulator.
header:
  css: ["/samples/samples.css"]
---

# {{ page.title }}

The <a
href="https://github.com/dart-lang/bleeding_edge/tree/master/dart/samples">dart/samples</a>
directory contains many applications written in Dart.
Some of these samples are available in [Dart Editor](/tools/editor/) for easy
experimentation.

{% injectdata samples samples/samples.yaml %}
<div class="row">
  <div class="span6">
    {% for group in page.samples.col1 %}
      <div class="group-heading">{{ group.heading }}</div>
      {% for example in group.examples %}
        <div class="row-fluid example">
          <div class="span8">
            <div class="title"><a href="{{ example.explanation_url }}">{{ example.title }}</a></div>
          </div>
          <div class="span2">
            <div class="link"><a href="{{ example.source_url }}">Source</a></div>
          </div>
          <div class="span2">
            {% if example.tryit_url %}
              <div class="link"><a href="{{ example.tryit_url }}">Try it</a></div>
            {% endif %}
          </div>
        </div>
      {% endfor %}
    {% endfor %}
  </div>
  <div class="span6">
    {% for group in page.samples.col2 %}
      <div class="group-heading">{{ group.heading }}</div>
      {% for example in group.examples %}
        <div class="row-fluid example">
          <div class="span8">
            <div class="title"><a href="{{ example.explanation_url }}">{{ example.title }}</a></div>
          </div>
          <div class="span2">
            <div class="link"><a href="{{ example.source_url }}">Source</a></div>
          </div>
          <div class="span2">
            <div class="link"><a href="{{ example.tryit_url }}">Try it</a></div>
          </div>
        </div>
      {% endfor %}
    {% endfor %}
  </div>
</div>

