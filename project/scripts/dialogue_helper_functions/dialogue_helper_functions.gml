global.dialogue_models = {
	CharacterSpec: function() constructor {
		character = "";
		width = -1;
		xOffset = 0;
		yOffset = 0;
		effect = TextEffect.Normal;
	}
}

global.dialogue_functions = {
	create_hyphen_spec: function(xOffset, yOffset) {
		var hyphenSpec = new global.dialogue_models.CharacterSpec();
		hyphenSpec.character = "-";
		hyphenSpec.width = string_width(hyphenSpec.character);
		hyphenSpec.xOffset = xOffset;
		hyphenSpec.yOffset = yOffset;
		return hyphenSpec;
	},
	create_character_specs: function(dialogueEntry, textAreaWidth, textLength) {
		var characterSpecs = [];
		var currentText = dialogueEntry.text;
		var currentXOffset = 0;
		var currentYOffset = 0;
		var lineHeight = string_height("M");
		var mostRecentSpace = -1;
		var characterInsertCount = 0;
		for (var i = 0; i < textLength + characterInsertCount; i++) {
			var spec = new global.dialogue_models.CharacterSpec();
			spec.character = string_char_at(currentText, i + 1);
			spec.width = string_width(spec.character);
			spec.xOffset = currentXOffset;
			spec.yOffset = currentYOffset;
			
			if (spec.character == " ") {
				mostRecentSpace = i;
			}
			
			// Handle fonts
			// Handle colors
			// Handle effects
			
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
					var hyphenXOffset = lastCharacterOnWordBreakLine.xOffset + lastCharacterOnWordBreakLine.width;
					var hyphenYOffset = lastCharacterOnWordBreakLine.yOffset;
					var hyphenSpec = create_hyphen_spec(hyphenXOffset, hyphenYOffset);
					characterSpecs = array_insert_at(characterSpecs, startOfNewline, hyphenSpec);
					// Skip forward by 1 to account for inserted character
					i++;
					// Increment inserted character count to ensure the loop covers all remaining text
					characterInsertCount++;
				}
				
				mostRecentSpace = -1;
			}
		}
		
		show_debug_message(string(characterSpecs));
		
		return characterSpecs;
	}
}