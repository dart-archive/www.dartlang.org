// For Google+

function gplus_pressed(data) {
  if (data && data['state'] == 'on') {
    _gaq.push(['_trackEvent', 'Social', 'Share', 'Gplus', 1]);
  }
}

$(document).ready(function() {
  var gplus_circle = document.getElementById('gplus-circle');

  if (gplus_circle) {
    gplus_circle.addEventListener('click', function(e) {
      e.preventDefault();
      var target = e.target;
      var href = target.attributes['href'].value;
      _gaq.push(['_trackEvent', 'Social', 'Follow', 'Gplus', 1]);
      var destCommand = 'document.location = "' + href + '"';
      setTimeout(destCommand, 200);
    });
  }
});

// For Twitter

// See: https://dev.twitter.com/docs/intents/events
// assumes Twitter's widgets.js is loaded

function tweetIntentToAnalytics(intent_event) {
  if (intent_event) {
    _gaq.push(['_trackEvent', 'Social', 'Share', 'Twitter', 1]);
  };
}

function followIntentToAnalytics(intent_event) {
  if (intent_event) {
    _gaq.push(['_trackEvent', 'Social', 'Follow', 'Twitter', 1]);
  };
}

// Wait for the asynchronous resources to load
twttr.ready(function (twttr) {
  // Now bind our custom intent events
  // twttr.events.bind('click',    clickEventToAnalytics);
  twttr.events.bind('tweet',    tweetIntentToAnalytics);
  // twttr.events.bind('retweet',  retweetIntentToAnalytics);
  // twttr.events.bind('favorite', favIntentToAnalytics);
  twttr.events.bind('follow',   followIntentToAnalytics);
});

