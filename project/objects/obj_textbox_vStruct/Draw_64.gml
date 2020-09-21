/// @description Write and Increment

if (!active) return;

#region Dialogue Choice

#endregion

#region Normal Dialogue

// Increment Text Index
if (textIndex + 1 < string_length(dialogue[currentPage].text)) {
	textIndex++;
}

// Draw text up to this point in textIndex
var textToDraw = string_copy(dialogue[currentPage].text, 1, textIndex);
draw_text_ext(200, 200, textToDraw, font_get_size(0) + 10, room_width - 10);

#endregion
