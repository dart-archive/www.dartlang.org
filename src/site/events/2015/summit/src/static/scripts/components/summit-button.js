CDS.Button = (function() {

	"use strict";

	var buttons = document.querySelectorAll('.paper-button');
	var button, bound, x, y, ripple, size, transformString;
	var frameCount = 0;

	for (var b = 0; b < buttons.length; b++) {
		button = buttons[b];
		bound = button.getBoundingClientRect();
		size = Math.max(bound.width, bound.height) * 2;

		ripple = button.querySelector('.ripple');
		ripple.style.width = size + 'px';
		ripple.style.height = size + 'px';

		button.addEventListener('click', onClick);
	}

	function onClick(evt) {

		if (frameCount > 0)
			return;

		var trackingEvent = evt.currentTarget.dataset.event;

		if (trackingEvent && typeof ga === 'function') {
			ga('send', 'event', 'button', 'click', trackingEvent);
		}

		frameCount = 1;
		bound = evt.currentTarget.getBoundingClientRect();
		x = Math.round(evt.clientX - bound.left);
		y = Math.round(evt.clientY - bound.top);
		transformString = 'translate(-50%, -50%) ' +
				'translate(' + x + 'px, ' + y + 'px) ' +
				'scale(0.0001, 0.0001)';

		ripple = evt.currentTarget.querySelector('.ripple');
		ripple.style.webkitTransform = transformString;
		ripple.style.transform = transformString;
		ripple.style.opacity = '0.4';
		ripple.classList.remove('animate');

		requestAnimFrame(reset);
	}

	function reset() {

		if (frameCount-- > 0) {
			requestAnimFrame(reset);
		} else {

			transformString = 'translate(-50%, -50%) ' +
					'translate(' + x + 'px, ' + y + 'px)' +
					'scale(1, 1)';

			ripple.style.webkitTransform = transformString;
			ripple.style.transform = transformString;
			ripple.style.opacity = '0';
			ripple.classList.add('animate');
		}
	}


})();
