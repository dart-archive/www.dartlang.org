---
layout: default
title: "Dart Code Samples"
description: Check out some Dart code in action with these samples, ranging
             from Hello, World to a solar system simulator.
---

# {{ page.title }}

The <a 
href="https://code.google.com/p/dart/source/browse/branches/bleeding_edge/dart/samples/">dart/samples</a>
directory contains many applications written in Dart.
Some of these samples are available in [Dart Editor](/editor/) for easy
experimentation.

{% injectdata samples samples/samples.yaml %}

<ul class="thumbnails">

  {% for sample in page.samples.row01 %}
  <li class="span4">
    <div class="thumbnail">
      <img src="imgs/{{ sample.name }}.png" alt="{{ sample.alt }}">
      <h3>{{ sample.title }}</h3>
      <p>
        {{ sample.desc }}
        {% if sample.walkthrough %}
        <a href="{{ sample.name }}/index.html">Code walkthrough.</a>
        {% endif %}
      </p>
      <p>
        <a href="{{ sample.source_url }}">View the source.</a>
        {% if sample.live_url %}
        <a href="{{ sample.live_url }}">Try it live.</a>
        {% endif %}
      </p>
      <ul>
        {% for feature in sample.features %}
        <li>{{ feature }}</li>
        {% endfor %}
      </ul>
    </div>
  </li>
  {% endfor %}

</ul>

<ul class="thumbnails">

  {% for sample in page.samples.row02 %}
  <li class="span4">
    <div class="thumbnail">
      <img src="imgs/{{ sample.name }}.png" alt="{{ sample.alt }}">
      <h3>{{ sample.title }}</h3>
      <p>
        {{ sample.desc }}
        {% if sample.walkthrough %}
        <a href="{{ sample.name }}/index.html">Code walkthrough.</a>
        {% endif %}
      </p>
      <p>
        <a href="{{ sample.source_url }}">View the source.</a>
        {% if sample.live_url %}
        <a href="{{ sample.live_url }}">Try it live.</a>
        {% endif %}
      </p>
      <ul>
        {% for feature in sample.features %}
        <li>{{ feature }}</li>
        {% endfor %}
      </ul>
    </div>
  </li>
  {% endfor %}

</ul>

<ul class="thumbnails">

  {% for sample in page.samples.row03 %}
  <li class="span4">
    <div class="thumbnail">
      <img src="imgs/{{ sample.name }}.png" alt="{{ sample.alt }}">
      <h3>{{ sample.title }}</h3>
      <p>
        {{ sample.desc }}
        {% if sample.walkthrough %}
        <a href="{{ sample.name }}/index.html">Code walkthrough.</a>
        {% endif %}
      </p>
      <p>
        <a href="{{ sample.source_url }}">View the source.</a>
        {% if sample.live_url %}
        <a href="{{ sample.live_url }}">Try it live.</a>
        {% endif %}
      </p>
      <ul>
        {% for feature in sample.features %}
        <li>{{ feature }}</li>
        {% endfor %}
      </ul>
    </div>
  </li>
  {% endfor %}

</ul>