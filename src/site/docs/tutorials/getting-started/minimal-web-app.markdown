---
layout: default
title: "A Minimalist Web App"
description: "Describes the files of a basic web app and the DOM"
tutorial:
  id: gs-mini-web
---

{% capture whats_the_point %}

* A web app needs one .dart file and one .html file.
* ...factoid...
  
{% endcapture %}

{% capture content %}

# {{ page.title }}

Now that you've seen a command-line app,
let's write a very basic web application.
The web app you will write in this section
is stripped-down,
smaller even than the default web app created by Dart Editor.

This minimalistic app has just two files:
an `.html` file and a `.dart` file.
We will use this example
to learn about the connection between the HTML and Dart files
and the Document Object Model (DOM).

## Create the Dart Source File

Create a new application using Dart Editor.
Even though we are creating a web app,
unselect
"Generate content for a basic web app".
We will be building this web app
starting with the HelloWorld command-line application.

Give the new application the name Minimal.

Again Dart Editor creates a folder and a .dart file.
As before, the code in the `.dart` file is the basic Hello World program.

Using Dart Editor,
modify the Dart code to look like this:

{% highlight dart %}
#import('dart:html');

main() {
  document.query('#Rumpelstiltskin').text = 'Hello, World!';
}
{% endhighlight %}

Line one imports the dart.html library.
This library is required for all web apps.
You can find its sources in the dart-sdt/lib/html directory
in your Dart installation directory.

The Dart HTML library includes classes that manipulate the
elements on a browser page.
The connection between the Dart web application
and the browser page is the Document object.
By importing the Dart HTML library,
you automatically have a Document object
in your program, which you can refer to with the
name `document`.

We'll deconstruct the line of code that appears in the main function below.
For now, it's enough to know that
our mini app displays the message "Hello, World!"
on the web page.

## Create the Dart HTML File

Your web app requires at least one HTML file.
In Dart Editor, select File->New File
and give it the name Minimal.html.
The Dart Editor fills the file with some default HTML code.
Replace the default contents with the following,
slightly simplified HTML.

{% highlight html %}
<!DOCTYPE html>

<html>
  <head>
    <title>A Minimalist Web App</title>
  </head>

  <body>
    <h1>A Minimalist Web App</h1>
    
    <p>Below is the output from the from Minimal.dart!</p>
    
    <p id="Rumpelstiltskin"></p>

    <script type="application/dart" src="Minimal.dart"></script>
    <script src="http://dart.googlecode.com/svn/branches/bleeding_edge/dart/client/dart.js"></script>
  </body>
</html>
{% endhighlight %}

HTML is a markup language that identifies elements on a browser page.
Elements are marked with tags,
special identifiers that appear between angle brackets.
The file above has a header, a title, a body and several other elements.
[XX: more about HTML...then punt]

## Run Minimal Web App

In Dart Editor, click the Run button
![Dart Editor's run button](images/run.png).

Dart Editor spawns the Chromium web browser
included in your Dart download
and runs the web app in it.

You should see this:

![Minimal app's output](images/minimal-output.png).

## What's happening?

The following diagram shows the interesting bits
of the .dart and .html files.

![HTML Dart and DOM](images/dart-html-connect.png)

[XX: blah blah blah ]

## Dart Language Notes

#### Strings

Our minimal app uses two string literals: 'Rumpelstiltskin',
and 'Hello, World!'.
In Dart you can use either single- or double-quotes to delineate
a string literal.
String functions,
such as ??concatenate?? and string conversions,
are provided by the String object in the
Dart core library.

#### Libraries

Import libraries from the Dart SDK or from other sources using #import.
[XX: how is the path resolved? what it is relative to?]

#### Functions

Anything noteworthy...?

Use 2 space indentation.

[XX: define a function as follows

return_type function-name(arg-type arg-name, ...) {
  code here 
}

]

[XX: call a function like this:
  var var-name = function-name(arg, arg, arg);
]


{% endcapture %}

{% include tutorial.html %}
