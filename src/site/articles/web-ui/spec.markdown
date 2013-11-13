---
layout: article
title: "Web UI Specification"
rel:
  author: siggi-cherem
description: "A detailed reference guide of how to use Web UI for declarative modern web apps."
has-permalinks: true
---
{% comment %}

See README comment in index.markdown for explanations on {{'{{'}}, \{\% raw \%\}
and \{\% codesample \%\}.

{% endcomment %}

{% include toc.html %}

# {{ page.title }}
{: .no_toc}

<aside class="alert alert-danger" markdown="1">
<strong>Web UI is deprecated.</strong>
Instead, use [Polymer.dart](/polymer-dart/),
which supersedes Web UI beginning with version 0.5
and provides many fixes and improvements.
We encourage Web UI users to upgrade to Polymer.dart.
The information on this page applies only to Web UI.
</aside>

_Written by Sigmund Cherem<br />
November 2012 (Updated February 2013)_

The Web UI package (Web UI for short) provides web components and templating to
help you write web applications at scale. This article contains a detailed
specification of Web UI's features. For a quick reference table of
these features, please refer to our [summary article](summary.html); for a
high-level introduction and examples, see our
[explainer article](/articles/web-ui/).

- - -

## Components

The appearance and behavior of a web component is encapsulated as a
[custom HTML element][wc]. This section describes how to declare them, shows how
to use them, and gives some insights about how they work.


### Declaration

Dart web components are declared using custom elements, which are introduced
with the `<element>` tag. You can put an `<element>` tag anywhere under the
`<body>` tag of an HTML page. The attributes and children of an element tag
describe the component in detail.

An element tag accepts the following attributes, some of which are mandatory:

| | Attribute             |  | Required? |  | Description   |
|-| :------------         |- | :-------- |- | :-------  |
| | `name`                |  | required  |  | The component's tag name.
| | `extends`             |  | required  |  | DOM element or other component that this component refines. |
| | `constructor`         |  | optional  |  | Dart type associated with the component. |
| | `apply-author-styles` |  | optional  |  | Whether styles from the document apply to the contents of the component. |
|=| ===============       |= | ========= |= | ========  |

An element tag can have the following children (at most one of each):

| | Child                              |  | Required? |  | Description   |
|-| :------------                      |- | :-------- |- | :-------  |
| | `<template>`                       |  | required  |  | The visual appearance of the component. |
| | `<script type='application/dart'>` |  | optional  |  | The component's behavior written in Dart  |
| | `<style>`                          |  | optional  |  | Any scoped style that applies only to the component's appearance. |
|=| ===============                    |= | ========= |= | ========  |

Note that these attributes and children match the [web components
specification][wcappendix].

The `name` attribute in the element tag declaration defines the actual tag name
associated with the component. This name can later be used to
[instantiate a component](#instantiation) in your markup. These tag names are
part of the same namespace as normal markup tags. To avoid collissions, we
require that tag names start with an `x-` prefix, for instance `x-my-button`.

The `constructor` attribute is optional. When it is not specified its value is
inferred as the CamelCase name associated with the name attribute without the
`x-` prefix. For instance, the inferred constructor for `x-my-button` is
`MyButton`.

Let's discuss the rest of these attributes and children in more detail as we
discuss the appearance and behavioral aspects of a component.

<aside>
<div class="alert alert-info">
<strong>Status:</strong> It should be allowed to declare element tags anywhere,
not just in the body of an HTML page. See
<a href="https://github.com/dart-lang/web-ui/issues/197">Issue
#197</a> for details.
</div>
</aside>

#### Appearance

Every component inherits from existing tags.
This includes tags corresponding to
standard DOM elements or previously defined components. For example, you can
extend `div`, `span`, `button`, `x-my-button`, etc. The base tag for the
component is specified in the `extends` attribute. The idea is that a component
can override and compose the appearance and behavior of its base tag. It is a
common practice to use `span` as the base tag if you intend to define the
entire appearance of a component yourself.

A component's `<template>` tag declares the HTML fragment that will be rendered
when the component is instantiated. When possible, this fragment will be
encapsulated using [Shadow DOM][sd]. Within a `<template>` it is valid to:

  * use standard HTML elements
  * use other [component tag names](#declaration)
  * use [templating features](#template-syntax) (described further below)
  * use the `<content>` element for [composition][content-el]
  * use the `<shadow>` element for [extension][shadow-el]

The `<content>` tag, combined with [CSS selectors][css],
lets you control how to
distribute child nodes provided at the component's
[instantiations](#instantiate).
The `<shadow>` tag is useful when extending from
other components. It allows you to inject within your template the contents of
the parent's component. Web UI follows the same [composition rules][composition]
as the Shadow DOM spec for both `<content>` and `<shadow>` tags.

A component's `<style>` tag contains scoped CSS rules that are only applicable
in the context of the component's `<template>` body. If the attribute
`apply-author-styles` is present in the element tag declaration, then author
style rules from the document will also apply within the template (even if
Shadow DOM is available).

<aside>
<div class="alert alert-info">
<strong>NOTE:</strong> scoped <code>style</code> is not supported yet in the
current implementation of the the Web UI compiler, and a lot of details are
missing in this specification. Learn more at the <a
href="http://dvcs.w3.org/hg/webcomponents/raw-file/tip/spec/shadow/index.html#styles">web
components specification article</a>.
</div>
</aside>

#### Behavior

The behavior of a component is declared directly in Dart code. The `<script>`
tag declares the code associated with the component.
It must be specified unless
a component has no behavior and its code can be assumed to be an empty class.
If the tag is present, it must use the `type="application/dart"` attribute to
indicate that the code is written in Dart.

Whether you write code inline or you include it via a `src` attribute, the code
must be a valid Dart library. In such a library you must define a class
corresponding to the component. The name of this class must match the name
specified by the `constructor` attribute. For example,

{% prettify html %}
<element name='x-my-friend' constructor='AName'>
 ...
 <script type='application/dart'>
   ...
   // name matches constructor attribute
   class AName extends WebComponent { ... }
 </script>
</element>
{% endprettify %}

but if the constructor attribute was omitted, you must use the name inferred
from the tag name, for example,

{% prettify html %}
<element name='x-my-friend'>
 ...
 <script type='application/dart'>
   ...
   // contructor attribute omitted, name inferred from tag name.
   class MyFriend extends WebComponent { ... }
 </script>
</element>
{% endprettify %}

Currently the component's Dart class must be a subclass of `WebComponent` from
`package:web_ui/web_ui.dart`.

<aside>
<div class="alert alert-info">
In the future the Dart class defining a component will
extend directly from an HTML type, instead of extending from WebComponent, for
example <code>MyButton extends ButtonElement</code>.
</div>
</aside>


### Instantiation

Components can be instantiated declaratively or programatically. Consider a
component declared as:

{% prettify html %}
<element name="x-foo" extends="span" constructor="FooComponent">
 ...
{% endprettify %}

You can instantiate such component in the following three ways:

  * use the element's name as a tag. For example, use `<x-foo></x-foo>` in your
    HTML. **Note**: Components are treated as [semantically
    neutral](http://dev.w3.org/html5/spec/infrastructure.html#other-applicable-specifications)
    by the HTML parser. They are not treated as [void
    elements](http://dev.w3.org/html5/spec/syntax.html#void-elements) even if
    they extend a void element. This means you should use an end tag to avoid
    HTML [parse errors](http://dev.w3.org/html5/spec/parsing.html#parse-error).

  * use a `<span is="x-foo"></span>` tag in your HTML. More specifically, create
    the node that is being extended (`span` in this case) and include an `is`
    attribute indicating the name.

  * create the component programatically in Dart. We don't recommend using
    this approach because it requires several set up steps. Ultimately this
    should be easier when components can directly subclass elements in the Dart
    type hierarchy.  If you wish to do so, [this
    test](https://github.com/dart-lang/web-ui/blob/master/test/data/input/component_created_in_code_test.html#L28)
    shows an example of how to do so. Basically we:
      * create the component instance, for instance `c = new MyComponent()`
      * create a host element and associate it with your component, for
        instance `c.host = new SpanElement()`
      * update any fields in your component that need to be initialized (like
        fields used in [data bindings](#data-bindings))
      * use a lifecycle helper to initialize the component, for instance
       `helper = new ComponentInfo(c)..create();`
      * insert the host node to the DOM tree
      * call the `helper.insert()` on your lifecycle helper.

    When components extend directly from DOM elements you'll be able
    to add a component directly in the DOM tree without creating a host element
    by hand.

<aside>
<div class="alert alert-info">
<strong>Open issues</strong>: we strongly would like to completely hide any
pieces that are autogenerated. This explanation should also be simpler once we
add a runtime library for constructing components programatically. For more
details see <a
href="https://github.com/dart-lang/web-ui/issues/93">issue #93</a>.
</div>
</aside>

### Retrieval

You can reach a component instance using the `xtag` property of the
associated HTML element. For example, if you create a tag as `<x-foo
id="example"></x-foo>` in the top-level body of your page, you can get an
instance of the component by calling `document.query('#example').xtag`.

Note that `xtag` only works after an application is initialized and web
components have been created. In particular, the `xtag` will be null when the
main script of an application just started running, but will be available at the
end of the event loop. See the [main script section](#main-script) for more
details.

<aside>
<div class="alert alert-info">
<strong>Note</strong>: The `xtag` field will not be needed in the future when
components extend directly from HTML elements.
</div>
</aside>

### Template lexical scope {#template-scope}

There is a strong connection between a components's script and a component's
template.
Data bindings and other [templating](#template-syntax) features inside
the `<template>` tag can contain expressions and references to functions.
Unlike templates in model driven views ([MDV][mdv]), Web UI uses
[lexical scoping rules][dart-scope-rules] to determine the meaning of these
expressions and symbols. In particular, template binding expressions will be
interpreted as a lexical part of the component class definition. For instance,
consider the following example:

{% prettify html %}
{% raw %}
<element name='x-example'>
 <template>{{foo}} {{bar}}</template>
 <script type='application/dart'>
   var foo = 'foo top-level';
   var bar = 'bar top-level';
   class Example extends WebComponent {
     var foo = 'foo class-level';
   }
 </script>
</element>
{% endraw %}
{% endprettify %}

The expressions `{{'{{'}}foo}}` and `{{'{{'}}bar}}` are valid [Dart
expressions][dart-expressions] and are evaluated as if you
wrote them inside a method of the class `Example`. In this case, the template
will display the value `foo class-level` and `bar top-level`.


### Lifecycle methods

A component class exposes public methods to attach hooks to lifecycle events of
the component.
These special callback methods are invoked during the lifetime of a Dart web
component. These methods are defined as part of the `WebComponent` class, and
you can override them to run code at those lifecycle events. These special
lifecycle methods are:

| | Method             |  | When will it be invoked?
|-| :------------      |- | :-------- |- | :-------  |
| | `created`          |  | Invoked slightly after a component is created. |
| | `inserted`         |  | Invoked whenever a component is added to the DOM. |
| | `attributeChanged` |  | Invoked whenever an attribute in the component changes. |
| | `removed`          |  | Invoked whenever a component is removed from the DOM |
|=| ===============    |= | ========= |= | ========  |

<aside>
<div class="alert alert-info">
<strong>Status:</strong> <em>attributeChanged</em> is not supported yet. See
<a href="https://github.com/dart-lang/web-ui/issues/90">Issue
#90</a>.
</div>
</aside>

## Template Syntax

Templates provide a declarative syntax to create applications that follow a
model-view-viewmodel (MVVM) architecture.
In this architecture, applications use
models to hold data, view-models adapt the model to a friendly representation
to display to the end user, and views reflect the latest changes to the model
and view-model in the UI.

The declarative syntax of templates gives developers an easy way to express how
views bind data from the model and view-model. This makes it possible to
simplify dramatically how to keep the views in sync with the data, which
sometimes can be done completely automatically.

Just like [MDV][mdv] templates, our template syntax is valid HTML. Hence, it is
always processed first as HTML. Within the HTML content, special text nodes and
attributes can be used to add more semantic meaning to the template.  This
section discusses these special features in detail.

### Data binding

Data bindings concisely describe the relation between portions of the document
and Dart expressions.
Bindings can be used to indicate that some HTML content or
attributes should be rendered with the result of evaluating a Dart expression.
They can also be used to indicate that we wish to watch Dart expressions and
reactively update the document whenever the expressions change. Alternatively,
bindings can also be used to update Dart properties with the latest value in an
interactive element, such as input boxes and text areas.

If data bindings are used within a component, the associated Dart expressions
are resolved in the scope of the class associated with the component (see more
details [above](#template-scope)). If data bindings are used directly on
the body of an HTML page, these expressions are evaluated in the context of the
main script associated with that page (more details
[later](#top-level-templates)).

#### Binding in content

You can introduce a data binding in a text node
by using expressions of the form
`{{'{{'}}exp}}` as nodes in your HTML. For example, a component with the
following template:

{% prettify html %}
{% raw %}
<element name='x-example2'>
 <template><span>one {{x}} tree</span></template>
 <script type='application/dart'>
   class Example2 extends WebComponent {
     String x = 'two';
   }
 </script>
</element>
{% endraw %}
{% endprettify %}

will render as `<span>one two three</span>`. At runtime, `x` will be
[watched](#watchers) for changes.
When changes are detected, the contents of the
page will be updated in place.

You can use any valid Dart expression inside the double brackets `{{'{{'}} ...
}}`. While any expression is allowed, it is good practice to use expressions
that have no visible side-effects. In particular, binding expressions will
be evaluated to render your application, and sometimes they might be evaluated
more than once in a single event cycle. If your expression has visible
side effects, those changes might trigger more updates in the document
than what you initially intended to happen.

The program generated by the Web UI compiler will evaluate a
binding expression to a value,  call [`toString()`][tostring] on it and place
the result as a text node where the binding was found. This means that if your
content has some HTML tags in it, the content is automatically escaped. For
instance, if we use `x='<span>two</span>'`, the result will be `<span>one
&lt;span&gt;two&lt;/span&gt; three</span>`

On occasions, you may want to inject HTML fragments directly in the page.
You can do so by creating an instance of `SafeHtml` (see 
[`package:web_ui/safe_html.dart`][safehtml]). If your content happen to
be an instance of `SafeHtml`, then the data will not be escaped.

**Note:** Use `SafeHtml` carefully. In particular, you can easily
make your application exploitable through cross-site scripting (XSS) attacks if
you allow arbitrary user data to be placed unescaped in your page. In practice,
you should only use it when you know that the HTML is valid and safe.

<aside>
<div class="alert alert-info">
<strong>Status:</strong> `SafeHtml` is available but very primitive at this
point. This type should evolve,
and maybe one day it could be integrated as part
of the `dart:html` APIs.
</div>
</aside>

#### Binding in attributes

You can also use `{{'{{'}}expression}}` bindings in the middle of HTML
attributes. An attribute written as `foo="{{'{{'}}exp}}"` will be initialized
with the value of `exp`. Like bindings in content nodes, expressions are
[watched](#watchers) for changes and attributes will be updated in place when
expressions' changes are detected.  At runtime, attribute values will be updated
using an assignment directly on the HTML element property corresponding to that
attribute. Bindings of the form `attribute="{{'{{'}}exp}}"` are assigned
directly, however bindings of the form `attribute="abc {{'{{'}}exp}} xyc"` will
perform string interpolation.

It is perfectly valid to use bindings to set and update boolean attributes.
Without data-bindings a tag such as `<input type="checkbox"
disabled="false">` will be disabled.  The value "false" is ignored by browsers
and the only two ways to make the element enabled is to remove the `disabled`
attribute or to programatically set the `disabled` property on the element to
false. When you use attribute bindings you can simply write: `<input
type="checkbox" disabled="{{'{{'}}exp}}">`. At runtime this will create the
element with the disabled attribute, but the property will be assigned the value
of `exp` immediately after. If `exp` is false, the element will be enabled.

You can use bindings in any kind of attribute, but there are some additional
features available for class and style attributes.

* class attributes: A common use of data bindings in attributes is to select
  classes to attach to an element. You can bind a single class attribute by
  binding a getter to the property defining your class. For example,

{% prettify html %}
{% raw %}
<element name='x-example2'>
 <template><span class="{{class1}}"></span></template>
 <script type='application/dart'>
   class Example2 extends WebComponent {
     String class1 = 'pretty';
   }
 </script>
</element>
{% endraw %}
{% endprettify %}

  In this example, if you update `class1` to null or an empty string, when the
  associated watcher detects this change it will remove the previous value
  (`'pretty'`) from the element.

  You can bind multiple class attributes in several ways: by returning a list
  of values in your expression, by returning a string with multiple classes
  separated by spaces, or by writing multiple bindings in the same class
  attribute. For example, suppose you want to bind 2 CSS class variables,
  `class1` and `class2`, on an element. The tree alternatives would look as
  follows:

{% prettify html %}
{% raw %}
<element name='x-example2'>
 <template>
  <!-- bind classes with a list -->
   <span class="{{classesAsList}}"></span>

  <!-- bind classes with a string -->
   <span class="{{classesAsString}}"></span>

  <!-- bind classes separately -->
   <span class="{{class1}} {{class2}}"></span>
 </template>
 <script type='application/dart'>
   class Example2 extends WebComponent {
      String class1 = 'pretty';
      String class2 = 'selected';
      List<String> get classesAsList => [class1, class2];
      String get classesAsString =>
        "${class1 != null ? class1 : ''} "
        "${class2 != null ? class2 : ''}";
      ...
   }
 </script>
</element>
{% endraw %}
{% endprettify %}


* style attributes: you can pass either a `String` or a `Map<String, String>` as
  a binding to `style` attributes. When using a map, we track changes to
  the map keys and values and update actual style of the element accordingly.

#### Binding interactive elements

Bindings can also be used to monitor user modifications on interactive elements,
such as input boxes, text areas, and radio buttons. We do so by binding an
interactive element with a Dart assignable value, such as a field or a property
with a getter and setter. Unlike the bindings we discussed above, these bindings
operate in two directions: changes in the Dart value are reflected in the UI,
but also changes from the user in the UI are reflected directly in the Dart
value. Because of their bidirectional nature, we refer to these bindings as
_two-way data bindings_. Two-way data bindings are expressed with an attribute
of the form `bind-property="assignableValue"`, where _property_ is the
associated property in the HTML element that we are monitoring, and
_assignableValue_ is a Dart assignable value. This is the current list of
two-way bindings supported by Web UI:

| | Interactive element          |  | Attribute      |  | Description                                |  | Event that triggers an update |
|-| :-----------                 |- | :--------      |- | :-------                                   |- | :------ | 
| | `<textarea>`                 |  | `value`        |  | The current value in the textarea element  |  | `input`  |
| | `<input type="text">`        |  | `value`        |  | The current value in the input box         |  | `input`  |
| | `<input type="checkbox">`    |  | `checked`      |  | Whether the checkbox is checked            |  | `change` |
| | `<input type="radio">`       |  | `checked`      |  | Whether a radio button is checked          |  | `change` |
| | `<input name="group" type="radio" value="option">`       |  | `value`        |  | Whether a value matches the radio button's value |  | `change` |
| | `<select>`                   |  | `selected-index`|  | Selected option index on the dropdown list |  | `change` |
| | `<select>`                   |  | `value`        |  | Selected option value on the dropdown list |  | `change` |
|=| ===============              |= | =========      |= | ========                                   |= | == |

Under the hood two-way bindings are implemented by using a [watcher](#watchers)
to watch for changes in Dart that will trigger updates in the corresponding HTML
element property, and a [UI event listener](#event-listeners) that will react to
user interactions and update the corresponding Dart assignable value.

Although most two-way bindings copy contents between an HTML element property
and a Dart value without doing any processing of the data, one special binding
on radio buttons behaves differently. Radio buttons can be grouped together by
name, so only one button in a group is selected at a time. You can track which
element is seleceted in two ways: you can bind each radio button to a boolean
flag, or you can bind all radio buttons in a group to a single Dart value. The
following example illustrates how to do both. Note that in this example both
groups behave exactly the same way.

{% prettify html %}
{% raw %}
<element name='x-example2'>
 <template>
   <input name="a" type="radio" value="one" bind-value="groupValue">One
   <input name="a" type="radio" value="two" bind-value="groupValue">Two

   <input name="b" type="radio" value="one" bind-checked="oneSelected">One
   <input name="b" type="radio" value="two" bind-checked="twoSelected">Two
 </template>
 <script type='application/dart'>
   class Example2 extends WebComponent {
      var groupValue = "one";

      bool get oneSelected => groupValue == 'one';
      bool get twoSelected => groupValue == 'two';
      set oneSelected(v) { groupValue = 'one'; }
      set twoSelected(v) { groupValue = 'two'; }
   }
 </script>
</element>
{% endraw %}
{% endprettify %}

<aside>
<div class="alert alert-info">
  <strong>Status:</strong> More interactive elements need to be supported.
</div>
</aside>



#### Watchers

As hinted in the previous sections, data bindings are reactive. We would like
the UI to be updated automatically whenever a Dart expression used in a data
binding changes. Watchers provide a way to implement this functionality. Their
implementation is available under `package:web_ui/watcher.dart`. For
each expression used in a data binding, we create a watcher. These watchers are
inactive until the special method `dispatch` in the watcher's library is
invoked. The `dispatch` method will iterate over all active watchers and fire
events on any watcher whose value has changed.

Web UI automatically adds call to `dispatch` on two-way data bindings and at the
end of [inlined UI event listeners](#event-listeners).  If a change made in your
data doesn't automatically appear in the UI, it is very likely that a call to
`dispatch` is missing. Here are common situations where you need to invoke
`dispatch` by hand:

* If you install event listeners manually via the `dart:html` API.
* If you make data changes that happen after an asynchronous API call, for
  example: after receiving the results of an `HttpRequest`, or after working
  with a local database API.


<aside>
<div class="alert alert-info">
<strong>Status:</strong> We are looking at alternatives to automatically call
dispatch or change how watchers are implemented so that you don't need to
manually write any of the additional calls above.  See <a
href="https://github.com/dart-lang/web-ui/issues/156">Issue
#156</a> for more details.

</div>
</aside>

### Conditionals

Portions of the template can be conditionally hidden using template
conditionals. Web UI supports two different ways to express conditionals. You
can make a document fragment conditionally visible by declaring it within a
conditional `<template>` element node, or you can make an element and its
children conditionally visible by using a conditional attribute
in the element. Next, we discuss each of these approaches and when it is
appropriate to [use one or the other](#which-conditional).

#### The conditional element node {#conditional-template}

A template conditional element is a `<template>` tag containing a special
attribute of the form `instantiate="if expression"`, where `expression` is a
valid Dart expression, just like any [data binding expression](#data-binding).
Alternatively, instead of `instantiate="if exp"` you can write `if="exp"`.

<aside>
<div class="alert alert-info">
<strong>Note:</strong> 
The final syntax for conditionals is not finalized. In particular, currently
only <code>instantiate="if ..."</code> is part of the MDV specification.
However, Web UI supports both <code>instantiate="if ..."</code> and
<code>if="..."</code> and it will later provide feedback whenever one is
deprecated in favor of the other.
</div>
</aside>

Consider this concrete example:

{% prettify html %}
Unconditional portion 1
<!-- a template conditional -->
<template instantiate="if exp">
 this <div>is sometimes <strong>shown</strong></div> here
</template>
Unconditional portion 2
{% endprettify %}

If `exp` is `true`, then the contents of the tag will be displayed,
otherwise, they will not be rendered altogether. In particular, if there were
additional data bindings under the conditional node, those binding expressions
will only be evaluated when `exp` is  true.

At runtime, the HTML generated for a template using a conditional will have an
invisible placeholder that indicates where was this conditional initially
declared, then if the condition is true, the contents of the template node will
be appended as siblings of this placeholder.

The Web UI compiler uses a shallow clone of the original template node as the
invisible placeholder. For example, this is how the tree looks when the
condition is false in our example above:

{% prettify html %}
Unconditional portion 1
<!-- the next tag is an invisible placeholder -->
<template instantiate="if exp" style="display:none"></template>
Unconditional portion 2
{% endprettify %}

When the condition becomes true, the HTML tree will look as follows:

{% prettify html %}
Unconditional portion 1
<!-- the next tag is an invisible placeholder -->
<template instantiate="if exp" style="display:none"></template>
this
<div>
  is sometimes <strong>shown</strong>
</div>
here
Unconditional portion 2
{% endprettify %}

Note that the contents of the initial template are not within the template
tag anymore, they got added directly as siblings. This behavior is
intentional. Template nodes are intended to be inert, and they are mainly used
as a declaration. This matches closely the semantics of [MDV][mdv] templates.

A benefit of this semantics is that the resulting HTML is often closer to 
what the developer intended to say. For example, a template of the form:

{% prettify html %}
<ul>
  <li> item 1
  <template instantiate="if showItem2">
    <li> item 2
  </template>
</ul>
{% endprettify %}

Will be rendered so that all `<li>` elements are direct children of the `<ul>`
element:

{% prettify html %}
<ul>
  <li> item 1
  <template instantiate="if showItem2" style="display:none"></template>
  <li> item 2
</ul>
{% endprettify %}

As an app developer, you must know these rendering decisions because it may
affect parts of the application logic, like CSS selectors. The current approach
has the advantage that parent/child relationships are preserved if you add a
conditional in the middle of your template. Note, however, that the extra
placeholder node can still affect positional selectors like matching the _nth_
child of a node.

**Note**: the `<template>` tag has multiple uses in this specification: it is
used to declare the appearance of a component and it can be used to declare
conditionals and loops. It is mandatory to use separate tags for each intended
use. In particular, the first example below is valid, but the second is invalid:

{% prettify html %}
{% raw %}
<element name='x-example'>
 <template>
   <template instantiate="if true">this is valid</template>
 </template>
</element>
{% endraw %}
{% endprettify %}

{% prettify html %}
{% raw %}
<element name='x-example'>
 <!-- invalid: we need an extra template here. -->
 <template instantiate="if true">this is invalid</template>
</element>
{% endraw %}
{% endprettify %}

#### The conditional attribute. {#conditional-attribute}

An alternative syntax to create conditional content is to use a conditional
attribute on an arbitrary element. This is especially useful in contexts where
you are not allowed to insert a `<template>` element (such as tables).

You can express a conditional by adding two attributes to any element, an empty
`template` attribute, and a `instantiate="if ..."` attribute. For example, in
the following code, `item 2` will only be visible if `showItem2` is true.

{% prettify html %}
<ul>
  <li> item 1
  <li template instantiate="if showItem2"> item 2
</ul>
{% endprettify %}

<aside>
<div class="alert alert-info">
<strong>Note:</strong> In the future a single attribute will be enough, we
intend to remove the extra <code>template</code> attribute.
</div>
</aside>

The runtime semantics of these conditionals is similar, but not quite the same
as conditional `<template>` elements. Like before, an invisible placeholder is
added to the tree regardless of the condition being true or false. Instead of a
template node, the HTML will have an empty clone of the element annotated with
the condition. When the condition is true, the actual element itself is added
(with the template attribute removed). For instance, the following shows the
rendered tree when the condition is true in the example above:

{% prettify html %}
<ul>
  <li> item 1
  <!-- the next tag is an invisible placeholder -->
  <li template instantiate="if showItem2" style="display:none"></li>
  <li> item 2
</ul>
{% endprettify %}

And the following shows the rendered tree when the condition is false:

{% prettify html %}
<ul>
  <li> item 1
  <!-- the next tag is an invisible placeholder -->
  <li template instantiate="if showItem2" style="display:none"></li>
</ul>
{% endprettify %}

<aside>
<div class="alert alert-info">
<strong>Note:</strong> These semantics might change in the near future. The
placeholder in this case seems redundant when the condition is true - we could
simply reuse the placeholder node to render the contents within it.
</div>
</aside>

#### Conditional element vs. attribute {#which-conditional}

The main difference between conditional template nodes and conditional
attributes is that the former makes the contents of the template node
conditionally visible, while the latter makes the actual node conditionally
visible.

This difference is especially noticeable when making plain text nodes
conditionally visible. For example, the following template:

{% prettify html %}
<div> a <template instantiate="if exp">c</template> b </div>
{% endprettify %}

will be rendered such that `c` is a direct child of `<div>`:

{% prettify html %}
<div> a <template style="display:none"></template> c b </div>
{% endprettify %}

This cannot be expressed using conditional attributes. If you were to use
conditional attributes, you would be forced to introduce a DOM node that will
wrap `c`:

{% prettify html %}
<div> a <span instantiate="if exp">c</span> b </div>
{% endprettify %}

which will render as:

{% prettify html %}
<div> a <span style="display:none"></span> <span>c</span> b </div>
{% endprettify %}

Another subtle difference derives from the fact that templates are
syntactically valid HTML. The HTML5 parsing algorithm has very strict rules
about where you can use certain element types.
In particular, `<template>` nodes
cannot occur within tables, and the parsing algorithm move these template nodes
somewhere else. This also happens in the Web UI compiler, which uses an HTML5
compliant parser. For example, if you write:

{% prettify html %}
<table><tbody>
<template instantiate="if showRow"><tr><td> row </td></tr></template>
</tbody></table>
{% endprettify %}

This is transformed by HTML parsers as if you had written the template outside
of the table:

{% prettify html %}
<template instantiate="if showRow"><tr><td> row </td></tr></template>
<table><tbody>
</tbody></table>
{% endprettify %}

We can express our intent of conditionally hiding a row using conditional
attributes as follows:

{% prettify html %}
<table><tbody>
<tr instantiate="if showRow"><td> row </td></tr>
</tbody></table>
{% endprettify %}

### Loops

Loops make it possible to iterate over a collection and repeat portions of a
template with each iteration. Just like [conditionals](#conditionals),
there are
also 2 ways to express loops.
You can repeat a fragment by declaring it within a
iterate `<template>` element node, or you can repeat the body of an element by
using an iterate attribute on the element.

#### The iterate element node {#iterate-template}

A template iterate element is a `<template>` tag containing a special attribute
of the form `iterate="identifier in expression"`, where `expression` evaluates
to a collection, and `identifier` is a new variable that will be visible to the
body of the iterate element. For instance, in the following example:

{% prettify html %}
{% raw %}
<ul>
  <li> header
  <!-- a template iteration -->
  <template iterate="x in list">
    <li> before {{x}}
    <li> {{x}}
  </template>
  <li> footer
</ul>
{% endraw %}
{% endprettify %}

the expression `list` is evaluated to a collection. For each element in the
collection, there will be 2 `<li>` tags in the generated HTML.

The runtime semantics of loops has a lot of similarities with conditionals.
At runtime,
the HTML generated for this template will have an invisible placeholder
indicating where the loop starts, the repeated content is appended directly
after this placeholder node.

For example, `list` is `['one', 'two', 'three']` then the rendered HTML will
look as follows:

{% prettify html %}
<ul>
  <li> header
  <!-- invisible placeholder -->
  <template iterate="x in list" style="display:none"></template>
  <li> before one
  <li> one
  <li> before two
  <li> two
  <li> before three
  <li> three
  <li> footer
</ul>
{% endprettify %}

See the sections above on [conditionals](#conditionals) for more details on why
children of the template node are appended directly as siblings of the
placeholder node, and to understand what implications this has during app
development.

#### The iterate attribute {#iterate-attribute}

An alternative syntax to do template iterations is
to use an `iterate` attribute
directly on an element. This is especially useful to iterate on table rows or
columns, where you are not allowed to use `<template>` tags.

The runtime semantics of iterate attributes are different than iterate template
nodes. The placeholder node and the iteration element are basically the same.
The node is always present, but its contents are modified depending on the
values found in the collection. For example, the following template:

{% prettify html %}
{% raw %}
<ul template iterate="x in list">
  <li> before {{x}}
  <li> {{x}}
</ul>
{% endraw %}
{% endprettify %}

will be rendered as follows when `list` has the following value `['one', 'two',
'three']`:

{% prettify html %}
<ul>
  <li> before one
  <li> one
  <li> before two
  <li> two
  <li> before three
  <li> three
</ul>
{% endprettify %}

<aside>
<div class="alert alert-info">
<strong>Note:</strong> In the future a single attribute will be enough, we
intent to remove the extra <code>template</code> attribute.
</div>
</aside>

#### Iterate element vs. attribute {#which-loop}

The main difference between iterate template nodes and iterate attributes is
that the former appends the repeated contents
as siblings of the iteration node,
while the latter appends them as children of
the element containing the iterate attribute.

This difference is especially noticeable when you want to create a list with a
header and a footer. This is supported by template nodes as follows:

{% prettify html %}
{% raw %}
<ul>
  <li> header
  <template iterate="x in list">
    <li> item {{x}}
  </template>
  <li> footer
</ul>
{% endraw %}
{% endprettify %}

but it cannot be expressed using iteration attributes.

Because HTML parsering algorithm moves `<template>` nodes outside tables, they
cannot be used to iterate over `<tr>` or `<td>` elements.
Here again, similar to
conditional attributes, iteration attributes can be used in this context. For
example:

{% prettify html %}
{% raw %}
<table>
  <tbody iterate="row in rows">
  <tr iterate="cell in row">
    <td> {{cell}} </td>
  </tr>
  </tbody>
</table>
{% endraw %}
{% endprettify %}

<aside>
<div class="alert alert-info">
<strong>Status:</strong>
Tables always have a <code>&lt;tbody&gt;</code>, and if
instead you use the iterate attribute in <code>&lt;table&gt;</code>
the Dart web
component compiler will think that you intend to repeat the table body multiple
times. This needs to be fixed.
</div>
</aside>


### Event listeners

Templates also have a concise syntax to bind a Dart event handler with a
UI event. These can be expressed today using an attribute of the form
`on-event-name="action"`. For example, the following code will listen for click
events on the `div` element, on each click the function `handleClick` will be
called:

{% prettify html %}
{% raw %}
<element name='x-example3'>
  <template><div on-click="handleClick($event)">click me</div></template>
  <script type='application/dart'>
    class Example3 extends WebComponent {
      handleClick(Event e) { ... }
    }
  </script>
</element>
{% endraw %}
{% endprettify %}

The name for the `on-` attributes is the hyphenated version of the Dart name
associated with the event in `dart:html`,
which is what you would normally write
in calls of the form `elem.onSomeEvent.listen(eventListener)`. For example, the
attribute for the `doubleClick` event is `on-double-click`. See the API docs for
[Element][elemevents] for a complete list of event names.

The action written in the attribute value can be any valid Dart expression, but
typically is a method invocation. This expression is evaluated using lexical
scoping just like any [data binding expression](#data-binding). A special
variable `$event` is added to the scope of this expression to refer to the HTML
event that was fired.

At runtime, when the event is fired, the handler will be invoked followed
immediately after by a call to `dispatch` that notifies watchers about data
changes.


## Web apps

To create modern web applications, use web components and templates as
building blocks and put it all together with HTML pages. The main HTML file for
a web app can declare components directly, load components from other files,
declare the main Dart script, and even use templating features directly in the
HTML body.

### Declaring components

We mentioned earlier that components are declared using the `<element>` tag.
You can write many of these tags in a page,
but only directly under the `<body>`
element. For example,

{% prettify html %}
<html>
  ...
  <body>
  <element name='x-example1'>...</element>
  <element name='x-example2'>...</element>
  ...
{% endprettify %}

You can then either use these components directly in your page
or load this file
from other HTML files. In essence, an HTML file works like a library that
bundles web components.

### Loading components

Web components defined in an external HTML file can be loaded with a `<link>`
tag in the HTML header. For example,

{% prettify html %}
<html>
  <head>
    <link rel="import" href='otherfile.html'>
  </head>
...
{% endprettify %}

Loading such file allows you to use the loaded components directly in the body
of the page or within a component declaration.

### Main script

Like with other dart web apps, the main entry point of your app has top-level
script (either inlined or sourced) which starts everything. For instance,

{% prettify html %}
<html>
  <body>
    ...
    <script type='application/dart'>
      main() {
        ...
      }
    </script>
  </body>
</html>
{% endprettify %}

Only one script tag loading Dart code is allowed in a single page. Similar to
script tags in component declarations, this script tag is optional. If all the
behavior of your application is already initialized and defined with your
components, you can omit this script tag and the Web UI compiler
will automatically generate a standard one.

Within your main script, you can query for DOM elements that you had initially
written in the page. However, you cannot query for children of conditional and
iteration nodes.

The initialization of web components is done after `main` is executed, but
before the end of the event loop. If you query in `main` for the element
associated with a component, its `xtag` will be null. To [retrieve a component
instance](#retrieval) you need to defer queries until the end of the event loop,
for example using a `Timer.run(f)`.

### Top-level templates

The same template features we described earlier in this article can be used in
the body of your HTML page. One important distinction here is how data bindings
are evaluated. We discussed earlier that templates in a component are evaluated
in the context of the [component's class](#template-scope), here the templates
are evaluated in the top-level context of the main script.

[composition]: http://dvcs.w3.org/hg/webcomponents/raw-file/tip/spec/shadow/index.html#composition
[content-el]: http://dvcs.w3.org/hg/webcomponents/raw-file/tip/spec/shadow/index.html#content-element
[css]: http://www.w3.org/TR/selectors/
[dart-expressions]: http://www.dartlang.org/docs/spec/latest/dart-language-specification.html#h.dz8ekoegseec
[dart-scope-rules]: http://www.dartlang.org/docs/spec/latest/dart-language-specification.html#h.jb82efuudrc5
[project]: https://github.com/dart-lang/web-ui/
[mdv]: http://code.google.com/p/mdv/
[sd]: http://dvcs.w3.org/hg/webcomponents/raw-file/tip/spec/shadow/index.html
[shadow-el]: http://dvcs.w3.org/hg/webcomponents/raw-file/tip/spec/shadow/index.html#shadow-element
[wc]: http://dvcs.w3.org/hg/webcomponents/raw-file/tip/explainer/index.html
[wcappendix]: http://dvcs.w3.org/hg/webcomponents/raw-file/tip/explainer/index.html#appendix-b-html-elements
[tostring]: http://api.dartlang.org/docs/bleeding_edge/dart_core/Object.html#toString
[safehtml]: https://github.com/dart-lang/web-ui/blob/master/lib/safe_html.dart
[elemevents]: http://api.dartlang.org/docs/releases/latest/dart_html/Element.html
