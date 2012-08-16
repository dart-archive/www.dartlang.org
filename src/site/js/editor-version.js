$(document).ready(function() {
  var displayIntegrationVersion = function() {
    fetchEditorVersion('integration');
  };

  var updatePlaceholders = function(channel, version) {
    $('.editor-build-rev-' + channel).each(function(index, elem) {
      elem.innerHTML = version;
    });
  };

  var fetchEditorVersion = function(buildType) {
    $.ajax({
      type: "GET",
      url: 'http://dart-editor-archive-' + buildType + '.commondatastorage.googleapis.com/latest/VERSION',
      dataType: "json",
      success: function(data) {
        updatePlaceholders(buildType, data['revision']);
      },
      error: function(xhr, textStatus, errorThrown) {
        console.log(textStatus);
      }
    })
  };

  displayIntegrationVersion();
});