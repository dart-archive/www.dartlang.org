---
layout: default
title: "pub cache"
---

# {{ page.title }}

_Cache_ is one of the commands of the [pub](/tools/pub/) tool.

    $ pub cache list

This command lists information about packages currently downloaded into your
[system cache](glossary.html#system-cache). Currently, it only outputs
information in JSON form and exists mainly for the Editor's benefit.

<aside class="alert alert-warning">
  Eventually, this command will be more useful for end users. For now, you
  probably just want to ignore it. We may change the format of its output at
  any time.
</aside>
