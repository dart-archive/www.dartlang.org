---
layout: default
title: "Pub Versioning Philosophy"
---

{% include toc.html %}

# {{ page.title }}

One of [pub](/tools/pub/)'s main jobs is helping you work with versioning.
This document explains a bit about the history of versioning and pub's
approach to it.
Consider this to be advanced information. If you want a better picture of *why*
pub was designed the way it was, read on. If you just want to *use* pub, the
[other docs](index.html) will serve you better.

Modern software development, especially web development, leans heavily on
reusing lots and lots of existing code. That includes code *you* wrote in the
past, but also code from third-parties, everything from big frameworks to small
utility libraries. It's not uncommon for an application to depend on
dozens of different packages and libraries.

It's hard to understate how powerful this is. When you see stories of small web
startups building a site in a few weeks that gets millions of users, the
only reason they can achieve this is because the open source community has
laid a feast of software at their feet.

But this doesn't come for free: There's a challenge to code
reuse, especially reusing code you don't maintain. When your app uses code
being developed by other people, what happens when they change it? They
don't want to break your app, and you certainly don't either.

## A name and a number

We solve this by *versioning*. When you depend on some piece of outside code,
you don't just say "My app uses `widgets`." You say, "My app uses
`widgets 2.0.5`." That combination of name and version number uniquely
identifies an *immutable* chunk of code. The people updating `widgets` can
make all of the changes they want, but they promise to not touch any already
released versions. They can put out `2.0.6` or `3.0.0` and it won't affect you
one whit because the version you use is unchanged.

When you *do* want to get those changes, you can always point your app to a
newer version of `widgets` and you don't have to coordinate with those
developers to do it. So, problem solved, right?

## Shared dependencies and unshared libraries

Well, no. Depending on specific versions works fine when your dependency
*graph* is really just a dependency *tree*. If your app depends on a bunch of
packages, and those things in turn have their own dependencies and so on, that
all works fine as long as none of those dependencies *overlap*.

But let's consider an example:

          myapp
          /   \
         /     \
    widgets  templates
        \      /
         \    /
       collections

So your app uses `widgets` and `templates`, and *both* of those use
`collections`. This is called a **shared dependency**. Now what happens when
`widgets` wants to use `collections 2.3.5` and `templates` wants
`collections 2.3.7`? What if they don't agree on a version?

One option is to just let the app use both
versions of `collections`. It will have two copies of the library at different
versions and `widgets` and `templates` will each get the one they want.

This is what [npm][] does for node.js. Would it work for Dart? Consider this
scenario:

 1. `collections` defines some `Dictionary` class.
 2. `widgets` gets an instance of it from its copy of `collections` (`2.3.5`).
    It then passes it up to `myapp`.
 3. `myapp` sends the dictionary over to `templates`.
 4. That in turn sends it down to *its* version of `collections` (`2.3.7`).
 5. The method that takes it has a `Dictionary` type annotation for that object.

As far as Dart is concerned, `collections 2.3.5` and `collections 2.3.7` are
entirely unrelated libraries. If you take an instance of class `Dictionary`
from one and pass it to a method in the other, that's a completely different
`Dictionary` type. That means it will fail to match a `Dictionary` type
annotation in the receiving library. Oops.

Because of this (and because of the headaches of trying to debug an app that
has multiple versions of things with the same name), we've decided npm's model
isn't a good fit.

[npm]: https://npmjs.org/

## Version lock

Instead, when you depend on a package, your app will only use a single copy of
that package. When you have a shared dependency, everything that depends on it
has to agree on which version to use. If they don't, you get an error.

That doesn't actually solve your problem though. When you *do* get that error,
you need to be able to resolve it. So let's say you've gotten yourself into
that situation in the previous example. You want to use `widgets` and
`templates`, but they are using different versions of `collections`. What do
you do?

The answer is to try to upgrade one of those. `templates` wants
`collections 2.3.7`. Is there a later version of `widgets` that you can upgrade
to that works with that version?

In many cases, the answer will be "no". Look at it from the perspective of the
people developing `widgets`. They want to put out a new version with new changes
to *their* code, and they want as many people to be able to upgrade to it it as
possible. If they stick to their *current* version of `collections` then anyone
who is using the current version `widgets` will be able to drop in this new one
too.

If they were to upgrade *their* dependency on `collections` then everyone who
upgrades `widgets` would have to as well, *whether they want to or not.* That's
painful, so you end up with a disincentive to upgrade dependencies. That's
called **version lock**: everyone wants to move their dependencies forward, but
no one can take the first step because it forces everyone else to as well.

## Version constraints

To solve version lock, we loosen the constraints that packages place on their
dependencies. If `widgets` and `templates` can both indicate a *range* of
versions for `collections` that they will work with, then that gives us enough
wiggle room to move our dependencies forward to newer versions. As long as there
is overlap in their ranges, we can still find a single version that makes them
both happy.

This is the model that [bundler](http://gembundler.com/) follows, and is pub's
model too. When you add a dependency in your pubspec, you can specify a *range*
of versions that you can accept. If the pubspec for `widgets` looked like this:

{% prettify yaml %}
dependencies:
  collections: '>=2.3.5 <2.4.0'
{% endprettify %}

Then we could pick version `2.3.7` for `collections` and then both `widgets`
and `templates` have their constraints satisfied by a single concrete version.

## Semantic versions

When you add a dependency to your package, you'll sometimes want to specify a
range of versions to allow. How do you know what range to pick? You need to
forward compatible, so ideally the range encompasses future versions that
haven't been released yet. But how do you know your package is going to work
with some new version that doesn't even exist yet?

To solve that, you need to agree on what a version number *means*. Imagine that
the developers of a package you depend on say, "If we make any backwards
incompatible change, then we promise to increment the major version number."
If you trust them, then if you know your package works with `2.5.7` of theirs,
you can rely on it working all the way up to `3.0.0`. So you can set your range
like:

{% prettify yaml %}
dependencies:
  collections: '>=2.3.5 <3.0.0'
{% endprettify %}

To make this work, then, we need to come up with that set of promises.
Fortunately, other smart people have done the work of figuring this all out and
named it [*semantic versioning*](http://semver.org/spec/v2.0.0-rc.1.html).

That describes the format of a version number, and the exact API behavioral
differences when you increment to a later version number. Pub requires versions
to be formatted that way, and to play well with the pub community, your package
should follow the semantics it specifies. You should assume that the packages
you depend on also follow it. (And if you find out they don't, let their
authors know!)

Although semantic versioning doesn't promise any compatibility between versions
prior to `1.0.0`, the Dart community convention is to treat those versions
semantically as well. The interpretation of each number is just shifted down one
slot: going from `0.1.2` to `0.2.0` indicates a breaking change, going to
`0.1.3` indicates a new feature, and going to `0.1.2+1` indicates a change that
doesn't affect the public API.

We've got almost all of the pieces we need to deal with versioning and API
evolution now. Let's see how they play together and what pub does.

## Constraint solving

When you define your package, you list its
[**immediate dependencies**](glossary.html#immediate-dependency)&mdash;the
packages it itself uses. For each one, you specify the range of versions it
allows. Each of those dependent packages may in turn have their own
dependencies (called
[**transitive dependencies**](glossary.html#transitive-dependency). Pub will
traverse these and  build up the entire deep dependency graph for your app.

For each package in the graph, pub looks at everything that depends on it. It
gathers together all of their version constraints and tries to simultaneously
solve them. (Basically, it intersects their ranges.) Then it looks at the
actual versions that have been released for that package and selects the best
(most recent) one that meets all of those constraints.

For example, let's say our dependency graph contains `collections`, and three
packages depend on it. Their version constraints are:

    >=1.7.0
    >=1.4.0 <2.0.0
    <1.9.0

The developers of `collections` have released these versions of it:

    1.7.0
    1.7.1
    1.8.0
    1.8.1
    1.8.2
    1.9.0

The highest version number that fits in all of those ranges is `1.8.2`, so pub
picks that. That means your app *and every package your app uses* will all use
`collections 1.8.2`.

## Constraint context

The fact that selecting a package version takes into account *every* package
that depends on it has an important consequence: *the specific version that
will be selected for a package is a global property of the app using that
package.*

The following example shows what this means. Let's say we have
two apps. Here are their pubspecs:

{% prettify yaml %}
name: my_app
dependencies:
  widgets:
{% endprettify %}

{% prettify yaml %}
name: other_app
dependencies:
  widgets:
  collections: '<1.5.0'
{% endprettify %}

They both depend on `widgets`, whose pubspec is:

{% prettify yaml %}
name: widgets
dependencies:
  collections: '>=1.0.0 <2.0.0'
{% endprettify %}

The `other_app` package uses depends directly on `collections` itself. The
interesting part is that it happens to have a different version constraint on
it than `widgets` does.

What this means is that you can't just look at the `widgets` package in
isolation to figure out what version of `collections` it will use. It depends
on the context. In `my_app`, `widgets` will be using `collections 1.9.9`. But
in `other_app`, `widgets` will get saddled with `collections 1.4.9` because of
the *other* constraint that `otherapp` places on it.

This is why each app gets its own "packages" directory: The concrete version
selected for each package depends on the entire dependency graph of the
containing app.

## Lockfiles

So once pub has solved your app's version constraints, then what? The end
result is a complete list of every package that your app depends on either
directly or indirectly and the best version of that package that will work with
your app's constraints.

Pub takes that and writes it out to a **lockfile** in your app's directory
called `pubspec.lock`. When pub builds the "packages" directory your app, it
uses the lockfile to know what versions of each package to pull in. (And if
you're curious to see what versions it selected, you can read the lockfile to
find out.)

The next important thing pub does is it *stops touching the lockfile*. Once
you've got a lockfile for your app, pub won't touch it until you tell it to.
This is important. It means you won't spontanteously start using new versions
of random packages in your app without intending to. Once your app is locked,
it stays locked until you manually tell it to update the lockfile.

If your package is for an app, you *check your lockfile into your source
control system!* That way, everyone on your team will be using
the exact same versions of every dependency when they build your app. You'll
also use this when you deploy your app so you can ensure that your production
servers are using the exact same packages that you're developing with.

## When things go wrong

Of course, all of this presumes that your dependency graph is perfect and
flawless. Even with version ranges and pub's constraint solving and
semantic versioning, you can never be entirely spared from the
dangers of versionitis.

You might run into one of the following problems:

### You can have disjoint constraints

Lets say your app uses `widgets` and
`templates` and both use `collections`. But `widgets` asks for a version
of it between `1.0.0` and `2.0.0` and `templates` wants something
between `3.0.0` and `4.0.0`. Those ranges don't even overlap. There's no
possible version that would work.

### You can have ranges that don't contain a released version

Let's say after
putting all of the constraints on a shared dependency together, you're
left with the narrow range of `>=1.2.4 <1.2.6`. It's not an empty range.
If there was a version `1.2.4` of the dependency, you'd be golden. But maybe
they never released that and instead when straight from `1.2.3` to `1.3.0`.
You've got a range but nothing exists inside it.

### You can have an unstable graph

This is, by far, the most challenging part of
pub's version solving process. The process was described as "build up the
dependency graph and then solve all of the constraints and pick versions".
But it doesn't actually work that way. How could you build up the *whole*
dependency graph before you've picked *any* versions? *The pubspecs
themselves are version-specific*. Different versions of the same package
may have different sets of dependencies.

As you're selecting versions of packages, they are changing the shape of
the dependency graph itself. As the graph changes, that may change
constraints, which can cause you to select different versions, and then you
go right back around in a circle.

Sometimes this process never settles down into a stable solution. Gaze into
the abyss:

{% prettify yaml %}
name: my_app
version: 0.0.0
dependencies:
  yin: '>=1.0.0'
{% endprettify %}

{% prettify yaml %}
name: yin
version: 1.0.0
dependencies:
{% endprettify %}

{% prettify yaml %}
name: yin
version: 2.0.0
dependencies:
  yang: '1.0.0'
{% endprettify %}

{% prettify yaml %}
name: yang
version: 1.0.0
dependencies:
  yin: '1.0.0'
{% endprettify %}

In all of these cases, there is no set of concrete versions that will work for
your app, and when this happens pub will report an error and tell you what's
going on. It definitely will not try to leave you in some weird state where you
think things can work but won't.

## Summary

That was a lot of information, but here are the key points:

 *  Code reuse is great, but in order to let developers move quickly, packages
    need to be able to evolve independently.
 *  Versioning is how you enable that. But depending on single concrete versions
    is too precise and with shared dependencies leads to version lock.
 *  To cope with that, you depend on *ranges* of versions. Pub will then walk
    your dependency graph and pick the best versions for you. If it can't, it
    tells you.
 *  Once your app has a solid set of versions for its dependencies, that gets
    pinned down in a *lockfile*. That ensures that every machine your app is
    on is using the same versions of all of its dependencies.
