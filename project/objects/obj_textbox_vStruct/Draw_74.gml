/// @description Increment
// You can write your code in this editor

if (dialogueEntry.type == DialogueType.Normal) {
	// TODO: Give textIndex a better name. It does not really map to a particular index in the string.
	if (textIndex < specsLength) {
		textIndex += dialogueSpeed;
	}
}

waveEffectTime = (waveEffectTime + 1) % 360;
colorShiftTime = (colorShiftTime + colorShiftRate) % 256;