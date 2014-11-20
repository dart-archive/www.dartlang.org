CDS.Cards = (function() {

	"use strict";

	var cardElements = document.querySelectorAll('.card');
	var card;
	var cards = {};
	var cardId = '';

	for (var i = 0; i < cardElements.length; i++) {
		card = cardElements[i];
		cardId = card.querySelector('.card__see-more').getAttribute('href');
		cards[cardId] = new CDS.Card(card);
	}

	return cards;

})();
