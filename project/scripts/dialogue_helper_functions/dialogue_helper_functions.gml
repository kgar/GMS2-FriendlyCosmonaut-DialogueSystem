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
		//var currentYOffset = 0; // TODO: Implement yOffset
		//var lineHeight = string_height("M"); // TODO: increment yOffset with this.
		for (var i = 0; i < textLength; i++) {
			var spec = new global.dialogue_models.CharacterSpec();
			spec.character = string_char_at(currentText, i + 1);
			spec.width = string_width(spec.character);
			spec.xOffset = currentXOffset;
			spec.yOffset = 0;
			
			// Handle fonts
			// Handle colors
			// Handle effects
			
			characterSpecs[i] = spec;
			currentXOffset += spec.width;
			
			// Handle newlines
		}
		
		return characterSpecs;
	}
}