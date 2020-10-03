/// @description Increment

if (dialogueEntry.type == DialogueType.Normal) {
	// TODO: Give textIndex a better name. It does not really map to a particular index in the string.
	if (textIndex < specsLength) {
		textIndex += dialogueSpeed;
	}
	
	dialogueSpeed = textIndex < specsLength
		? currentCharacterSpecs[textIndex].speed
		: dialogueSpeed;
}

waveEffectTime = (waveEffectTime + 1) % 360;
colorShiftTime = (colorShiftTime + colorShiftRate) % 256;