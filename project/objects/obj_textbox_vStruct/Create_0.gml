dialogue = undefined;
currentPage = undefined;
textIndex = undefined;
active = false;

function Init(_dialogue) {
	dialogue = _dialogue;
	TurnPage();
	active = true;
}

function TurnPage() {
	currentPage = currentPage == undefined
		? 0
		: currentPage + 1;
	
	textIndex = 0;
}
