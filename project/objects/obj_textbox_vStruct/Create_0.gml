active = false;
dialogue = undefined;
dialogueEntry = undefined;
currentPage = undefined;
currentText = undefined;
textIndex = undefined;
textLength = undefined;
characterWidth = undefined;
characterHeight = undefined;
lineBreakPoints = undefined;
guiWidth = display_get_gui_width();
guiHeight = display_get_gui_height();
textboxWidth = guiWidth - 50; // TODO: Calculate this whenever I figure out what textbox sprite / methodology I'm using.
textboxHeight = guiHeight * 0.3;
guiWhitespace = guiWidth - textboxWidth;
textboxPaddingX = 10;
textboxPositionX = (guiWhitespace/2);
textboxPaddingY = 10;
textboxPositionY = guiHeight - textboxHeight - 8;

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

	// TODO: 
	// draw_set_font(font[page]);
	characterWidth = string_width("M");
	characterHeight = string_height("M");

	lineBreakPoints = CalculateLineBreakPoints(
		currentText,
		textboxWidth,
		textboxPaddingX,
		textLength,
		characterWidth);
	
	show_debug_message(lineBreakPoints);
	
	// Perform calculations, 
	// prepare any optional features for the page
	// etc.
}

function CalculateLineBreakPoints(currentText, boxWidth, textboxPaddingX, textLength, characterWidth) {
	var breakpointIndex = 0;
	var lastBreakPoint = 0;
	var characterPointer = 1;
	var nextSpace = 0;
	var maxTextWidth = boxWidth - (2 * textboxPaddingX);
	
	var breakpoints = -1;
	
	repeat(textLength) {
		if (characterPointer >= nextSpace) {
			nextSpace = characterPointer;
			while (nextSpace < textLength and string_copy(currentText, nextSpace, 1) != " ") nextSpace++;
			var lineWidth = (nextSpace - lastBreakPoint) * characterWidth;
			if (lineWidth >= maxTextWidth) {
				lastBreakPoint = characterPointer;
				breakpoints[breakpointIndex] = characterPointer;
				breakpointIndex++;
			}
		}
		
		characterPointer++;
	}
	
	return breakpoints;
}
