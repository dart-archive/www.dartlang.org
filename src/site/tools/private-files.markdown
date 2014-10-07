---
layout: default
title: "What Not to Commit"
description: "Your development tools generate a bunch of files. Not all of them should be committed."
has-permalinks: true
---

{% include breadcrumbs.html %}

# {{ page.title }}

When you put Dart source code in a repository,
whether using the [pub](/tools/pub) tool, [GitHub](https://github.com/)
or another source code management system,
you shouldn't include most of the files
that Dart Editor, the pub tool, and other tools generate.

<aside class="alert alert-info" markdown="1">
**Note:**
Except where noted, this page discusses only source code repositories,
_not_ app deployment.
Some files that you wouldn't normally put in a repository
are useful or essential when you deploy an app.
</aside>

1. [The rules](#the-rules)
1. [Details](#details)
   1. [packages/](#packages)
   1. [pubspec.lock](#pubspeclock)
   1. [*.dart.js and *.js.map](#dartjs)
{:.toc}

## The rules

**Don't commit** the following files and directories
created by pub, Dart Editor, and dart2js:

{% prettify none %}
build/
packages/
pubspec.lock  // Except for application packages
.buildlog
.project
.pub/
{% endprettify %}

**Don't commit** files and directories
dropped by other development environments.
For example:

{% prettify none %}
.project      // Eclipse
*.iml         // IntelliJ
*.ipr         // IntelliJ
*.iws         // IntelliJ
.idea/        // IntelliJ
.DS_Store     // Mac
{% endprettify %}

**Avoid committing** generated JavaScript files:

{% prettify none %}
*.dart.js
*.js_
*.js.deps
*.js.map
{% endprettify %}

For more details, read on.

## Details

As a rule, you should commit only the files that people need
to use your package or source code repository.
Including additional files is unnecessary,
could be counterproductive,
and might even have security implications
if you expose details about your machine's setup.
In many source code repositories,
the common practice is not to commit generated files, at all.

See [Ignoring files](https://help.github.com/articles/ignoring-files)
in the GitHub help for more information.

### packages/

The `packages/` directory
contains symlinks specific to your machine.
Users of your code should generate their own packages directory,
using [pub get](/tools/pub/get-started.html#installing-packages).


### pubspec.lock

The `pubspec.lock` file is a special case,
similar to Ruby's `Gemfile.lock`.

**For library packages**, do **not** commit the `pubspec.lock` file.

**For application packages**, **do** commit `pubspec.lock`.
This file is the recommended way for non-shared resources
such as applications to manage their dependencies.


### *.dart.js and *.js.map {#dartjs}

Because .dart.js and .js.map files are generated,
they aren't usually saved in source code repositories.

However, when _deploying_ a web app,
you need to deploy the .dart.js files so that the web app works
in browsers that don't have a Dart VM.
When _testing_ a web app,
you should probably also deploy the .js.map files,
which provide source maps from JavaScript to Dart
that make debugging easier.
For more information on generating and debugging
JavaScript source for Dart apps, see the
[dart2js documentation](/tools/dart2js/).
