---
layout: default
title: "Dart Language Specification"
description: "The Dart language specification and proposed changes."
---

# {{page.title}}

Download the _Dart Programming Language Specification_ from
the Ecma website:

* <a href="http://www.ecma-international.org/publications/files/ECMA-ST/ECMA-408.pdf"
   target="_blank">Dart Programming Language Specification</a>

For a gentler introduction to the Dart language, see the
[Dart language tour](/docs/dart-up-and-running/ch02.html) or
the [first Dart code lab](/codelabs/darrrt/).


## Proposed specification changes

Here is the newest version of the specification,
approved by
<a href="http://www.ecma-international.org/memento/TC52.htm"
   target = "_blank">TC52</a>
(but not yet by the Ecma General Assembly):

* <a href="proposedDartLangSpec.pdf" target="_blank">Draft:
  Dart Programming Language Specification, 2<sup>nd</sup> Edition</a>

The 2<sup>nd</sup> edition includes information about
the following proposed language features:

* Enumerations (`enum`)<br>
  Implemented in 1.8.

* Asynchrony support (`async`, `await`, and more)<br>
  Partially implemented in 1.8, as described in
  [Dart Language Asynchrony Support: Phase 1](/articles/await-async/).

* Deferred loading (`import ... deferred as`)<br>
  Implemented in 1.6, as described in
  [Deferred Loading in Dart](deferred-loading.html).

{% comment %}
In the following documents,
<span style="background:yellow">yellow highlights</span>
mark proposed changes to the Dart language specification.
Non-normative text is in
<span style="color:blue; font-style:italic">blue italics</span> (for rationale)
or <span style="color:green">green</span> (for commentary).

* <a href="Asyncdraft-TC52.pdf"
     target="_blank">Async Await</a>
* <a href="EnumsTC52draft.pdf"
     target="_blank">Enums</a>
{% endcomment %}
