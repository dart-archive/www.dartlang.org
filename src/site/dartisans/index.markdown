---
layout: default
title: "Dartisans: The Dart show"
description: "The Dartisans show features special guests from the Dart team and community. Watch videos or subscribe to the podcast."
---

{% injectdata episodes dartisans/episodes.yaml %}

# Dartisans

## The Dart show and podcast

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

[{{episode.title}}](dartisans-ep-{{forloop.rindex | plus: 1}}.html)
: Aired {{episode.pubdate}}.

{% endfor %}

Dartisans Ep. 1
: (Unfortunately, lost to the bit bucket in the sky. Probably too epic for servers to contain.)