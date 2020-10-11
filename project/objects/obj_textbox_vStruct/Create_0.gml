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
choicePointerWidth = sprite_get_width(spr_pointer);
choicePointerRightPadding = choicePointerWidth / 2;
choicePointerLastX = undefined;
choicePointerLastY = undefined;
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

// Nameplate
nameplateName = undefined;
nameplateX = undefined;
nameplateY = undefined;
nameplateWidth = undefined;
nameplateHeight = undefined;
nameplatePadding = 5;
nameplateXOffset = 20;

// Portrait
portraitSprite = undefined;
portraitSubImg = undefined;
portraitX = undefined;
portraitY = undefined;
portraitWidth = undefined;
portraitPaddingX = 20;
portraitWidthAndPadding = undefined;

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
	choicePointerLastX = undefined;
	choicePointerLastY = undefined;
		
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

	// TODO: Throw this right into a struct and calculate everything on construction :O
	var portrait = variable_struct_get(dialogueEntry, "portrait");
	portraitSprite = portrait != undefined ? asset_get_index(portrait.assetName) : undefined;
	portraitSubImg = portrait != undefined ? coalesce(variable_struct_get(portrait, "subImg"), 0) : undefined;
	portraitWidth = portraitSprite != undefined ? sprite_get_width(portraitSprite) : 0;
	portraitX = portrait != undefined ? textboxPositionX + portraitPaddingX + portraitWidth / 2 : undefined;
	portraitY = portrait != undefined ? textboxPositionY + textboxHeight / 2 : undefined;
	portraitWidthAndPadding = portrait != undefined ? portraitWidth + portraitPaddingX * 2 : 0;
	
	draw_set_font_temp(fnt_dialogue, function() {		
		stringHeight = string_height("M");
		
		nameplateName = variable_struct_get(dialogueEntry, "name");
		nameplateHeight = nameplateName != undefined ? stringHeight + nameplatePadding * 2 : undefined;
		nameplateWidth = nameplateName != undefined ? string_width(nameplateName) + nameplatePadding * 2 : undefined;
		nameplateX = nameplateName != undefined ? textboxPositionX + textboxWidth - nameplateWidth - nameplateXOffset : undefined;
		nameplateY = nameplateName != undefined ? textboxPositionY - nameplateHeight : undefined;
				
		var textAreaWidth = textboxWidth - textboxPaddingX * 2 - portraitWidthAndPadding;
		
		currentCharacterSpecs = global.dialogue_functions.create_character_specs(
		dialogueEntry, 
		textAreaWidth);
		
		specsLength = array_length(currentCharacterSpecs);
	});	
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