---
layout: default
title: "Dart Code Samples"
description: Sample Dart code for Polymer, HTML5, Angular, and more.
header:
  css: ["/samples/samples.css"]
has_permalinks: true
---

{% injectdata samples samples/samples.yaml %}

# {{ page.title }}

Check out many other [Dart code examples](/dart-by-example/).

<div class="row">
<div class="col-md-4">
    <div class="bs-sidebar hidden-print" data-spy="affix" data-offset-top="150"
         data-offset-bottom="350" role="complementary">
      <ol class="toc nav bs-sidenav" id="markdown-toc">
      {% for group in page.samples.col1 %}
        <li><a href="#{{group.anchor}}">{{ group.heading }}</a></li>
      {% endfor %}
      </ol>
    </div>
</div>

<div class="col-md-8" >
  <div class="row">
    {% for group in page.samples.col1 %}
      <div class="row">
        <h2 class="has-permalinks" id="{{group.anchor}}">{{ group.heading }}</h2>
      </div>
      <div class="row">
        <div class="col-md-7 group">
          {% for example in group.examples %}
            <div class="row">
              <h3 class="title">{{ example.title }}</h3>
            </div>

            <div class="row">
              <div class="col-md-6">
                <p class="text-muted">{{ example.description }}&nbsp;
                   <a href="{{ example.explanation_url}}">More</a>
                </p>
              </div>
              <div class="col-md-3">
                <a href="{{ example.source_url }}">Source</a>
              </div>
              <div class="col-md-3">
                {% if example.tryit_url %}
                  <a href="{{ example.tryit_url }}">Try it</a>
                {% endif %}
              </div>
            </div>

          {% endfor %}
        </div>
        <div class="col-md-5">
          <div class="row">
            <div class="thumbnail">
              <a href="{{group.link}}">
                <img class="screenshot"
                    alt="{{group.caption}}"
                    src="imgs/{{group.screenshot}}">
              </a>
              <div class="caption">{{group.caption}}</div>
            </div>
          </div>
        </div>
      </div>
    {% endfor %}
  </div>
</div>
