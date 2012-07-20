---
layout: default
title: "Hangout Videos"
description: "A collection of videos about Dart from previous Google+ Hangouts."
---

{% injectdata episodes hangouts/episodes.yaml %}

# Hangout Videos

This page archives recordings of Dartisans, the live
Google+ Hangout show about Dart. Dartisans is a semi-regular Hangout
broadcast featuring special guests from the Dart team.

You can also subscribe to an
<a href="/dartisans/podcast-feed"><i class="icon-rss"> </i> audio podcast of Dartisans</a>.

{% for episode in page.episodes.episodes %}

[{{episode.title}}](dartisans-ep-{{forloop.rindex | plus: 1}}.html)
: Aired {{episode.pubdate}}.

{% endfor %}

Dartisans Ep. 1
: (Unfortunately, lost to the bit bucket in the sky. Probably too epic for servers to contain.)