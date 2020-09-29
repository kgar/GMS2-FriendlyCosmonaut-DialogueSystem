active = false;
dialogue = undefined;
dialogueEntry = undefined;
currentPage = undefined;
currentText = undefined;
specsLength = undefined;
currentCharacterSpecs = undefined;
textIndex = undefined;
guiWidth = display_get_gui_width();
guiHeight = display_get_gui_height();
textboxWidth = guiWidth - 50; // TODO: Calculate this whenever I figure out what textbox sprite / methodology I'm using.
textboxHeight = guiHeight * 0.3; // TODO: Calculate this based on N lines of text, depending on the size of the standard dialogue font.
guiWhitespace = guiWidth - textboxWidth;
// TODO: Make a better name for this. It essentially is the padding for one side, not both sides.
textboxPaddingX = 10;
textboxPositionX = (guiWhitespace/2);
// TODO: Make a better name for this. It essentially is the padding for one side, not both sides.
textboxPaddingY = 10;
textboxPositionY = guiHeight - textboxHeight - 8;
dialogueSpeed = 1;
interactKey = ord("E");

function Init(_dialogue) {
	dialogue = _dialogue;
	TurnPage();
	active = true;
}

function TurnPage() {
	currentPage = currentPage == undefined
		? 0
		: currentPage + 1;
		
	if (currentPage >= array_length(dialogue)) {
		instance_destroy();
		return;
	}
		
	dialogueEntry = dialogue[currentPage];
	
	currentText = dialogueEntry.text;
	
	textIndex = 0;

	draw_set_font_temp(fnt_dialogue, function() {		
		currentCharacterSpecs = global.dialogue_functions.create_character_specs(
		dialogueEntry, 
		textboxWidth - textboxPaddingX * 2);
		
		specsLength = array_length(currentCharacterSpecs);
	});
	
	// Perform calculations, 
	// prepare any optional features for the page
	// etc.
}