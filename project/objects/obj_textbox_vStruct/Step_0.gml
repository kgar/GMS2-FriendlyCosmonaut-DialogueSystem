/// @description Handle User Input




switch (dialogueEntry.type) {
	case DialogueType.Normal:
	
		if (!keyboard_check_pressed(interactKey)) return;
	
		if (specIndex >= specsLength - 1) {
			TurnPage();
		} else if (specIndex > 2 || specsLength <= 2) {
			specIndex = specsLength - 1; // Skip to end of text prompt
		}
		break;
	case DialogueType.Choice:
		if (chosen) exit;
		var finishedTypeWriting = specIndex >= specsLength - 1;
		if (keyboard_check_pressed(interactKey)) {
			if (finishedTypeWriting) {
				// Process input
				chosen = true;
				audio_play_sound(choiceSelectSound, choiceSoundPriority, false); 
				delayedAction = ProcessChoice;
				alarm[0] = 10;			
			} else if (specIndex > 2 || specsLength <= 2) {
				specIndex = specsLength - 1; // Skip to end of text prompt
			}
			
			exit;
		}
		
		if (!finishedTypeWriting) exit;
		var change = keyboard_check_pressed(choiceMoveDownKey) - keyboard_check_pressed(choiceMoveUpKey);
		if(change != 0){ 
			var choicesLength = array_length(dialogueEntry.choices);
			currentChoiceIndex = (currentChoiceIndex + change + choicesLength) % choicesLength; 
			audio_play_sound(choiceChangeSound, choiceSoundPriority, false); 
		}
		break;
	default:
		throw "Invalid DialogueType";
	break;
}