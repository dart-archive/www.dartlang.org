$(document).ready(function() {
  var isMobile = {
      Android: function() {
          return navigator.userAgent.match(/Android/i) ? true : false;
      },
      BlackBerry: function() {
          return navigator.userAgent.match(/BlackBerry/i) ? true : false;
      },
      iOS: function() {
          return navigator.userAgent.match(/iPhone|iPad|iPod/i) ? true : false;
      },
      Windows: function() {
          return navigator.userAgent.match(/IEMobile/i) ? true : false;
      },
      any: function() {
          return (isMobile.Android() || isMobile.BlackBerry() || isMobile.iOS() || isMobile.Windows());
      }
  };

  if (isMobile.any() != true) {
    $('.download-buttons').show();
    $('.os-choices').show();
  }

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

// Anchor scrolling for the page
$(function() {
  var scrollPadding   = 5;

  $('a[href*=#]:not([href=#])').click(function() {
    if (location.pathname.replace(/^\//,'') == this.pathname.replace(/^\//,'') && location.hostname == this.hostname) {
      var target = $(this.hash);
      target = target.length ? target : $('[name=' + this.hash.slice(1) +']');
      var isnavtabs = $('.nav-tabs')[0];
      if (target.length && !isnavtabs) {
        var scrollOffset = $('.navbar').outerHeight() + scrollPadding;
        $('html,body').animate({
          scrollTop: target.offset().top - scrollOffset
        }, 1000);
        window.location.hash = this.hash;
        return false;
      } else {
        window.location.hash = this.hash;
      }
    }
  });
});



$(function(){
  
  var popOpen = false;

  $(".dart-popover").popover();

  $('.dart-popover').on( "click", function(e) {
    e.preventDefault();
    if (popOpen) {
      $(".dart-popover").not(this).popover('hide');
    } 
    popOpen = true;
  });


  // Adding the navigation to the popup
  // $("a.dart-popover").each(function(index) {
  //   var lnk = $(this);
    
  //   // Add prev and nex buttons
  //   if ( lnk == $('.lang-dart:first-child a.dart-popover') ) {
  //     //console.log('first');
  //     var navCopy = '<div class="popover_nav"><div class="left"></div><div class="right"><a class="btn" href="#">Next &gt;</a></div></div>';
  //   } else if ( lnk == $('.lang-dart a.dart-popover:last') ) {
  //     //console.log('last');
  //     var navCopy = '<div class="popover_nav"><div class="left"><a class="btn" href="#">&lt; Previous</a></div><div class="right"></div></div>';
  //   } else {
  //     //console.log('not first or last');
  //     var navCopy = '<div class="popover_nav"><div class="left"><a class="btn" href="#">&lt; Previous</a></div><div class="right"><a class="btn" href="#">Next &gt;</a></div></div>';
  //   };

  //   var orgCopy = lnk.attr('data-content');
  //   lnk.attr('data-content', orgCopy + navCopy);


  //   // Add close button to each one.
  //   var popTitle = lnk.attr('data-original-title');
  //   var closeBtn = '<a class="close-btn" href="javascript:"><i class="sprite-icon-close-x"></i></a>';
  //   lnk.attr('data-original-title', closeBtn + popTitle);

  // });

  // $( document ).ready(function() {
  //   $("a.close-btn").on( "click", function(e) {
  //     e.preventDefault();
  //     console.log('close was just called.');
  //   });
  // });

});


