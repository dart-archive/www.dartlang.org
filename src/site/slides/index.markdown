---
layout: default
title: "Presentations, Videos, and Slides"
description: "Watch videos and review slides from presentations about the Dart web programming language and tools."
js:
- url: /js/slides-analytics.js
  defer: true
snippet_img: imgs/dart-today-and-beyond.jpg
---

# Dart Presentations

Watch videos and review slides from presentations about Dart.
You can also watch our 5-minute video tutorials, [Dart Tips](/dart-tips/).

{% injectdata presos slides/presentations.yaml %}


<!-- XXXX don't set width/height on images, just use 640x360 -->

{% for preso in page.presos %}

<!-- create a row for every three presos -->
{% cycle '<div class="row">', '', '' %}

<div class="col-md-4" id="{{ preso.short }}">
  <div class="thumbnail">
    <img class="screenshot" src="imgs/{{ preso.short }}.jpg">
    <div class="caption">
      <h4 class="title">{{ preso.title }}</h4>
      <p>
        by {{ preso.presenters | array_to_sentence_string }}<br>
        from {{ preso.event }}, {{ preso.date }}
      </p>
      <p class="buttons">
        {% if preso.video %}
        <a href="{{ preso.video }}" target="_blank" class="btn btn-primary"><i class="glyphicon glyphicon-film"> </i> Watch</a>
        {% endif %}
        {% if preso.slides %}
        <a href="{{ preso.slides }}" target="_blank" class="btn btn-primary"><i class="glyphicon glyphicon-picture"> </i> Slides</a>
        {% endif %}
      </p>
    </div>
  </div>
</div>

{% cycle '', '', '</div>' %}
{% endfor %}


