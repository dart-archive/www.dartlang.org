$(document).ready(function() {
  $.ajax("/is-dartisans-live-now", {dataType: 'json'}).done(function (data) {
    if (data['show-num']) {
      var url = 'https://developers.google.com/live/shows/' + data['show-num'] + '/' +
                '?utm_source=dartlang&utm_medium=ribbon&utm_campaign=dartisans-live';
      $('#dartisans-ribbon')[0].href = url;
      // TODO: set analytics
      $('#dartisans-ribbon').show();
    }
  });
});