/// @description Write

if (!active) exit;

// Draw textbox
draw_set_color_temp(c_black, function() {
	draw_rectangle(
		textboxPositionX, textboxPositionY, 
		textboxPositionX + textboxWidth, textboxPositionY + textboxHeight, 
		false);
});

#region Normal Dialogue

// Draw text up to this point in specIndex
draw_set_font(fnt_dialogue);
var time = get_timer() / 1000000 * room_speed;
var roundedspecIndex = floor(specIndex);
for (var i = 0; i <= roundedspecIndex; i++) {
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
			var shiftOffset = (time + i);
			var shift = dsin(shiftOffset * 6) * waveEffectAmplitude;
			draw_text_color(drawTextX, drawTextY + shift, spec.character, color, color, color, color, 1);
			break;
		case TextEffect.ColorShift:
			var colorShift = time * 8 + drawTextX;
			var color1 = make_color_hsv(colorShift % 256, 255, 255);
			var color2 = make_color_hsv((colorShift + 34) % 256, 255, 255);
			draw_text_color(drawTextX, drawTextY, spec.character, color1, color1, color2, color2, 1);
			break;
		case TextEffect.WaveAndColorShift:
			var colorShift = time * 8 + drawTextX;
			var shift = dsin(shiftOffset * 6) * waveEffectAmplitude;
			var colorShift = (time + i) * 10;
			var color1 = make_color_hsv(colorShift % 256, 255, 255);
			var color2 = make_color_hsv((colorShift + 34) % 256, 255, 255);
			draw_text_color(drawTextX, drawTextY + shift, spec.character, color1, color1, color2, color2, 1);
			break;
		case TextEffect.Spin:
			var shiftOffset = (time + i);
			var shift = dsin(shiftOffset * 6);
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
			var shiftOffset = time + i;
			var shift = abs(dsin(shiftOffset * 6));
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
			var shiftOffset = time + i;
			var shift = dsin(shiftOffset * 6);
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


#region Dialogue Choice
if (dialogueEntry.type == DialogueType.Choice && specIndex >= specsLength - 1) {
	// If current index is at or exceeding text length, 
	// show choices
		// Ensure selected choice is highlighted
		// Ensure pointer exists
		// lerp pointer to its appropriate place to the left of the choice text
}
#endregion