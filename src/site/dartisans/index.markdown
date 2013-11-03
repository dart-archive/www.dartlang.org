---
layout: default
title: "Dartisans: The Dart show"
description: "The Dartisans show features special guests from the Dart team and community. Watch videos or subscribe to the podcast."
---

{% injectdata episodes dartisans/episodes.yaml %}

# Dartisans: The Dart show and podcast

This page archives recordings of Dartisans, the video show
and podcast about Dart. Dartisans is a semi-regular
broadcast featuring special guests from the Dart team and the community.

You can also subscribe to an audio podcast of Dartisans,
either with a
<a href="/dartisans/podcast-feed"
  title="Subscribe to Dartisans podcast feed"> <i class="icon-rss"> </i> direct link</a>
or with
<a href="http://itunes.apple.com/us/podcast/dartisans-dart-programming/id546874773?mt=2"
  title="Subscribe to Dartisans podcast with iTunes"> <i class="icon-rss"> </i> iTunes</a>.

{% for episode in page.episodes.episodes %}

{% capture link %}dartisans-ep-{{episode.num}}.html{% endcapture %}

<div class="row" style="margin-bottom:1em">
  <div class="col-md-2">
    <a href="{{ link }}"><img style="margin-top:9px; box-shadow: 5px 5px 10px #CCC" src="{{episode.thumbnail}}"></a>
  </div>
  <div class="col-md-10">
    <h3><a href="{{ link }}">Ep. {{ episode.num }}: {{ episode.subtitle }}</a></h3>
    
    <p>{{ episode.description }}</p>

    <p>{{episode.pubdate}}</p>
  </div>
</div>

{% endfor %}
