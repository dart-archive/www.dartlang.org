---
layout: default
title: "Dart Code Samples"
header:
  css: ["/samples/samples.css"]
has_permalinks: true
---
{% injectdata samples samples/samples.yaml %}
  <h1> {{ page.title }} </h1>
<div class="row">
<div class="col-md-3">
  <ul id="samples-toc">
  {% for group in page.samples.col1 %}
    <li><a href="#{{group.anchor}}">{{ group.heading }}</a></li>
  {% endfor %}
  </ul>
</div>

<div class="col-md-9" >
  <div class="row">
    {% for group in page.samples.col1 %}
      <div class="group-heading">{{ group.heading }}</div>
      {% for example in group.examples %}
        <div class="row example">
          <div class="col-md-8">
            <div class="title"><a href="{{ example.explanation_url }}">{{ example.title }}</a></div>
          </div>
          <div class="col-md-4">
            <div class="link pull-left"><a href="{{ example.source_url }}">Source</a></div>

            <div class="link pull-right">
              {% if example.tryit_url %}
                <a href="{{ example.tryit_url }}">Try it</a>
              {% endif %}
            </div>
          {% endfor %}
        </div>
        <div class="col-md-3">
          <div class="screenshot-container">
            <a href="{{group.link}}">
              <img width="135" class="screenshot"
                  alt="{{group.caption}}"
                  src="imgs/{{group.screenshot}}">
            </a>
          </div>
          <div class="col-md-4">
            <div class="link pull-left"><a href="{{ example.source_url }}">Source</a></div>

            <div class="link pull-right">
              {% if example.tryit_url %}
                <a href="{{ example.tryit_url }}">Try it</a>
              {% endif %}
            </div>
          </div>
        </div>
      </div>
    {% endfor %}
  </div>
</div>
