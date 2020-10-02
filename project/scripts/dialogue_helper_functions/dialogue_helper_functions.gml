global.dialogue_models = {
	CharacterSpec: function() constructor {
		character = "";
		width = -1;
		xOffset = 0;
		yOffset = 0;
		effect = TextEffect.Normal;
		color = c_white;
	}
}

global.dialogue_functions = {
	copy_character_spec: function(spec) {
		var copy = new global.dialogue_models.CharacterSpec();
		copy.character = spec.character;
		copy.width = spec.width;
		copy.xOffset = spec.xOffset;
		copy.yOffset = spec.yOffset;
		copy.effect = spec.effect;
		return copy;
	},
	create_range_map: function(struct, rangeArrayName, valueName) {
		var effectsMap = ds_map_create();
		var array = variable_struct_get(struct, rangeArrayName);
		if (array == undefined) {
			return effectsMap;
		}
		var arrayLength = array_length(array);
		for (var i = 0; i < arrayLength; i++) {
			var entry = array[i];
			ds_map_set(effectsMap, entry.index, variable_struct_get(entry, valueName)); 
		}
		return effectsMap;
	},
	create_character_specs: function(dialogueEntry, textAreaWidth) {
		// Offsets and positioning setup
		var currentXOffset = 0;
		var currentYOffset = 0;
		var lineHeight = string_height("M");
		var mostRecentSpace = -1;
		var characterInsertCount = 0;
		
		// Effects setup
		var effectsMap = create_range_map(dialogueEntry, "effects", "effect");
		var currentEffect = TextEffect.Normal;

		// Color setup
		var currentColor = draw_get_color();
		var colorMap = create_range_map(dialogueEntry, "textColors", "color");
		
		// Create Specs
		var characterSpecs = [];
		var currentText = dialogueEntry.text;
		var textLength = string_length(currentText);
		for (var i = 0; i < textLength + characterInsertCount; i++) {
			var spec = new global.dialogue_models.CharacterSpec();
			spec.character = string_char_at(currentText, i + 1);
			spec.width = string_width(spec.character);
			spec.xOffset = currentXOffset;
			spec.yOffset = currentYOffset;
			
			if (spec.character == " ") {
				mostRecentSpace = i;
			}
			
			// Handle effects
			// TODO: Create a common struct for handling this pattern of ranges and values; use for each of the ranges (effects, fonts, colors, etc.)
			var effectAtIndex = effectsMap[? i - characterInsertCount];
			if (effectAtIndex != undefined) {
				currentEffect = effectAtIndex;
			}
			spec.effect = currentEffect;
			
			// Handle fonts
			
			// Handle colors
			var colorAtIndex = colorMap[? i - characterInsertCount];
			if (colorAtIndex != undefined) {
				currentColor = colorAtIndex;
			}
			spec.color = currentColor;
			
			characterSpecs[i] = spec;
			currentXOffset += spec.width;
			
			// Handle newlines
			if (currentXOffset > textAreaWidth) {
				currentXOffset = 0;
				currentYOffset += lineHeight;
				
				var breakWord = mostRecentSpace == -1;
				var startOfNewline = breakWord
					? i - 1 // Take the last character on the current line, and the current over-wide character
					: mostRecentSpace + 1; // Take the whole word
				
				// Backfill new yOffset from last-known space
				for (var j = startOfNewline; j <= i; j++) {
					var specToMoveToNewLine = characterSpecs[j];
					specToMoveToNewLine.yOffset = currentYOffset;
					specToMoveToNewLine.xOffset = currentXOffset;
					currentXOffset += specToMoveToNewLine.width;
				}
				
				// Insert hyphen if breaking a word
				if (breakWord) {
					currentText = string_insert("-", currentText, startOfNewline);
					var lastCharacterOnWordBreakLine = characterSpecs[startOfNewline - 1];
					var hyphenSpec = copy_character_spec(lastCharacterOnWordBreakLine);
					hyphenSpec.xOffset = lastCharacterOnWordBreakLine.xOffset + lastCharacterOnWordBreakLine.width;
					hyphenSpec.character = "-";
					characterSpecs = array_insert_at(characterSpecs, startOfNewline, hyphenSpec);
					i++; // Skip forward by 1 to account for inserted character
					characterInsertCount++; // Increment inserted character count to ensure the loop covers all remaining text
				}
				
				mostRecentSpace = -1;
			}
		}
		
		show_debug_message(string(characterSpecs));
		
		ds_map_destroy(effectsMap);
		ds_map_destroy(colorMap);
		
		return characterSpecs;
	}
}