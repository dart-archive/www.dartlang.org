---
layout: default
title: "pub install"
description: "Reference documentation for the `pub install` command."
has-permalinks: true
---

# {{ page.title }}

    $ pub install

This command installs all the dependencies listed in the
[`pubspec.yaml`](pubspec.html) file in the current working directory, as well as
their [transitive dependencies](glossary.html#transitive-dependencies), to a
`packages` directory located next to the pubspec. For example:

    $ pub install
    Dependencies installed!

Once the dependencies are installed, they may be referenced in Dart code. For
example, if a package depends on `unittest`:

{% highlight dart %}
#import("package:unittest/unittest.dart);
{% endhighlight %}

When `pub install` installs new dependencies, it writes a
[lockfile](glossary.html#lockfile) to ensure that future installs will use the
same versions of those dependencies. Application packages should check in the
lockfile to source control; this ensures the application will use the exact same
versions of all dependencies for all developers and when deployed to production.
Library packages should not check in the lockfile, though, since they're
expected to work with a range of dependency versions.

If a lockfile already exists, `pub install` uses the versions of dependencies
locked in it if possible. If a dependency isn't locked, pub will install the
latest version of that dependency that satisfies all the version constraints.
This is the primary difference between `pub install` and [`pub
update`](pub-update.html), which always tries to install the latest versions of
all dependencies.

## Installing a new dependency

If a dependency is added to the pubspec and then `pub install` is run, it will
install the new dependency and any of its transitive dependencies to the
`packages` directory. However, it won't change the versions of any
already-installed dependencies unless that's necessary to install the new
dependency.

## Uninstalling a dependency

If a dependency is removed from the pubspec and then `pub install` is run, it
will remove the dependency from the `packages` directory, thus making it
unavailable for importing. Any transitive dependencies of the removed dependency
will also be removed, as long as no remaining immediate dependencies also depend
on them. Removing a dependency will never change the versions of any
already-installed dependencies.

## The system package cache

Dependencies are not stored directly in the `packages` directory when they're
installed. Dependencies downloaded over the internet, such as those from Git and
[pub.dartlang.org](http://pub.dartlang.org), are stored in a system-wide cache
and linked to from the `packages` directory. This means that if multiple
packages use the same version of the same dependency, it will only need to be
downloaded and stored locally once. It also means that it's safe to delete the
`packages` directory without worrying about re-downloading packages.

By default, the system package cache is located in the `.pub-cache` subdirectory
of your home directory. However, it may be configured by setting the `PUB_CACHE`
environment variable before running Pub.
