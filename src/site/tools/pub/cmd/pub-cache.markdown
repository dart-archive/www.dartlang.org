---
layout: default
title: "pub cache"
---

# {{ page.title }}

_Cache_ is one of the commands of the [pub](/tools/pub/) tool.

{% prettify lang-sh %}
$ pub cache add <package> [--version <constraint>] [--all]
{% endprettify %}

The `pub cache` command works with the
[system cache](/tools/pub/glossary.html#system-cache).

You can use `pub cache add` to install a library in your cache.
The `--all` flag installs all matching versions and the
`--version <constraints>` flag installs the best version matching
the specified constraint.  For example:

{% prettify lang-sh %}
$ pub cache add barback --version ">=0.8.0 <0.110"
{% endprettify %}

If `--version` is omitted, pub installs the best of all known versions.
