---
layout: default
title: Books about Dart
description: Read all about it! Here's a collection of books about Dart.
---

# Books on Dart

Here's a collection of books about Dart.
[Let us know](http://dartbug.com/new) if you see a book missing.

{% injectdata books books/books.yaml %}

{% for book in page.books %}
<div class="book row">
  <div class="col-md-2">
    <a href="{{ book.link }}"><img src="covers/{{ book.cover }}" class="cover"></a>
  </div>
  <div class="col-md-10">
    <h3 class="title"><a href="{{ book.link }}">{{ book.title }}</a></h3>
    <h4 class="authors">Written by {{ book.authors || array_to_sentence_string }}</h4>
    <p>{{ book.desc }}</p>
  </div>
</div>
{% endfor %}