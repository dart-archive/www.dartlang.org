---
layout: default
title: "pub install"
description: "Reference documentation for the `pub install` command."
has-permalinks: true
---

# {{ page.title }}

<aside class="note">
  <a href="index.html" style="text-align: right;">
    <i class="icon-hand-right icon-white">&nbsp;</i>
    Get started with pub
  </a>
</aside>

    $ pub update [PACKAGE]

Without any additional arguments, `pub update` installs the latest versions of
all the dependencies listed in the [`pubspec.yaml`](pubspec.html) file in the
current working directory, as well as their [transitive
dependencies](glossary.html#transitive-dependencies), to the `packages`
directory located next to the pubspec. For example:

    $ pub update
    Dependencies updated!

When `pub update` updates dependency versions, it writes a
[lockfile](glossary.html#lockfile) to ensure that future [`pub
install`s](pub-install.html) will use the same versions of those dependencies.
Application packages should check in the lockfile to source control; this
ensures the application will use the exact same versions of all dependencies for
all developers and when deployed to production. Library packages should not
check in the lockfile, though, since they're expected to work with a range of
dependency versions.

If a lockfile already exists, `pub update` will ignore it and generate a new one
from scratch using the latest versions of all dependencies. This is the primary
difference between `pub update` and `pub install`, which always tries to install
the dependency versions specified in the existing lockfile.

## Updating specific dependencies

It's possible to tell `pub update` to update specific dependencies to the latest
version while leaving the rest of the dependencies alone as much as possible.
For example:

    $ pub update unittest args
    Dependencies updated!

Updating a dependency updates its transitive dependencies to their latest
versions as well. Usually, no other dependencies are updated; they stay at the
versions that are locked in the lockfile. However, if the requested updates
cause incompatibilities with these locked versions, they will be selectively
unlocked until a compatible set of versions is found.

## Installing a new dependency

If a dependency is added to the pubspec before `pub update` is run, it will
install the new dependency and any of its transitive dependencies to the
`packages` directory. This is the same behavior as `pub install`.

## Uninstalling a dependency

If a dependency is removed from the pubspec before `pub update` is run, it
will remove the dependency from the `packages` directory, thus making it
unavailable for importing. Any transitive dependencies of the removed dependency
will also be removed, as long as no remaining immediate dependencies also depend
on them. This is the same behavior as `pub install`.
