---
layout: default
title: "Dart and Google Cloud Platform"
description: "An introduction to Dart App Engine Managed VMs and runtimes."
has-permalinks: false
header:
  css: ["/cloud/styles.css"]
---

# {{ page.title }}

Managed VMs and custom runtimes on Google Cloud Platform are
now available in beta.
You can run Dart as a custom runtime on Managed VMs.
This means that you can use App Engine to host
your Dart application "in the cloud".

For an overview, watch this short video with Søren Gjesse.

<iframe style="display:block;margin: 0 auto;" width="560" height="315" src="//www.youtube.com/embed/UqolCJsvD_g" frameborder="0" allowfullscreen></iframe>

## About App Engine and Managed VMs

App Engine lets you build and run applications on Google's
infrastructure, providing high performance, load balancing,
security, and other benefits.
Previously, App Engine ran all applications in a secure,
sandboxed environment and supported four programming languages:
Python, Java, Go, and PHP.

Now, in addition to the sandboxed hosting environment,
App Engine supports _Managed VMs_ for hosting your apps.
This VM-based hosting environment offers more flexibility, and
provides more CPU and memory options. In addition, it allows
applications to be written in any programming language,
including Dart.

<img src="images/vmhosting.png" style="display:block;margin: 0 auto;" alt="Sandboxes and VMs">

For general information about App Engine's Managed VMs, refer to
<a href="https://developers.google.com/appengine/docs/managed-vms/">
Managed VMs</a>.

## Prerequisite

* You should be familiar with writing HTTP clients and servers in Dart
before working with Dart applications running on Managed VMs.
If you aren't, consider
reading [Writing HTTP Clients & Servers in Dart](/docs/tutorials/httpserver/)
before getting started here.

## What next?

If you are eager to start playing with this feature, knowing that it
will change and mature in future releases, use the following links:

<ul markdown ="1">
<li markdown ="1">
[Set Up for App Engine Development](setup.html)
</li>
<li markdown="1">
[Create and Run HelloWorld](run.html)
</li>
<li markdown="1">
[API Overview](api.html)
</li>
<li markdown="1">
[A Client-Server Example](client-server/)
</li>

<ul markdown="a">
<li markdown="1">
[The Client Code Explained](client-server/client-code.html)
</li>
<li markdown="1">
[The Server Code Explained](client-server/server-code.html)
</li>
</ul>

<li markdown="1">
[Deploy a Dart App to App Engine](deploy.html)
</li>
</ul>

To participate in the discussion on running Dart on Managed VMs,
and to stay informed with news and announcements,
sign up for
[cloud@dartlang.org](https://groups.google.com/a/dartlang.org/forum/?fromgroups#!forum/cloud).
