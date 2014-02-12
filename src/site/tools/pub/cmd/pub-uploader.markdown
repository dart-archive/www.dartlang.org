---
layout: default
title: "pub uploader"
---

# {{ page.title }}

_Uploader_ is one of the commands of the [pub](/tools/pub/) tool.

    $ pub uploader [options] {add/remove} <email>

This command allows [uploaders](glossary.html#uploader) of a package on
[pub.dartlang.org](http://pub.dartlang.org) to add or remove other uploaders for
that package. It has two sub-commands, `add` and `remove`, that take the email
address of the person to add/remove as an uploader. For example:

    ~/code/transmogrify$ pub uploader add nweiz@google.com
    'nweiz@google.com' added as an uploader for package 'transmogrify'.

    ~/code/transmogrify$ pub uploader remove nweiz@google.com
    'nweiz@google.com' is no longer an uploader for package 'transmogrify'.

If a package has only one uploader, that uploader can't be removed. You may
remove yourself as an uploader (as long as other uploaders are available),
but you won't be able to re-add yourself again afterwards.

By default, the package in the current working directory will have its
uploaders modified. You can also pass the `--package` flag to choose a
package by name. For example:

    $ pub uploader --package=transmogrify add nweiz@google.com
    'nweiz@google.com' added as an uploader for package 'transmogrify'.

Note that uploaders are identified by their Google accounts, so use a Gmail or
Google Apps email address for any new uploaders.
