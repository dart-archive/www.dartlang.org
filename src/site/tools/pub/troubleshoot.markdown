---
layout: default
title: "Troubleshooting Pub"
description: "Common gotchas you might run into when using Pub."
---

{% include breadcrumbs.html %}

# {{ page.title }}

#### Contents
{:.no_toc}

1. ToC
{:toc}

### Getting a "403" error when publishing a package {#pub-publish-403}

You receive the following error when running `pub publish`:

{% prettify lang-sh %}
HTTP error 403: Forbidden
...
You aren't an uploader for package '<foo>'
{% endprettify %}

This problem can occur if one of your accounts was granted permission to
publish a package, but the pub client registers you with another account.

You can reset pub's authentication process by removing the credentials file:

{% prettify lang-sh %}
rm ~/.pub-cache/credentials.json
{% endprettify %}

### Pub build fails with HttpException error {#pub-get-fails}

You receive an HttpException error similar to the following when
running `pub build`:

{% prettify lang-sh %}
Pub build failed, [1] IsolateSpawnException: 'HttpException: Connection closed while receiving data,
...
library handler failed
...
{% endprettify %}

This can happen as a result of some antivirus software, such as the
AVG 2013 Internet security suite. Check the manual for your security
suite to see how to temporarily
disable this feature. For example, see
[Disabling AVG temporarily](http://www.avg.com/ww-en/faq.num-3857).

