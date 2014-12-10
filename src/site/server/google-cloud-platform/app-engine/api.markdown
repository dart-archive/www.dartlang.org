---
layout: default
title: "API Overview"
short-title: "API"
description: "A brief overview of the libraries used for creating a Dart runtime instance on App Engine."
header:
  css: ["styles.css"]
---

{% include breadcrumbs.html %}

# {{ page.title }}

The following Dart libraries let you write code that leverages
the features and services of App Engine's Managed VMs.

### [`appengine`](https://github.com/dart-lang/appengine)

This library provides the functions and classes you need to run and host
a Dart application on App Engine Managed VMs.
Your Dart application runs in an isolated container and
can access App Engine's services such as gcloud and memcache.

Your code needs to import the library:

<pre>
import 'package:appengine/appengine.dart';
</pre>

To start an App Engine instance,
call the top-level `runAppEngine()` method, passing in a callback function.
When an HTTP request comes in, the callback function is called to process
the request.

From within a request handler,
you can use `context.services` to access the various App Engine services.
For example, to access the Cloud Datastore service API write:
<pre>
context.services.db
</pre>

This library also includes API for logging, users, and errors.

### [`gcloud`](https://pub.dartlang.org/packages/gcloud)

The `gcloud` package contains a number of APIs,
including Cloud Datastore and Cloud Storage, that can
be used to provide a mapping from Dart objects to the cloud datastore.

Your code needs to import the library:

<pre>
import 'package:gcloud/db.dart'
</pre>

The cloud datastore is App Engine's scalable, schemaless, storage system
for your application's data.

Entities in the datastore can have a parent and children, and thus
form a hierarchical structure.
Entities descended from a common ancestor are in the same entity group.
Queries over a single entity group return strongly consistent results.
Other queries return eventually consistent results.

Important classes from this library include:

* `DatastoreDB`
: The primary interface to App Engine's Datastore, this class provides
  top-level `withTransaction()` and `query()` functions.

* `Query`
: A Query is an object that queries the Datastore for an entity or
  a group of entities using search criteria. The Query class provides
  methods for ordering and filtering the results.
  Use `filter()` to further refine the results and `order()` to sort them.

<blockquote style="border:0px">
<pre>
var db = context.services.db;
db.query(Greeting)..order('date');  // sort by date
db.query(Greeting)..filter('date'); // filter out anything that is not a date
</pre>
</blockquote>

* `Transaction`
: A transaction is an atomic operation or set of operations on a
  database.
  Use a Transaction to insert, update, or delete entities in a datastore.
  Modifications to a Datastore entity must take place within a Transaction.
  Use `queueMutations()` to set up the insertions and deletions,
  then call `commit()` to permanently make the changes.
  All modifications in the Transaction must successfully complete
  otherwise the Transaction has no effect and must be rolled back
  using the `rollback()` method.

### [`memcache`](https://github.com/dart-lang/memcache)

This library provides an interface to App Engine's high-performance,
distributed in-memory caching system.
The main class in this library,
`Memcache`, provides top-level functions for getting, setting,
and removing objects from the cache.

The Memcache service provides a shared cache, which is organized as a map
from keys to values. Both keys and values are binary (lists of bytes).
The key value used in Memcache has a maximum
length of 250 bytes.
The maximum size for a
value depends on the configuration of the memcache service.
The most common default is 1M (one megabyte).

For each entry in the cache, an expiration time can be set
to ensure the item is evicted from the cache after a given interval or at
a specific time. The cache has a limited size, so items can be
evicted by the service at any time, typically using a Least
Recently Used (LRU) policy.

## What next?

Next, you can check out [A Client-Server Example](client-server/),
which shows how to run and deploy a program with separate
client and server programs.
