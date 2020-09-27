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
if (textIndex + 1 < string_length(dialogue[currentPage].text)) {
	textIndex++;
}

// Draw text up to this point in textIndex
var textToDraw = string_copy(dialogueEntry.text, 1, textIndex);
draw_text_ext(
	textboxPositionX + textboxPaddingX, 
	textboxPositionY + textboxPaddingY, 
	textToDraw, 
	characterHeight, 
	textboxWidth - textboxPaddingX * 2);
#endregion
