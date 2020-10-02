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
	var color = spec.color;
	draw_set_font(spec.font);
	
	switch(spec.effect) {
		case TextEffect.Shakey:
			draw_text_color(drawTextX + random_range(-1, 1), drawTextY + random_range(-1, 1), spec.character, color, color, color, color, 1);
			break;
		case TextEffect.Wave:
			var shiftOffset = (waveEffectTime + i);
			var shift = sin(shiftOffset * pi * waveEffectFrequency / room_speed) * waveEffectAmplitude;
			draw_text_color(drawTextX, drawTextY + shift, spec.character, color, color, color, color, 1);
			break;
		case TextEffect.ColorShift:
			var color1 = make_color_hsv(colorShiftTime, 255, 255);
			var secondaryHue = (colorShiftTime + 34) % 256;
			var color2 = make_color_hsv(secondaryHue, 255, 255);
			draw_text_color(drawTextX, drawTextY, spec.character, color1, color1, color2, color2, 1);
			break;
		case TextEffect.WaveAndColorShift:
			var shiftOffset = (waveEffectTime + i);
			var shift = sin(shiftOffset * pi * waveEffectFrequency / room_speed) * waveEffectAmplitude;
			var color1 = make_color_hsv(colorShiftTime, 255, 255);
			var secondaryHue = (colorShiftTime + 34) % 256;
			var color2 = make_color_hsv(secondaryHue, 255, 255);
			draw_text_color(drawTextX, drawTextY + shift, spec.character, color1, color1, color2, color2, 1);
			break;
		case TextEffect.Spin:
			var shiftOffset = (waveEffectTime + i);
			var shift = sin(shiftOffset * pi * waveEffectFrequency / room_speed);
			var characterCenterOffset = spec.width / 2;
			var valign = draw_get_valign(), halign = draw_get_halign();
			draw_set_valign(fa_middle);
			draw_set_halign(fa_middle);
			var color = draw_get_color();
			draw_text_transformed_color(drawTextX + characterCenterOffset, drawTextY + stringHeight / 2, 
				spec.character, 1, 1, shift * 20, color, color, color, color, 1);
			draw_set_valign(valign);
			draw_set_halign(halign);
			break;
		case TextEffect.Pulse:
			var shiftOffset = waveEffectTime + i;
			var shift = abs(sin(shiftOffset * pi * waveEffectFrequency / room_speed));
			var characterCenterOffset = spec.width / 2;
			var color = draw_get_color();
			var valign = draw_get_valign(), halign = draw_get_halign();
			draw_set_valign(fa_middle);
			draw_set_halign(fa_middle);
			draw_text_transformed_color(drawTextX + characterCenterOffset, drawTextY + stringHeight / 2, 
				spec.character, shift, shift, 0, color, color, color, color, 1);
			draw_set_valign(valign);
			draw_set_halign(halign);
			break;
		case TextEffect.Flicker:
			var shiftOffset = waveEffectTime + i;
			var shift = sin(shiftOffset * pi * waveEffectFrequency / room_speed);
			var color = draw_get_color();
			draw_text_color(drawTextX, drawTextY, spec.character, color, color, color, color, shift + random_range(-1, 1));
			break;
		case TextEffect.Normal:
		default:
			draw_text(drawTextX, drawTextY, spec.character);
			break;
	}
}

#endregion