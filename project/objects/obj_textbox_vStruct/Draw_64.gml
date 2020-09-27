/// @description Write and Increment

if (!active) return;

// Draw textbox
draw_set_color_temp(c_black, function() {
	draw_rectangle(
		textboxPositionX, textboxPositionY, 
		textboxPositionX + textboxWidth, textboxPositionY + textboxHeight, 
		false);
});

#region Dialogue Choice

#endregion

#region Normal Dialogue

// Increment Text Index
if (textIndex + 1 < string_length(currentText)) {
	textIndex++;
}

// Draw text up to this point in textIndex
var characterCount = textIndex + 1;
var currentCharacter = 1;
repeat(characterCount) {
	var character = string_char_at(currentText, currentCharacter);
	// TODO: precalculate character widths during newline calculation!
	var characterWidth = string_width(character);
	var xOffset = (currentCharacter - 1) * characterWidth;
	var drawTextX = textboxPositionX + textboxPaddingX + xOffset;
	var drawTextY = textboxPositionY + textboxPaddingY /* newline stuff here */;
	
	draw_text(drawTextX, drawTextY, character);	
	currentCharacter++;
}

//var textToDraw = string_copy(dialogueEntry.text, 1, textIndex);
//draw_text_ext(
//	textboxPositionX + textboxPaddingX, 
//	textboxPositionY + textboxPaddingY, 
//	textToDraw, 
//	characterHeight, 
//	textboxWidth - textboxPaddingX * 2);
#endregion
