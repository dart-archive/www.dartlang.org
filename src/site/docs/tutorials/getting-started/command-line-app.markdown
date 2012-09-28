---
layout: default
title: "Create and Run a Dart Application"
description: "Explains what comprises a Dart application"
tutorial:
  id: gs-cmd-line
---


{% capture whats_the_point %}

* All Dart apps have a main function.
* ...factoid...
  
{% endcapture %}

{% capture content %}

# {{ page.title }}

Start the Dart Editor by double-clicking its icon
in your Dart installation directory 
![Dart Editor icon](images/DartEditor.png)

## Create a Command-line Application

Click the New Application button
![New App button](images/newapp.png)
(at the upper left of Dart Editor).
Alternatively, choose **File > New Application**
from the Dart Editor menu.
A dialog appears.

Type `HelloWorld` in the **Application Name** text box.
A command-line application does not need
the extra files required by a web app,
so unselect **Generate content for a basic web app**.
Click **Finish**.

![New Application Dialog](images/new-hello-world-app.png)

Dart Editor creates a
a file named HelloWorld.dart,
which contains the Dart source code
for the canonical Hello World program.
Dart Editor puts HelloWorld.dart in a
folder named HelloWorld.

We recommend that you follow these naming conventions.
That is,
each application should be contained in its own folder
whose name provides the application name.
In addition, the file containing the `main` function
should be named application-name.dart.

![Dart Editor with HelloWorld](images/darteditor-hello-world.png)

The panel to the left is called the _Files view_.
Here you can manage your folders and files.

[XX: what features of the files view should be called out at this time?]

##The main Function

Every Dart application _must_ have a `main` function.
When invoked from the command-line,
the Dart VM starts executing the program with the `main` function.

{% highlight dart %}
void main() {
  print("Hello, World!");
}
{% endhighlight %}

The `main` function in HelloWorld simply
prints the text _Hello,World!_ to the standard output stream.

`print` is a function provided by the `dart.core` library.
The functions and objects defined in the core library
are automatically avialable to all Dart applications.

[XX: bring up command-line args here? or return values? ]

## Run HelloWorld

You can use Dart Editor to run your command-line applications.
Make sure either the HelloWorld folder or the HelloWorld.dart
is selected, then click the green run button
![Dart Editor's run button](images/run.png).

Dart Editor opens a panel at the bottom of its window,
called the _Output view_ and displays
the output of the HelloWorld app.

![Hello World output](images/hello-world-output.png)

You can also run the application from the command-line in a terminal window.
The Dart VM is in the dart-sdk/bin folder in your dart installation directory.
Presuming that you have added this directory to your $PATH environment
variable, you can run the Dart VM as follows:

{% highlight dart %}

% dart HelloWorld.dart
Hello, World!
%

{% endhighlight %}

{% endcapture %}

{% include tutorial.html %}
