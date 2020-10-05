active = false;

// Dialogue Settings
dialogue = undefined;
dialogueEntry = undefined;
currentPage = undefined;
currentText = undefined;

// Normal Dialogue
dialogueSpeed = 1;
specsLength = undefined;
currentCharacterSpecs = undefined;
textIndex = undefined;

// Choice Dialogue
choiceMoveSound = snd_moveselect;
choiceSelectSound = snd_select;
choiceTextColor = c_yellow;
choicePointerSprite = spr_dialoguefinished;
chosen = false;
currentChoiceIndex = 0;

// Input
interactKey = ord("E");
choiceMoveUpKey = vk_up;
choiceMoveDownKey = vk_down;

// Delayed actions
delayedAction = undefined;

// Draw Settings
stringHeight = undefined;
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

// Effect Settings
waveEffectAmplitude = 4;

function Init(_dialogue) {
	dialogue = _dialogue;
	TurnPage();
	active = true;
}

function TurnPage() {
	currentPage = currentPage == undefined
		? 0
		: currentPage + 1;
		
	currentChoiceIndex = 0;
	chosen = false;
		
	if (currentPage >= array_length(dialogue)) {
		instance_destroy();
		return;
	}
	
	dialogueSpeed = 1;
	
	if (dialogueEntry != undefined && variable_struct_exists(dialogueEntry, "onPageTurn")) {
		dialogueEntry.onPageTurn();
	}
	
	dialogueEntry = dialogue[currentPage];
	
	currentText = dialogueEntry.text;
	
	textIndex = 0;

	draw_set_font_temp(fnt_dialogue, function() {		
		stringHeight = string_height("M");
		currentCharacterSpecs = global.dialogue_functions.create_character_specs(
		dialogueEntry, 
		textboxWidth - textboxPaddingX * 2);
		
		specsLength = array_length(currentCharacterSpecs);
	});
	
	// Perform calculations, 
	// prepare any optional features for the page
	// etc.
}

function ProcessChoice() {
	// Get choice object based on chosen index
	
	// Optionally execute associated action
	
	// Optionally adjust custom page turn; else, turn page normally
	
	
}