CDS.Analytics = (function() {

	"use strict";

	function track(name, type, value) {

		if (typeof ga === 'function') {
			ga('send', 'event', name, type, value);
		}
	}

	return {
		track: track
	};

})();
