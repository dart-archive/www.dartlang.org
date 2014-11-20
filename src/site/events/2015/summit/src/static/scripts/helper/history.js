CDS.History = (function() {

	"use strict";

	var activePath;
	var transitioningCard = null;

	function manageCards(opt_disableAnimation) {

		var currentPath = document.location.pathname;
		var compositePath = '/';

		if (typeof opt_disableAnimation !== 'boolean')
			opt_disableAnimation = false;

		if (activePath === currentPath)
			return;

		if (transitioningCard)
			return;

		// If the new card is not a child of the current section collapse it
		// before opening the new card.
		if (currentPath.indexOf(activePath) === -1 &&
			typeof CDS.Cards[activePath] !== 'undefined') {

			transitioningCard = CDS.Cards[activePath];
			transitioningCard.collapse();

		} else if (typeof CDS.Cards[currentPath] !== 'undefined') {

			// Step up through the path making sure any other cards are enabled
			currentPath.split('/').forEach(function(part) {

				if (part === '')
					return;

				compositePath += part + '/';

				if (compositePath !== currentPath &&
						typeof CDS.Cards[compositePath] !== 'undefined') {

					CDS.Cards[compositePath].expand(true);

				} else if (compositePath === currentPath) {

					transitioningCard = CDS.Cards[currentPath];
					transitioningCard.expand(opt_disableAnimation);
				}
			});
		}

		if (transitioningCard !== null) {
			transitioningCard.addEventListener('transitionend',
					onTransitionEnd.bind(transitioningCard), true);
		}

		activePath = currentPath;
	}

	function onPopState(evt) {
		evt.preventDefault();
		requestAnimFrame(manageCards);
	}

	function onTransitionEnd() {
		transitioningCard = null;
		requestAnimFrame(manageCards);
	}

	function forth(path) {
		window.history.pushState(null, "", path);
		requestAnimFrame(manageCards);
	}

	function back() {
		window.history.back();
	}

	function init() {
		manageCards(true);
		transitioningCard = null;
	}

	window.addEventListener('popstate', onPopState);

	return {
		back: back,
		forth: forth,
		init: init
	};

})();
