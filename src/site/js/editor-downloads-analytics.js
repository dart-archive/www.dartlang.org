$(document).ready(function() {
  var links = document.querySelectorAll('a.download-link');
  for (var i = 0; i < links.length; i++) {
    var link = links[i];

    link.addEventListener('click', function(e) {
      var target = e.target;
      var os = target.getAttribute('data-os') || 'unknown';
      var bits = target.getAttribute('data-bits') || 'unknown';
      var build = target.getAttribute('data-build') || 'unknown';
      var bitsAndBuild = build + '/' + bits;
      _gaq.push(['_trackEvent', 'Editor Downloads', os, bitsAndBuild, 1]);
    });
  }
});