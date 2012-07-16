$(document).ready(function() {
  var addPermalink = function() {
  	$(this).addClass('has-permalink');
  	$(this).append($('<a class="permalink" title="Permalink" href="#' + $(this).attr('id') + '">#</a>'));
  };

  $.each(['h2','h3','h4'], function(n, h) { $('.has-permalinks ' + h).each(addPermalink); });
});