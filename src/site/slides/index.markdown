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
You can also watch our Dart videocast, [Dartisans](/dartisans/),
and our 5-minute video tutorials, [Dart Tips](/dart-tips/).

{% injectdata presos slides/presentations.yaml %}

<style>
.thumbnail {
  position: relative;
}
.presentation-details {
  position: absolute;
  bottom: 58px;
  left: 0px;
  width: 100%;
  background: whitesmoke;
}
.inner {
  padding: 15px;
}
.thumbnail .buttons {
  margin-top: 15px;
  position: relative;
}
.thumbnail .plusone-preso {
  position: absolute;
  bottom: 30px;
  right: 15px;
}
</style>

<!-- XXXX don't set width/height on images, just use 640x360 -->

<ul class="thumbnails">
  {% for preso in page.presos %}
  <li class="col-md-6" id="{{ preso.short }}">
    <div class="thumbnail">
      <img class="screenshot" src="imgs/{{ preso.short }}.jpg">
      <div class="presentation-details">
        <div class="inner">
          <h4 class="title">{{ preso.title }}</h4>
          <p>
            by {{ preso.presenters | array_to_sentence_string }}<br>
            from {{ preso.event }}, {{ preso.date }}
          </p>

        </div>
      </div>
      <p class="buttons">
        {% if preso.video %}
        <a href="{{ preso.video }}" target="_blank" class="video btn btn-primary"><i class="icon-film">&nbsp;</i>Watch</a>
        {% endif %}
        {% if preso.slides %}
        <a href="{{ preso.slides }}" target="_blank" class="pdf btn btn-primary"><i class="icon-picture">&nbsp;</i>Slides</a>
        {% endif %}
      </p>
    </div>
  </li>
  {% endfor %}
</ul>


