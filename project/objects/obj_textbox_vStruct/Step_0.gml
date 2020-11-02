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
		
		if (keyboard_check_pressed(choiceMoveDownKey)) {
			audio_play_sound(choiceChangeSound, choiceSoundPriority, false);
			GoToNextChoice();
			RefreshScrollIndicators();
		}
		else if (keyboard_check_pressed(choiceMoveUpKey)) {
			audio_play_sound(choiceChangeSound, choiceSoundPriority, false);
			GoToPreviousChoice();
			RefreshScrollIndicators();
		}
		
		
		break;
	default:
		throw "Invalid DialogueType";
	break;
}