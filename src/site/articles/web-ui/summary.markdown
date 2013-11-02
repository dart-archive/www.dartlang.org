---
layout: article
title: "Web UI Feature Summary"
rel:
  author: siggi-cherem
description: "A table summarizing all features in the Web UI package."
has-permalinks: true
---
{% comment %}

See README comment in index.markdown for explanations of
{{'{{'}}, \{\% raw \%\}, and \{\% codesample \%\}.

{% endcomment %}

{% include toc.html %}

# {{ page.title }}

<aside class="alert alert-danger" markdown="1">
<strong>Web UI is deprecated.</strong>
Instead, use [Polymer.dart](/polymer-dart/),
which supersedes Web UI beginning with version 0.5
and provides many fixes and improvements.
We encourage Web UI users to upgrade to Polymer.dart.
The information on this page applies only to Web UI.
</aside>


_Written by Sigmund Cherem<br />
November 2012 (Updated December 2012)_

The Web UI package (Web UI for short) provides web components and templates to
help you write web applications at scale. The following tables collect all
features supported by Web UI. Read the [reference specification](spec.html) for
more details, or refer to our [explainer article](index.html) for a high-level
introduction and examples.

## Web components features

<table class="table">
<tbody>
<tr>
  <th width="20%"> Feature </th>
  <th width="35%"> Syntax example </th>
  <th> Purpose </th>
</tr>

<tr><td>
Component
<a href="spec.html#declaration">tag name</a>
declaration
</td><td>
{% prettify html %}<element name='x-foo-bar' ...>{% endprettify %}
</td><td>
Names a component, which lets you instantiate it as
<code>&lt;x-<em>foo-bar</em>&gt;</code>. If the <code>constructor</code> attribute is not
set, the component behavior is defined by the class
<code><em>FooBar</em></code>. Names must start with the <code>x-</code> prefix.
</td></tr>

<tr><td>
Component
<a href="spec.html#declaration">constructor</a>
declaration
</td><td>
{% prettify html %}<element ... constructor='MyClass'>{% endprettify %}
</td><td>
Associates the Dart class <em>MyClass</em> with the component's behavior. If
omitted, the name of the Dart class is derived from the name of the element
(see tag name declaration, above).
</td></tr>

<tr><td>
<a href="spec.html#declaration">Tag extension</a>
</td><td>
{% prettify html %}<element ... extends='span'>{% endprettify %}
</td><td>
Specifies the base element that is being extended by a component. The base
element can be an HTML element or another component.
</td></tr>

<tr><td>
<a href="spec.html#instantiation">Instantiation</a>
</td><td>
{% prettify html %}... <x-tag></x-tag>{% endprettify %}
{% prettify html %}... <span is='x-tag'></span>{% endprettify %}
</td><td>
Lets you use a component in your page or within another component.
You can instantiate a component in two ways:
using the tag directly (<code>&lt;x-<em>tag</em>&gt;</code>)
or using the <code>is</code> attribute on the base HTML element
that the component directly or indirectly extends from
(<code>&lt;span is='x-<em>tag</em>'&gt;</code>).
<br>
<br>
<strong>Note:</strong> Do not omit the closing tag.
</td></tr>

<tr><td>
<a href="spec.html#retrieval">Retrieval</a>
</td><td>
{% prettify dart %}document.query('x-foo').xtag{% endprettify %}
</td><td>
Retrieves a reference to a component previously instantiated in your page.
<br>
<br>
<strong>Note:</strong> The <code>xtag</code> fields will be null within
<code>main</code>, but will be available at the end of the event loop.

</td></tr>

<tr><td>
Element's <a href="spec.html#appearance">template</a>
</td><td>
{% prettify html %}
<element name='x-foo'>
  <template> ... </template>
{% endprettify %}
</td><td>
Specifies the markup of the component. The template portion of a web component
is inert until the component is instantiated. The template may contain any of
the templating features (data bindings, conditionals, loops, and so on)
and also the content redistribution available in web components.
</td></tr>

<tr><td>
Element's <a href="spec.html#behavior">script</a>
</td><td>
{% prettify html %}
<element name='x-foo'>
  ...
  <script type='application/dart'>...</script>
{% endprettify %}
</td><td>
Specifies the behavior of a component. This script defines the class
corresponding to the component.
</td></tr>

<tr><td>
Element's <a href="spec.html#appearance">style</a>
</td><td>
{% prettify html %}
<element name='x-foo'>
  ...
  <style> ... </style>
{% endprettify %}
</td><td>
Specifies scoped CSS rules that are only applicable in the context of the
component's <code>&lt;template></code> body.
</td></tr>

<tr><td>
<a href="spec.html#appearance">Content insertion</a>
</td><td>
{% prettify html %}
<element name='x-foo'>
  <template>
    ...
    <content></content>
{% endprettify %}
</td><td>
Allows components to have children. When a component has children, those
children go where the <code>&lt;content></code> tags are.
For example, consider this usage:
{% prettify html %}
<x-foo><div>hello</div></x-foo>
{% endprettify %}
The <code>&lt;div&gt;hello&lt;/div&gt;</code> will be placed within the
element's template where the content tag is specified.
</td></tr>

<tr><td>
Selector in <a href="spec.html#appearance">content insertion</a>
</td><td>
{% prettify html %}
<element name='x-foo'>
  <template>
    ...
    <content select='div'></content>
    <content></content>
{% endprettify %}
</td><td>
Specifies which subset of a component's children
are distributed in a particular content tag.
For example, consider this usage:
{% prettify html %}
<x-foo><span>one</span><div>two</div></x-foo>
{% endprettify %}
The <code>&lt;div&gt;two&lt;/div&gt;</code> will be placed at the first
<code>&lt;content&gt;</code> insertion point (where div tags are selected), and
the <code>&lt;span&gt;</code> will be added at the insertion point
of the second content tag.
</td></tr>

<tr><td>
<a href="spec.html#appearance">Base component insertion</a>
</td><td>
{% prettify html %}
<element ... >
  <template>
    ...
    <shadow></shadow>
{% endprettify %}
</td><td>
Embeds the content of a base component. When a component extends another
component, The <code>&lt;shadow&gt;</code> tag is an insertion point where the
contents of the parent component are added.
</td></tr>

<tr><td>
<a href="spec.html#loading-components">Components inclusion</a>
</td><td>
{% prettify html %}
<html ...>
  <head>
  <link rel="import" href="...">
  </head>
{% endprettify %}
</td><td>
Imports component definitions
from the URL specified by <code>href</code>.
You can use these components
within the body of the current HTML page
and within components that the current HTML page defines.
</td></tr>
</tbody>
</table>


## Templating features

<table class="table">
<tr>
  <th width="20%"> Feature </th>
  <th width="35%"> Syntax example </th>
  <th> Purpose </th>
</tr>

<tr><td>
<a href="spec.html#binding-in-content">Text node data binding</a>
</td><td>
{% prettify html %}<div>{{'{{'}}exp}}</div>{% endprettify %}
</td><td>
Injects the value of evaluating <em>exp</em> in the document and watches for
changes. Any time a change to <em>exp</em> is detected, the UI is updated.
Values of the special type SafeHtml (from <a
href="https://github.com/dart-lang/web-ui/blob/master/lib/safe_html.dart">package:web_components/safe_html.dart</a>)
are treated in a special manner.
If the value of <em>exp</em> is not SafeHtml,
the contents are converted to a string
and are treated as text (they are escaped as safe HTML).
Otherwise, if the value of <em>exp</em> is a SafeHtml,
the contents are injected directly as an HTML fragment.
</td></tr>

<tr><td>
<a href="spec.html#binding-in-attributes">Attribute data binding</a>
</td><td>
{% prettify html %}<td colspan="{{'{{'}}exp}}"></td>{% endprettify %}
</td><td>
Binds the value of <em>exp</em> to the value of the attribute. Similar to
binding in text nodes, the expression is watched for changes
and the element
attribute is updated accordingly. The type of the expression is treated
accordingly, so unsafe content is appropriately escaped
as an attribute value.
</td></tr>

<tr><td>
<a href="spec.html#binding-in-attributes">Class attribute data binding</a>
</td><td>
{% prettify html %}<div class="{{'{{'}}Class1}} {{'{{'}}Class2}}"></div>{% endprettify %}
{% prettify html %}<div class="{{'{{'}}classesAsList}}"></div>{% endprettify %}
{% prettify html %}<div class="{{'{{'}}classesAsString}}"></div>{% endprettify %}
</td><td>
Binds the values to a class attribute. Similar
to attribute bindings, except that the system is smart enough
to update the class list
by adding and removing individual classes that change.
If the expression is
null, it means that the class(es) represented by that expression are all
removed.
</td></tr>

<tr><td>
<a href="spec.html#binding-in-attributes">Style attribute data binding</a>
</td><td>
{% prettify html %}<div style="{{'{{'}}exp}}"></div>{% endprettify %}
</td><td>
Binds the value of <em>exp</em> to the value of a style attribute.
Similar to attribute bindings,
except that <em>exp</em> is expected to be a map
and the system updates the style of the node
by treating the key-value pairs
in <em>exp</em> as CSS property-value pairs.
</td></tr>

<tr><td>
<a href="spec.html#binding-interactive-elements">Two-way data binding</a>
in interactive elements
</td><td>
{% prettify html %}<input type="text"
       bind-value="assignableValue">{% endprettify %}
{% prettify html %}<textarea bind-value="assignableValue">
</textarea>{% endprettify %}
{% prettify html %}<input type="checkbox"
       bind-checked="assignableValue">{% endprettify %}
</td><td>
Directly updates <em>assignableValue</em> with user input. Like data bindings in
attributes, this displays the latest value of the <em>assignableValue</em>
expression in the element.  Additionally, when the element is updated due to UI
interaction, the <em>assignableValue</em> is also updated and kept in sync.
</td></tr>


<tr><td>
<a href="spec.html#conditional-template">Conditional template node</a>
</td><td>
{% prettify html %}
<template instantiate="if exp">
contents
</template>
{% endprettify %}

{% prettify html %}<template if="exp">contents</template>{% endprettify %}
</td><td>
Conditionally adds <em>contents</em> if <em>exp</em> evaluates to true. The
contents are added <em>after</em> the template tag
(not as children of the template tag).
To make a conditional
row or cell in a table, use conditional tag attributes instead.
<br>
<br>
<strong>Note:</strong> both <code>instance="if exp"</code> and
<code>if="exp"</code> are accepted, the syntax is not yet finalized.
</td></tr>

<tr><td>
<a href="spec.html#conditional-attribute">Conditional tag attribute</a>
</td><td>
{% prettify html %}
<div template instantiate="if exp">
contents
</div>
{% endprettify %}
{% prettify html %}<div template if="exp">contents</div>{% endprettify %}
{% prettify html %}
<table><tbody>
<tr>
  <td template instantiate="if showCell">
    contents
  </td>
</tr>
</tbody></table>
{% endprettify %}
</td><td>
Conditionally adds the element to the DOM tree if the expression is true. This
can be used to make rows and cells conditionally visible.
<br>
<br>
<strong>Note:</strong> both <code>instance="if exp"</code> and
<code>if="exp"</code> are accepted, the syntax is not yet finalized.
</td></tr>

<tr><td>
<a href="spec.html#iterate-template">Iterating template node</a>
</td><td>
{% prettify html %}
<template iterate="x in exp">
contents
</template>
{% endprettify %}
</td><td>
Inserts <em>contents</em> for each item in <em>exp</em>
(an iterable collection).
The contents are added <em>after</em> the template tag (not
as children of the tag). To iterate over table rows or cells,
use iterating tag attributes instead.
</td></tr>

<tr><td>
<a href="spec.html#iterate-attribute">Iterating tag attribute</a>
</td><td>
{% prettify html %}
{% raw %}
<table>
<tbody template iterate="x in exp">
  <tr>
    <td>{{x.firstName}}</td>
    <td>{{x.lastName}}</td>
  </tr>
</tbody>
</table>
{% endraw %}
{% endprettify %}
</td><td>
Expands <em>contents</em> under the element,
once per item in the collection that <em>exp</em> evaluates to.
This can be used to create rows and cells in tables.
</td></tr>

<tr><td>
<a href="spec.html#event-listeners">Inline event listener</a>
</td><td>
{% prettify html %}
<div on-click="myHandler($event)">
contents
</div>
{% endprettify %}
</td><td>
Binds a UI event to a Dart expression. Whenever the event fires, the associated
expression is executed and watchers are notified about possible changes. The
fired event is stored in the special variable <code>$event</code>, available in
the scope of the Dart expression.
</td></tr>

</tbody></table>
