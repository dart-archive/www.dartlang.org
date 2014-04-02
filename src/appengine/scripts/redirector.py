from webapp2 import *

NEWS_POSTS = {
    '/2012/01/26/revisiting-equality.html' :                     '/2012/01/proposed-changes-for-equality.html',
    '/2012/01/20/dart-language-spec-0.07.html' :                 '/2012/01/dart-language-spec-v007-now-available.html',
    '/2012/01/17/new-editor-build.html' :                        '/2012/01/new-dart-editor-build-3331.html',
    '/2012/01/10/new-editor-build.html' :                        '/2012/01/new-dart-editor-build-3101.html',
    '/2012/01/06/getting-started-with-dart.html' :               '/2012/01/getting-started-with-dart-screencast.html',
    '/2011/12/21/new-api-docs.html' :                            '/2011/12/new-api-docs-site.html',
    '/2011/12/19/new-editor-build.html' :                        '/2011/12/new-dart-editor-build-2380.html',
    '/2011/12/13/dart-language-spec-0.06.html' :                 '/2011/12/dart-language-spec-v006-now-available.html',
    '/2011/12/02/new-editor-build.html' :                        '/2011/12/new-dart-editor-build-1910.html',
    '/2011/11/23/dart-presentations-and-slides-available.html' : '/2011/11/new-dart-presentations-and-slides.html',
    '/2011/11/18/new-editor-build.html' :                        '/2011/11/new-dart-editor-build-1584.html',
    '/2011/11/14/dart-language-spec-0.05.html' :                 '/2011/11/dart-language-spec-v005-now-available.html',
    '/2011/11/09/new-editor-build.html' :                        '/2012/01/new-dart-editor-build.html',
    '/2011/11/01/dart-language-spec-0.04-now-available.html' :   '/2011/11/dart-language-spec-v004-now-available.html',
    '/2011/10/31/editor.html' :                                  '/2011/10/try-out-dart-editor.html',
    '/2011/10/28/style-guide.html' :                             '/2011/10/coding-style-guide.html',
    '/2011/10/26/dart-slides-from-senchacon.html' :              '/2011/10/posted-by-david-chandler-i-recently.html',
    '/2011/10/18/dart-language-spec-0.03-now-available.html' :   '/2011/10/dart-language-spec-v003-now-available.html'
}

class ApiRedirectPage(RequestHandler):
  def get(self):
    filename = self.request.path.split('/docs/api/')[1]
    if filename == '' or filename == 'index.html':
        self.redirect('http://api.dartlang.org/', permanent=True)
    else:
        self.redirect('http://api.dartlang.org/dart_core/' + filename, permanent=True)

class SpecRedirectPage(RequestHandler):
  def get(self):
    suffix = self.request.path.split('/docs/spec/dartLangSpec')[1]
    if suffix == '.html' or suffix == '.pdf':
        self.redirect('/docs/spec/latest/dart-language-specification' + suffix, permanent=True)

class PubRedirectPage(RequestHandler):
  def get(self):
    filename = self.request.path.split('/docs/pub-package-manager/')[1]
    if filename == 'pubspec.html':
        self.redirect('http://pub.dartlang.org/doc/pubspec.html', permanent=True)
    else:
        self.redirect('http://pub.dartlang.org/doc', permanent=True)

class NewsRedirectPage(RequestHandler):
  def get(self):
    url = self.request.path[5:len(self.request.path)]
    if url == '' or url == '/' or url == '/index.html':
        self.redirect('http://news.dartlang.org', permanent=True)
    elif NEWS_POSTS.has_key(url):
        self.redirect('http://news.dartlang.org' + NEWS_POSTS[url], permanent=True)
    else:
        self.error(404)

class HangoutsRedirectPage(RequestHandler):
  def get(self):
    path = self.request.path.replace('/hangouts', '/dartisans', 1)
    self.redirect(path, permanent=True)

class CloudStorageRedirect(RequestHandler):
  def get(self, *args, **kwargs):
    self.redirect_to_cloud_storage(kwargs['path'])
  def head(self, *args, **kwargs):
    self.redirect_to_cloud_storage(kwargs['path'])
  def redirect_to_cloud_storage(self, path):
    self.redirect(self.prefix + path, permanent=False)

# XXX DO NOT USE SSL here. The editor can't handle redirects to SSL
class EditorUpdateRedirect(CloudStorageRedirect):
  prefix = 'http://storage.googleapis.com/dart-editor-archive-integration'

# XXX DO NOT USE SSL here. The editor can't handle redirects to SSL
class EditorUpdateRedirectBeChannel(CloudStorageRedirect):
  prefix = 'http://storage.googleapis.com/dart-archive/channels/be/raw'

# XXX DO NOT USE SSL here. The editor can't handle redirects to SSL
class EditorUpdateRedirectDevChannel(CloudStorageRedirect):
  prefix = 'http://storage.googleapis.com/dart-archive/channels/dev/release'

# XXX DO NOT USE SSL here. The editor can't handle redirects to SSL
class EditorUpdateRedirectStableChannel(CloudStorageRedirect):
  prefix = 'http://storage.googleapis.com/dart-archive/channels/stable/release'

class EclipseUpdateRedirectBase(CloudStorageRedirect):
  def get(self, *args, **kwargs):
    filename = kwargs['path']
    if filename == '' or filename == '/':
      filename = '/index.html'
    self.redirect_to_cloud_storage(filename)

# XXX DO NOT USE SSL here. The editor can't handle redirects to SSL
class EclipseUpdateRedirectBeChannel(EclipseUpdateRedirectBase):
  prefix = 'http://storage.googleapis.com/dart-archive/channels/be/raw/latest/editor-eclipse-update'

# XXX DO NOT USE SSL here. The editor can't handle redirects to SSL
class EclipseUpdateRedirectDevChannel(EclipseUpdateRedirectBase):
  prefix = 'http://storage.googleapis.com/dart-archive/channels/dev/release/latest/editor-eclipse-update'

# XXX DO NOT USE SSL here. The editor can't handle redirects to SSL
class EclipseUpdateRedirectStableChannel(EclipseUpdateRedirectBase):
  prefix = 'http://storage.googleapis.com/dart-archive/channels/stable/release/latest/editor-eclipse-update'

class BookRedirect(RequestHandler):
  def get(self, *args, **kwargs):
    self.redirect('/docs/dart-up-and-running/contents/ch0' + kwargs['num'] + '.html', permanent=True)
  def head(self, *args, **kwargs):
    self.redirect('/docs/dart-up-and-running/contents/ch0' + kwargs['num'] + '.html', permanent=True)

class WebUiRedirect(RequestHandler):
  def get(self):
    filename = self.request.path.split('/articles/dart-web-components/')[1]
    if filename == '' or filename == 'index.html':
        self.redirect('/articles/web-ui/', permanent=True)
    else:
        self.redirect('/articles/web-ui/' + filename, permanent=True)

class CookbookRedirect(RequestHandler):
  def get(self):
    self.redirect('/docs/dart-up-and-running/contents/ch03.html', permanent=True)

def trailing_slash(handler, *args, **kwargs):
  return '/' + kwargs['path'] + '/'

application = WSGIApplication(
   [('/docs/api/.*', ApiRedirectPage),
    ('/docs/spec/dartLangSpec.*', SpecRedirectPage),
    ('/news.*', NewsRedirectPage),
    ('/hangouts.*', HangoutsRedirectPage),
    ('/docs/pub-package-manager/.*', PubRedirectPage),
    ('/articles/dart-web-components/.*', WebUiRedirect),
    Route('/editor/update/channels/be<path:.*>',
      EditorUpdateRedirectBeChannel),
    Route('/editor/update/channels/dev<path:.*>',
      EditorUpdateRedirectDevChannel),
    Route('/editor/update/channels/stable<path:.*>',
      EditorUpdateRedirectStableChannel),
    Route('/editor/update<path:.*>', EditorUpdateRedirect),
    Route('/eclipse/update/channels/be<path:.*>',
      EclipseUpdateRedirectBeChannel),
    Route('/eclipse/update/channels/dev<path:.*>',
      EclipseUpdateRedirectDevChannel),
    Route('/eclipse/update/channels/stable<path:.*>',
      EclipseUpdateRedirectStableChannel),
    Route('/eclipse/update<path:.*>', EclipseUpdateRedirectDevChannel),
    Route('/docs/dart-up-and-running/ch0<num:\d>.html', BookRedirect),
    Route('/docs/cookbook/', CookbookRedirect),
    Route('/dartisans/podcast-feed', RedirectHandler,
      defaults={'_uri': 'http://feeds.feedburner.com/DartisansDartProgrammingLanguagePodcast',
                '_code': 302}),
    Route('/language-tour/', RedirectHandler,
      defaults={'_uri': '/docs/dart-up-and-running/contents/ch02.html'}),
    Route('/docs/dart-up-and-running/contents/ch04-tools-dartdoc.html', RedirectHandler,
      defaults={'_uri': '/tools/docgen/'}),
    Route('/docs/technical-overview/', RedirectHandler,
      defaults={'_uri': '/docs/dart-up-and-running/contents/ch01.html'}),
    Route('/downloads.html', RedirectHandler,
      defaults={'_uri': '/tools/download.html'}),
    Route('/tools/dartdoc/', RedirectHandler,
      defaults={'_uri': '/tools/docgen/'}),
    Route('/docs/language-tour/', RedirectHandler,
      defaults={'_uri': '/docs/dart-up-and-running/contents/ch02.html'}),
    Route('/docs/library-tour/', RedirectHandler,
      defaults={'_uri': '/docs/dart-up-and-running/contents/ch03.html'}),
    Route('/eclipse/', RedirectHandler,
      defaults={'_uri': '/tools/eclipse-plugin/'}),
    Route('/docs/editor/troubleshoot.html', RedirectHandler,
      defaults={'_uri': '/tools/editor/troubleshoot.html'}),
    Route('/docs/editor<:/?>', RedirectHandler,
      defaults={'_uri': '/tools/editor/'}),
    Route('/docs/sdk<:/?>', RedirectHandler,
      defaults={'_uri': '/tools/sdk/'}),
    Route('/editor<:/?>', RedirectHandler,
      defaults={'_uri': '/tools/editor/'}),
    Route('/dartium/', RedirectHandler,
      defaults={'_uri': '/tools/dartium/'}),
    Route('/community/', RedirectHandler,
      defaults={'_uri': '/support/'}),
    Route('/docs/getting-started/editor/', RedirectHandler,
      defaults={'_uri': '/docs/dart-up-and-running/contents/ch01.html#ch01-editor'}),
    Route('/docs/getting-started/sdk/', RedirectHandler,
      defaults={'_uri': '/docs/sdk/'}),
    Route('/resources/', RedirectHandler,
      defaults={'_uri': '/community/'}),
    Route('/articles/feet-wet-streams/', RedirectHandler,
      defaults={'_uri': '/docs/tutorials/streams/'}),
    Route('/articles/using-future-based-apis/', RedirectHandler,
      defaults={'_uri': '/docs/tutorials/futures/'}),
    Route('/articles/profiling/', RedirectHandler,
      defaults={'_uri': '/articles/benchmarking/'}),
    Route('/articles/m1-language-changes/', RedirectHandler,
      defaults={'_uri': '/articles/'}),
    Route('/articles/m2-whats-new/', RedirectHandler,
      defaults={'_uri': '/articles/'}),
    Route('/articles/m3-whats-new/iterables.html', RedirectHandler,
      defaults={'_uri': '/articles/'}),
    Route('/articles/dart-js/', RedirectHandler,
      defaults={'_uri': '/articles/js-dart-interop/'}),
    Route('/docs/editor/getting-started/', RedirectHandler,
      defaults={'_uri': '/docs/dart-up-and-running/contents/ch01.html#ch01-editor'}),
    Route('/docs/dart2js/', RedirectHandler,
      defaults={'_uri': '/docs/dart-up-and-running/contents/ch04-tools-dart2js.html'}),
    Route('/docs/standalone-dart-vm/', RedirectHandler,
      defaults={'_uri': '/docs/dart-up-and-running/contents/ch04-tools-dart-vm.html'}),
    Route('/events/2013/flight-school/', RedirectHandler,
      defaults={'_uri': '/events/2014/flight-school/'}),
    Route('/codelab', RedirectHandler,
      defaults={'_uri': '/codelabs/darrrt/'}),
    Route('/docs/tutorials/web-ui/', RedirectHandler,
      defaults={'_uri': '/docs/tutorials/polymer-intro/'}),
    Route('/docs/tutorials/templates/', RedirectHandler,
      defaults={'_uri': '/docs/tutorials/polymer-intro/'}),
    Route('/docs/tutorials/custom-elements/', RedirectHandler,
      defaults={'_uri': '/docs/tutorials/polymer-intro/'}),
    Route('/codelabs/web-ui-writer/codelab.pdf', RedirectHandler,
      defaults={'_uri': '/codelabs/'}),
    Route('/codelabs/web-ui-writer/', RedirectHandler,
      defaults={'_uri': '/codelabs/'}),
    Route('/tools/analyzer', RedirectHandler,
      defaults={'_uri': '/docs/dart-up-and-running/contents/ch04-tools-dart_analyzer.html'}),
    Route('/atom.xml', RedirectHandler,
      defaults={'_uri': 'http://news.dartlang.org/feeds/posts/default'}),
    Route('/+lexicalscope', RedirectHandler,
      defaults={'_uri': '/docs/dart-up-and-running/contents/ch02.html#ch02-lexical-scope'}),
    Route('/+pub', RedirectHandler,
      defaults={'_uri': 'https://pub.dartlang.org/'}),
    Route('/+dart2js', RedirectHandler,
      defaults={'_uri': '/docs/dart-up-and-running/contents/ch04-tools-dart2js.html'}),
    Route('/+isolates', RedirectHandler,
      defaults={'_uri': '/docs/dart-up-and-running/contents/ch03.html#ch03-dartisolate---concurrency-with-isolates'}),
    Route('/+', RedirectHandler,
      defaults={'_uri': 'https://google.com/+dartlang'}),
    Route('/mailing-list', RedirectHandler,
      defaults={'_uri': 'https://groups.google.com/a/dartlang.org/forum/#!forum/misc'}),
    Route('/<path:[^.]*[^/]$>', RedirectHandler,
      defaults={'_uri': trailing_slash})],
   debug=True)
