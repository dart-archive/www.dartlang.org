CDS.Masthead = (function() {

	"use strict";

	var RANGE = 30;
	var masthead = document.querySelector('.masthead');
	var mastheadColorBlock = masthead.querySelector('.masthead__color-block');
	var y;

	function onScroll() {

		y = CDS.Util.getWindowScrollPosition();

		if (y < 0)
			return;

		mastheadColorBlock.style.opacity = Math.min(1, Math.max(0, y / RANGE));
	}

	CDS.EventPublisher.add('scroll', onScroll);

})();
