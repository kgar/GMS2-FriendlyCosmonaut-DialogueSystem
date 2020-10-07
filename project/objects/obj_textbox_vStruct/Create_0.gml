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
specIndex = undefined;

// Choice Dialogue
choiceChangeSound = snd_moveselect;
choiceSelectSound = snd_select;
choiceSoundPriority = 5;
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

/// @description Turn the page
/// @param index  optional field specifying the absolute index to change the page to.
function TurnPage() {
	
	var absoluteIndex = argument_count > 0 ? argument[0] : undefined;
	
	if (absoluteIndex != undefined) {
		currentPage = absoluteIndex;
	} 
	else {
		currentPage = currentPage == undefined
			? 0
			: currentPage + 1;	
	}
			
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
	
	specIndex = 0;

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

function FindPageIndexByUniqueId(uniqueId) {
	var totalPages = array_length(dialogue);
	for (var i = 0; i < totalPages; i++) {
		var dialogueEntryToCheck = dialogue[i];
		var pageUniqueId = variable_struct_get(dialogueEntryToCheck, "uniqueId");
		if (uniqueId == pageUniqueId) return i;
	}
	return undefined;
}

function ProcessChoice() {
	// Get choice object based on chosen index
	var choice = dialogueEntry.choices[currentChoiceIndex];
	
	// Optionally execute associated script
	var action = variable_struct_get(choice, "script");
	if (action != undefined) {
		action();
	}
	
	// Optionally adjust custom page turn; else, turn page normally
	var jump = variable_struct_get(choice, "jump");
	if (jump != undefined) {
		switch(jump.jumpType) {
			case DialogueJumpType.AbsoluteIndex:
				TurnPage(jump.value);
				break;
			case DialogueJumpType.RelativeIndex:
				var absoluteIndex = currentPage + jump.value;
				TurnPage(absoluteIndex);
				break;
			case DialogueJumpType.UniqueId:
				var pageSearchResult = FindPageIndexByUniqueId(jump.value);
				if (pageSearchResult == undefined) {
					throw "Attempt to jump dialogue by unique ID failed. Dialogue does not contain the unique ID " + jump.value;
				}
				TurnPage(pageSearchResult);
				break;
			case DialogueJumpType.ExitDialogue:
				instance_destroy();
				break;
		}
	}
	else {
		TurnPage();
	}
}