/// @description Write

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
		case TextEffect.Wave:
			var shiftOffset = (waveEffectTime + i);
			var shift = sin(shiftOffset * pi * waveEffectFrequency / room_speed) * waveEffectAmplitude;
			draw_text(drawTextX, drawTextY + shift, spec.character);
			break;
		case TextEffect.ColorShift:
			var secondaryShift = (colorShiftTime + 34) % 256;
			var color1 = make_color_hsv(colorShiftTime, 255, 255);
			var color2 = make_color_hsv(secondaryShift, 255, 255);
			draw_text_color(drawTextX, drawTextY, spec.character, color1, color1, color2, color2, 1);
			break;
		case TextEffect.Normal:
		default:
			draw_text(drawTextX, drawTextY, spec.character);
			break;
	}
}

#endregion