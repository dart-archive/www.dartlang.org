---
layout: default
title: "Dart and Google Cloud Platform"
short-title: "Google Cloud Platform"
description: "An introduction to Dart support for services in Google Cloud Platform."
has-permalinks: false
---

# {{ page.title }} <img src="images/GoogleCloudPlatform-logo.png" alt="logo for Google Cloud Platform">

**Note**: There are many ways to host a Dart server. You might also be
interested in [Heroku][] and [Dartvoid][].

[Google Cloud Platform](https://cloud.google.com/)
provides a set of cloud-based services that allow you to build,
test, and deploy applications on Google's highly scalable
and reliable infrastructure for your web, mobile, and backend solutions.

Cloud libraries and prepackaged Docker images developed for the
Dart platform provide support for the following services:

App Engine Managed VMs
: See [Dart on App Engine Managed VMs](app-engine) to learn how to
  run your Dart application on Managed VMs as a custom runtime.

Google Compute Engine
: See
  [Running on Google Compute Engine](https://github.com/dart-lang/dart_docker/tree/master/hello#running-on-google-compute-engine) for information
  on how to use Google Compute Engine for your application.

Google Container Engine
: See
  [Running on Google Container Engine](https://github.com/dart-lang/dart_docker/tree/master/hello#running-on-google-container-engine)
  for information on how to take advantage of clusters of containers.

Some of these features are in early releases and will be changing.

All of these features use container technology&mdash;specifically,
[Docker](https://www.docker.com/).
For more information on setting up Docker for any of these services, see
the [Configure Docker](app-engine/setup.html#configure-docker) and
[Get the Docker images](app-engine/setup.html#get-the-docker-images)
sections of the [Dart on App Engine Managed VMs](app-engine/)
documentation.

[Heroku]: https://github.com/igrigorik/heroku-buildpack-dart
[Dartvoid]: http://www.dartvoid.com/
