---
layout: default
title: "pub deps"
---

{% include breadcrumbs.html %}

# {{ page.title }}

_Deps_ is one of the commands of the _pub_ tool.
[Learn more about pub](/tools/pub/).

{% prettify lang-sh %}
$ pub deps [--style=<style>]
{% endprettify %}

This command prints the dependency graph for a package.
The graph includes both the
[immediate dependencies](../glossary.html#immediate-dependency)
that the package uses (as specified in the pubspec), as well as the
[transitive dependencies](../glossary.html#transitive-dependency)
pulled in by the immediate dependencies.

The dependency information is printed as a tree, a list, or a compact
list.

For example, the pubspec for the markdown_converter example specifies
the following dependencies:

{% prettify lang-sh %}
dependencies:
  barback: any
  markdown: any
{% endprettify %}

Here's an example of the `pub deps` output for markdown_converter:

{% prettify lang-sh %}
$ pub deps
markdown_converter 0.0.0
|-- barback 0.11.1
|   |-- path 1.0.0
|   |-- source_maps 0.9.0
|   '-- stack_trace 0.9.2
|       '-- path...
'-- markdown 0.5.0
{% endprettify %}

## Options {#options}

For options that apply to all pub commands, see
[Global options](/tools/pub/cmd/#global-options).

`--style=<style>` or `-s <style>`
: Optional. How the output should be displayed. The options are:
`compact`, `tree`, or `list`. The default is tree.

<aside class="alert alert-info" markdown="1">
*Problems?*
See [Troubleshooting Pub](../troubleshoot.html).
</aside>
