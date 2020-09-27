global.dialogue_models = {
	CharacterSpec: function() constructor {
		character = "";
		width = -1;
		xOffset = 0;
		yOffset = 0;
	}
}

global.dialogue_functions = {
	create_character_specs: function(currentText, textAreaWidth, textLength) {
		var characterSpecs = [];
		
		var currentXOffset = 0;
		var currentYOffset = 0; // TODO: Implement yOffset
		var lineHeight = string_height("M"); // TODO: increment yOffset with this.
		var mostRecentSpace = 0;
		for (var i = 0; i < textLength; i++) {
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
				// Backfill new yOffset from last-known space
				for (var j = mostRecentSpace + 1; j <= i; j++) {
					var specToMoveToNewLine = characterSpecs[j];
					specToMoveToNewLine.yOffset = currentYOffset;
					specToMoveToNewLine.xOffset = currentXOffset;
					currentXOffset += specToMoveToNewLine.width;
				}
			}
		}
		
		return characterSpecs;
	}
}