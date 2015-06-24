---
layout: default
title: "Set Up for App Engine Development"
short-title: "Setup"
description: "How to set up App Engine Managed VMs to run Dart programs."
header:
  css: ["styles.css"]
---

{% include breadcrumbs.html %}

# {{ page.title }}

### Contents
{: .no_toc}

{% include default_toc.html %}

## What do you need?

App Engine Managed VMs rely on [Docker](https://www.docker.io)
to develop and deploy applications to the cloud.
Docker is a portable, lightweight runtime and a cloud service for sharing
applications, and is a Linux-only technology.
If you are not developing on Linux, you need a Linux VM to use Docker.
These instructions use
[VirtualBox](https://www.virtualbox.org/), a cross-platform virtualization
application, to host a Linux VM.

The Google Cloud SDK provides a local App Engine development server
that provides the same environment locally as in the cloud&mdash;it
distributes incoming requests, provides APIs, and so on.

<img src="images/insidevirtualbox.png" style="display:block;margin: 0 auto;" alt="Docker, boot2docker and VirtualBox running together">

The instructions on this page show you how to install and configure
the following required software:

Dart
: The Dart SDK bundle contains the software
  and libraries you need to create, edit,
  and build server-side applications that
  you can deploy to App Engine Managed VMs.

Virtual Box version 4.3.10 or later
: VirtualBox hosts the docker VM daemon
  and runs all the docker containers.

boot2docker
: `boot2docker` is a pre-packaged Linux VM image for 
  VirtualBox. This image contains a docker daemon installation,
  as well as the `boot2docker` command line tool.

docker
: The `docker` command line tool talks to the docker
  daemon running inside VirtualBox.

Google Cloud SDK
: The Google Cloud SDK contains all App Engine tools and
  commands, including the `gcloud` command line tool. All functionality is
  available through the `gcloud preview app` sub-commands.

## Download and install Dart

{% include download-dart-configure-path.html %}

## Setup instructions

{% include docker-setup.html %}

### Set up a cloud project {#set-up-a-cloud-project}
{: .no_toc}

You need an App Engine project to develop and deploy
an application to App Engine.
Go to the <a href="https://console.developers.google.com">Google Developer
Console</a> and follow the instructions for creating a project.
Give it a unique name.

### Install Google Cloud SDK
{: .no_toc}

You need a Google account, like gmail, to use the Google Cloud SDK.

You need to grant certain permissions to Google Cloud SDK
to use the tools included in it.
During the setup instructions below,
you use the `gcloud auth login` command to login into your gmail account.
The command launches a browser with a list of permissions
for you to grant.

The list is sufficient to use any of the tools included in the Cloud SDK.
Your credentials do not expire (that is, you do not need to re-run this
command), but you can repeat this process as many times as you'd like to
add more accounts.  Use `gcloud config set account` to set the active one.

<ol markdown="1">
  <li>To install the Google Cloud SDK, follow the instructions
    given in <a href="https://cloud.google.com/sdk/#Quick_Start">Installing
    the Cloud SDK</a> and then return to these instructions.
  </li>
  <li>
    The Google Cloud SDK has the beta features on.
    So if you are already using the Cloud SDK,
    you don't need to do anything special to use the beta features.

    If you are not yet using the Google Cloud SDK,
    add <i>google-cloud-sdk/bin</i> to your path.
  </li>
  <li markdown="1"> Now login, set the project,
    and install the Managed VMs support.
    Replace <i>my-project-name</i> with your project name chosen
    in [Set up a cloud project](#set-up-a-cloud-project-mac).

<pre>
$ gcloud auth login
$ gcloud config set project <i>my-project-name</i>
$ gcloud components update app
</pre>
  </li>
  <li> Run this command to show the current configuration.
<pre>
$ gcloud config list
</pre>
The output should look something like this:
<pre>
[core]
account = mem@example.com
project = <i>my-project-name</i>
user_output_enabled = True
</pre>
  </li>
</ol>

## What's next? {#what-next}

Your development environment is set up
and you are ready to write some code.

<p>Now, you can 
  <a href="run.html">create and run</a> HelloWorld.

