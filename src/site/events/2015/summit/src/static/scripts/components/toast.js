CDS.Toast = function(message) {

	this.element_ = document.createElement('div');
	this.elementInner_ = document.createElement('div');

	this.elementInner_.innerText = message;

	this.element_.classList.add('toast');
	this.elementInner_.classList.add('toast__message');

	this.hide = this.hide.bind(this);

	this.element_.appendChild(this.elementInner_);
	document.body.appendChild(this.element_);

	requestAnimFrame(this.hide);

	return this;
};

CDS.Toast.prototype = {

	hide: function() {
		this.element_.classList.add('toast__hidden');
		this.element_.addEventListener('transitionend', this.remove_);
		this.element_.addEventListener('webkittransitionend', this.remove_);
	},

	remove_: function() {

		if (!this.element_)
			return;

		document.removeChild(this.element_);
	}
};

CDS.Toaster = {
	create: function(message) {
		return new CDS.Toast(message);
	}
};
