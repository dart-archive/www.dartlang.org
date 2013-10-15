---
layout: default
title: Working with forms
live_example_url: /docs/tutorials/forms/examples/slambook/out/web/slambook.html
header:
  css: ["/samples/samples.css"]
---

## {{ page.title }}


Enter some data and click the *Submit* button. The request gives you an innocent
stare and displays “No server” because you are not running the server on your
machine.

This example show how to use a form to collect data from a user.

A form usually contains several input elements for entering data of various
kinds, such as names and addresses, birthdays, email addresses, and so on.
HTML supports several kinds of input elements, including text fields, text
areas, radio buttons, and checkboxes. HTML5 adds more specialized input
elements such as email and password fields, color pickers, date and time
widgets, and range elements.

A form has an action, which is a URL to which to send the form data, and a
method, which indicates how the form data is to be sent. The action and the
method can be specified declaratively within HTML, or you can write Dart code
and use Dart libraries to perform the action programmatically.

Read this [tutorial](/docs/tutorials/forms) for
more detail, or read the
[source](https://github.com/dart-lang/dart-tutorials-samples/tree/master/web/slambook).

<iframe class="running-app-frame"
        style="height:400px;width:50%;"
        src="{{page.live_example_url}}">
</iframe>

See all [samples](/samples/)
