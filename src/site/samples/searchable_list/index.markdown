---
layout: default
title: Searchable List
live_example_url: example/index.html

header:
  css: ["/samples/samples.css"]
---

## {{ page.title }}

This simple application shows the use of a custom element where list data is
searchable. The demonstrates the following parts of Polymer:

* defining custom elements
* the `<template>` tag
* HTML imports
* data binding


The `<searchable-list>` element uses data binding to implement search.
See the `searchable_list.html` and the `searchable_list.dart` files for the
code.

The `SearchableList` class uses three variables in the search implementation:

* `data` stores all the data in the list
* `searchParam` stores the search parameter
* `results` stores the elements of `data` that match the search paramater

When the user types in the search input, the `search()` method triggers, and
the value of `results` is updated.  Since `results` is an observable variable,
its representation in the UI automatically updates as its contents change.

Here is the minimal code for required to implement search
(`searchable_list.dart`):

    search() {
      results.clear();
      String lower = searchParam.toLowerCase();
      results.addAll(data.where((d) => d.toLowerCase().contains(lower)));
    }

Any changes to `searchParam` trigger  `search()`. Here is the code for that
(the `enteredView()` method in `searchable_list.dart`):

    onPropertyChange(this, #searchParam, search);

Read the
[source](https://code.google.com/p/dart/source/browse/#svn%2Fbranches%2Fbleeding_edge%2Fdart%2Fsamples%2Fsearchable_list).

<iframe class="running-app-frame"
        style="height:500px;width:100%;"
        src="{{page.live_example_url}}">
</iframe>

See all [samples](/samples/)
