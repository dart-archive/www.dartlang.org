CDS.Util = (function() {

	"use strict";
	var appElement = document.querySelector('.app');

	function makeObject(keys, defaultValue) {

		var obj = {};
		for (var i = 0; i < keys.length; i++) {
			obj[keys[i]] = defaultValue;
		}

		return obj;
	}

	function getWindowScrollPosition() {
		if (typeof window.scrollY === 'undefined')
			return document.documentElement.scrollTop;
		else
			return window.scrollY;
	}

	function isIOS() {
		return (/(iPhone|iPad|iPod)/gi).test(navigator.platform);
	}

	function isSafari() {
		var userAgent = navigator.userAgent;
		return (/Safari/gi).test(userAgent) &&
			!(/Chrome/gi).test(userAgent);
	}

	function isChrome() {
		var userAgent = navigator.userAgent;
		return (/Chrome/gi).test(userAgent);
	}

	function isIE() {
		var userAgent = navigator.userAgent;
		return (/Trident/gi).test(userAgent);
	}

	return {
		appElement: appElement,
		isIE: isIE,
		isIOS: isIOS,
		isSafari: isSafari,
		isChrome: isChrome,
		makeObject: makeObject,
		getWindowScrollPosition: getWindowScrollPosition
	};

})();
