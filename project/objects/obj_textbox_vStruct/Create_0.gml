active = false;
dialogue = undefined;
dialogueEntry = undefined;
currentPage = undefined;
currentText = undefined;
textLength = undefined;
specsLength = undefined;
currentCharacterSpecs = undefined;
textIndex = undefined;
guiWidth = display_get_gui_width();
guiHeight = display_get_gui_height();
textboxWidth = guiWidth - 50; // TODO: Calculate this whenever I figure out what textbox sprite / methodology I'm using.
textboxHeight = guiHeight * 0.3;
guiWhitespace = guiWidth - textboxWidth;
textboxPaddingX = 10;
textboxPositionX = (guiWhitespace/2);
textboxPaddingY = 10;
textboxPositionY = guiHeight - textboxHeight - 8;
dialogueSpeed = 1;

function Init(_dialogue) {
	dialogue = _dialogue;
	TurnPage();
	active = true;
}

function TurnPage() {
	currentPage = currentPage == undefined
		? 0
		: currentPage + 1;
		
	dialogueEntry = dialogue[currentPage];
	
	currentText = dialogueEntry.text;
	textLength = string_length(dialogueEntry.text);
	
	textIndex = 0;

	draw_set_font_temp(fnt_dialogue, function() {		
		currentCharacterSpecs = global.dialogue_functions.create_character_specs(
		currentText, 
		textboxWidth - textboxPaddingX,
		textLength);
		
		specsLength = array_length(currentCharacterSpecs);
	});
	
	// Perform calculations, 
	// prepare any optional features for the page
	// etc.
}