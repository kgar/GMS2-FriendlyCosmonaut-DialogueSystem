global.dialogue_functions = {
	textevent_already_underway: function() {
		return instance_number(obj_textevent_vStruct) > 1 or
			instance_number(obj_textbox_vStruct) > 0;
	},
	calculate_newlines: function(currentText, boxWidth, textboxPaddingX, textLength, characterWidth) {
		var breakpointIndex = 0;
		var lastBreakPoint = 0;
		var characterPointer = 1;
		var nextSpace = 0;
		var maxTextWidth = boxWidth - (2 * textboxPaddingX);
	
		var newlines = -1;
	
		repeat(textLength) {
			if (characterPointer >= nextSpace) {
				nextSpace = characterPointer;
				while (nextSpace < textLength and string_copy(currentText, nextSpace, 1) != " ") nextSpace++;
				var lineWidth = (nextSpace - lastBreakPoint) * characterWidth;
				if (lineWidth >= maxTextWidth) {
					lastBreakPoint = characterPointer;
					newlines[breakpointIndex] = characterPointer;
					breakpointIndex++;
				}
			}
		
			characterPointer++;
		}
	
		return newlines;
	}
}