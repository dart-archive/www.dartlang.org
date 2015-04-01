$(document).ready(function() {
  var downloadList = ['editor', 'sdk'];

  function registerDownloadHandlers() {
    filterDownloadText('sdk'); // Make SDK the default download.
    for (var i = 0; i < downloadList.length; i++) {
      var download = downloadList[i];
      var downloadButton = document.getElementById(download);
      if (downloadButton) {
        downloadButton.addEventListener('click', function(e) {
          filterDownloadText(e.target.id);
          highlightDownload(e.target.id);
          recordDownloadChoice(e.target.id);
        });
      }
    }
  }

  function highlightDownload(buttonId) {
    for (var i = 0; i < downloadList.length; i++) {
      if (downloadList[i] != buttonId) {
        $('#' + downloadList[i]).removeClass('btn-primary');
      } else {
        $('#' + downloadList[i]).addClass('btn-primary');
      }
    }
  }

  function filterDownloadText(showId) {
    // Get all the platform-specific elements.
    for (var i = 0; i < downloadList.length; i++) {
      var download = downloadList[i];
      var shouldShow = (download === showId);
      $('.' + download).each(function(i, el) { $(el).toggle(shouldShow); });
    }
  }

  function recordDownloadChoice(buttonId) {
    var downloadChoice = buttonId;
    ga('send', 'event', 'Download Choice', downloadChoice, 1);
    ga('dartlangTracker.send', 'event', 'Download Choice', downloadChoice, 1);
  }

  registerDownloadHandlers();
});
