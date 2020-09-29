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
// TODO: Give textIndex a better name. It does not really map to a particular index in the string.
if (textIndex < specsLength) {
	textIndex += dialogueSpeed;
}

// Draw text up to this point in textIndex
draw_set_font(fnt_dialogue);
for (var i = 0; i < textIndex; i++) {
	var spec = currentCharacterSpecs[i];
	
	var drawTextX = textboxPositionX + textboxPaddingX + spec.xOffset;
	var drawTextY = textboxPositionY + textboxPaddingY + spec.yOffset;
	
	switch(spec.effect) {
		case TextEffect.Shakey:
			draw_text(drawTextX + random_range(-1, 1), drawTextY + random_range(-1, 1), spec.character);
			break;
		case TextEffect.Normal:
		default:
			draw_text(drawTextX, drawTextY, spec.character);
			break;
	}
}

#endregion