---
layout: default
title: "pub get"
---

# {{ page.title }}

_Get_ is one of the commands of the [pub](/tools/pub/) tool.

    $ pub get [--offline]

This command gets all the dependencies listed in the
[`pubspec.yaml`](pubspec.html) file in the current working directory, as well as
their [transitive dependencies](glossary.html#transitive-dependency), and places
them in a `packages` directory located next to the pubspec. For example:

    $ pub get
    Got dependencies!

Once the dependencies are acquired, they may be referenced in Dart code. For
example, if a package depends on `unittest`:

{% prettify dart %}
import "package:unittest/unittest.dart;
{% endprettify %}

When `pub get` gets new dependencies, it writes a
[lockfile](glossary.html#lockfile) to ensure that future gets will use the
same versions of those dependencies. Application packages should check in the
lockfile to source control; this ensures the application will use the exact same
versions of all dependencies for all developers and when deployed to production.
Library packages should not check in the lockfile, though, since they're
expected to work with a range of dependency versions.

If a lockfile already exists, `pub get` uses the versions of dependencies
locked in it if possible. If a dependency isn't locked, pub will get the
latest version of that dependency that satisfies all the [version
constraints](glossary.html#version-constraint). This is the primary difference
between `pub get` and [`pub upgrade`](pub-upgrade.html), which always tries to
get the latest versions of all dependencies.

<aside class="alert alert-info" markdown="1">
**Note:** In earlier releases of Dart, _pub get_ was called _pub install_.
</aside>

## Getting a new dependency

If a dependency is added to the pubspec and then `pub get` is run, it will
get the new dependency and any of its transitive dependencies and place them in
the `packages` directory. However, it won't change the versions of any
already-acquired dependencies unless that's necessary to get the new
dependency.

## Removing a dependency

If a dependency is removed from the pubspec and then `pub get` is run, it will
remove the dependency from the `packages` directory, thus making it
unavailable for importing. Any transitive dependencies of the removed dependency
will also be removed, as long as no remaining immediate dependencies also depend
on them. Removing a dependency will never change the versions of any
already-acquired dependencies.

## Linked `packages` directories

Every [entrypoint](glossary.html#entrypoint) in a package needs to be next to a
`packages` directory in order for it to import packages acquired by Pub.
However, it's not convenient to put every entrypoint at the top level of the
package alongside the main `packages` directory. You may have example scripts or
tests that you want to be able to run from subdirectories.

`pub get` solves this issue by creating additional `packages` directories
that link to the main `packages` directory at the root of your package. It
assumes your package is laid out according to the [package layout
guide](package-layout.html), and creates a linked `packages` directory in
`bin/`, `test/`, and `example/`, as well as their subdirectories.

## The system package cache

Dependencies are not physically stored in the `packages` directory that pub
creates. Dependencies downloaded over the internet, such as those from Git and
[pub.dartlang.org](http://pub.dartlang.org), are stored in a system-wide cache
and linked to from the `packages` directory. This means that if multiple
packages use the same version of the same dependency, it will only need to be
downloaded and stored locally once. It also means that it's safe to delete the
`packages` directory without worrying about re-downloading packages.

By default, the system package cache is located in the `.pub-cache` subdirectory
of your home directory. However, it may be configured by setting the `PUB_CACHE`
environment variable before running Pub.

## Getting while offline

If you don't have network access, you can still run `pub get`. Since pub
downloads packages to a central cache shared by all packages on your system, it
can often find previous-downloaded packages there without needing to hit the
network.

However, by default, pub will always try to go online when you get if you
have any hosted dependencies so that it can see if newer versions of them are
available. If you don't want it to do that, pass the `--offline` flag when
running pub. In this mode, it will only look in your local package cache and
try to find a set of versions that work with your package from what's already
available.

Keep in mind that pub *will* generate a lockfile after it does this. If the
only version of some dependency in your cache happens to be old, this will lock
your app to that version. The next time you are online, you will likely want to
run [`pub upgrade`](pub-upgrade.html) to upgrade to a later version.
