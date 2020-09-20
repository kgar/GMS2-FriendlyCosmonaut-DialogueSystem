/// @description Write and Increment

#region Dialogue Choice

#endregion

#region Normal Dialogue

// Increment Text Index
if (active && textIndex + 1 < string_length(dialogue[currentPage].text)) {
	textIndex++;
}

// Draw text up to this point in textIndex
var textToDraw = string_copy(dialogue[currentPage].text, 1, textIndex);
draw_text_ext(10, 10, textToDraw, 1, room.width - 10);

#endregion
