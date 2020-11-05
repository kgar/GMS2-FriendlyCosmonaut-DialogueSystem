/// @description Handle User Input




switch (dialogueEntry.type) {
	case DialogueType.Normal:
	
		if (!keyboard_check_pressed(interactKey)) return;
	
		if (IsFinishedTypeWriting()) {
			TurnPage();
		} else if (CanSkipToEndOfText()) {
			SkipToEndOfText();
		}
		break;
	case DialogueType.Choice:
		if (chosen) exit;
		
		var finishedTypeWriting = IsFinishedTypeWriting();
		if (keyboard_check_pressed(interactKey)) {
			if (finishedTypeWriting) {
				// Process input
				chosen = true;
				audio_play_sound(choiceSelectSound, choiceSoundPriority, false); 
				delayedAction = ProcessChoice;
				alarm[0] = 10;			
			} else if (CanSkipToEndOfText()) {
				SkipToEndOfText();
			}
			
			exit;
		}
		
		if (!finishedTypeWriting) exit;
		
		if (framesSinceTypeWritingCompleted < postTypeWriteDelayBeforeInteraction) exit;
		
		if (keyboard_check_pressed(choiceMoveDownKey)) {
			audio_play_sound(choiceChangeSound, choiceSoundPriority, false);
			choiceDriver.go_to_next_choice();
		}
		else if (keyboard_check_pressed(choiceMoveUpKey)) {
			audio_play_sound(choiceChangeSound, choiceSoundPriority, false);
			choiceDriver.go_to_previous_choice();
		}
		
		
		break;
	default:
		throw "Invalid DialogueType";
	break;
}