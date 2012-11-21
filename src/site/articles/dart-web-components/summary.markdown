---
layout: default
title: "Dart Web Components Feature Summary"
rel:
  author: siggi-cherem
description: "A table summarizing all features in Dart Web Components."
has-permalinks: true
---
{% comment %}

See README comment in index.markdown for explanations on {{'{{'}}, \{\% raw \%\}
and \{\% codesample \%\}.

{% endcomment %}

# {{ page.title }}

_Written by Siggi Cherem<br />
November 2012_

Dart web components provide templates, data binding, and encapsulation to help
you write web applications at scale. This article contains a table that collects
all features supported by Dart web components. Read the [reference
specification](spec.html) for more details or refer to our [explainer
article](index.html) for a high-level introduction and examples.

<table class="table">
<thead>
  <tr>
    <td width="20%"> Feature </td>
    <td width="35%"> Syntax example </td>
    <td>Purpose</td>
  </tr>
</thead>
<tbody>

<tr><td colspan="3">
<strong>Web components features</strong>
</td></tr>

<tr><td>
Component
<a href="spec.html#declaration">tag name</a>
declaration.
</td><td>
{% highlight html %}<element name='x-foo-bar' ...>{% endhighlight %}
</td><td>
Names a component, which lets you instantiate it as
<code>&lt;x-foo-bar&gt;</code>. If the <code>constructor</code> attribute is not
set, it also indicates that the component behavior is defined by the class
<code>FooBar</code>. Names must start with the <code>x-</code> prefix.
</td></tr>

<tr><td>
Component
<a href="spec.html#declaration">constructor</a>
declaration.
</td><td>
{% highlight html %}<element ... constructor='MyClass'>{% endhighlight %}
</td><td>
Associates the Dart class <code>MyClass</code> with the component's behavior. If
omitted, the name of such Dart class is derived from the name of the element
(see tag name declaration above).
</td></tr>

<tr><td>
<a href="spec.html#declaration">Tag extension</a>.
</td><td>
{% highlight html %}<element ... extends='span'>{% endhighlight %}
</td><td>
Specifies the base element that is being extended by a component. The base
element can be an HTML element or another component.
</td></tr>

<tr><td>
<a href="spec.html#instantiation">Instantiation</a>.
</td><td>
{% highlight html %}... <x-tag></x-tag>{% endhighlight %}
{% highlight html %}... <span is='x-tag'></span>{% endhighlight %}
</td><td>
Lets you use a component in your page or within another component. There are two
valid forms to instantiate a component, using the tag directly (like
<code>&lt;x-tag&gt;</code>) or using the `is` attribute on the base HTML element
that the component directly or indirectly extends from (like <code>&lt;span
is='x-tag'&gt;</code>).
<strong>Note</strong>: the closing tag is necessary. Components are not allowed
to declare void elements (like <code>&lt;img&gt;</code>), so their closing tag
is mandatory. If you omit it, the HTML might still be valid, but it will be
parsed as if the rest of the document are children of your component tag.
</td></tr>

<tr><td>
Element's <a href="spec.html#appearance">template</a>.
</td><td>
{% highlight html %}
<element name='x-foo'>
  <template> ... </template>
{% endhighlight %}
</td><td>
Specifies the markup of the component. The template portion of a web component
is inert until the component is instantiated. The template may contain any of
the templating features (data bindings, conditionals, loops, etc) and also the
content redistribution available in web components.
</td></tr>

<tr><td>
Element's <a href="spec.html#behavior">script</a>.
</td><td>
{% highlight html %}
<element name='x-foo'>
  ...
  <script type='application/dart'>...</script>
{% endhighlight %}
</td><td>
Specifies the behavior of a component. This script defines the class
corresponding to the component.
</td></tr>

<tr><td>
Element's <a href="spec.html#appearance">style</a>.
</td><td>
{% highlight html %}
<element name='x-foo'>
  ...
  <style> ... </style>
{% endhighlight %}
</td><td>
Specifies scoped CSS rules that are only applicable in the context of the
component's `<template>` body.
</td></tr>

<tr><td>
<a href="spec.html#appearance">Content insertion</a>.
</td><td>
{% highlight html %}
<element name='x-foo'>
  <template>
    ...
    <content></content>
{% endhighlight %}
</td><td>
Allows components to have children. When a component has children, distribute those
children where the content tags are. For instance, with this usage:
{% highlight html %}
<x-foo><div>hello</div></x-foo>
{% endhighlight %}
The <code>&lt;div&gt;hello&lt;/div&gt;</code> will be placed within the
element's template where <code>&lt;content&gt;</code> was specified.
</td></tr>

<tr><td>
Selector in <a href="spec.html#appearance">content insertion</a>.
</td><td>
{% highlight html %}
<element name='x-foo'>
  <template>
    ...
    <content select='div'></content>
    <content></content>
{% endhighlight %}
</td><td>
Specifies which subset of a component's children are distributed in a particular
content tag. For instance, with this usage:
{% highlight html %}
<x-foo><span>one</span><div>two</div></x-foo>
{% endhighlight %}
The <code>&lt;div&gt;two&lt;/div&gt;</code> will be placed at the first
<code>&lt;content&gt;</code> insertion point (where div tags are selected), and
the <code>&lt;span&gt;</code> is added at the insertion point of the second
content tag.
</td></tr>

<tr><td>
<a href="spec.html#appearance">Base component insersion</a>.
</td><td>
{% highlight html %}
<element ... >
  <template>
    ...
    <shadow></shadow>
{% endhighlight %}
</td><td>
Embeds the content of a base component. When a component extends from another
component, The <code>&lt;shadow&gt;</code> tag is an insertion point where the
contents of the parent component are added.
</td></tr>

<tr><td>
<a href="spec.html#loading-components">Components inclusion</a>.
</td><td>
{% highlight html %}
<html ...>
  <head>
  <link rel="components" href="...">
  </head>
{% endhighlight %}
</td><td>
Imports component definitions. You can use within the body of the current HTML
page or within components defined in such page all components that were defined
in the file referred to by the <code>href</code> URL.
</td></tr>

<tr><td colspan="3">
<strong>Templating features</strong>
</td></tr>


<tr><td>
<a href="spec.html#binding-in-content">Text node data binding</a>.
</td><td>
{% highlight html %}<div>{{'{{'}}exp}}</div>{% endhighlight %}
</td><td>
Injects the value of evaluating <code>exp</code> in the document and watches for
changes. Any time a change to <code>exp</code> is detected, the UI is updated.
Values of the special type <code>SafeHtml</code> from <a
href="https://github.com/dart-lang/dart-web-components/blob/master/lib/safe_html.dart">
<code>package:web_components/safe_html.dart</code>
</a> are treated in a special manner.  If the value of <code>exp</code> is not
<code>SafeHtml</code>, the contents are converted to a string and are treated as
text (they will be escaped as safe html). Otherwise, if the value of
<code>exp</code> is a <code>SafeHtml</code>, the contents are injected directly
as an HTML fragment.
</td></tr>

<tr><td>
<a href="spec.html#binding-in-attributes">Attribute data binding</a>.
</td><td>
{% highlight html %}<td colspan="{{'{{'}}exp}}"></td>{% endhighlight %}
</td><td>
Binds the value of <code>exp</code> to the value of the attribute. Similar to
binding in text nodes, the expression is watched for changes and the element
attribute is updated accordingly. The type of the expression is treated
accordingly, so unsafe content is appropriately escaped as an attribute value.
</td></tr>

<tr><td>
<a href="spec.html#binding-in-attributes">Class attribute data binding</a>.
</td><td>
{% highlight html %}<div class="{{'{{'}}class1}} {{'{{'}}class2}}"></div>{% endhighlight %}
{% highlight html %}<div class="{{'{{'}}classesAsList}}"></div>{% endhighlight %}
{% highlight html %}<div class="{{'{{'}}classesAsString}}"></div>{% endhighlight %}
</td><td>
Binds the values to a class attribute. Similar
to attribute bindings, except that the system will be smart to update the class
list by adding and removing individual classes that change. It is valid to use
individual string variables (like, <code>class1</code>, <code>class2</code>),
specify a list of strings (like, <code>classesAsList</code>) or even specify a
string that separtes classes with
spaces (like, <code>classesAsString</code>). If any of these expressions is
null, it means that the class(es) represented by that expression are all
removed.
</td></tr>

<tr><td>
<a href="spec.html#binding-in-attributes">Style attribute data binding</a>.
</td><td>
{% highlight html %}<div class="{{'{{'}}exp}}"></div>{% endhighlight %}
</td><td>
Binds the value of <code>exp</code> to the value of a style attribute. Similar
to attribute bindings, except that <code>exp</code> is expected to be a map of
and the system will update the style of the node by treating the key-value pairs
in <code>exp</code> as a CSS property-value pairs.
</td></tr>

<tr><td>
<a href="spec.html#binding-interactive-elements">Two-way data binding</a> in interactive elements.
</td><td>
{% highlight html %}<input type="text"
       data-bind="value:property">{% endhighlight %}
{% highlight html %}<textarea data-bind="value:property">
</textarea>{% endhighlight %}
{% highlight html %}<input type="checkbox"
       data-bind="checked:property">{% endhighlight %}
</td><td>
Directly updates Dart properties with user input. Like data bindings in
attributes, this displays the latest value of a property in the element.
Additionally, when the element is updated due to UI interaction, the Dart
property is also updated and kept in sync.
</td></tr>


<tr><td>
<a href="spec.html#conditional-template">Conditional template node</a>.
</td><td>
{% highlight html %}
<template instantiate="if exp">
contents
</template>
{% endhighlight %}
</td><td>
Conditionally inserts contents if <code>exp</code> evaluates to true. The
contents of this tag will be appended in the location where the template tag is
located (not as children of such tag). It cannot be used to make a conditional
row or cell in a table, use conditional tag attributes instead.
</td></tr>

<tr><td>
<a href="spec.html#conditional-attribute">Conditional tag attribute</a>.
</td><td>
{% highlight html %}
<div template instantiate="if exp">
contents
</div>
{% endhighlight %}
{% highlight html %}
<table><tbody>
<tr>
  <td template instantiate="if showCell">
    contents
  </td>
</tr>
</tbody></table>
{% endhighlight %}
</td><td>
Conditionally adds the element to the DOM tree if the expression is true. This
can be used to make rows and cells conditionally visible.
</td></tr>

<tr><td>
<a href="spec.html#iterate-template">Iterating template node</a>.
</td><td>
{% highlight html %}
<template iterate="x in exp">
contents
</template>
{% endhighlight %}
</td><td>
Inserts contents for each item in <code>exp</code> (an iterable collection).
Contents will be appended in the location where the template tag is located (not
as children of such tag). It cannot be used to iterate over rows or cells in a
table, use iterating tag attributes instead.
</td></tr>

<tr><td>
<a href="spec.html#iterate-attribute">Iterating tag attribute</a>.
</td><td>
{% highlight html %}
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
{% endhighlight %}
</td><td>
Expands contents under the element, one per item in the collection that
<code>exp</code> evaluates to. This can be used to create rows and cells in
tables.
</td></tr>

<tr><td>
<a href="spec.html#event-listeners">Inline event listener</a>.
</td><td>
{% highlight html %}
<div data-action="click:myHandler">
contents
</div>
{% endhighlight %}
</td><td>
Binds a UI event to a Dart function. Whenever the event fires, the associated
function is executed and watchers are notified about possible changes.
<strong>Note</strong>: this syntax might change in the near future. See
<a href="spec.html#event-listeners">spec</a> for more details.
</td></tr>

</tbody></table>
