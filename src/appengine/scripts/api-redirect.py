from google.appengine.ext import webapp
from google.appengine.ext.webapp.util import run_wsgi_app

class ApiRedirectPage(webapp.RequestHandler):
    def get(self):
        filename = self.request.path.split('/docs/api/')[1]
        if filename == '' or filename == 'index.html':
            self.redirect('http://api.dartlang.org/', permanent=True)
        else:
            self.redirect('http://api.dartlang.org/dart_core/' + filename, permanent=True)

application = webapp.WSGIApplication(
                                     [('/docs/api/.*', ApiRedirectPage)],
                                     debug=True)

def main():
    run_wsgi_app(application)

if __name__ == "__main__":
    main()