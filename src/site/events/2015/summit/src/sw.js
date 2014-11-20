importScripts('scripts/third_party/serviceworker-cache-polyfill.js');

var CACHE_NAME = 'dart-dev-summit';
var CACHE_VERSION = 8;

self.oninstall = function(event) {

  event.waitUntil(
    cachesPolyfill.open(CACHE_NAME + '-v' + CACHE_VERSION).then(function(cache) {

      return cache.addAll([

        '/events/2015/summit/',
        '/events/2015/summit/schedule/',
        '/events/2015/summit/sessions/',
        '/events/2015/summit/attendee-information/',
        '/events/2015/summit/get-involved/',
        '/events/2015/summit/about-chrome-dev-summit/',

        '/events/2015/summit/styles/cds.min.css',
        '/events/2015/summit/scripts/cds.min.js',
        '/events/2015/summit/images/dart-logo.png',
        '/events/2015/summit/images/icon-camera.svg',
        '/events/2015/summit/images/masthead-1.png',
        '/events/2015/summit/images/masthead-2.png',
        '/events/2015/summit/images/icon-back-arrow.svg',
        '/events/2015/summit/images/icon-schedule.svg',
        '/events/2015/summit/images/icon-schedule-gray.svg',
        '/events/2015/summit/images/icon-sessions.svg',
        '/events/2015/summit/images/icon-quad.svg',
        '/events/2015/summit/images/icon-get-involved.svg',
        '/events/2015/summit/images/pic-1.png',
        '/events/2015/summit/images/pic-2.png',
        '/events/2015/summit/images/pic-3.png'

      ]);
    })
  );
};

self.onactivate = function(event) {

  var currentCacheName = CACHE_NAME + '-v' + CACHE_VERSION;
  cachesPolyfill.keys().then(function(cacheNames) {
    return Promise.all(
      cacheNames.map(function(cacheName) {
        if (cacheName.indexOf(CACHE_NAME) == -1) {
          return;
        }

        if (cacheName != currentCacheName) {
          return cachesPolyfill.delete(cacheName);
        }
      })
    );
  });

};

self.onfetch = function(event) {

  var request = event.request;
  var requestURL = new URL(event.request.url);
  var randomNumber = 1 + Math.round(Math.random() * 3);
  var mastheadImage = /masthead\-(\d)/g;

  // If this is a masthead image we should just pick a
  // new one at random, as that's what the server-side
  // version of the code does.
  if (mastheadImage.test(requestURL.pathname)) {

    var replacedRequest = event.request.url.replace(
        mastheadImage, 'masthead-' + randomNumber);
    request = new Request(replacedRequest);
  }

  event.respondWith(

    // Check the cache for a hit.
    cachesPolyfill.match(request).then(function(response) {

      // If we have a response return it.
      if (response)
        return response;

      // Otherwise fetch it, store and respond.
      return fetch(request).then(function(response) {

        var responseToCache = response.clone();

        cachesPolyfill.open(CACHE_NAME + '-v' + CACHE_VERSION).then(
          function(cache) {
            cache.put(request, responseToCache).catch(function(err) {
              // Likely we got an opaque response which the polyfill
              // can't deal with, so log out a warning.
              console.warn(requestURL + ': ' + err.message);
            });
          });

        return response;
      });

    })
  );
};
