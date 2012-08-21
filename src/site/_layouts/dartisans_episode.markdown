---
layout: default
---

# Dartisans ep. {{ page.episode.title }}

<div class="row" style="margin-top: 25px">
	<div class="span12">

		<img style="box-shadow: 5px 5px 10px #CCC; float: left; margin-right: 25px" src="dartisans-{{page.episode.num | format_num: "%02d" }}-thumb.jpeg" width="120" height="90" alt="Screenshot of Dartisans ep {{ page.episode.num }}">

		<p>
			{{ page.episode.description }}
		</p>

		<p>
			This hangout was recorded on {{ page.episode.pubdate }}.
		</p>

	</div>
</div>

<div class="row" style="margin-top: 25px">
	<div class="span12">

		<iframe width="640" height="360" src="http://www.youtube.com/embed/{{ page.episode.youtubeid }}" frameborder="0" allowfullscreen></iframe>

		<p>
			Watch more <a href="index.html">recordings of previous episodes of Dartisans</a>
			or subscribe to an
			<a href="/dartisans/podcast-feed"><i class="icon-rss"> </i> audio podcast of Dartisans</a>.
		</p>

	</div>
</div>