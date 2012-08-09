---
layout: default
title: "pub: What is a Pubspec?"
description: "More details about the pubspec format and contents."
has-permalinks: true
---

# {{ page.title }}

Every pub package needs some metadata associated with it so it can specify its
dependencies and other information that a user might need to work with it. Pub
stores this in a "pubspec" in a file named `pubspec.yaml`. As you could guess,
it uses [YAML][].

[YAML]: http://www.yaml.org/

A simple, but complete pubspec looks something like this:

{% highlight yaml %}
name: newtify
version: 1.2.3
description: >
  Have you been turned into a newt? Would you like to be? This
  package can help: it has all of the newt-transmogrification
  functionality you've been looking for.
dependencies:
  unittest:
    sdk: unittest
  transmogrify: '>=0.4.0'
{% endhighlight %}

You can have other metadata in there too if you like, and pub will safely
ignore it.

## Name

Every package needs a name. When your stellar code gets props on the world
stage, this is what they'll be hollering. Also, it is how other packages will
refer to yours, and how it will appear on [pub.dartlang.org][pubsite], should
you publish it.

It should be all lowercase, with underscores to separate words,
`just_like_this`. Stick with basic Latin letters and Arabic digits:
`[a-z0-9_]`. Try to pick a name that is clear, terse, and not already in use. A
quick search on the pub site to make sure nothing else is using your name can
save you heartache later.

## Version

Every package has a version. No one really gets excited about versioning, but it's a necessary evil for reusing code while letting it evolve quickly. A
version number is three numbers separated by dots, like `0.2.43`. It can also
optionally have a build (`+hotfix.oopsie`) or pre-release (`-alpha.12`) suffix.

Each time you publish your package, you will publish it at a specific version.
Once that's been done, consider it hermetically sealed: you can't touch it
anymore. To make more changes, you'll need a new version.

When you select a version, follow [semantic versioning][]. When you do, the
clouds will part and sunshine will pour into your soul. If you don't, prepare
yourself for hordes of angry users.

[semantic versioning]: http://semver.org

If you don't specify a version for your package, you still have one, it's just
`0.0.0`. It's perfectly fine to leave it unspecified like this when your
package is new and still being developed.

## Description

This is optional for your own personal packages, but if you intend to share
your package with the world (and you should because, let's be honest with
ourselves, it's a thing of beauty) you must provide a description. This should
be relatively short&mdash; a few sentences, maybe a whole paragraph&mdash; and
tells a casual reader what they might want to know about your package.

Think of it as the sales pitch for your package. Users will see it when they
browse [pub.dartlang.org][pubsite]. It should be simple plain text: no markdown or HTML. That's what your README is for.

## Dependencies

And, finally, the pubspec's *raison d'être*: dependencies. Here, you list each
package that your package needs in order to work. You only list *immediate
depedencies*, the stuff your package itself uses directly. If a package you
depend on has its own dependencies (*transitive dependencies*), then that
package will take care of them.

For each dependency, you will specify the *name* of the package you depend on,
and the *range of versions* of that package that you'll allow. There are a
couple of different sources that pub can use to find packages, and each one
specifies its dependency a little differently.

### Hosted packages

A *hosted* package is one that can be downloaded from
[pub.dartlang.org][pubsite]. Most of your dependencies will be of this form.
They look like this:

    dependencies:
      transmogrify: '>=0.4.0 <1.0.0'

Here, you're saying your package depends on a hosted package named
"transmogrify" and you'll work with any version from 0.4.0 to 1.0.0 (but not
1.0.0 itself).

### SDK packages

Some packages are a built-in part of the Dart SDK. These are the "batteries
included" packages that you get for free when you install Dart.

    dependencies:
      sdk: unittest

The `sdk` here says this package should be found in the installed Dart SDK, and
"unittest" is the name of the package to use.

### Git packages

Sometimes you live on the bleeding edge and you need to use stuff that hasn't
been formally released yet. Maybe your package itself is still in development
and is using other packages that are being developed at the same time. To make
that easier, you can depend directly on a package stored in a [git][]
repository.

[git]: http://git-scm.com/

    dependencies:
      git: git://github.com/munificent/kittens.git

The `git` here says this package is found using git, and the URL after that is
the git URL that can be used to clone the package. Pub assumes that the package
is in the root of the git repository.

At some point, we may add more sources where you can get packages. And that's
pretty much it. We will likely expand the set of metadata in here (authors,
website, etc.) but this is what we have now.

[pubsite]: http://pub.dartlang.org.
