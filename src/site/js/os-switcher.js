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
      $('.' + os).each(function(i, el) { $(el).toggle(shouldShow); });
    }
  }

  function resetButtons(el) {
    if (el.tagName == "BUTTON") {
      $('.btn-group.os-choices button').removeClass('active').addClass('inactive');
    }
    $(el).removeClass('inactive').addClass('active');
  }

  function registerHandlers() {
    for (var i = 0; i < osList.length; i++) {
      var os = document.getElementById(osList[i]);
      if (os) {
        os.addEventListener('click', function(e) {
          filterPlatformText(e.target.id);
          resetButtons(e.target);
        });
      }
    }
  }

  var defaultOs = detectPlatform();
  $('.' + defaultOs+'-option').prop('selected', true);
  var defaultOsElem;
  defaultOsElem = $('input#' + defaultOs);
  if (defaultOsElem.length > 0) {
    defaultOsElem.attr('checked', 'checked')
  }

  defaultOsElem = $('button#' + defaultOs);
  if (defaultOsElem.length > 0) {
    resetButtons(defaultOsElem[0]);
  }
  //if (defaultOsElem.length > 0) {
    filterPlatformText(defaultOs);
    registerHandlers();
  //}
});
