$(document).ready(function() {
  var links = document.querySelectorAll('a.pdf');

  for (var i = 0; i < links.length; i++) {
    var link = links[i];

    link.addEventListener('click', function(e) {
      var target = e.target;
      var href = '/' + target.attributes['href'].value;
      ga('send', 'pageview', href);
      ga('dartlangTracker.send', 'pageview', href);
    });
  }
});
