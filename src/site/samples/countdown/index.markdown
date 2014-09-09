---
layout: default
title: Storing and Retrieving Data using IndexedDB
live_example_url: /docs/tutorials/indexeddb/examples/count_down/web/count_down.html
header:
  css: ["/samples/samples.css"]
---

<h1>{{ page.title }}</h1>

Enter a name date and time and click the plus (+) button.

This program shows you how to store and retrieve data on the client-side using
IndexedDB.

IndexedDB is one kind of local storage supported by many browsers that any web
app can use to store and retrieve data on the client. IndexedDB is an indexed
database in which each record is identified by unique ID.

In brief, to save a record in an IndexedDB:

- check for browser support
- create or open a database
- create or open an object store on the database
- create a transaction on the object store
- add the record to the database
- handle transaction completed or error


Read this [tutorial](/docs/tutorials/indexeddb) for
more detail, or read the
[source](https://github.com/dart-lang/dart-tutorials-samples/tree/master/stopwatch).

<iframe class="running-app-frame"
        style="height:400px;width:100%;"
        src="{{page.live_example_url}}">
</iframe>

See all [samples](/samples/).
