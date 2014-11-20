CDS.RegisterPanel = (function() {

	"use strict";

	var container = document.querySelector('.summit-register');
	var panel = container.querySelector('.summit-dialog-panel');
	var showButton = document.querySelector('.summit-register-button');
	var hideButton = container.querySelector('button');
	var active = false;

	function show(evt) {
		// container.classList.add('active');
		// setTimeout(setIsActive, 200);

		if (evt.currentTarget.dataset.url)
			window.location = evt.currentTarget.dataset.url;
	}

	function setIsActive() {
		active = true;
	}

	function hide() {

		if (!active)
			return;

		active = false;
		container.classList.remove('active');
	}

	function cancelClick(evt) {
		evt.stopImmediatePropagation();
	}

	function onKeyUp(evt) {
		if (evt.keyCode !== 13 || !container.classList.contains('active'))
			return;

		hide();
	}

	panel.addEventListener('click', cancelClick);
	showButton.addEventListener('click', show);
	hideButton.addEventListener('click', hide);
	container.addEventListener('click', hide);

	CDS.EventPublisher.add('keyup', onKeyUp);

	return {
		show: show,
		hide: hide
	};

})();
