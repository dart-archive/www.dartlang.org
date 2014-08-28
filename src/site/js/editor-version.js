$(document).ready(function() {
  var displayVersion = function() {
    fetchEditorVersion('stable');
    fetchEditorVersion('dev');
  };

  var updatePlaceholders = function(channel, version) {
    $('.editor-build-rev-' + channel).each(function(index, elem) {
        $(elem).text(version);
    });
    var download = 'https://storage.googleapis.com/dart-archive/channels/' + channel + '/release/latest/linux_packages/debian_wheezy/dart_' + version + '-1_amd64.deb';
    if (channel == 'stable') {
      var target = $("#debian-link-stable");
      target.attr('href', download);
    } else {
      var target = $("#debian-link-dev");
      target.attr('href', download);
    }
  }

  var fetchEditorVersion = function(channel) {
    $.ajax({
      type: "GET",
      url: 'https://storage.googleapis.com/dart-archive/channels/' + channel + '/release/latest/VERSION',
      dataType: "json",
      success: function(data) {
        updatePlaceholders(channel, data['version']);
      },
      error: function(xhr, textStatus, errorThrown) {
        console.log(textStatus);
      }
    })
  }

  displayVersion();
});
