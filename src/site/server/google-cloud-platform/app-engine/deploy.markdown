---
layout: default
title: "Deploy a Dart Application on App Engine"
short-title: "Deploy a Dart App"
description: "How to deploy a Dart application to the cloud on App Engine Managed VMs"
header:
  css: ["styles.css"]
---

{% include breadcrumbs.html %}

# {{ page.title }}

To deploy your Dart application on App Engine Managed VMs,
you need to create a Google Cloud project with a unique name.
The project name provides part of the URL for your application.

<pre>
  <i>&lt;my-project-name&gt;</i>.appspot.com
</pre>

As you follow these instructions,
replace <i>&lt;my-project-name&gt;</i> with the name of your project.

### Contents
{: ._no_toc}

{% include default_toc.html %}

## Deploy the application

<ol markdown="1">
  <li markdown="1">
  If you have not already done so,
  put `dart/dart-sdk/bin` in your PATH environment variable.
  You will need this for the next step.
  </li>

  <li markdown="1">
  Change to the directory that contains the
  <a href="client-server/">Client/Server Example</a>
  you used previously and run `pub build`.

<pre>
$ cd appengine_samples/clientserver
$ pub build
$ gcloud preview app deploy app.yaml
</pre>

Note that the `deploy` command can take awhile.

<aside class="alert alert-info" markdown="1">
**Note:**
If you are using custom datastore indices, you also need to specify index.yaml:
<pre>
$ gcloud preview app deploy app.yaml index.yaml
</pre>
</aside>

  </li>

  <li markdown="1">
  Visit the project URL to see the Dart application running.
  
<pre>
http://<i>&lt;my-project-name&gt;</i>.appspot.com/
</pre>
  </li>
</ol>

Congratulations! You've deployed your Dart app on the web using
App Engine Managed VMs.

## How deployment works

Before deploying, you run `pub build` on the `web` directory
where the client code lives before building the container.
This creates a `build` directory, which contains all the transformed assets.
The application gets assets from here using the same code that is used
to get assets from `pub serve` when developing.

## What next?

Try out some other samples in the
[`appengine_samples`](https://github.com/dart-lang/appengine_samples) repo.
