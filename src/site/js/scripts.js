$(document).ready(function() {
  var addPermalink = function() {
    if ($(this).hasClass('no-permalink')) {
      return;
    }
  	$(this).addClass('has-permalink');
  	$(this).append($('<a class="permalink" title="Permalink" href="#' + $(this).attr('id') + '">#</a>'));
  };

  $.each(['h2','h3','h4'], function(n, h) { $('.has-permalinks ' + h).each(addPermalink); });

  // Add the `prettyprint` class to the blocks of code specified in the way that
  // the book pages use.
  $('pre.programlisting > em > span.remark, pre.screen > em > span.remark')
      .each(function(i, element) {
    var $element = $(element);
    var $programListing = $element.parent().parent();
    $programListing.addClass('prettyprint');
    // This regular expression is to test if this remark is of the right form to
    // specify the language of the code block.
    var re = /^lang\-[a-z]+$/i;
    if (re.test($element.text().trim())) {
      $programListing.addClass($element.text().trim());
    }
  });

  // Add syntax highlighting.
  prettyPrint();
});
