---
layout: default
title: "Create and Run a Dart Application"
description: "Explains what comprises a Dart application"
tutorial:
  id: gs-cmd-line
---

{% capture whats_the_point %}

* All Dart apps have a main function.
* The Dart VM runs on the command-line.
* Dart Editor can run command-line apps.
  
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

Type `helloworld` in the **Application Name** text box.
A command-line application does not need
the extra files required by a Web app,
so unselect **Generate content for a basic Web app**.
Click **Finish**.

![New Application Dialog](images/new-hello-world-app.png)

Dart Editor creates a
a file named helloworld.dart,
which contains the Dart source code
for the canonical Hello World program.
Dart Editor puts helloworld.dart in a
folder named helloworld.

By convention:

* filenames are lower-case
* an application is contained in its own folder
  whose name provides the application name
* the `main` function is contained in the main file of the app

![Dart Editor with Hello World](images/darteditor-hello-world.png)

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

## Run Hello World

You can use Dart Editor to run your command-line applications.
Make sure either the helloworld folder or the helloworld.dart
is selected, then click the green run button.

Dart Editor opens a panel at the bottom of its window,
called the _Output view_ and displays
the output of the Hello World app.

![Hello World output](images/hello-world-output.png)

You can also run the application from the command-line in a terminal window.
The Dart VM is in the dart-sdk/bin folder in your dart installation directory.
Presuming that you have added this directory to your $PATH environment
variable, you can run the Dart VM as follows:

{% highlight dart %}

% dart helloworld.dart
Hello, World!
%

{% endhighlight %}

{% endcapture %}

{% include tutorial.html %}
