// CDS.Livestream = (function() {

// 	"use strict";

// 	// var isIOS = /(iPhone|iPad|iPod)/gi.test(navigator.platform);
// 	var livestreamImage = document.querySelector('.livestream__image');
// 	var y, proportion = 0.4, displacement;

// 	// if (isIOS)
// 	// 	return;

// 	function onScroll() {

// 		y = CDS.Util.getWindowScrollPosition();

// 		if (y < 0)
// 			return;

// 		displacement = y * proportion;

// 		livestreamImage.style.webkitTransform = 'translateY(' + displacement + 'px)';
// 		livestreamImage.style.transform = 'translateY(' + displacement + 'px)';

// 	}

// 	CDS.EventPublisher.add('scroll', onScroll);

// })();
