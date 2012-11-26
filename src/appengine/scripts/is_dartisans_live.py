from webapp2 import *
from google.appengine.api import memcache

class IsDartisansLiveNow(RequestHandler):
  def get(self):
    self.response.headers['Content-Type'] = 'application/json'
    live_show_num = memcache.get('dartisans-live-show-num')
    if live_show_num is not None:
      self.response.out.write('{"show-num": "%s"}' % live_show_num)
    else:
      self.response.out.write('{}')

class DartisansLiveConfig(RequestHandler):
  def get(self):
    if self.request.get('set') is not '':
      memcache.set('dartisans-live-show-num', self.request.get('set'), time=3600)
    elif self.request.get('delete') is not '':
      memcache.delete('dartisans-live-show-num')

application = WSGIApplication(
   [('/is-dartisans-live-now', IsDartisansLiveNow),
    ('/dartisans-live-config', DartisansLiveConfig)]
)