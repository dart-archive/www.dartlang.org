The [dart:html library](http://api.dartlang.org/html.html)
gives web apps access to HTML5 APIs.
Use dart:html to manipulate objects and elements in the _DOM_
(the _Document Object Model_,
which describes the hierarchy of an HTML page).

Other common uses of dart:html are manipulating styles (_CSS_),
getting data using HTTP requests
(_XMLHttpRequest_, or _XHR_),
and exchanging data using [WebSockets](#html-websockets).

<aside class="note" markdown="1">
**Note:**
HTML5 (and dart:html) have many additional APIs that this section doesn't cover.
These APIs include background worker tasks,
audio,
2D and 3D graphics,
database,
geolocation,
speech input,
and more.
XMLHttpRequest will soon be covered in this section.
</aside>

Only web apps can use dart:html&mdash;not command-line apps.


### Importing the HTML library

To use the HTML library in your web app,
import `dart:html`.

{% highlight dart %}
#import('dart:html');

main() {
  // The web app
}
{% endhighlight %}
