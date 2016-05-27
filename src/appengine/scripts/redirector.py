# import logging
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

class PolymerRedirectPage(RequestHandler):
  def get(self):
    filename = self.request.path.split('/polymer/')[1]
    if filename == '' or filename == 'index.html':
        self.redirect('https://github.com/dart-lang/polymer-dart/wiki', permanent=True)
    else:
        self.redirect('/polymer-old/' + filename, permanent=True)

class ApiRedirectPage(RequestHandler):
  def get(self):
    filename = self.request.path.split('/docs/api/')[1]
    if filename == '' or filename == 'index.html':
        self.redirect('http://api.dartlang.org/', permanent=True)
    else:
        self.redirect('http://api.dartlang.org/dart_core/' + filename, permanent=True)

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
    self.redirect(self.request.scheme + '://' + self.prefix + path, permanent=False)

class EditorUpdateRedirect(CloudStorageRedirect):
  prefix = 'storage.googleapis.com/dart-editor-archive-integration'

class EditorUpdateRedirectBeChannel(CloudStorageRedirect):
  prefix = 'storage.googleapis.com/dart-archive/channels/be/raw'

class EditorUpdateRedirectDevChannel(CloudStorageRedirect):
  prefix = 'storage.googleapis.com/dart-archive/channels/dev/release'

class EditorUpdateRedirectStableChannel(CloudStorageRedirect):
  prefix = 'storage.googleapis.com/dart-archive/channels/stable/release'

class EclipseUpdateRedirectBase(CloudStorageRedirect):
  def get(self, *args, **kwargs):
    filename = kwargs['path']
    if filename == '' or filename == '/':
      filename = '/index.html'
    self.redirect_to_cloud_storage(filename)

class EclipseUpdateRedirectBeChannel(EclipseUpdateRedirectBase):
  prefix = 'storage.googleapis.com/dart-archive/channels/be/raw/latest/editor-eclipse-update'

class EclipseUpdateRedirectDevChannel(EclipseUpdateRedirectBase):
  prefix = 'storage.googleapis.com/dart-archive/channels/dev/release/latest/editor-eclipse-update'

class EclipseUpdateRedirectStableChannel(EclipseUpdateRedirectBase):
  prefix = 'storage.googleapis.com/dart-archive/channels/stable/release/latest/editor-eclipse-update'

class ServerRedirect(RequestHandler):
  def get(self):
    filename = self.request.path.split('/server/')[1]
    if filename == 'tls-ssl.html':
        self.redirect('https://dart-lang.github.io/server/tls-ssl.html', permanent=True)
    elif filename.find("app-engine") != -1:
        self.redirect('https://dart-lang.github.io/server/google-cloud-platform/app-engine/', permanent=True)
    elif filename.find("google-cloud-platform") != -1:
        self.redirect('https://dart-lang.github.io/server/google-cloud-platform/', permanent=True)
    else:
        self.redirect('https://dart-lang.github.io/server/', permanent=True)

class BookRedirect(RequestHandler):
  # logging.info('in BookRedirect')
  def get(self):
    filename = self.request.path.split(
                '/docs/dart-up-and-running/contents/')[1]
    book_home = '/docs/dart-up-and-running/'
    filenames = ['foreword.html', 'preface.html', 'ch01.html', 'ch02.html',
                 'ch03.html', 'ch04.html', 'ch05.html']
    if filename in filenames:
        self.redirect(book_home + filename, permanent=True)
    elif filename == 'ch04-tools-pub.html':
        self.redirect('/tools/pub/', permanent=True)
    elif filename == 'ch04-tools-editor.html':
        self.redirect('/tools/', permanent=True)
    elif filename == 'ch04-tools-dartium.html':
        self.redirect('/tools/dartium/', permanent=True)
    elif filename == 'ch04-tools-dartdoc.html':
        self.redirect('https://github.com/dart-lang/dartdoc#dartdoc', permanent=True)
    elif filename == 'ch04-tools-dart2js.html':
        self.redirect('/tools/dart2js/', permanent=True)
    elif filename == 'ch04-tools-dart-vm.html':
        self.redirect('/tools/dart-vm/', permanent=True)
    elif filename == 'ch04-tools-dart_analyzer.html':
        self.redirect('https://github.com/dart-lang/sdk/tree/master/pkg/analyzer#analyzer-for-dart', permanent=True)
    else:
        self.redirect(book_home)

class CookbookRedirect(RequestHandler):
  def get(self):
    self.redirect('/docs/dart-up-and-running/ch03.html', permanent=True)

def trailing_slash(handler, *args, **kwargs):
  return '/' + kwargs['path'] + '/'

application = WSGIApplication(
   [('/docs/api/.*', ApiRedirectPage),
    ('/polymer/.*', PolymerRedirectPage),
    ('/news.*', NewsRedirectPage),
    ('/hangouts.*', HangoutsRedirectPage),
    ('/docs/pub-package-manager/.*', PubRedirectPage),
    ('/docs/dart-up-and-running/contents/.*', BookRedirect),
    ('/server/.*', ServerRedirect),
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
    Route('/docs/cookbook/', CookbookRedirect),
    Route('/tools/editor/<:.*>', RedirectHandler,
      defaults={'_uri': '/tools/'}),
    Route('/tools/eclipse-plugin/<:.*>', RedirectHandler,
      defaults={'_uri': '/tools/'}),
    Route('/dartisans/podcast-feed', RedirectHandler,
      defaults={'_uri': 'http://feeds.feedburner.com/DartisansDartProgrammingLanguagePodcast',
                '_code': 302}),
    Route('/mobile/', RedirectHandler,
      defaults={'_uri': '/devices/'}),
    Route('/docs/spec/deferred-loading.html', RedirectHandler,
      defaults={'_uri': '/docs/dart-up-and-running/ch02.html#deferred-loading'}),
    Route('/docs/spec/proposedDartLangSpec.pdf', RedirectHandler,
      defaults={'_uri': '/docs/spec/'}),
    Route('/docs/spec/<:.*>', RedirectHandler,
      defaults={'_uri': '/docs/spec/'}),
    Route('/articles/dart-web-components/', RedirectHandler,
      defaults={'_uri': '/polymer-old/upgrading-to-polymer-from-web-ui.html'}),
    Route('/articles/web-ui/', RedirectHandler,
      defaults={'_uri': '/polymer-old/upgrading-to-polymer-from-web-ui.html'}),
    Route('/web-ui/observables/', RedirectHandler,
      defaults={'_uri': '/polymer-old/upgrading-to-polymer-from-web-ui.html'}),
    Route('/docs/technical-overview/', RedirectHandler,
      defaults={'_uri': '/docs/dart-up-and-running/ch01.html'}),
    Route('/tools/download-editor.html', RedirectHandler,
      defaults={'_uri': '/downloads/'}),
    Route('/downloads.html', RedirectHandler,
      defaults={'_uri': '/downloads/'}),
    Route('/tools/debian.html', RedirectHandler,
      defaults={'_uri': '/downloads/linux.html'}),
    Route('/tools/more_downloads.html', RedirectHandler,
      defaults={'_uri': '/tools/'}),
    Route('/tools/download_archive/', RedirectHandler,
      defaults={'_uri': '/downloads/archive/'}),
    Route('/tools/download-archive/', RedirectHandler,
      defaults={'_uri': '/downloads/archive/'}),
    Route('/tools/download.html', RedirectHandler,
      defaults={'_uri': '/downloads/'}),
    Route('/googleapis/', RedirectHandler,
      defaults={'_uri': 'https://github.com/dart-lang/googleapis#google-apis-client-libraries-with-dart'}),
    Route('/tools/dartdoc/', RedirectHandler,
      defaults={'_uri': 'https://github.com/dart-lang/dartdoc#dartdoc'}),
    Route('/tools/dartfmt/', RedirectHandler,
      defaults={'_uri': 'https://github.com/dart-lang/dart_style#readme'}),
    Route('/tools/observatory/', RedirectHandler,
      defaults={'_uri': 'https://dart-lang.github.io/observatory/'}),
    Route('/tools/docgen/', RedirectHandler,
      defaults={'_uri': 'https://github.com/dart-lang/dartdoc#dartdoc'}),
    Route('/tools/dartdocgen/', RedirectHandler,
      defaults={'_uri': 'https://github.com/dart-lang/dartdoc#dartdoc'}),
    Route('/tools/analyzer/', RedirectHandler,
      defaults={'_uri': 'https://github.com/dart-lang/sdk/tree/master/pkg/analyzer#analyzer-for-dart'}),
    Route('/language-tour/', RedirectHandler,
      defaults={'_uri': '/docs/dart-up-and-running/ch02.html'}),
    Route('/docs/language-tour/', RedirectHandler,
      defaults={'_uri': '/docs/dart-up-and-running/ch02.html'}),
    Route('/docs/library-tour/', RedirectHandler,
      defaults={'_uri': '/docs/dart-up-and-running/ch03.html'}),
    Route('/eclipse/', RedirectHandler,
      defaults={'_uri': '/tools/'}),
    Route('/dart2js-stripped-uri', RedirectHandler,
      defaults={'_uri': 'https://groups.google.com/a/dartlang.org/forum/#!topic/misc/xuL-MNlcJSY'}),
    Route('/dart2js-reflection', RedirectHandler,
      defaults={'_uri': 'https://code.google.com/p/dart/issues/detail?id=21654'}),
    Route('/docs/editor<:/?>', RedirectHandler,
      defaults={'_uri': '/tools/'}),
    Route('/editor<:/?>', RedirectHandler,
      defaults={'_uri': '/tools/'}),
    Route('/docs/sdk<:/?>', RedirectHandler,
      defaults={'_uri': '/tools/sdk/'}),
    Route('/polymer-dart/reference/release-notes/', RedirectHandler,
      defaults={'_uri': '/polymer-old/reference/release-notes/'}),
    Route('/polymer-dart/', RedirectHandler,
      defaults={'_uri': '/polymer-old/'}),
    Route('/dartium/', RedirectHandler,
      defaults={'_uri': '/tools/dartium/'}),
    Route('/community/', RedirectHandler,
      defaults={'_uri': '/support/'}),
    Route('/docs/getting-started/editor/', RedirectHandler,
      defaults={'_uri': '/docs/dart-up-and-running/ch01.html#up-and-running'}),
    Route('/docs/getting-started/sdk/', RedirectHandler,
      defaults={'_uri': '/docs/sdk/'}),
    Route('/resources/', RedirectHandler,
      defaults={'_uri': '/community/'}),
    Route('/articles/feet-wet-streams/', RedirectHandler,
      defaults={'_uri': '/docs/tutorials/streams/'}),
    Route('/articles/dart-unit-tests/', RedirectHandler,
      defaults={'_uri': 'https://pub.dartlang.org/packages/test'}),
    Route('/articles/mocking-with-dart/', RedirectHandler,
      defaults={'_uri': 'https://pub.dartlang.org/packages/mockito'}),
    Route('/articles/writing-unit-tests-for-pub-packages/', RedirectHandler,
      defaults={'_uri': 'https://pub.dartlang.org/packages/test'}),
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
    Route('/articles/api-naming-guide/', RedirectHandler,
      defaults={'_uri': '/effective-dart/'}),
    Route('/articles/doc-comment-guidelines/', RedirectHandler,
      defaults={'_uri': '/effective-dart/documentation/'}),
    Route('/articles/idiomatic-dart/', RedirectHandler,
      defaults={'_uri': '/effective-dart/'}),
    Route('/articles/style-guide/', RedirectHandler,
      defaults={'_uri': '/effective-dart/style/'}),
    Route('/docs/editor/getting-started/', RedirectHandler,
      defaults={'_uri': '/docs/dart-up-and-running/ch01.html#up-and-running'}),
    Route('/docs/dart2js/', RedirectHandler,
      defaults={'_uri': '/tools/dart2js/'}),
    Route('/docs/standalone-dart-vm/', RedirectHandler,
      defaults={'_uri': '/tools/dart-vm/'}),
    Route('/events/2013/flight-school/', RedirectHandler,
      defaults={'_uri': '/events/2014/flight-school/'}),
    Route('/codelab', RedirectHandler,
      defaults={'_uri': '/codelabs/darrrt/'}),
    Route('/docs/tutorials/using-polymer/', RedirectHandler,
      defaults={'_uri': 'https://github.com/dart-lang/polymer-dart/wiki'}),
    Route('/docs/tutorials/forms/', RedirectHandler,
      defaults={'_uri': 'https://angular.io/docs/dart/latest/guide/forms.html'}),
    Route('/docs/tutorials/indexeddb/', RedirectHandler,
      defaults={'_uri': '/docs/tutorials/'}),
    Route('/codelabs/web-ui-writer/codelab.pdf', RedirectHandler,
      defaults={'_uri': '/codelabs/'}),
    Route('/codelabs/web-ui-writer/', RedirectHandler,
      defaults={'_uri': '/codelabs/'}),
    Route('/codelabs/deploy/', RedirectHandler,
      defaults={'_uri': '/codelabs/'}),
    Route('/codelabs/server/', RedirectHandler,
      defaults={'_uri': 'https://dart-lang.github.io/server/codelab/'}),
    Route('/docs/dart-up-and-running/ch05.html', RedirectHandler,
      defaults={'_uri': '/docs/dart-up-and-running/'}),
    Route('/atom.xml', RedirectHandler,
      defaults={'_uri': 'http://news.dartlang.org/feeds/posts/default'}),
    Route('/+lexicalscope', RedirectHandler,
      defaults={'_uri': '/docs/dart-up-and-running/ch02.html#lexical-scope'}),
    Route('/+pub', RedirectHandler,
      defaults={'_uri': 'https://pub.dartlang.org/'}),
    Route('/+dart2js', RedirectHandler,
      defaults={'_uri': '/tools/dart2js/'}),
    Route('/+isolates', RedirectHandler,
      defaults={'_uri': 'https://dart-lang.github.io/observatory/isolate.html'}),
    Route('/cloud/', RedirectHandler,
      defaults={'_uri': 'https://dart-lang.github.io/server/'}),
    Route('/+', RedirectHandler,
      defaults={'_uri': 'https://google.com/+dartlang'}),
    Route('/mailing-list', RedirectHandler,
      defaults={'_uri': 'https://groups.google.com/a/dartlang.org/forum/#!forum/misc'}),
    Route('/redirects/sdk-download-stable', RedirectHandler,
          defaults={'_uri': '/downloads/'}),
    Route('/redirects/sdk-download-dev', RedirectHandler,
          defaults={'_uri': '/downloads/'}),
    Route('/<path:[^.]*[^/]$>', RedirectHandler,
      defaults={'_uri': trailing_slash})],
   debug=True)
