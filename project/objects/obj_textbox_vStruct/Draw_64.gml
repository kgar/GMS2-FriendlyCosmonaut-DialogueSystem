/// @description Write

if (!active) exit;

// Draw textbox
draw_nine_panel_textbox(spr_nine_panel_textbox, textboxPositionX, textboxPositionY, 
		textboxPositionX + textboxWidth, textboxPositionY + textboxHeight, 0);

#region Normal Dialogue

// Draw text up to this point in specIndex
draw_set_font(fnt_dialogue);
var time = get_timer() / 1000000 * room_speed;
var roundedspecIndex = floor(specIndex);
var drawTextY = textboxPositionY + textboxPaddingY;

for (var i = 0; i <= roundedspecIndex; i++) {
	var spec = currentCharacterSpecs[i];
	
	// TODO: Need a better name than effectivePortraitWidthAndPadding
	var effectivePortraitWidthAndPadding = portraitSide == PortraitSide.Left
		? portraitWidthAndPadding
		: 0;
	var drawTextX = textboxPositionX + textboxPaddingX + effectivePortraitWidthAndPadding + spec.xOffset;
	drawTextY = textboxPositionY + textboxPaddingY + spec.yOffset;
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
			var shiftOffset = (time + i);
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
			draw_text_transformed_color(drawTextX + characterCenterOffset, drawTextY + stringHeight / 2, 
				spec.character, 1, 1, shift * 20, color, color, color, color, 1);
			draw_set_valign(valign);
			draw_set_halign(halign);
			break;
		case TextEffect.Pulse:
			var shiftOffset = time + i;
			var shift = abs(dsin(shiftOffset * 6));
			var characterCenterOffset = spec.width / 2;
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
			draw_text_color(drawTextX, drawTextY, spec.character, color, color, color, color, shift + random_range(-1, 1));
			break;
		case TextEffect.Normal:
		default:
			draw_text_color(drawTextX, drawTextY, spec.character, color, color, color, color, 1);
			break;
	}
}

#endregion


#region Dialogue Choice
if (dialogueEntry.type == DialogueType.Choice && specIndex >= specsLength - 1) {
	
	if (!surface_exists(choiceSurface)) {
		choiceSurface = surface_create(choiceSurfaceWidth, choiceSurfaceHeight);
	}
	
	choiceSurfaceCurrentYOffset = lerp(coalesce(choiceSurfaceCurrentYOffset, choiceSurfaceTargetYOffset), choiceSurfaceTargetYOffset, 0.25);
	
	surface_set_target(choiceSurface);
	
	draw_clear_alpha(c_white, 0);
	
	var choicesLength = array_length(dialogueEntry.choices);
	
	// TODO: Need a better name than effectivePortraitWidthAndPadding
	var effectivePortraitWidthAndPadding = portraitSide == PortraitSide.Left
		? portraitWidthAndPadding
		: 0;
	var drawChoiceX = 0;
	var drawChoiceY = 0;
	var choiceOffsetY = 0;
	
	for (var i = 0; i < choicesLength; i++) {
		var choice = dialogueEntry.choices[i];
		var isSelected = currentChoiceIndex == i;
		var color = isSelected ? choiceTextColor : c_white /* TODO: Eliminate this hardcodedness */;
		draw_text_ext_color(drawChoiceX, drawChoiceY + choiceOffsetY + choiceSurfaceCurrentYOffset, choice.text, stringHeight, choiceSurfaceWidth, color, color, color, color, 1);
		choiceOffsetY += string_height_ext(choice.text, stringHeight, choiceSurfaceWidth);
	}
	
	surface_reset_target();
	draw_surface(choiceSurface, choiceSurfaceX, choiceSurfaceY);
	
	// Draw Pointer
	currentChoicePointerX = lerp(coalesce(currentChoicePointerX, targetChoicePointerX), targetChoicePointerX, 0.25);
	currentChoicePointerY = lerp(coalesce(currentChoicePointerY, targetChoicePointerY), targetChoicePointerY, 0.25);
	draw_sprite(spr_pointer, 0, currentChoicePointerX, currentChoicePointerY);
	
	// Draw Indicators
	if (hasChoiceHeightOverflow) {
		// Scroll Up
		
		var choiceScrollIndicatorArrowPadding = choiceScrollIndicatorWidth / 5;
		if (CanScrollUp()) {
			draw_triangle_color(
				// Top center
				choiceScrollUpIndicatorX + choiceScrollIndicatorWidth / 2,
				choiceScrollUpIndicatorY + choiceScrollIndicatorArrowPadding,
				// Bottom left
				choiceScrollUpIndicatorX + choiceScrollIndicatorArrowPadding,
				choiceScrollUpIndicatorY + choiceScrollIndicatorHeight - choiceScrollIndicatorArrowPadding,
				// Bottom right
				choiceScrollUpIndicatorX + choiceScrollIndicatorWidth - choiceScrollIndicatorArrowPadding,
				choiceScrollUpIndicatorY + choiceScrollIndicatorHeight - choiceScrollIndicatorArrowPadding,
				choiceScrollTextColor, choiceScrollTextColor, choiceScrollTextColor, false
			);
		}
		
		if (CanScrollDown()) {
			draw_triangle_color(
				// Top left
				choiceScrollDownIndicatorX + choiceScrollIndicatorArrowPadding,
				choiceScrollDownIndicatorY + choiceScrollIndicatorArrowPadding,
				// Top right
				choiceScrollDownIndicatorX + choiceScrollIndicatorWidth - choiceScrollIndicatorArrowPadding,
				choiceScrollDownIndicatorY + choiceScrollIndicatorArrowPadding,
				// Bottom center
				choiceScrollDownIndicatorX + choiceScrollIndicatorWidth / 2,
				choiceScrollDownIndicatorY + choiceScrollIndicatorHeight - choiceScrollIndicatorArrowPadding,
				choiceScrollTextColor, choiceScrollTextColor, choiceScrollTextColor, false
			);
		}
	}
}
#endregion

#region Nameplate

if (nameplateName != undefined) {
	draw_nine_panel_textbox(spr_nine_panel_textbox, nameplateX, nameplateY, 
		nameplateX + nameplateWidth, nameplateY + nameplateHeight, 0);
	
	draw_set_font_temp(fnt_dialogue, function() {
		draw_text_color(nameplateX + nameplateXPadding, nameplateY + nameplateYPadding, nameplateName, c_white, c_white, c_white, c_white, 1);
	});
}

#region Portrait 

// TODO: Expand on this for distinguishing punctuation from consonants and vowels.
var isSpeaking = floor(specIndex) + 1 < specsLength;

if (isSpeaking && portraitSpriteSpeaking != undefined) {
	draw_sprite_ext(portraitSpriteSpeaking, portraitSpeakAnimationTracker.currentSubImg, portraitX, portraitY, portraitXScale, 1, 0, c_white, 1);
}
else if (portraitSpriteIdle != undefined) {
	// TODO: Move calculations to page turn ;)
	draw_sprite_ext(portraitSpriteIdle, portraitSubImg, portraitX, portraitY, portraitXScale, 1, 0, c_white, 1);
}

#endregion

#endregion