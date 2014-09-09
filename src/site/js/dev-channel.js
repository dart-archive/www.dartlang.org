$(document).ready(function() {
  $.getJSON(
    "https://storage.googleapis.com/dart-archive/channels/dev/release/latest/VERSION",
    function( data ) {
        var date = data.date;
        var revDate = date.substr(0,4) + "-" + date.substr(4,2) + "-" + date.substr(6,2);
        $(".dev-channel").append($("<strong></strong>").text("version " +data.version))
                         .append($("<span></span>").text(", built on " + revDate))
                         .append($("<span></span>").text(", at revision " + data.revision));
  });
});
