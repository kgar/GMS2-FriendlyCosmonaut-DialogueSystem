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
framesSinceTypeWritingCompleted = undefined;
postTypeWriteDelayBeforeInteraction = 15;

// Choice Dialogue
chosen = false;
choiceSoundPriority = 5;
choiceChangeSound = snd_moveselect;
choiceSelectSound = snd_select;
choiceDriver = undefined;

// Input
interactKey = global.interactKey;
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

// Portrait
portraitSpriteIdle = undefined;
portraitSubImg = undefined;
portraitSpriteSpeaking = undefined;
portraitX = undefined;
portraitY = undefined;
portraitWidth = undefined;
portraitPaddingX = 20;
portraitWidthAndPadding = undefined;
portraitSide = undefined;
portraitXScale = 0;
portraitSpeakAnimationTracker = undefined; // TODO: Destroy and recreate this for the lifetime of the textbox; if not undefined, then destroy on object destruction.

// Nameplate
nameplateName = undefined;
nameplateX = undefined;
nameplateY = undefined;
nameplateWidth = undefined;
nameplateHeight = undefined;
nameplateXPadding = 12;
nameplateYPadding = 6;
nameplateXOffset = 0;
nameplateYOffset = 0;

// Effect Settings
waveEffectAmplitude = 4;

function Init(_dialogue, _caller) {
	dialogue = _dialogue;
	caller = _caller;
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
	
	#region Disposal of prior resources
	if (portraitSpeakAnimationTracker != undefined) {
		instance_destroy(portraitSpeakAnimationTracker);
		portraitSpeakAnimationTracker = undefined;
	}
	#endregion
		
	if (dialogueEntry != undefined && variable_struct_exists(dialogueEntry, "onPageTurn")) {
		dialogueEntry.onPageTurn(caller);
	}
		
	if (currentPage >= array_length(dialogue)) {
		instance_destroy();
		return;
	}
	
	dialogueSpeed = 1;
	
	dialogueEntry = dialogue[currentPage];
	
	if (variable_struct_exists(dialogueEntry, "showThisPage") && !dialogueEntry.showThisPage(caller)) {
		TurnPage();
		return;
	}
	
	if (dialogueEntry != undefined && variable_struct_exists(dialogueEntry, "onPageOpen")) {
		dialogueEntry.onPageOpen(caller);
	}
	
	currentText = variable_struct_exists(dialogueEntry, "text") ? dialogueEntry.text : "";
	
	specIndex = 0;
	framesSinceTypeWritingCompleted = 0;

	// TODO: Throw this right into a struct and calculate everything on construction :O
	var portrait = variable_struct_get(dialogueEntry, "portrait");
	
	portraitSpriteIdle = portrait != undefined 
		? asset_get_index(portrait.idle) 
		: undefined;
		
	portraitSubImg = portrait != undefined 
		? coalesce(variable_struct_get(portrait, "subImg"), 0) 
		: undefined;

	portraitSpriteSpeaking = portrait != undefined && variable_struct_exists(portrait, "speaking")
		? asset_get_index(variable_struct_get(portrait, "speaking"))
		: undefined;
		
	if (portraitSpriteSpeaking != undefined) {
		portraitSpeakAnimationTracker = instance_create_layer(0, 0, "Instances", obj_sequential_loop_animation_tracker);
		
		var portraitSpriteSpeakingFps = portrait != undefined && variable_struct_exists(portrait, "speakingFps")
			? variable_struct_get(portrait, "speakingFps")
			: 6;
		
		portraitSpeakAnimationTracker.Init(portraitSpriteSpeakingFps, sprite_get_number(portraitSpriteSpeaking));
	}
	
	portraitWidth = portraitSpriteIdle != undefined 
		? sprite_get_width(portraitSpriteIdle) 
		: 0;
	
	portraitSide = portrait != undefined 
		? coalesce(variable_struct_get(portrait, "side"), PortraitSide.Left) 
		: PortraitSide.Left;
	
	if (portrait != undefined && portraitSide == PortraitSide.Left) {
		portraitX = textboxPositionX + portraitPaddingX + portraitWidth / 2;
	} else if (portrait != undefined && portraitSide == PortraitSide.Right) {
		portraitX = textboxPositionX + textboxWidth - portraitPaddingX - portraitWidth / 2;
	} else {
		portraitX = undefined;
	}
	
	portraitY = portrait != undefined 
		? textboxPositionY + textboxHeight / 2 
		: undefined;
	
	portraitWidthAndPadding = portrait != undefined 
		? portraitWidth + portraitPaddingX * 2 
		: 0;
	
	portraitXScale = portrait != undefined && variable_struct_get(portrait, "invert") == true
		? -1
		: 1;
	
	
	draw_set_font_temp(fnt_dialogue, function() {		
		stringHeight = string_height("M");
		
		// TODO: Put nameplates in a struct; name is required parameter; portrait struct is optional parameter
		nameplateName = variable_struct_get(dialogueEntry, "name");
		nameplateHeight = nameplateName != undefined ? stringHeight + nameplateYPadding * 2 : undefined;
		nameplateWidth = nameplateName != undefined ? string_width(nameplateName) + nameplateXPadding * 2 : undefined;
		// TODO: Clean this up! This is a mess! Perhaps use some functions when this is extracted to its own nameplate struct...
		nameplateX = portraitSide == PortraitSide.Right
			? (nameplateName != undefined ? textboxPositionX + textboxWidth - nameplateWidth - nameplateXOffset : undefined)
			: (nameplateName != undefined ? textboxPositionX + nameplateXOffset : undefined);
		nameplateY = nameplateName != undefined ? textboxPositionY - nameplateHeight + nameplateYOffset: undefined;
				
		var textAreaWidth = textboxWidth - textboxPaddingX * 2 - portraitWidthAndPadding;
		
		currentCharacterSpecs = currentText != "" 
			? global.dialogue_functions.create_character_specs(
				dialogueEntry, 
				textAreaWidth,
				caller)
			: [];
		
		specsLength = array_length(currentCharacterSpecs);
		
		if (dialogueEntry.type == DialogueType.Choice) {
			chosen = false;
			
			var effectivePortraitLeftPadding = portraitSide == PortraitSide.Left
				? portraitWidthAndPadding
				: 0;
			var effectivePortraitRightPadding = portraitSide == PortraitSide.Right
				? portraitWidthAndPadding
				: 0;
			var lastTextLineYOffset = specsLength > 0 ? currentCharacterSpecs[specsLength - 1].yOffset + stringHeight : 0;
			var height = textboxHeight - textboxPaddingY * 2 - lastTextLineYOffset;
			var width = textboxWidth - textboxPaddingX * 2 - effectivePortraitLeftPadding - effectivePortraitRightPadding;
			var x1 = textboxPositionX + textboxPaddingX + effectivePortraitLeftPadding;
			var y1 = textboxPositionY + textboxHeight - height - textboxPaddingY;
			
			if (choiceDriver != undefined) {
				choiceDriver._destroy();
			}
			
			choiceDriver = new DialogueChoiceDriver(
				dialogueEntry.choices, 
				x1,
				y1,
				width,
				height,
				stringHeight);	
		}
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
	var choice = dialogueEntry.choices[choiceDriver.currentChoiceIndex];
	
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

function IsFinishedTypeWriting() { 
	return specIndex >= specsLength - 1;
}

function CanSkipToEndOfText() {
	return specIndex > 2 || specsLength <= 2;
}

function SkipToEndOfText() {
	specIndex = specsLength - 1;
}