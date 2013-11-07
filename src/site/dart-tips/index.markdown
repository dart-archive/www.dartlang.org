---
layout: default
title: "Dart Tips: Short Video Tutorials about Dart"
description: "Super short video intros to Dart language and library features."
---

{% injectdata tips dart-tips/episodes.yaml %}

# Dart Tips: Short Video Tutorials

Sometimes, you only have 5 minutes. Watch super short introductions to
Dart language and library topics.

{% for episode in page.tips.episodes %}

{% capture link %}dart-tips-ep-{{episode.num}}.html{% endcapture %}

<div class="row" style="margin-bottom:1em">
  <div class="col-md-2">
    <a href="{{ link }}"><img style="margin-top:25px; box-shadow: 5px 5px 10px #CCC; width:100%" src="{{episode.thumbnail}}"></a>
  </div>
  <div class="col-md-10">
    <h3><a href="{{ link }}">Ep. {{ episode.num }}: {{ episode.subtitle }}</a></h3>
    
    <p>{{ episode.description }}</p>

    <p>{{ episode.pubdate }}</p>
  </div>
</div>

{% endfor %}

<a href="http://marakana.com"><img src="imgs/marakana-logo.png" alt="Marakana Logo"></a>

Our thanks go out to [Marakana](http://www.marakana.com) for producing this
video series.