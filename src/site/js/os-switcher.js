$(document).ready(function() {
  var osList = ['macos', 'windows', 'linux'];

  function detectPlatform() {
    // default to 'linux', since linux strings are unpredictable.
    if (navigator.platform.indexOf('Win') != -1) {
      return 'windows';
    } else if (navigator.platform.indexOf('Mac') != -1) {
      return 'macos';
    } else {
      return 'linux';
    }
  }

  function filterPlatformText(showId) {    
    // Get all the platform-specific elements.
    for (var i = 0; i < osList.length; i++) {
      var os = osList[i];
      var shouldShow = (os === showId);
      $('.' + os).each(function(i, el) {      
        if (shouldShow) {
          $(el).show();
        } else {
          $(el).hide();
        }
      });
    }
  }

  function registerHandlers() {
    for (var i = 0; i < osList.length; i++) {
      var os = document.getElementById(osList[i]);
      if (os) {
        os.addEventListener('click', function(e) {
          filterPlatformText(e.target.id);
        });
      }
    }
  }

  var defaultOs = detectPlatform();
  var defaultOsElem = document.getElementById(defaultOs);
  if (defaultOsElem) {
    defaultOsElem.setAttribute('checked', 'checked');
    filterPlatformText(defaultOs);
    registerHandlers();
  }

});
