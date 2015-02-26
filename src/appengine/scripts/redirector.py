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
        self.redirect('/tools/editor', permanent=True)
    elif filename == 'ch04-tools-dartium.html':
        self.redirect('/tools/dartium/', permanent=True)
    elif filename == 'ch04-tools-dartdoc.html':
        self.redirect('/tools/dartdocgen/', permanent=True)
    elif filename == 'ch04-tools-dart2js.html':
        self.redirect('/tools/dart2js/', permanent=True)
    elif filename == 'ch04-tools-dart-vm.html':
        self.redirect('/tools/dart-vm/', permanent=True)
    elif filename == 'ch04-tools-dart_analyzer.html':
        self.redirect('/tools/analyzer/', permanent=True)
    else:
        self.redirect(book_home)


class CloudRedirect(RequestHandler):
  # logging.info('in CloudRedirect')
  def get(self):
    filename = self.request.path.split('/cloud')[1]
    app_engine_home = '/server/google-cloud-platform/app-engine/'
    if filename == '' or filename == '/':
        self.redirect(app_engine_home, permanent=True)

class CloudFilesRedirect(RequestHandler):
  # logging.info('in CloudFilesRedirect')
  def get(self):
    filename = self.request.path.split('/cloud/')[1]
    app_engine_home = '/server/google-cloud-platform/app-engine/'
    filenames = ['api.html', 'deploy.html', 'index.html' 'run.html',
                 'setup.html', 'client-server']
    if filename in filenames:
        self.redirect(app_engine_home + filename, permanent=True)

class ClientServerRedirect(RequestHandler):
  # logging.info('in ClientServerRedirect')
  def get(self):
    filename = self.request.path.split('/cloud/clientserver')[1]
    client_server_home = '/server/google-cloud-platform/app-engine/client-server/'
    if filename == '' or filename == '/':
        self.redirect(client_server_home, permanent=True)

class ClientServerFilesRedirect(RequestHandler):
  # logging.info('in ClientServerFilesRedirect')
  def get(self):
    filename = self.request.path.split('/cloud/client-server/')[1]
    client_server_home = '/server/google-cloud-platform/app-engine/client-server/'
    filenames = ['client-code.html', 'server-code.html']
    if filename == '' or filename == 'index.html':
        self.redirect(client_server_home)
    elif filename in filenames:
        self.redirect(client_server_home + filename, permanent=True)

class CookbookRedirect(RequestHandler):
  def get(self):
    self.redirect('/docs/dart-up-and-running/ch03.html', permanent=True)

def trailing_slash(handler, *args, **kwargs):
  return '/' + kwargs['path'] + '/'

application = WSGIApplication(
   [('/docs/api/.*', ApiRedirectPage),
    ('/news.*', NewsRedirectPage),
    ('/hangouts.*', HangoutsRedirectPage),
    ('/docs/pub-package-manager/.*', PubRedirectPage),
    ('/docs/dart-up-and-running/contents/.*', BookRedirect),
    ('/cloud/client-server/.*', ClientServerFilesRedirect),
    ('/cloud/', CloudRedirect),
    ('/cloud/.*', CloudFilesRedirect),
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
    Route('/dartisans/podcast-feed', RedirectHandler,
      defaults={'_uri': 'http://feeds.feedburner.com/DartisansDartProgrammingLanguagePodcast',
                '_code': 302}),
    Route('/docs/spec/deferred-loading.html', RedirectHandler,
      defaults={'_uri': '/docs/dart-up-and-running/ch02.html#deferred-loading'}),
    Route('/docs/spec/proposedDartLangSpec.pdf', RedirectHandler,
      defaults={'_uri': '/docs/spec/'}),
    Route('/docs/spec/<:.*>', RedirectHandler,
      defaults={'_uri': '/docs/spec/'}),
    Route('/articles/dart-web-components/', RedirectHandler,
      defaults={'_uri': '/polymer/upgrading-to-polymer-from-web-ui.html'}),
    Route('/articles/web-ui/', RedirectHandler,
      defaults={'_uri': '/polymer/upgrading-to-polymer-from-web-ui.html'}),
    Route('/web-ui/observables/', RedirectHandler,
      defaults={'_uri': '/polymer/upgrading-to-polymer-from-web-ui.html'}),
    Route('/docs/technical-overview/', RedirectHandler,
      defaults={'_uri': '/docs/dart-up-and-running/ch01.html'}),
    Route('/tools/download-editor.html', RedirectHandler,
      defaults={'_uri': '/tools/download.html'}),
    Route('/downloads.html', RedirectHandler,
      defaults={'_uri': '/tools/download.html'}),
    Route('/tools/download_archive/', RedirectHandler,
      defaults={'_uri': '/tools/download-archive/'}),
    Route('/tools/dartdoc/', RedirectHandler,
      defaults={'_uri': '/tools/dartdocgen/'}),
    Route('/tools/docgen/', RedirectHandler,
      defaults={'_uri': '/tools/dartdocgen/'}),
    Route('/language-tour/', RedirectHandler,
      defaults={'_uri': '/docs/dart-up-and-running/ch02.html'}),
    Route('/docs/language-tour/', RedirectHandler,
      defaults={'_uri': '/docs/dart-up-and-running/ch02.html'}),
    Route('/docs/library-tour/', RedirectHandler,
      defaults={'_uri': '/docs/dart-up-and-running/ch03.html'}),
    Route('/eclipse/', RedirectHandler,
      defaults={'_uri': '/tools/eclipse-plugin/'}),
    Route('/dart2js-stripped-uri', RedirectHandler,
      defaults={'_uri': 'https://groups.google.com/a/dartlang.org/forum/#!topic/misc/xuL-MNlcJSY'}),
    Route('/dart2js-reflection', RedirectHandler,
      defaults={'_uri': 'https://code.google.com/p/dart/issues/detail?id=21654'}),
    Route('/docs/editor/troubleshoot.html', RedirectHandler,
      defaults={'_uri': '/tools/editor/troubleshoot.html'}),
    Route('/docs/editor<:/?>', RedirectHandler,
      defaults={'_uri': '/tools/editor/'}),
    Route('/docs/sdk<:/?>', RedirectHandler,
      defaults={'_uri': '/tools/sdk/'}),
    Route('/editor<:/?>', RedirectHandler,
      defaults={'_uri': '/tools/editor/'}),
    Route('/polymer-dart/reference/release-notes/', RedirectHandler,
      defaults={'_uri': '/polymer/reference/release-notes/'}),
    Route('/polymer-dart/', RedirectHandler,
      defaults={'_uri': '/polymer/'}),
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
      defaults={'_uri': '/docs/dart-up-and-running/ch01.html#up-and-running'}),
    Route('/docs/dart2js/', RedirectHandler,
      defaults={'_uri': '/tools/dart2js/'}),
    Route('/docs/standalone-dart-vm/', RedirectHandler,
      defaults={'_uri': '/tools/dart-vm/'}),
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
    Route('/codelabs/deploy/', RedirectHandler,
      defaults={'_uri': '/codelabs/'}),
    Route('/atom.xml', RedirectHandler,
      defaults={'_uri': 'http://news.dartlang.org/feeds/posts/default'}),
    Route('/+lexicalscope', RedirectHandler,
      defaults={'_uri': '/docs/dart-up-and-running/ch02.html#lexical-scope'}),
    Route('/+pub', RedirectHandler,
      defaults={'_uri': 'https://pub.dartlang.org/'}),
    Route('/+dart2js', RedirectHandler,
      defaults={'_uri': '/tools/dart2js/'}),
    Route('/+isolates', RedirectHandler,
      defaults={'_uri': '/tools/observatory/isolate.html'}),
    Route('/+', RedirectHandler,
      defaults={'_uri': 'https://google.com/+dartlang'}),
    Route('/mailing-list', RedirectHandler,
      defaults={'_uri': 'https://groups.google.com/a/dartlang.org/forum/#!forum/misc'}),
    Route('/<path:[^.]*[^/]$>', RedirectHandler,
      defaults={'_uri': trailing_slash})],
   debug=True)
