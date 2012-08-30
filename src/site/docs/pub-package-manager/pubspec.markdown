---
layout: default
title: "Pub: What is a Pubspec?"
description: "More details about the pubspec format and contents."
has-permalinks: true
---

# {{ page.title }}

Every pub package needs some metadata so it can specify its dependencies. Pub
packages that are shared with others also need to provide some other
information so users can discover them. Pub stores this in a "pubspec" in a file
named `pubspec.yaml`. As you could guess, it is written in the
[YAML](http://www.yaml.org/) language.

A simple but complete pubspec looks something like this:

{% highlight yaml %}
name: newtify
version: 1.2.3
description: >
  Have you been turned into a newt? Would you like to be? This
  package can help: it has all of the newt-transmogrification
  functionality you've been looking for.
dependencies:
  efts: '>=2.0.4 <3.0.0'
  transmogrify: '>=0.4.0'
{% endhighlight %}

At the top level are a series of fields. The currently supported ones are:

<dl class="dl-horizontal">
  <dt>Name</dt>
  <dd>Required for every package.</dd>
  <dt>Version</dt>
  <dd>Required for packages that will be hosted on pub.dartlang.org.</dd>
  <dt>Description</dt>
  <dd>Required for packages that will be hosted on pub.dartlang.org.</dd>
  <dt>Dependencies</dt>
  <dd>Can be omitted if your package has no dependencies.</dd>
</dl>

All other fields will be ignored.

## Name

Every package needs a name. When your stellar code gets props on
the world stage, this is what they'll be hollering. Also, it's how other
packages will refer to yours, and how it will appear on
[pub.dartlang.org][pubsite], should you publish it.

It should be all lowercase, with underscores to separate words,
`just_like_this`. Stick with basic Latin letters and Arabic digits:
`[a-z0-9_]` and ensure that it's a valid Dart identifier (i.e. doesn't start
with digits and isn't a reserved word).

Try to pick a name that is clear, terse, and not already in use. A quick search
on [pub.dartlang.org][pubsite] to make sure nothing else is using your name can
save you heartache later.

## Version

Every package has a version. A version number is required to host your package on
[pub.dartlang.org][pubsite], but can be omitted for local-only packages. If you
omit it, your package is implicitly versioned `0.0.0`.

No one really gets excited about versioning, but
it's a necessary evil for reusing code while letting it evolve quickly. A
version number is three numbers separated by dots, like `0.2.43`. It can also
optionally have a build (`+hotfix.oopsie`) or pre-release (`-alpha.12`) suffix.

Each time you publish your package, you will publish it at a specific version.
Once that's been done, consider it hermetically sealed: you can't touch it
anymore. To make more changes, you'll need a new version.

When you select a version, follow [semantic versioning][]. When you do, the
clouds will part and sunshine will pour into your soul. If you don't, prepare
yourself for hordes of angry users.

[semantic versioning]: http://semver.org

## Description

This is optional for your own personal packages, but if you intend to share
your package with the world (and you should because, let's be honest with
ourselves, it's a thing of beauty) you must provide a description. This should
be relatively short&mdash;a few sentences, maybe a whole paragraph&mdash;and
tells a casual reader what they might want to know about your package.

Think of the description as the sales pitch for your package. Users will see it
when they browse [pub.dartlang.org][pubsite]. It should be simple plain text:
no markdown or HTML. That's what your README is for.

## Dependencies

Finally, the pubspec's *raison d'être*: dependencies. Here, you list each
package that your package needs in order to work. You only list immediate
depedencies, the stuff your package itself uses directly. Pub handles
transitive dependencies automatically for you.

For each dependency, you specify the *name* of the package you depend on. For
library packages, you specify the *range of versions* of that package that
you allow. You may also specify the *source* which tells pub how the package
can be located, and any additional *description* that the source needs to find
the package.

There are a few different ways to specify dependencies based on how much of
that data you need to provide. The shortest way is to just specify a name:

{% highlight yaml %}
dependencies:
  transmogrify:
{% endhighlight %}

This creates a dependency on `transmogrify`. It allows any version, and looks
it up using the default source ([pub.dartlang.org][pubsite]). To limit the
dependency to a range of versions, you can provide a *version constraint*:

{% highlight yaml %}
dependencies:
  transmogrify: '>=1.0.0 <2.0.0'
{% endhighlight %}

This creates a dependency on `transmogrify` using the default source and
allowing any version from `1.0.0` to `2.0.0` (but not including `2.0.0`). See
[below](#version-constraints) for details on the version constraint syntax.

<aside class="alert alert-warning">

The default source isn't currently implemented, but it's coming very soon.

</aside>

If you want to specify a source, the syntax looks a bit different:

{% highlight yaml %}
dependencies:
  transmogrify:
    hosted:
      url: http://some-package-server.com
{% endhighlight %}

This depends on the `transmogrify` package using the `hosted` source.
Everything under the source key (here, just a map with a `url:` key) is the
description that gets passed to the source. Each source has its own description
format, detailed below.

You can also provide a version constraint:

{% highlight yaml %}
dependencies:
  transmogrify:
    hosted:
      url: http://some-package-server.com
    version: '>=1.0.0 <2.0.0'
{% endhighlight %}

This long form is used when you don't use the default source or when you have a
complex description you need to specify. But in most cases, you'll just use the
simple "name: version" form.

## Dependency sources

Here are the different sources pub can use to locate packages, and the
descriptions they allow:

### Hosted packages

<aside class="alert alert-warning">

Hosted packages aren't currently implemented, but they are coming very soon.

</aside>

A *hosted* package is one that can be downloaded from
[pub.dartlang.org][pubsite] (or another HTTP server that speaks the same API).
Most of your dependencies will be of this form. They look like this:

{% highlight yaml %}
dependencies:
  transmogrify: '>=0.4.0 <1.0.0'
{% endhighlight %}

Here, you're saying your package depends on a hosted package named
"transmogrify" and you'll work with any version from 0.4.0 to 1.0.0 (but not
1.0.0 itself).

If you want to use your own package server, you can use a description that
specifies its URL:

{% highlight yaml %}
dependencies:
  transmogrify:
    hosted:
      url: http://your-package-server.com
    version: '>=0.4.0 <1.0.0'
{% endhighlight %}

### SDK packages

Some packages are a built-in part of the Dart SDK. These are the "batteries
included" packages that you get for free when you install Dart.

{% highlight yaml %}
dependencies:
  i18n:
    sdk: i18n
{% endhighlight %}

The `sdk` here says this package should be found in the installed Dart SDK, and
"i18n" is the name of the package to use.

### Git packages

Sometimes you live on the bleeding edge and you need to use stuff that hasn't
been formally released yet. Maybe your package itself is still in development
and is using other packages that are being developed at the same time. To make
that easier, you can depend directly on a package stored in a [Git][]
repository.

[git]: http://git-scm.com/

{% highlight yaml %}
dependencies:
  kittens:
    git: git://github.com/munificent/kittens.git
{% endhighlight %}

The `git` here says this package is found using Git, and the URL after that is
the Git URL that can be used to clone the package. Pub assumes that the package
is in the root of the git repository.

If you want to depend on a specific commit, branch, or tag, you can also
provide a `ref` argument:

{% highlight yaml %}
dependencies:
  kittens:
    git:
      url: git://github.com/munificent/kittens.git
      ref: some-branch
{% endhighlight %}

The ref can be anything that Git allows to [identify a commit][commit].

[commit]: http://www.kernel.org/pub/software/scm/git/docs/user-manual.html#naming-commits

## Version constraints

If your package is an application, you don't usually need to specify version
constraints for your dependencies. You will typically want to use the latest
versions of the dependencies when you first create your app. Then you'll create
and check in a lockfile that pins your dependencies to those specific versions.
Specifying version constraints in your pubpsc then is usually redundant (though
you can do it if you want).

For a library package that you want users to reuse, though, it is important
to specify version constraints. That lets people using your package know which
versions of its dependencies they can rely on to be compatible with your
library. Your goal is to allow a range of versions as wide as possible to give
your users' flexibility. But it should be narrow enough to exclude versions
that you know don't work or haven't been tested.

The Dart community uses [semantic versioning][], which helps you know which
versions should work. If you know that your package works fine with `1.2.3` of
some dependency, then semantic versioning tells you that it should work (at
least) up to `2.0.0`.

A version constraint is a space-separated series of version parts. A part can
be one of:

<dl class="dl-horizontal">
  <dt><code>any</code></dt>
  <dd>The string "any" allows any version. This is equivalent to an empty
    version constraint, but is more explicit.</dd>

  <dt><code>1.2.3</code></dt>
  <dd>A concrete version number pins the dependency to only allow that
    <em>exact</em> version. Avoid using this when you can because it can cause
    version lock for your users and make it hard for them to use your package
    along with other packages that also use it.</dd>

  <dt><code>&gt;=1.2.3</code></dt>
  <dd>Allows the given version or any greater one. You'll typically use this.
    </dd>

  <dt><code>&gt;1.2.3</code></dt>
  <dd>Allows any version greater than the specified one but <em>not</em> that
    version itself.</dd>

  <dt><code>&lt;=1.2.3</code></dt>
  <dd>Allows any version lower than or equal to the specified one. You
    <em>won't</em> typically use this.</dd>

  <dt><code>&lt;1.2.3</code></dt>
  <dd>Allows any version lower than the specified one but <em>not</em> that
    version itself. This is what you'll usually use because it lets you specify
    the upper version that you know does <em>not</em> work with your package
    (because it's the first version to introduce some breaking change).</dd>
</dl>

<aside class="alert alert-warning">

Make sure not to put a space between any of these comparison operators and the
subsequent version number. <code>&gt;=1.2.3</code> is good,
<code>&gt;= 1.2.3</code> is not.

</aside>

You can specify version parts as you want, and their ranges will be intersected
together. For example, `>=1.2.3 <2.0.0` allows any version from `1.2.3` to
`2.0.0` excluding `2.0.0` itself.

<aside class="alert alert-warning">

Note that <code>&gt;</code> is also valid YAML syntax so you will want to quote
the version string (like <code>'<=1.2.3 >2.0.0'</code>) if the version
constraint starts with that.

</aside>

[pubsite]: http://pub.dartlang.org
[semantic versioning]: http://semver.org/
