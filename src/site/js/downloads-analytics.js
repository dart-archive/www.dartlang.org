$(document).ready(function() {
    countClicks();
});

function countClicks() {
  var links = document.querySelectorAll('a.download-link');
  for (var i = 0; i < links.length; i++) {
    var link = links[i];

    link.addEventListener('click', function(e) {
      var downloadType;
      if (link.dataset['tool'] == "editor") {
        downloadType = "Editor Downloads";
      } else if (link.dataset['tool'] == "sdk") {
        downloadType = "SDK Downloads";
      } else if (link.dataset['tool'] == "dartium") {
        downloadType = "Dartium Downloads";
      } else {
        downloadType = "Unknown Downloads";
      }

      var target = e.currentTarget;
      var os = target.getAttribute('data-os') || 'unknown';
      var bits = target.getAttribute('data-bits') || 'unknown';
      var build = target.getAttribute('data-build') || 'unknown';
      var bitsAndBuild = build + '/' + bits;
      _gaq.push(['_trackEvent', downloadType, os, bitsAndBuild, 1]);
    });
  }
}
