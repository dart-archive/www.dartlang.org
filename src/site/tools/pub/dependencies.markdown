---
layout: default
title: "Pub Dependencies"
---

{% include toc.html %}

# {{ page.title }}

Dependencies are one of [pub](/tools/pub)'s core concepts.
A dependency is another package
that your package needs in order to work. Dependencies are specified in your
[pubspec](pubspec.html). You only list
[immediate dependencies](glossary.html#immediate-dependency)&mdash;the
software that your package uses directly. Pub handles
[transitive dependencies](glossary.html#transitive-dependency) for you.

For each dependency, you specify the *name* of the package you depend on. For
[library packages](glossary.html#library-package), you specify the *range of
versions* of that package that you allow. You may also specify the
[*source*](glossary.html#source) which tells pub how the package can be located,
and any additional *description* that the source needs to find the package.

Based on what data you want to provide, you can specify dependencies in two
ways. The shortest way is to just specify a name:

{% prettify yaml %}
dependencies:
  transmogrify:
{% endprettify %}

This creates a dependency on `transmogrify` that  allows any version, and looks
it up using the default source, which is pub.dartlang.org. To limit the
dependency to a range of versions, you can provide a *version constraint*:

{% prettify yaml %}
dependencies:
  transmogrify: '>=1.0.0 <2.0.0'
{% endprettify %}

This creates a dependency on `transmogrify` using the default source and
allowing any version from `1.0.0` to `2.0.0` (but not including `2.0.0`). See
[Version constraints](#version-constraints) for details on the version
constraint syntax.

If you want to specify a source, the syntax looks a bit different:

{% prettify yaml %}
dependencies:
  transmogrify:
    hosted:
      name: transmogrify
      url: http://some-package-server.com
{% endprettify %}

This depends on the `transmogrify` package using the `hosted` source.
Everything under the source key (here, just a map with a `url:` key) is the
description that gets passed to the source. Each source has its own description
format, detailed below.

You can also provide a version constraint:

{% prettify yaml %}
dependencies:
  transmogrify:
    hosted:
      name: transmogrify
      url: http://some-package-server.com
    version: '>=1.0.0 <2.0.0'
{% endprettify %}

This long form is used when you don't use the default source or when you have a
complex description you need to specify. But in most cases, you'll just use the
simple "name: version" form.

## Dependency sources {#dependency-sources}

Here are the different sources pub can use to locate packages, and the
descriptions they allow:

### Hosted packages {#hosted-packages}

A *hosted* package is one that can be downloaded from pub.dartlang.org
(or another HTTP server that speaks the same API). Most of your dependencies
will be of this form, as shown in the following example:

{% prettify yaml %}
dependencies:
  transmogrify: '>=0.4.0 <1.0.0'
{% endprettify %}

This specifies that your package depends on a hosted package named
"transmogrify" and will work with any version from 0.4.0 to 1.0.0 (but not
1.0.0 itself).

If you want to use your own package server, you can use a description that
specifies its URL:

{% prettify yaml %}
dependencies:
  transmogrify:
    hosted:
      name: transmogrify
      url: http://your-package-server.com
    version: '>=0.4.0 <1.0.0'
{% endprettify %}

### Git packages {#git-packages}

Sometimes you live on the bleeding edge and you need to use packages that
haven't been formally released yet. Maybe your package itself is still in
development and is using other packages that are being developed at the
same time. To make that easier, you can depend directly on a package
stored in a [Git][] repository.

[git]: http://git-scm.com/

{% prettify yaml %}
dependencies:
  kittens:
    git: git://github.com/munificent/kittens.git
{% endprettify %}

The `git` here says this package is found using Git, and the URL after that is
the Git URL that can be used to clone the package. Pub assumes that the package
is in the root of the git repository.

If you want to depend on a specific commit, branch, or tag, you can also
provide a `ref` argument:

{% prettify yaml %}
dependencies:
  kittens:
    git:
      url: git://github.com/munificent/kittens.git
      ref: some-branch
{% endprettify %}

The ref can be anything that Git allows to [identify a commit][commit].

[commit]: http://www.kernel.org/pub/software/scm/git/docs/user-manual.html#naming-commits

### Path packages {#path-packages}

Sometimes you find yourself working on multiple related packages at the same
time. Maybe you are creating a framework while building an app that uses it.
In those cases, during development you really want to depend on the "live"
version of that package on your local file system. That way changes in one
package are instantly picked up by the one that depends on it.

To handle that, pub supports *path dependencies*.

{% prettify yaml %}
dependencies:
  transmogrify:
    path: /Users/me/transmogrify
{% endprettify %}

This says the root directory for `transmogrify` is `/Users/me/transmogrify`.
For this dependency, pub generates a symlink directly to the `lib` directory
of the referenced package directory. Any changes you make to the dependent
package are seen immediately. You don't need to run pub every time you
change the dependent package.

Relative paths are allowed and are considered relative to the directory
containing your pubspec.

Path dependencies are useful for local development, but do not work when
sharing code with the outside world&mdash;not everyone can get to
your file system. Because of this, you cannot upload a package to
[pub.dartlang.org][pubsite] if it has any path dependencies in its pubspec.

Instead, the typical workflow is:

1. Edit your pubspec locally to use a path dependency.
2. Work on the main package and the package it depends on.
3. Once they're both working, publish the dependent package.
4. Change your pubspec to point to the now hosted version of its dependent.
5. Publish your main package too, if you want.

## Version constraints {#version-constraints}

If your package is an application, you don't usually need to specify [version
constraints](glossary.html#version-constraint) for your dependencies. You
typically want to use the latest versions of the dependencies when you first
create your app. Then you'll create and check in a
[lockfile](glossary.html#lockfile) that pins your dependencies to those specific
versions. Specifying version constraints in your pubspec then is usually
redundant (though you can do it if you want).

For a [library package](glossary.html#library-package) that you want users to
reuse, though, it is important to specify version constraints. That lets people
using your package know which versions of its dependencies they can rely on to
be compatible with your library. Your goal is to allow a range of versions as
wide as possible to give your users flexibility. But it should be narrow enough
to exclude versions that you know don't work or haven't been tested.

The Dart community uses [semantic versioning][]<sup id="fnref:semver"><a
href="#fn:semver">1</a></sup>, which helps you know which versions should work.
If you know that your package works fine with `1.2.3` of some dependency, then
semantic versioning tells you that it should work (at least) up to `2.0.0`.

A version constraint is a series of:

<code>any</code>
: The string "any" allows any version. This is equivalent to an empty
    version constraint, but is more explicit.

<code>1.2.3</code>
: A concrete version number pins the dependency to only allow that
    <em>exact</em> version. Avoid using this when you can because it can cause
    version lock for your users and make it hard for them to use your package
    along with other packages that also depend on it.

<code>&gt;=1.2.3</code>
: Allows the given version or any greater one. You'll typically use this.

<code>&gt;1.2.3</code>
: Allows any version greater than the specified one but <em>not</em> that
  version itself.

<code>&lt;=1.2.3</code>
: Allows any version lower than or equal to the specified one. You
  <em>won't</em> typically use this.

<code>&lt;1.2.3</code>
: Allows any version lower than the specified one but <em>not</em> that
  version itself. This is what you'll usually use because it lets you specify
  the upper version that you know does <em>not</em> work with your package
  (because it's the first version to introduce some breaking change).

You can specify version parts as you want, and their ranges are intersected
together. For example, `>=1.2.3 <2.0.0` allows any version from `1.2.3` to
`2.0.0` excluding `2.0.0` itself.

<aside class="alert alert-warning">

Note that <code>&gt;</code> is also valid YAML syntax so you will want to quote
the version string (like <code>'&lt;=1.2.3 &gt;2.0.0'</code>) if the version
constraint starts with that.

</aside>

## Dev dependencies {#dev-dependencies}

Pub supports two flavors of dependencies: regular dependencies and *dev
dependencies.* Dev dependencies differ from regular dependencies in that *dev
dependencies of packages you depend on are ignored*. Here's an example:

Say the `transmogrify` package uses the `unittest` package in its tests and only
in its tests. If someone just wants to use `transmogrify`&mdash;import its
libraries&mdash;it doesn't actually need `unittest`. In this case, it specifies
`unittest` as a dev dependency. Its pubspec will have something like:

{% prettify yaml %}
dev_dependencies:
  unittest: '>=0.5.0'
{% endprettify %}

Pub gets every package that your package depends on, and everything *those*
packages depend on, transitively. It also gets your package's dev dependencies,
but it *ignores* the dev dependencies of any dependent packages. Pub only gets
*your* package's dev dependencies. So when your package depends on
`transmogrify` it will get `transmogrify` but not `unittest`.

The rule for deciding between a regular or dev dependency is simple: If
the dependency is imported from something in your `lib` directory, it needs to
be a regular dependency. If it's only imported from `test`, `example`, etc. it
can and should be a dev dependency.

Using dev dependencies makes dependency graphs smaller. That makes `pub` run
faster, and makes it easier to find a set of package versions that satisfies all
constraints.

## Dependency overrides {#dependency-overrides}

You can use `dependency_overrides` to temporarily override all references
to a dependency.

For example, perhaps you are updating a local copy of transmogrify, a
published library package. Transmogrify is used by other packages in your
dependency graph, but you don't want to clone each package locally
and change each pubspec to test your local copy of transmogrify.

In this situation, you can override the dependency using
`dependency_overrides` to specify the directory holding the local
copy of the package.

The pubspec would look something like the following:

{% prettify yaml %}
name: my_app
dependencies:
  transmogrify: '>= 1.2.0 <2.0.0'
dependency_overrides:
  transmogrify:
    path: ../transmogrify_patch/
{% endprettify %}

When you run `pub get`, the pubspec's lockfile is updated to reflect the
new path to your dependency and, whereever transmogrify is used, pub
uses the local version instead.

You can also use `dependency_overrides` to specify a particular
version of a package:

{% prettify yaml %}
name: my_app
dependencies:
  transmogrify: '>= 1.2.0 <2.0.0'
dependency_overrides:
  transmogrify: '3.2.1'
{% endprettify %}

*Caution:* Using a dependency override involves some risk. For example,
using an override to specify a version outside the range that the
package claims to support, or using an override to specify
a local copy of a package that has unexpected behaviors,
may break your application.

---

<!-- We can't use the built-in Markdown footnote syntax here because it
     conflicts with the TOC header. -->
<ol>
<li id="fn:semver">

Pub follows version <code>2.0.0-rc.1</code> of the semantic versioning spec,
because that version allows packages to use build identifiers (e.g.
<code>+12345</code>) to differentiate versions. <a href="#fnref:semver">↩</a>

</li>
</ol>

[pubsite]: http://pub.dartlang.org
[semantic versioning]: http://semver.org/spec/v2.0.0-rc.1.html
